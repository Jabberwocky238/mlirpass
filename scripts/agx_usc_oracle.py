#!/usr/bin/env python3
"""Regenerate tests/agx/usc.{mlir,expected}: every instruction of Mesa's AGX2 disassembler cases
(src/asahi/isa/test/cases.txt: real encodings and their disassembly), decoded with Mesa's own model (isa.py, the
way its test/disasm.py does: the first instruction whose exact bits match, then each operand's first matching case)
into its fields, as an agx.usc op; usc.expected is the encoding itself. Cases with bits the model does not explain
are left out. MESA: a Mesa tree (default ~/coding/mesa); only read."""
import os, sys
mesa = os.environ.get('MESA', os.path.expanduser('~/coding/mesa'))
sys.path.insert(0, os.path.join(mesa, 'src/asahi/isa'))
from isa import isa  # noqa: E402

def match(raw):  # test/disasm.py match_instr
    for i in isa.instrs.values():
        n = i.length_spec.bits.extract(raw) if i.length_spec is not None else 0
        length = i.length[n]
        r = raw & ((1 << (length * 8)) - 1)
        if (r & i.exact.mask) == i.exact.value:
            return length, i, r
    return None

def operand(v, kind):  # test/disasm.py map_op, as fields
    for k, c in enumerate(isa.encodings[kind].cases):
        if (v & c.exact.mask) == c.exact.value:
            out = [('case', k)]
            if c.kind is not None:
                out.append((c.kind.name, c.kind.bits.extract(v) << c.kind.shift))
            out += [(m.name, m.bits.extract(v)) for m in c.modifiers if m.bits.extract(v)]
            return '{' + ', '.join(f'{n} = {x}' for n, x in out) + '}'
    raise SystemExit(f'no case of {kind} for {v:#x}')

root = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
lines = ['// Every instruction of Mesa\'s AGX2 disassembler cases, decoded into its fields with Mesa\'s model',
         '// (scripts/agx_usc_oracle.py); the comment is Mesa\'s disassembly, usc.expected the encoding.']
expected = []
for case in open(os.path.join(mesa, 'src/asahi/isa/test/cases.txt')):
    if not case.strip():
        continue
    hexs, asm = case.split(maxsplit=1)
    raw = int.from_bytes(bytes.fromhex(hexs), 'little')
    m = match(raw)
    if m is None or m[0] * 2 != len(hexs) or (m[2] & ~m[1].mask()) != 0:
        continue
    length, ins, raw = m
    attrs = [(f.name, f.bits.extract(raw)) for f in ins.modifiers if f.name != 'length' and f.bits.extract(raw)]
    # the long form, where the short one would hold it too: said, not inferred
    if ins.length_spec is not None and ins.length_spec.bits.extract(raw):
        attrs.insert(0, ('long', 1))
    attrs += [(f.name, f.bits.extract(raw)) for f in ins.immediates]
    attrs += [(f'd{k}', operand(d.bits.extract(raw), d.kind)) for k, d in enumerate(ins.dests)]
    attrs += [(f's{k}', operand(s.bits.extract(raw), s.kind)) for k, s in enumerate(ins.sources)]
    lines.append('// ' + ' '.join(asm.split()))
    lines.append(f'agx.usc.{ins.name} {{' + ', '.join(f'{n} = {v}' for n, v in attrs) + '}')
    expected.append(hexs)
open(os.path.join(root, 'tests/agx/usc.mlir'), 'w').write('\n'.join(lines) + '\n')
open(os.path.join(root, 'tests/agx/usc.expected'), 'w').write('\n'.join(expected) + '\n')
print(len(expected), 'instructions')

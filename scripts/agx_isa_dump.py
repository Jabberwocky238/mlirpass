#!/usr/bin/env python3
"""Regenerate data/apple/agx2-isa.json: Mesa's model of the AGX2 (Apple M1 ..) USC instruction set, as its own
src/asahi/isa/isa.py parses AGX2.xml (defines, groups and their substitutions applied, operand bits specialized to
the longest length): every instruction's lengths, length bit, exact bits, modifiers, immediates, destinations and
sources, and every operand encoding's cases. Bit masks and values are hex strings (up to 96 bits).
MESA: a Mesa tree (default ~/coding/mesa); only read."""
import json, os, sys
mesa = os.environ.get('MESA', os.path.expanduser('~/coding/mesa'))
sys.path.insert(0, os.path.join(mesa, 'src/asahi/isa'))
from isa import isa  # noqa: E402

bits = lambda b: [[r.start, r.end] for r in b.ranges]
field = lambda f: {'name': f.name, 'kind': f.kind, 'bits': bits(f.bits), **({'shift': f.shift} if getattr(f, 'shift', 0) else {})}
exact = lambda e: {'mask': hex(e.mask), 'value': hex(e.value)}
out = {
    'instructions': [{
        'name': i.name, 'display': i.display, 'lengths': i.length,
        'length_bit': i.length_bit if i.length_spec is not None else None, **exact(i.exact),
        'modifiers': [field(m) for m in i.modifiers if m.name != 'length'],
        'immediates': [field(m) for m in i.immediates],
        'dests': [{'kind': d.kind, 'bits': bits(d.bits)} for d in i.dests],
        'sources': [{'kind': s.kind, 'bits': bits(s.bits)} for s in i.sources],
    } for i in isa.instrs.values()],
    'encodings': {n: [{**exact(c.exact), 'field': field(c.kind) if c.kind else None,
                       'modifiers': [field(m) for m in c.modifiers], 'properties': c.properties}
                      for c in e.cases] for n, e in isa.encodings.items()},
}
root = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
with open(os.path.join(root, 'data/apple/agx2-isa.json'), 'w') as f:
    json.dump(out, f, indent=0)
    f.write('\n')
print(len(out['instructions']), 'instructions,', len(out['encodings']), 'operand encodings')

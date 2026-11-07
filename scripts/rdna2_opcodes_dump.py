#!/usr/bin/env python3
"""Regenerate data/amd/gfx10-opcodes.json (then run rdna2_opcodes.py): every instruction of Mesa's ACO opcode table (src/amd/compiler/
aco_opcodes.py, imported as it is) that GFX10 encodes, with its format and GFX10 opcode, sorted by name.
MESA: a Mesa tree (default ~/coding/mesa); only read."""
import json, os, sys
mesa = os.environ.get('MESA', os.path.expanduser('~/coding/mesa'))
sys.path.insert(0, os.path.join(mesa, 'src/amd/compiler'))
import aco_opcodes  # noqa: E402
FORMATS = {'SOP1', 'SOP2', 'SOPK', 'SOPP', 'SOPC', 'SMEM', 'DS', 'MUBUF', 'MTBUF', 'MIMG', 'EXP', 'FLAT', 'GLOBAL',
           'SCRATCH', 'VINTRP', 'VOP1', 'VOP2', 'VOPC', 'VOP3', 'VOP3P'}
out = [{'name': i.name, 'format': i.format.name, 'opcode': i.op.gfx10}
       for i in aco_opcodes.instructions.values() if i.format.name in FORMATS and i.op.gfx10 != -1]
root = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
with open(os.path.join(root, 'data/amd/gfx10-opcodes.json'), 'w') as f:
    json.dump(sorted(out, key=lambda i: i['name']), f, indent=0)
    f.write('\n')
print(len(out), 'instructions')

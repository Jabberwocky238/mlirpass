#!/usr/bin/env dash
# Regenerate tests/rdna2/oracle.{mlir,expected}: every gfx103 register (and packet dword) with fields,
# each field (but RESERVED) set to a random value of its width (seeded), as an rdna2 op; and what Mesa's S_* macros (amdgfxregs.h,
# made by Mesa's own src/amd/registers/makeregheader.py from data/amd/*.json) pack from the same values.
# MESA: a Mesa tree (default ~/coding/mesa); only read.
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
mesa=${MESA:-$HOME/coding/mesa}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
cd "$root"
python3 "$mesa/src/amd/registers/makeregheader.py" data/amd/gfx103.json data/amd/pkt3.json --sort address --guard REGS > "$tmp/regs.h"
python3 - data/amd/gfx103.json data/amd/pkt3.json tests/rdna2/oracle.mlir "$tmp/oracle.c" "$tmp/regs.h" <<'PY'
import json, random, re, sys
regs, pkt, mlir, c, header = sys.argv[1:]
defined = set(re.findall(r'#define\s+(S_\w+)\(x\)', open(header).read()))
random.seed(103)
lines = ['// Every gfx103 register / packet dword with fields, each field a random value of its width (scripts/amd-reg-oracle.sh);',
         '// oracle.expected is what Mesa\'s S_* macros pack from the same values.']
prints = []
for path, space in ((regs, 'reg'), (pkt, 'pkt')):
    db = json.load(open(path))
    mine = [m for m in db['register_mappings'] if 'gfx103' in m['chips'] and 'type_ref' in m]
    spell = lambda m: '{0:X}'.format(m['map']['at']).rjust(3 if m['map']['to'] == 'pkt3' else 6, '0')
    # Mesa defines a type's field macros once, at one of the registers of that type (and none for RESERVED)
    at = {}
    for m in mine:
        at.setdefault(m['type_ref'], []).append(spell(m))
    for m in sorted(mine, key=lambda m: m['name']):
        attrs, terms = [], []
        for f in db['register_types'][m['type_ref']]['fields']:
            if f['name'] == 'RESERVED':
                continue
            macro = next(n for n in ('S_{}_{}'.format(a, f['name']) for a in at[m['type_ref']]) if n in defined)
            v = random.getrandbits(f['bits'][1] - f['bits'][0] + 1)
            attrs.append('{} = {:#x}'.format(f['name'].lower(), v))
            terms.append('{}({:#x}u)'.format(macro, v))
        lines.append('rdna2.{}.{} {{{}}}'.format(space, m['name'].lower(), ', '.join(attrs)))
        prints.append('  printf("{} %08x\\n", {});'.format(m['name'], ' | '.join(terms)))
open(mlir, 'w').write('\n'.join(lines) + '\n')
open(c, 'w').write('#include <stdio.h>\n#include "regs.h"\nint main(void) {\n' + '\n'.join(prints) + '\n  return 0;\n}\n')
PY
cc -Werror -o "$tmp/oracle" "$tmp/oracle.c" -I "$tmp"
"$tmp/oracle" > tests/rdna2/oracle.expected
wc -l tests/rdna2/oracle.expected

#!/usr/bin/env dash
# Regenerate tests/agx/oracle.{mlir,expected} and cdm.expected: every AGX struct of data/apple/cmdbuf.xml, each
# settable field a random value its type and modifier take (seeded; floats are dyadic, so C and MLIR read the same
# number), as an agx op; and what Mesa packs from the same values: agx_pack.h made by Mesa's own
# src/asahi/genxml/gen_pack.py, compiled, `agx_pack(cl, T, cfg)` (its `_header` defaults, then the values).
# MESA: a Mesa tree (default ~/coding/mesa); only read. Run on an x86-64 with F16C: Mesa's half conversion is its
# vcvtps2ph path there, and the C stands in for Mesa's CPU detection with that.
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
mesa=${MESA:-$HOME/coding/mesa}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
cd "$root"
grep -qw f16c /proc/cpuinfo || { echo "needs an x86-64 with F16C (Mesa's half conversion)" >&2; exit 1; }
python3 "$mesa/src/asahi/genxml/gen_pack.py" data/apple/cmdbuf.xml "$mesa/src/asahi/genxml/agx_pack_header.h" > "$tmp/agx_pack.h"
python3 - data/apple/cmdbuf.xml tests/agx/oracle.mlir "$tmp/oracle.c" <<'PY'
import random, sys, xml.etree.ElementTree as ET
xml, mlir, c = sys.argv[1:]
random.seed(13)
SUBST = {' ': '_', '/': '_', '[': '', ']': '', '(': '', ')': '', '-': '_', ':': '', '.': '', ',': '', '=': '', '>': '',
         '#': '', '&': '', '*': '', '"': '', '+': '', "'": '', '?': ''}
def safe(n):  # gen_pack.py safe_name
    for k, v in SUBST.items():
        n = n.replace(k, v)
    return n if n[0].isalpha() else '_' + n
def dyadic(lo, hi, bits):  # a float with at most `bits` significant bits, in [lo, hi)
    k = random.randint(0, 8)
    return random.randrange(int(lo * 2 ** k), int(hi * 2 ** k)) / 2 ** k if bits == 0 else \
        random.randrange(1 << (bits - 1), 1 << bits) * 2.0 ** random.randint(-bits - 8, -bits + 6) * random.choice((1, -1))
root = ET.parse(xml).getroot()
enums = {e.get('name') for e in root.iter('enum')}
lines = ['// Every AGX struct, each settable field a random value of its type (scripts/agx_pack_oracle.sh);',
         "// oracle.expected is what Mesa's agx_pack packs from the same values."]
body = []
for s in sorted(root.iter('struct'), key=lambda s: safe(s.get('name')).lower()):
    sets, attrs = [], []
    for f in s.iter('field'):
        if f.get('exact'):
            continue
        name, width, ty, mod = safe(f.get('name')).lower(), int(f.get('size')), f.get('type'), f.get('modifier')
        if ty == 'bool':
            v = random.choice((True, False)); m, cv = str(v).lower(), str(int(v))
        elif ty == 'float':
            v = dyadic(0, 0, 24); m = cv = repr(v)
        elif ty == 'half':
            v = dyadic(0, 0, 24); m = cv = repr(v)
        elif ty == 'lod':
            v = random.randrange(-64, 16 * 256) / 256; m = cv = repr(v)
        else:
            assert ty in ('uint', 'hex', 'address') or ty in enums, ty
            # the C member holds the value: 64 bits for an address and a uint / hex over 33 bits, else 32
            member = 64 if ty == 'address' or (ty in ('uint', 'hex') and width - 1 > 32) else 32
            if mod is None:
                v = random.getrandbits(min(width, member))
            elif mod.startswith('shr('):
                n = int(mod[4:-1])
                v = random.getrandbits(min(width, member - n)) << n
            elif mod.startswith('minus('):
                v = int(mod[6:-1]) + random.getrandbits(width)
            elif mod == 'log2':
                v = 1 << random.randrange(0, min((1 << width) - 1, 31) + 1)
            elif mod.startswith('groups('):
                v = random.randint(0, int(mod[7:-1]) << width)
            else:
                raise SystemExit('modifier ' + mod)
            m, cv = hex(v), hex(v) + 'ull'
        attrs.append('{} = {}'.format(name, m))
        sets.append('cfg.{} = {};'.format(name, cv + ('f' if ty in ('float', 'half', 'lod') else '')))
    t = safe(s.get('name').upper())
    lines.append('agx.{} {{{}}}'.format(safe(s.get('name')).lower(), ', '.join(attrs)))
    body.append('  {{ uint32_t cl[16] = {{0}}; agx_pack(cl, {t}, cfg) {{ {sets} }} out("{n}", cl, (AGX_{t}_LENGTH + 3) / 4); }}'
                .format(t=t, sets=' '.join(sets), n=s.get('name')))
open(mlir, 'w').write('\n'.join(lines) + '\n')
open(c, 'w').write('#include "agx_pack.h"\n'
  '/* Mesa\'s CPU detection, as on an x86-64 with F16C: _mesa_float_to_half runs vcvtps2ph (the script checks) */\n'
  'struct _util_cpu_caps_state_t _util_cpu_caps_state = { .detect_done = 1, .caps = { .has_f16c = 1 } };\n'
  'void _util_cpu_detect_once(void) {}\n'
  'uint16_t _mesa_float_to_half_slow(float f) { (void)f; abort(); }\n'
  'static void out(const char *n, const uint32_t *cl, unsigned dw) { printf("%s", n); for (unsigned i = 0; i < dw; i++) printf(" %08x", cl[i]); printf("\\n"); }\n'
  'int main(void) {\n' + '\n'.join(body) + '\n  return 0;\n}\n')
PY
cc -Werror -Wno-unused-function -o "$tmp/oracle" "$tmp/oracle.c" -I "$tmp" -I "$mesa/src" -I "$mesa/include" -I "$mesa/src/util" \
  -D_GNU_SOURCE -DHAVE_PTHREAD -DHAVE_STRUCT_TIMESPEC -DHAVE_TIMESPEC_GET -DUTIL_ARCH_LITTLE_ENDIAN=1 -DUTIL_ARCH_BIG_ENDIAN=0 -lm
"$tmp/oracle" > tests/agx/oracle.expected
wc -l tests/agx/oracle.expected
# tests/agx/cdm.mlir as Mesa writes a CDM stream: each word agx_pack'ed after the last, then
# CDM_STREAM_TERMINATE (gallium agx_flush_compute). The C states cdm.mlir's values again: change both together.
cat > "$tmp/cdm.c" <<'C'
#include "agx_pack.h"
int main(void) {
  uint8_t buf[256] = {0}, *at = buf;
#define PUSH(T, ...) do { agx_pack(at, T, cfg) { __VA_ARGS__ } at += AGX_##T##_LENGTH; } while (0)
  PUSH(CDM_BARRIER, cfg.usc_cache_inval = true; cfg.unk_4 = true;);
  PUSH(CDM_LAUNCH_WORD_0, cfg.uniform_register_count = 64; cfg.texture_state_register_count = 8;
       cfg.sampler_state_register_count = 1; cfg.preshader_register_count = 16; cfg.mode = AGX_CDM_MODE_DIRECT;);
  PUSH(CDM_LAUNCH_WORD_1, cfg.pipeline = 0x1000c0;);
  PUSH(CDM_GLOBAL_SIZE, cfg.x = 256; cfg.y = 4; cfg.z = 1;);
  PUSH(CDM_LOCAL_SIZE, cfg.x = 32; cfg.y = 1; cfg.z = 1;);
  PUSH(CDM_STREAM_TERMINATE, (void)cfg;);
  for (uint8_t *p = buf; p < at; p++) printf("%02x\n", *p);
  return 0;
}
C
cc -Werror -Wno-unused-function -o "$tmp/cdm" "$tmp/cdm.c" -I "$tmp" -I "$mesa/src" -I "$mesa/include" -I "$mesa/src/util" \
  -D_GNU_SOURCE -DHAVE_PTHREAD -DHAVE_STRUCT_TIMESPEC -DHAVE_TIMESPEC_GET -DUTIL_ARCH_LITTLE_ENDIAN=1 -DUTIL_ARCH_BIG_ENDIAN=0 \
  -x c - -x none <<'STUB'
#include <stdint.h>
#include <stdlib.h>
#include "util/u_cpu_detect.h"
struct _util_cpu_caps_state_t _util_cpu_caps_state = { .detect_done = 1, .caps = { .has_f16c = 1 } };
void _util_cpu_detect_once(void) {}
uint16_t _mesa_float_to_half_slow(float f) { (void)f; abort(); }
STUB
"$tmp/cdm" > tests/agx/cdm.expected
wc -l tests/agx/cdm.expected

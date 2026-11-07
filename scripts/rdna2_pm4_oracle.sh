#!/usr/bin/env dash
# Regenerate tests/rdna2/pm4.expected: the IB Mesa writes for tests/rdna2/pm4.mlir, with
# Mesa's own macros: the register values with amdgfxregs.h's S_* (made by makeregheader.py from data/amd/*.json),
# the packets with sid.h's PKT3 and ac_cmdbuf.h's ac_cmdbuf_set_*_reg_seq, both cut out of the Mesa tree as they
# are; the padding as radv_amdgpu_cs_pad (vulkan/winsys/amdgpu/radv_amdgpu_cs.c, a static function: written out
# below with sid.h's PKT3 / PKT3_NOP_PAD). The C below states pm4.mlir's values again: change both together.
# MESA: a Mesa tree (default ~/coding/mesa); only read.
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
mesa=${MESA:-$HOME/coding/mesa}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
cd "$root"
python3 "$mesa/src/amd/registers/makeregheader.py" data/amd/gfx103.json data/amd/pkt3.json --sort address --guard REGS > "$tmp/regs.h"
# sid.h: the register spaces and the type-3 packet macros (multi-line ones with their continuations)
awk '/^#define (SI|CIK)_[A-Z]+_REG_(OFFSET|END)/ || /^#define PKT/ { print; while ($0 ~ /\\$/ && (getline) > 0) print }' \
  "$mesa/src/amd/common/sid.h" > "$tmp/pkt.h"
# ac_cmdbuf.h: from ac_cmdbuf_begin to the SH helpers
sed -n '/^#define ac_cmdbuf_begin(cs)/,/^#define ac_cmdbuf_set_sh_reg(reg, value)/p' "$mesa/src/amd/common/ac_cmdbuf.h" > "$tmp/cmdbuf.h"
sed -n '/^struct ac_cmdbuf {/,/^};/p' "$mesa/src/amd/common/ac_cmdbuf_base.h" > "$tmp/base.h"
cat > "$tmp/oracle.c" <<'C'
#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#define UNUSED __attribute__((unused))
#include "regs.h"
#include "pkt.h"
#include "base.h"
#include "cmdbuf.h"

int main(void) {
  uint32_t buf[64];
  struct ac_cmdbuf cs = { .buf = buf, .max_dw = 64 };
  ac_cmdbuf_begin(&cs);
  ac_cmdbuf_set_sh_reg_seq(R_00B830_COMPUTE_PGM_LO, 2);
  ac_cmdbuf_emit(0x12345678);
  ac_cmdbuf_emit(S_00B834_DATA(0x9a));
  ac_cmdbuf_set_sh_reg_seq(R_00B81C_COMPUTE_NUM_THREAD_X, 3);
  ac_cmdbuf_emit(S_00B81C_NUM_THREAD_FULL(0x40) | S_00B81C_NUM_THREAD_PARTIAL(0x3));
  ac_cmdbuf_emit(S_00B81C_NUM_THREAD_FULL(0x1));
  ac_cmdbuf_emit(S_00B81C_NUM_THREAD_FULL(0x1));
  ac_cmdbuf_set_sh_reg(R_00B848_COMPUTE_PGM_RSRC1, S_00B848_VGPRS(0x3) | S_00B848_SGPRS(0x2) | S_00B848_FLOAT_MODE(0xc0));
  ac_cmdbuf_set_ctx_reg(R_028780_CB_BLEND0_CONTROL, S_028780_COLOR_SRCBLEND(0x1) | S_028780_COLOR_DESTBLEND(0x5) | S_028780_ENABLE(0x1));
  ac_cmdbuf_set_ucfg_reg(R_0301F0_CP_COHER_CNTL, S_0301F0_SH_KCACHE_ACTION_ENA(0x1) | S_0301F0_TC_ACTION_ENA(0x1));
  const uint64_t out = 0x1010000ull; /* @out after rdna2-layout */
  ac_cmdbuf_emit(PKT3(PKT3_WRITE_DATA, 3, 0));
  ac_cmdbuf_emit(0x500);
  ac_cmdbuf_emit((uint32_t)out);
  ac_cmdbuf_emit((uint32_t)(out >> 32));
  ac_cmdbuf_emit(0xdeadbeef);
  ac_cmdbuf_emit(PKT3(PKT3_DISPATCH_DIRECT, 3, 0) | PKT3_SHADER_TYPE_S(1));
  ac_cmdbuf_emit(2); ac_cmdbuf_emit(3); ac_cmdbuf_emit(1); ac_cmdbuf_emit(1);
  /* radv_amdgpu_cs_pad: ib_pad_dw_mask 7; one NOP of n dwords (radv_amdgpu_cs_emit_pkt3_nop), PKT3_NOP_PAD for one */
  unsigned n = (8 - (__cs_num & 7)) & 7;
  if (n == 1) {
    ac_cmdbuf_emit(PKT3_NOP_PAD);
  } else if (n > 1) {
    ac_cmdbuf_emit(PKT3(PKT3_NOP, n - 2, 0));
    for (unsigned i = 1; i < n; i++) ac_cmdbuf_emit(0);
  }
  ac_cmdbuf_end();
  for (unsigned i = 0; i < cs.cdw; i++) printf("%08x\n", buf[i]);
  return 0;
}
C
cc -Werror -o "$tmp/oracle" "$tmp/oracle.c" -I "$tmp"
"$tmp/oracle" > tests/rdna2/pm4.expected
wc -l tests/rdna2/pm4.expected

// RDNA2 instructions; the comment above each is the same instruction in LLVM's syntax (mnemonics differ where
// Mesa's ACO names them otherwise), isa.expected is what `llvm-mc -mcpu=gfx1036` encodes (scripts/amd-isa-oracle.sh).
// s_mov_b32 s0, s1
rdna2.isa.salu {op = "s_mov_b32", dst = "s0", src0 = "s1"}
// s_mov_b32 s5, 0x12345678
rdna2.isa.salu {op = "s_mov_b32", dst = "s5", src0 = "0x12345678"}
// s_mov_b64 s[2:3], exec
rdna2.isa.salu {op = "s_mov_b64", dst = "s[2:3]", src0 = "exec"}
// s_add_u32 s0, s1, 7
rdna2.isa.salu {op = "s_add_u32", dst = "s0", src0 = "s1", src1 = "7"}
// s_and_b32 s4, s5, -1
rdna2.isa.salu {op = "s_and_b32", dst = "s4", src0 = "s5", src1 = "-1"}
// s_mul_i32 s6, s7, 1000
rdna2.isa.salu {op = "s_mul_i32", dst = "s6", src0 = "s7", src1 = "1000"}
// s_movk_i32 s8, 0x1234
rdna2.isa.salu {op = "s_movk_i32", dst = "s8", simm16 = 0x1234}
// s_cmp_eq_u32 s0, s1
rdna2.isa.salu {op = "s_cmp_eq_u32", src0 = "s0", src1 = "s1"}
// s_cmpk_eq_u32 s0, 0x10
rdna2.isa.salu {op = "s_cmpk_eq_u32", src0 = "s0", simm16 = 0x10}
// s_nop 0
rdna2.isa.salu {op = "s_nop", simm16 = 0}
// s_waitcnt 0
rdna2.isa.salu {op = "s_waitcnt", simm16 = 0}
// s_barrier
rdna2.isa.salu {op = "s_barrier"}
// s_branch 3
rdna2.isa.salu {op = "s_branch", simm16 = 3}
// s_cbranch_scc0 2
rdna2.isa.salu {op = "s_cbranch_scc0", simm16 = 2}
// s_endpgm
rdna2.isa.salu {op = "s_endpgm"}
// s_load_dword s0, s[4:5], 0x10
rdna2.isa.smem {op = "s_load_dword", dst = "s0", sbase = "s[4:5]", offset = 0x10}
// s_load_dwordx4 s[8:11], s[2:3], 0x0 glc
rdna2.isa.smem {op = "s_load_dwordx4", dst = "s[8:11]", sbase = "s[2:3]", offset = 0, glc}
// s_load_dwordx2 s[0:1], s[4:5], s6
rdna2.isa.smem {op = "s_load_dwordx2", dst = "s[0:1]", sbase = "s[4:5]", soffset = "s6"}
// v_mov_b32_e32 v0, v1
rdna2.isa.valu {op = "v_mov_b32", dst = "v0", src0 = "v1"}
// v_mov_b32_e32 v2, s3
rdna2.isa.valu {op = "v_mov_b32", dst = "v2", src0 = "s3"}
// v_mov_b32_e32 v3, 1.0
rdna2.isa.valu {op = "v_mov_b32", dst = "v3", src0 = "1.0"}
// v_mov_b32_e32 v4, 0x40490fdb
rdna2.isa.valu {op = "v_mov_b32", dst = "v4", src0 = "0x40490fdb"}
// v_cvt_f32_u32_e32 v5, v6
rdna2.isa.valu {op = "v_cvt_f32_u32", dst = "v5", src0 = "v6"}
// v_add_f32_e32 v1, v2, v3
rdna2.isa.valu {op = "v_add_f32", dst = "v1", src0 = "v2", src1 = "v3"}
// v_add_f32_e32 v1, s2, v3
rdna2.isa.valu {op = "v_add_f32", dst = "v1", src0 = "s2", src1 = "v3"}
// v_mul_f32_e32 v1, 0x3fc00000, v2
rdna2.isa.valu {op = "v_mul_f32", dst = "v1", src0 = "0x3fc00000", src1 = "v2"}
// v_and_b32_e32 v1, 0xff, v2
rdna2.isa.valu {op = "v_and_b32", dst = "v1", src0 = "0xff", src1 = "v2"}
// v_lshlrev_b32_e32 v1, 2, v3
rdna2.isa.valu {op = "v_lshlrev_b32", dst = "v1", src0 = "2", src1 = "v3"}
// v_add_nc_u32_e32 v1, v2, v3
rdna2.isa.valu {op = "v_add_u32", dst = "v1", src0 = "v2", src1 = "v3"}
// v_cndmask_b32_e32 v1, v2, v3, vcc_lo
rdna2.isa.valu {op = "v_cndmask_b32", dst = "v1", src0 = "v2", src1 = "v3"}
// v_add_f32_e64 v1, -v2, |v3|
rdna2.isa.valu {op = "v_add_f32", vop3, dst = "v1", src0 = "-v2", src1 = "|v3|"}
// v_mul_f32_e64 v1, v2, v3 clamp
rdna2.isa.valu {op = "v_mul_f32", vop3, dst = "v1", src0 = "v2", src1 = "v3", clamp}
// v_mul_f32_e64 v1, v2, v3 mul:2
rdna2.isa.valu {op = "v_mul_f32", vop3, dst = "v1", src0 = "v2", src1 = "v3", omod = 1}
// v_fma_f32 v1, v2, v3, v4
rdna2.isa.valu {op = "v_fma_f32", dst = "v1", src0 = "v2", src1 = "v3", src2 = "v4"}
// v_mad_u32_u24 v1, v2, v3, v4
rdna2.isa.valu {op = "v_mad_u32_u24", dst = "v1", src0 = "v2", src1 = "v3", src2 = "v4"}
// v_mul_lo_u32 v1, v2, v3
rdna2.isa.valu {op = "v_mul_lo_u32", dst = "v1", src0 = "v2", src1 = "v3"}
// v_add_co_u32 v1, vcc_lo, v2, v3
rdna2.isa.valu {op = "v_add_co_u32_e64", dst = "v1", sdst = "vcc_lo", src0 = "v2", src1 = "v3"}
// v_cmp_eq_f32_e32 vcc_lo, v1, v2
rdna2.isa.valu {op = "v_cmp_eq_f32", src0 = "v1", src1 = "v2"}
// v_cmp_lt_u32_e64 s0, v1, v2
rdna2.isa.valu {op = "v_cmp_lt_u32", vop3, dst = "s0", src0 = "v1", src1 = "v2"}
// v_mov_b32_e64 v1, s2
rdna2.isa.valu {op = "v_mov_b32", vop3, dst = "v1", src0 = "s2"}
// global_load_dword v1, v[2:3], off
rdna2.isa.flat {op = "global_load_dword", dst = "v1", addr = "v[2:3]", saddr = "off"}
// global_load_dword v1, v[2:3], off offset:16
rdna2.isa.flat {op = "global_load_dword", dst = "v1", addr = "v[2:3]", saddr = "off", offset = 16}
// global_load_dword v1, v2, s[4:5] offset:-8
rdna2.isa.flat {op = "global_load_dword", dst = "v1", addr = "v2", saddr = "s[4:5]", offset = -8}
// global_load_dwordx4 v[4:7], v[2:3], off glc
rdna2.isa.flat {op = "global_load_dwordx4", dst = "v[4:7]", addr = "v[2:3]", saddr = "off", glc}
// global_store_dword v[2:3], v1, off
rdna2.isa.flat {op = "global_store_dword", addr = "v[2:3]", data = "v1", saddr = "off"}
// ds_write_b32 v1, v2 offset:8
rdna2.isa.ds {op = "ds_write_b32", addr = "v1", data0 = "v2", offset0 = 8}
// ds_read_b32 v3, v1
rdna2.isa.ds {op = "ds_read_b32", dst = "v3", addr = "v1"}
// ds_read2_b32 v[4:5], v1 offset1:1
rdna2.isa.ds {op = "ds_read2_b32", dst = "v[4:5]", addr = "v1", offset1 = 1}

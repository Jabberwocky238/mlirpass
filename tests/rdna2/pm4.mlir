// A stream of every kind of PM4 this backend writes; pm4.expected is what Mesa's macros write for it
// (scripts/amd-pm4-oracle.sh). After `rdna2-pm4, rdna2-pad, rdna2-layout`: @code at 0x1000000, @out at 0x1010000.
image.memory @code {
  image.stream @ib {
    rdna2.reg.compute_pgm_lo {address = 0x1234567800}
    rdna2.reg.compute_pgm_hi {data = 0x9a}
    rdna2.reg.compute_num_thread_x {num_thread_full = 0x40, num_thread_partial = 0x3}
    rdna2.reg.compute_num_thread_y {num_thread_full = 0x1}
    rdna2.reg.compute_num_thread_z {num_thread_full = 0x1}
    rdna2.reg.compute_pgm_rsrc1 {vgprs = 0x3, sgprs = 0x2, float_mode = 0xc0}
    rdna2.reg.cb_blend0_control {color_srcblend = 0x1, color_destblend = 0x5, enable = 0x1}
    rdna2.reg.cp_coher_cntl {sh_kcache_action_ena = 0x1, tc_action_ena = 0x1}
    rdna2.pm4.write_data {body = [0x500, [@out], 0xdeadbeef]}
    rdna2.pm4.dispatch_direct {body = [0x2, 0x3, 0x1, 0x1], compute}
  }
}
image.memory @out attributes {mem = "coherent"} {
  image.data @result {size = 64}
}

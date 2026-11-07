// Every instruction of Mesa's AGX2 disassembler cases, decoded into its fields with Mesa's model
// (scripts/agx_usc_oracle.py); the comment is Mesa's disassembly, usc.expected the encoding.
// jmp_any -634
agx.usc.jmp_any {offset = 4294966662}
// csel r0l, 0.0, r0l, 0, r0l, fgtn
agx.usc.fcsel {condition = 7, d0 = {case = 0, reg = 0}, s0 = {case = 0, fimm = 0}, s1 = {case = 2, reg = 0, hint = 1}, s2 = {case = 0, imm = 0}, s3 = {case = 1, reg = 0, hint = 1}}
// csel r0l, r0l, 0.0, r1l, r0h, flt
agx.usc.fcsel {condition = 1, d0 = {case = 0, reg = 0}, s0 = {case = 2, reg = 0, hint = 1}, s1 = {case = 0, fimm = 0}, s2 = {case = 1, reg = 2, hint = 1}, s3 = {case = 1, reg = 1, hint = 1}}
// csel r0l, r0l, r2l, r0l, r2l, fltn
agx.usc.fcsel {condition = 3, d0 = {case = 0, reg = 0}, s0 = {case = 2, reg = 0, hint = 1}, s1 = {case = 2, reg = 4, hint = 1}, s2 = {case = 1, reg = 0, hint = 1}, s3 = {case = 1, reg = 4, hint = 1}}
// csel r0h, 0.0, r0h, 0, r0h, fgtn
agx.usc.fcsel {condition = 7, d0 = {case = 0, reg = 1}, s0 = {case = 0, fimm = 0}, s1 = {case = 2, reg = 1, hint = 1}, s2 = {case = 0, imm = 0}, s3 = {case = 1, reg = 1, hint = 1}}
// csel r0h, 0.0, r0h, r1h, 0, fgte
agx.usc.fcsel {condition = 5, d0 = {case = 0, reg = 1}, s0 = {case = 0, fimm = 0}, s1 = {case = 2, reg = 1, hint = 1}, s2 = {case = 1, reg = 3, hint = 1}, s3 = {case = 0, imm = 0}}
// csel r1l, 0.0, r0h, r1l, r0l, fgte
agx.usc.fcsel {condition = 5, d0 = {case = 0, reg = 2}, s0 = {case = 0, fimm = 0}, s1 = {case = 2, reg = 1, hint = 1}, s2 = {case = 1, reg = 2, hint = 1}, s3 = {case = 1, reg = 0, hint = 1}}
// csel r1l, r0h.abs, r0l.abs, r1h, r1l, feq
agx.usc.fcsel {d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 1, abs = 1, hint = 1}, s1 = {case = 2, reg = 0, abs = 1, hint = 1}, s2 = {case = 1, reg = 3, hint = 1}, s3 = {case = 1, reg = 2, hint = 1}}
// csel r2l, r3l.abs, r2h, r2l, r1h, fgte
agx.usc.fcsel {condition = 5, d0 = {case = 0, reg = 4}, s0 = {case = 2, reg = 6, abs = 1, hint = 1}, s1 = {case = 2, reg = 5, hint = 1}, s2 = {case = 1, reg = 4, hint = 1}, s3 = {case = 1, reg = 3, hint = 1}}
// csel r2h, 1.0, r1l, r1l, r2h, fgte
agx.usc.fcsel {condition = 5, d0 = {case = 0, reg = 5}, s0 = {case = 0, fimm = 48}, s1 = {case = 2, reg = 2, hint = 1}, s2 = {case = 1, reg = 2, hint = 1}, s3 = {case = 1, reg = 5, hint = 1}}
// csel r3l, 0.0, r0h, r0l, r1l, fgte
agx.usc.fcsel {condition = 5, d0 = {case = 0, reg = 6}, s0 = {case = 0, fimm = 0}, s1 = {case = 2, reg = 1, hint = 1}, s2 = {case = 1, reg = 0, hint = 1}, s3 = {case = 1, reg = 2, hint = 1}}
// csel r3h, 1.0, r1l, 0, r3h, fgte
agx.usc.fcsel {condition = 5, d0 = {case = 0, reg = 7}, s0 = {case = 0, fimm = 48}, s1 = {case = 2, reg = 2, hint = 1}, s2 = {case = 0, imm = 0}, s3 = {case = 1, reg = 7, hint = 1}}
// csel r6, 0.0, r6, u8, 0, fgte
agx.usc.fcsel {condition = 5, d0 = {case = 0, reg = 12, size32 = 1}, s0 = {case = 0, fimm = 0}, s1 = {case = 2, reg = 12, hint = 1, size32 = 1}, s2 = {case = 2, uniform = 16, size32 = 1}, s3 = {case = 0, imm = 0}}
// csel r6, r6, r7, r6, r7, fltn
agx.usc.fcsel {condition = 3, d0 = {case = 0, reg = 12, size32 = 1}, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 2, reg = 14, hint = 1, size32 = 1}, s2 = {case = 1, reg = 12, hint = 1, size32 = 1}, s3 = {case = 1, reg = 14, hint = 1, size32 = 1}}
// csel r8, r6, 0.0, r7, r5, flt
agx.usc.fcsel {condition = 1, d0 = {case = 0, reg = 16, size32 = 1}, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 0, fimm = 0}, s2 = {case = 1, reg = 14, hint = 1, size32 = 1}, s3 = {case = 1, reg = 10, hint = 1, size32 = 1}}
// load r0_r1_r2_r3, du8, 0, i32, xyzw, a
agx.usc.load {long = 1, format = 2, mask = 15, d0 = {case = 0, reg = 0, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 16}, s1 = {case = 1, imm = 0}}
// load r0, du64, 0, i32, x, a
agx.usc.load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 0, size32 = 1, mask = 1}, s0 = {case = 1, uniform = 128}, s1 = {case = 1, imm = 0}}
// load r0_r1_r2, du52, 4, i32, xyz, a
agx.usc.load {long = 1, format = 2, mask = 7, d0 = {case = 0, reg = 0, size32 = 1, mask = 7}, s0 = {case = 1, uniform = 104}, s1 = {case = 1, imm = 4}}
// load r0_r1, du52, 154, i32, xy, a
agx.usc.load {long = 1, format = 2, mask = 3, d0 = {case = 0, reg = 0, size32 = 1, mask = 3}, s0 = {case = 1, uniform = 104}, s1 = {case = 1, imm = 154}}
// load r1, du4, r2, i32, x, a
agx.usc.load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 2, size32 = 1, mask = 1}, s0 = {case = 1, uniform = 8}, s1 = {case = 0, reg = 4, zx = 1}}
// load r2_r3, dr2, 4, i32, xy, a
agx.usc.load {long = 1, format = 2, mask = 3, d0 = {case = 0, reg = 4, size32 = 1, mask = 3}, s0 = {case = 0, reg = 4}, s1 = {case = 1, imm = 4}}
// load r2, dr23, r11, i32, x, a
agx.usc.load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 4, size32 = 1, mask = 1}, s0 = {case = 0, reg = 46}, s1 = {case = 0, reg = 22, zx = 1}}
// load r4, dr0, 0, i32, x, b
agx.usc.load {long = 1, format = 2, mask = 1, waitgroup = 1, d0 = {case = 0, reg = 8, size32 = 1, mask = 1}, s0 = {case = 0, reg = 0}, s1 = {case = 1, imm = 0}}
// load r4, dr2, 0, i32, x, a
agx.usc.load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 8, size32 = 1, mask = 1}, s0 = {case = 0, reg = 4}, s1 = {case = 1, imm = 0}}
// load r4, dr0, 1, i32, x, a
agx.usc.load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 8, size32 = 1, mask = 1}, s0 = {case = 0, reg = 0}, s1 = {case = 1, imm = 1}}
// load r4, dr10, 3, i32, x, a
agx.usc.load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 8, size32 = 1, mask = 1}, s0 = {case = 0, reg = 20}, s1 = {case = 1, imm = 3}}
// load r6_r7, dr6, 0, i32, xy, a
agx.usc.load {long = 1, format = 2, mask = 3, d0 = {case = 0, reg = 12, size32 = 1, mask = 3}, s0 = {case = 0, reg = 12}, s1 = {case = 1, imm = 0}}
// load r6, dr8, 2, i32, x, a
agx.usc.load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 12, size32 = 1, mask = 1}, s0 = {case = 0, reg = 16}, s1 = {case = 1, imm = 2}}
// load r6, dr8, 4, i32, x, a
agx.usc.load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 12, size32 = 1, mask = 1}, s0 = {case = 0, reg = 16}, s1 = {case = 1, imm = 4}}
// load r6_r7, du54, r6, i32, xy, a
agx.usc.load {long = 1, format = 2, mask = 3, d0 = {case = 0, reg = 12, size32 = 1, mask = 3}, s0 = {case = 1, uniform = 108}, s1 = {case = 0, reg = 12, zx = 1}}
// load r8_r9, dr8, 0, i32, xy, a
agx.usc.load {long = 1, format = 2, mask = 3, d0 = {case = 0, reg = 16, size32 = 1, mask = 3}, s0 = {case = 0, reg = 16}, s1 = {case = 1, imm = 0}}
// load r8_r9_r10, du0, r0, i32, xyz, a
agx.usc.load {long = 1, format = 2, mask = 7, d0 = {case = 0, reg = 16, size32 = 1, mask = 7}, s0 = {case = 1, uniform = 0}, s1 = {case = 0, reg = 0, zx = 1}}
// load r8_r9, dr6, 0, i32, xy, a
agx.usc.load {long = 1, format = 2, mask = 3, d0 = {case = 0, reg = 16, size32 = 1, mask = 3}, s0 = {case = 0, reg = 12}, s1 = {case = 1, imm = 0}}
// load r8_r9_r10_r11, dr6, 0, i32, xyzw, a
agx.usc.load {long = 1, format = 2, mask = 15, d0 = {case = 0, reg = 16, size32 = 1, mask = 15}, s0 = {case = 0, reg = 12}, s1 = {case = 1, imm = 0}}
// load r8_r9, dr6, 0, i32, xy, b
agx.usc.load {long = 1, format = 2, mask = 3, waitgroup = 1, d0 = {case = 0, reg = 16, size32 = 1, mask = 3}, s0 = {case = 0, reg = 12}, s1 = {case = 1, imm = 0}}
// load r8, dr6, 2, i32, x, a
agx.usc.load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 16, size32 = 1, mask = 1}, s0 = {case = 0, reg = 12}, s1 = {case = 1, imm = 2}}
// load r8_r9_r10_r11, du0, 4095, lsl 2, i32, xyzw, a
agx.usc.load {long = 1, shift = 2, format = 2, mask = 15, d0 = {case = 0, reg = 16, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 0}, s1 = {case = 2, imm = 4095}}
// load r10, dr8, 3, i32, x, a
agx.usc.load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 20, size32 = 1, mask = 1}, s0 = {case = 0, reg = 16}, s1 = {case = 1, imm = 3}}
// load r12_r13_r14_r15, du54, r0, i32, xyzw, a
agx.usc.load {long = 1, format = 2, mask = 15, d0 = {case = 0, reg = 24, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 0, reg = 0, zx = 1}}
// load r12, dr10, r7, i32, x, b
agx.usc.load {long = 1, format = 2, mask = 1, waitgroup = 1, d0 = {case = 0, reg = 24, size32 = 1, mask = 1}, s0 = {case = 0, reg = 20}, s1 = {case = 0, reg = 14, zx = 1}}
// st_tile r0_r1_r2_r3, 0, 255, 0, u8norm, xyzw
agx.usc.st_tile {format = 4, mask = 15, offset = 0, s0 = {case = 0, reg = 0, size32 = 1, mask = 15}, s1 = {case = 0, imm = 0}, s2 = {case = 1, imm = 255}}
// st_tile r0_r1_r2, 0, 255, 0, rg11b10f_rtz, xyz
agx.usc.st_tile {format = 14, mask = 7, offset = 0, s0 = {case = 0, reg = 0, size32 = 1, mask = 7}, s1 = {case = 0, imm = 0}, s2 = {case = 1, imm = 255}}
// st_tile r0_r1_r2, 0, 255, 0, rgb9e5_rtz, xyz
agx.usc.st_tile {format = 15, mask = 7, offset = 0, s0 = {case = 0, reg = 0, size32 = 1, mask = 7}, s1 = {case = 0, imm = 0}, s2 = {case = 1, imm = 255}}
// st_tile r4l_r4h_r5l_r5h, 0, 255, 0, u8norm, xyzw
agx.usc.st_tile {format = 4, mask = 15, offset = 0, s0 = {case = 0, reg = 8, mask = 15}, s1 = {case = 0, imm = 0}, s2 = {case = 1, imm = 255}}
// st_tile r4_r5_r6_r7, r9l_r9h, 1, 0, explicit_coords, u8norm, xyzw
agx.usc.st_tile {explicit_coords = 1, format = 4, mask = 15, offset = 0, s0 = {case = 0, reg = 8, size32 = 1, mask = 15}, s1 = {case = 1, reg = 18}, s2 = {case = 1, imm = 1}}
// log2 r0l, r0l
agx.usc.log2 {d0 = {case = 0, reg = 0}, s0 = {case = 2, reg = 0, hint = 1}}
// exp2 r0l, r0l
agx.usc.exp2 {d0 = {case = 0, reg = 0}, s0 = {case = 2, reg = 0, hint = 1}}
// rcp r1h, r1h
agx.usc.rcp {d0 = {case = 0, reg = 3}, s0 = {case = 2, reg = 3, hint = 1}}
// rcp r2l, r2h
agx.usc.rcp {d0 = {case = 0, reg = 4}, s0 = {case = 2, reg = 5, hint = 1}}
// rcp r2h, r1l
agx.usc.rcp {d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 2, hint = 1}}
// rsqrt r2h, r2h
agx.usc.rsqrt {d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 5, hint = 1}}
// rsqrt r3, r3
agx.usc.rsqrt {d0 = {case = 0, reg = 6, size32 = 1}, s0 = {case = 2, reg = 6, hint = 1, size32 = 1}}
// rsqrt r3h, r3h
agx.usc.rsqrt {d0 = {case = 0, reg = 7}, s0 = {case = 2, reg = 7, hint = 1}}
// iadd r0, 0, r14.sx, lsl 4
agx.usc.iadd {shift = 4, d0 = {case = 1, reg = 0}, s0 = {case = 0, imm = 0}, s1 = {case = 2, reg = 28, sx = 1, hint = 1, size32 = 1}}
// iadd r0, r0.sx, 1
agx.usc.iadd {d0 = {case = 1, reg = 0}, s0 = {case = 2, reg = 0, sx = 1, hint = 1, size32 = 1}, s1 = {case = 0, imm = 1}}
// iadd r0, r0.sx, r1.sx
agx.usc.iadd {d0 = {case = 1, reg = 0}, s0 = {case = 2, reg = 0, sx = 1, hint = 1, size32 = 1}, s1 = {case = 2, reg = 2, sx = 1, hint = 1, size32 = 1}}
// iadd r0, r0.sx, r4.sx
agx.usc.iadd {d0 = {case = 1, reg = 0}, s0 = {case = 2, reg = 0, sx = 1, hint = 1, size32 = 1}, s1 = {case = 2, reg = 8, sx = 1, hint = 1, size32 = 1}}
// iadd r0, r5.sx, r5.sx, lsl 1
agx.usc.iadd {shift = 1, d0 = {case = 1, reg = 0}, s0 = {case = 2, reg = 10, sx = 1, hint = 1, size32 = 1}, s1 = {case = 2, reg = 10, sx = 1, hint = 1, size32 = 1}}
// iadd dr0, dr0, dr4
agx.usc.iadd {d0 = {case = 0, reg = 0}, s0 = {case = 2, reg = 0, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 2, reg = 8, hint = 1, size64 = 1, size32 = 1}}
// iadd r1, r1.sx, u64.sx
agx.usc.iadd {d0 = {case = 1, reg = 2}, s0 = {case = 2, reg = 2, sx = 1, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 128, sx = 1, size32 = 1}}
// iadd r1, r1.sx, u4.sx
agx.usc.iadd {d0 = {case = 1, reg = 2}, s0 = {case = 2, reg = 2, sx = 1, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 8, sx = 1, size32 = 1}}
// iadd r1, r1.sx, r4.sx
agx.usc.iadd {d0 = {case = 1, reg = 2}, s0 = {case = 2, reg = 2, sx = 1, hint = 1, size32 = 1}, s1 = {case = 2, reg = 8, sx = 1, hint = 1, size32 = 1}}
// iadd r2, r1.sx, u2.sx
agx.usc.iadd {d0 = {case = 1, reg = 4}, s0 = {case = 2, reg = 2, sx = 1, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 4, sx = 1, size32 = 1}}
// iadd r2, r2.sx, u65.sx
agx.usc.iadd {d0 = {case = 1, reg = 4}, s0 = {case = 2, reg = 4, sx = 1, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 130, sx = 1, size32 = 1}}
// iadd r2, r2.sx, u5.sx
agx.usc.iadd {d0 = {case = 1, reg = 4}, s0 = {case = 2, reg = 4, sx = 1, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 10, sx = 1, size32 = 1}}
// iadd dr2, dr2, dr6
agx.usc.iadd {d0 = {case = 0, reg = 4}, s0 = {case = 2, reg = 4, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 2, reg = 12, hint = 1, size64 = 1, size32 = 1}}
// iadd r3, r0.sx, r4.sx
agx.usc.iadd {d0 = {case = 1, reg = 6}, s0 = {case = 2, reg = 0, sx = 1, hint = 1, size32 = 1}, s1 = {case = 2, reg = 8, sx = 1, hint = 1, size32 = 1}}
// iadd r3, r2.sx, u3.sx
agx.usc.iadd {d0 = {case = 1, reg = 6}, s0 = {case = 2, reg = 4, sx = 1, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 6, sx = 1, size32 = 1}}
// iadd r3, r3.sx, u66.sx
agx.usc.iadd {d0 = {case = 1, reg = 6}, s0 = {case = 2, reg = 6, sx = 1, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 132, sx = 1, size32 = 1}}
// iadd r5l, u12h.sx, 2
agx.usc.iadd {d0 = {case = 2, reg = 10}, s0 = {case = 1, uniform = 25, sx = 1}, s1 = {case = 0, imm = 2}}
// iadd r5l, u12h.sx, 3
agx.usc.iadd {d0 = {case = 2, reg = 10}, s0 = {case = 1, uniform = 25, sx = 1}, s1 = {case = 0, imm = 3}}
// iadd r6, r6.sx, 1
agx.usc.iadd {d0 = {case = 1, reg = 12}, s0 = {case = 2, reg = 12, sx = 1, hint = 1, size32 = 1}, s1 = {case = 0, imm = 1}}
// iadd r6, r7.sx, r6.sx
agx.usc.iadd {d0 = {case = 1, reg = 12}, s0 = {case = 2, reg = 14, sx = 1, hint = 1, size32 = 1}, s1 = {case = 2, reg = 12, sx = 1, hint = 1, size32 = 1}}
// iadd dr6, dr6, dr10
agx.usc.iadd {d0 = {case = 0, reg = 12}, s0 = {case = 2, reg = 12, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 2, reg = 20, hint = 1, size64 = 1, size32 = 1}}
// iadd dr6, dr6, 12
agx.usc.iadd {d0 = {case = 0, reg = 12}, s0 = {case = 2, reg = 12, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 0, imm = 12}}
// iadd dr6, dr8, dr10
agx.usc.iadd {d0 = {case = 0, reg = 12}, s0 = {case = 2, reg = 16, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 2, reg = 20, hint = 1, size64 = 1, size32 = 1}}
// iadd dr6, dr8, dr6
agx.usc.iadd {d0 = {case = 0, reg = 12}, s0 = {case = 2, reg = 16, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 2, reg = 12, hint = 1, size64 = 1, size32 = 1}}
// iadd r7, 1, r7.sx
agx.usc.iadd {d0 = {case = 1, reg = 14}, s0 = {case = 0, imm = 1}, s1 = {case = 2, reg = 14, sx = 1, hint = 1, size32 = 1}}
// iadd r8l, u13l.sx, 1
agx.usc.iadd {d0 = {case = 2, reg = 16}, s0 = {case = 1, uniform = 26, sx = 1}, s1 = {case = 0, imm = 1}}
// iadd dr8, dr2, 8
agx.usc.iadd {d0 = {case = 0, reg = 16}, s0 = {case = 2, reg = 4, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 0, imm = 8}}
// iadd dr8, dr8, 4
agx.usc.iadd {d0 = {case = 0, reg = 16}, s0 = {case = 2, reg = 16, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 0, imm = 4}}
// iadd dr8, dr8, dr10
agx.usc.iadd {d0 = {case = 0, reg = 16}, s0 = {case = 2, reg = 16, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 2, reg = 20, hint = 1, size64 = 1, size32 = 1}}
// iadd dr8, dr8, 8
agx.usc.iadd {d0 = {case = 0, reg = 16}, s0 = {case = 2, reg = 16, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 0, imm = 8}}
// iadd dr8, dr10, dr8
agx.usc.iadd {d0 = {case = 0, reg = 16}, s0 = {case = 2, reg = 20, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 2, reg = 16, hint = 1, size64 = 1, size32 = 1}}
// iadd r9, r8.sx, r9.sx
agx.usc.iadd {d0 = {case = 1, reg = 18}, s0 = {case = 2, reg = 16, sx = 1, hint = 1, size32 = 1}, s1 = {case = 2, reg = 18, sx = 1, hint = 1, size32 = 1}}
// iadd r10, 0, r6.sx, lsl 4
agx.usc.iadd {shift = 4, d0 = {case = 1, reg = 20}, s0 = {case = 0, imm = 0}, s1 = {case = 2, reg = 12, sx = 1, hint = 1, size32 = 1}}
// iadd r10, r10.sx, r8.sx, lsl 4
agx.usc.iadd {shift = 4, d0 = {case = 1, reg = 20}, s0 = {case = 2, reg = 20, sx = 1, hint = 1, size32 = 1}, s1 = {case = 2, reg = 16, sx = 1, hint = 1, size32 = 1}}
// iadd dr10, dr2, dr10
agx.usc.iadd {d0 = {case = 0, reg = 20}, s0 = {case = 2, reg = 4, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 2, reg = 20, hint = 1, size64 = 1, size32 = 1}}
// iadd dr10, dr2, 8
agx.usc.iadd {d0 = {case = 0, reg = 20}, s0 = {case = 2, reg = 4, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 0, imm = 8}}
// iadd dr10, dr8, 24
agx.usc.iadd {d0 = {case = 0, reg = 20}, s0 = {case = 2, reg = 16, hint = 1, size64 = 1, size32 = 1}, s1 = {case = 0, imm = 24}}
// iadd r12, r6.sx, 1
agx.usc.iadd {d0 = {case = 1, reg = 24}, s0 = {case = 2, reg = 12, sx = 1, hint = 1, size32 = 1}, s1 = {case = 0, imm = 1}}
// iadd r12, r12.sx, 1
agx.usc.iadd {d0 = {case = 1, reg = 24}, s0 = {case = 2, reg = 24, sx = 1, hint = 1, size32 = 1}, s1 = {case = 0, imm = 1}}
// iadd r26, 1, $r11, lsl 1
agx.usc.iadd {shift = 1, d0 = {case = 1, reg = 52}, s0 = {case = 0, imm = 1}, s1 = {case = 2, reg = 22, hint = 2, size32 = 1}}
// call -160
agx.usc.call {offset = 4294967136}
// call -118
agx.usc.call {offset = 4294967178}
// st_var r0, r4l
agx.usc.st_var {s0 = {case = 0, reg = 0}, s1 = {case = 0, reg = 8}}
// st_var r0, 2
agx.usc.st_var {s0 = {case = 0, reg = 0}, s1 = {case = 1, imm = 2}}
// st_var r1, r3l
agx.usc.st_var {s0 = {case = 0, reg = 2}, s1 = {case = 0, reg = 6}}
// st_var r2, r4l
agx.usc.st_var {s0 = {case = 0, reg = 4}, s1 = {case = 0, reg = 8}}
// st_var r3, r4l
agx.usc.st_var {s0 = {case = 0, reg = 6}, s1 = {case = 0, reg = 8}}
// st_var r4, r5l
agx.usc.st_var {s0 = {case = 0, reg = 8}, s1 = {case = 0, reg = 10}}
// st_var r5, r6l
agx.usc.st_var {s0 = {case = 0, reg = 10}, s1 = {case = 0, reg = 12}}
// st_var r5, r8l
agx.usc.st_var {s0 = {case = 0, reg = 10}, s1 = {case = 0, reg = 16}}
// st_var r8, 0
agx.usc.st_var {s0 = {case = 0, reg = 16}, s1 = {case = 1, imm = 0}}
// st_var r9, 1
agx.usc.st_var {s0 = {case = 0, reg = 18}, s1 = {case = 1, imm = 1}}
// st_var r11, 3
agx.usc.st_var {s0 = {case = 0, reg = 22}, s1 = {case = 1, imm = 3}}
// st_var r12, 4
agx.usc.st_var {s0 = {case = 0, reg = 24}, s1 = {case = 1, imm = 4}}
// st_var r13, 5
agx.usc.st_var {s0 = {case = 0, reg = 26}, s1 = {case = 1, imm = 5}}
// st_var r14, 6
agx.usc.st_var {s0 = {case = 0, reg = 28}, s1 = {case = 1, imm = 6}}
// st_var r15, 7
agx.usc.st_var {s0 = {case = 0, reg = 30}, s1 = {case = 1, imm = 7}}
// csel r0l, r6, 5, r0l, 4, ieq
agx.usc.icsel {d0 = {case = 0, reg = 0}, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 0, imm = 5}, s2 = {case = 1, reg = 0, hint = 1}, s3 = {case = 0, imm = 4}}
// csel r0, r0, 1, r0, 1, ugt
agx.usc.icsel {condition = 2, d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}, s1 = {case = 0, imm = 1}, s2 = {case = 1, reg = 0, hint = 1, size32 = 1}, s3 = {case = 0, imm = 1}}
// csel r0h, r8l, r3l, r8l, r3l, ugt
agx.usc.icsel {condition = 2, d0 = {case = 0, reg = 1}, s0 = {case = 2, reg = 16, hint = 1}, s1 = {case = 2, reg = 6, hint = 1}, s2 = {case = 1, reg = 16, hint = 1}, s3 = {case = 1, reg = 6, hint = 1}}
// csel r4, r4, 0, r6, 0, ieq
agx.usc.icsel {d0 = {case = 0, reg = 8, size32 = 1}, s0 = {case = 2, reg = 8, hint = 1, size32 = 1}, s1 = {case = 0, imm = 0}, s2 = {case = 1, reg = 12, hint = 1, size32 = 1}, s3 = {case = 0, imm = 0}}
// csel r6, r4, 0, r6, 0, ieq
agx.usc.icsel {d0 = {case = 0, reg = 12, size32 = 1}, s0 = {case = 2, reg = 8, hint = 1, size32 = 1}, s1 = {case = 0, imm = 0}, s2 = {case = 1, reg = 12, hint = 1, size32 = 1}, s3 = {case = 0, imm = 0}}
// csel r6, r6, 1, r6, 1, ugt
agx.usc.icsel {condition = 2, d0 = {case = 0, reg = 12, size32 = 1}, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 0, imm = 1}, s2 = {case = 1, reg = 12, hint = 1, size32 = 1}, s3 = {case = 0, imm = 1}}
// csel r6, r7, 1, r7, 1, ugt
agx.usc.icsel {condition = 2, d0 = {case = 0, reg = 12, size32 = 1}, s0 = {case = 2, reg = 14, hint = 1, size32 = 1}, s1 = {case = 0, imm = 1}, s2 = {case = 1, reg = 14, hint = 1, size32 = 1}, s3 = {case = 0, imm = 1}}
// csel r13, r10, r12, r10, r12, ugt
agx.usc.icsel {condition = 2, d0 = {case = 0, reg = 26, size32 = 1}, s0 = {case = 2, reg = 20, hint = 1, size32 = 1}, s1 = {case = 2, reg = 24, hint = 1, size32 = 1}, s2 = {case = 1, reg = 20, hint = 1, size32 = 1}, s3 = {case = 1, reg = 24, hint = 1, size32 = 1}}
// csel r0h, r1, u67, 1, 0, ult
agx.usc.icsel {long = 1, condition = 1, d0 = {case = 0, reg = 1}, s0 = {case = 2, reg = 2, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 134, size32 = 1}, s2 = {case = 0, imm = 1}, s3 = {case = 0, imm = 0}}
// csel r0h, r2, u68, r0h, 0, ult
agx.usc.icsel {long = 1, condition = 1, d0 = {case = 0, reg = 1}, s0 = {case = 2, reg = 4, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 136, size32 = 1}, s2 = {case = 1, reg = 1, hint = 1}, s3 = {case = 0, imm = 0}}
// ret r1
agx.usc.ret {s0 = {case = 0, reg = 2}}
// atomic _, r10, du18, 0, add, coherent1, a
agx.usc.atomic {coherency = 1, d0 = {case = 1}, s0 = {case = 1, reg = 20}, s1 = {case = 1, uniform = 36}, s2 = {case = 1, imm = 0}}
// atomic _, r3, du10, r1.sx, add, coherent1, a
agx.usc.atomic {coherency = 1, d0 = {case = 1}, s0 = {case = 1, reg = 6}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 2}}
// atomic _, r3, du74, r1.sx, add, coherent1, a
agx.usc.atomic {coherency = 1, d0 = {case = 1}, s0 = {case = 1, reg = 6}, s1 = {case = 1, uniform = 148}, s2 = {case = 0, reg = 2}}
// atomic _, r3, du10, r1.sx, and, coherent1, a
agx.usc.atomic {op = 8, coherency = 1, d0 = {case = 1}, s0 = {case = 1, reg = 6}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 2}}
// atomic r1, r4, du10, r5.sx, add, coherent1, a
agx.usc.atomic {coherency = 1, d0 = {case = 0, reg = 2}, s0 = {case = 1, reg = 8}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 10}}
// atomic r1, r4, du10, r5.sx, and, coherent1, a
agx.usc.atomic {op = 8, coherency = 1, d0 = {case = 0, reg = 2}, s0 = {case = 1, reg = 8}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 10}}
// atomic r4, r1, du16, 0, add, coherent1, a
agx.usc.atomic {coherency = 1, d0 = {case = 0, reg = 8}, s0 = {case = 1, reg = 2}, s1 = {case = 1, uniform = 32}, s2 = {case = 1, imm = 0}}
// atomic r4, r1, du18, 0, add, coherent1, a
agx.usc.atomic {coherency = 1, d0 = {case = 0, reg = 8}, s0 = {case = 1, reg = 2}, s1 = {case = 1, uniform = 36}, s2 = {case = 1, imm = 0}}
// atomic r6, r6, du22, 2, add, coherent1, a
agx.usc.atomic {coherency = 1, d0 = {case = 0, reg = 12}, s0 = {case = 1, reg = 12}, s1 = {case = 1, uniform = 44}, s2 = {case = 1, imm = 2}}
// hmul r0l, $r0h, 0.234375
agx.usc.hmul {d0 = {case = 0, reg = 0}, s0 = {case = 2, reg = 1, hint = 2}, s1 = {case = 0, fimm = 15}}
// hmul r0l, r0l, u8h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 0}, s0 = {case = 2, reg = 0, hint = 1}, s1 = {case = 1, uniform = 17}}
// hmul r0l, r0l, r3h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 0}, s0 = {case = 2, reg = 0, hint = 1}, s1 = {case = 2, reg = 7, hint = 1}}
// hmul r0h, r0h, r3h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 1}, s0 = {case = 2, reg = 1, hint = 1}, s1 = {case = 2, reg = 7, hint = 1}}
// hmul r1l, r1l, r2l
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 2, hint = 1}, s1 = {case = 2, reg = 4, hint = 1}}
// hmul r1l, r1l.abs, r2l.abs
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 2, abs = 1, hint = 1}, s1 = {case = 2, reg = 4, abs = 1, hint = 1}}
// hmul r1l, r1l, r3h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 2, hint = 1}, s1 = {case = 2, reg = 7, hint = 1}}
// hmul r1h, r0l, r1h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 3}, s0 = {case = 2, reg = 0, hint = 1}, s1 = {case = 2, reg = 3, hint = 1}}
// hmul r1h, r1h, r2h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 3}, s0 = {case = 2, reg = 3, hint = 1}, s1 = {case = 2, reg = 5, hint = 1}}
// hmul r2l, r1l, r1h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 4}, s0 = {case = 2, reg = 2, hint = 1}, s1 = {case = 2, reg = 3, hint = 1}}
// hmul r2l, r2l, r2h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 4}, s0 = {case = 2, reg = 4, hint = 1}, s1 = {case = 2, reg = 5, hint = 1}}
// hmul r2h, r2l, r2l
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 4, hint = 1}, s1 = {case = 2, reg = 4, hint = 1}}
// hmul r2h, r3l, r2l
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 6, hint = 1}, s1 = {case = 2, reg = 4, hint = 1}}
// hmul r2h, r4l, r2h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 8, hint = 1}, s1 = {case = 2, reg = 5, hint = 1}}
// hmul r2h, r5l, r5l
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 10, hint = 1}, s1 = {case = 2, reg = 10, hint = 1}}
// hmul r3l, r3l, r2h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 6}, s0 = {case = 2, reg = 6, hint = 1}, s1 = {case = 2, reg = 5, hint = 1}}
// hmul r3h, r1l, r1l
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 7}, s0 = {case = 2, reg = 2, hint = 1}, s1 = {case = 2, reg = 2, hint = 1}}
// hmul r3h, r2h, r2h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 7}, s0 = {case = 2, reg = 5, hint = 1}, s1 = {case = 2, reg = 5, hint = 1}}
// hmul r3h, r5l, r2h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 7}, s0 = {case = 2, reg = 10, hint = 1}, s1 = {case = 2, reg = 5, hint = 1}}
// hmul r4l, r2l, r3h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 8}, s0 = {case = 2, reg = 4, hint = 1}, s1 = {case = 2, reg = 7, hint = 1}}
// hmul r4h, r4h, r2h
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 9}, s0 = {case = 2, reg = 9, hint = 1}, s1 = {case = 2, reg = 5, hint = 1}}
// hmul r5l, r5l, 2.0
agx.usc.hmul {long = 1, d0 = {case = 0, reg = 10}, s0 = {case = 2, reg = 10, hint = 1}, s1 = {case = 0, fimm = 64}}
// latomic r4, r4, 0, add
agx.usc.latomic {long = 1, d0 = {case = 0, reg = 8}, s0 = {case = 1, reg = 8}, s1 = {case = 1}, s2 = {case = 1, imm = 0}}
// latomic r4, r4, 0, xchg
agx.usc.latomic {long = 1, op = 2, d0 = {case = 0, reg = 8}, s0 = {case = 1, reg = 8}, s1 = {case = 1}, s2 = {case = 1, imm = 0}}
// latomic r4, r4, 0, umin
agx.usc.latomic {long = 1, op = 4, d0 = {case = 0, reg = 8}, s0 = {case = 1, reg = 8}, s1 = {case = 1}, s2 = {case = 1, imm = 0}}
// latomic r4, r4, 0, umax
agx.usc.latomic {long = 1, op = 6, d0 = {case = 0, reg = 8}, s0 = {case = 1, reg = 8}, s1 = {case = 1}, s2 = {case = 1, imm = 0}}
// latomic r4, r4, 0, and
agx.usc.latomic {long = 1, op = 8, d0 = {case = 0, reg = 8}, s0 = {case = 1, reg = 8}, s1 = {case = 1}, s2 = {case = 1, imm = 0}}
// latomic r4, r4, 0, or
agx.usc.latomic {long = 1, op = 9, d0 = {case = 0, reg = 8}, s0 = {case = 1, reg = 8}, s1 = {case = 1}, s2 = {case = 1, imm = 0}}
// latomic r4, r4, 0, xor
agx.usc.latomic {long = 1, op = 10, d0 = {case = 0, reg = 8}, s0 = {case = 1, reg = 8}, s1 = {case = 1}, s2 = {case = 1, imm = 0}}
// latomic r6, r6_r7, 0, cmpxchg
agx.usc.latomic {long = 1, op = 3, d0 = {case = 0, reg = 12}, s0 = {case = 0, reg = 12}, s1 = {case = 1}, s2 = {case = 1, imm = 0}}
// fmul r0, $r1, 0.234375
agx.usc.fmul {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 2, hint = 2, size32 = 1}, s1 = {case = 0, fimm = 15}}
// fmul r4, r11, r9
agx.usc.fmul {long = 1, d0 = {case = 0, reg = 8, size32 = 1}, s0 = {case = 2, reg = 22, hint = 1, size32 = 1}, s1 = {case = 2, reg = 18, hint = 1, size32 = 1}}
// fmul r9, r11, r9
agx.usc.fmul {long = 1, d0 = {case = 0, reg = 18, size32 = 1}, s0 = {case = 2, reg = 22, hint = 1, size32 = 1}, s1 = {case = 2, reg = 18, hint = 1, size32 = 1}}
// fmul r11, r9, r9
agx.usc.fmul {long = 1, d0 = {case = 0, reg = 22, size32 = 1}, s0 = {case = 2, reg = 18, hint = 1, size32 = 1}, s1 = {case = 2, reg = 18, hint = 1, size32 = 1}}
// imul r0, u4.sx, u5.sx
agx.usc.imul {d0 = {case = 1, reg = 0}, s0 = {case = 1, uniform = 8, sx = 1, size32 = 1}, s1 = {case = 1, uniform = 10, sx = 1, size32 = 1}}
// imadd r1, r1.sx, u69.sx, r2.sx
agx.usc.imadd {d0 = {case = 1, reg = 2}, s0 = {case = 2, reg = 2, sx = 1, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 138, sx = 1, size32 = 1}, s2 = {case = 2, reg = 4, sx = 1, hint = 1, size32 = 1}}
// imadd r2, r4.sx, u72.sx, r2.sx
agx.usc.imadd {d0 = {case = 1, reg = 4}, s0 = {case = 2, reg = 8, sx = 1, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 144, sx = 1, size32 = 1}, s2 = {case = 2, reg = 4, sx = 1, hint = 1, size32 = 1}}
// imadd r3, r1.sx, r1.sx, r3.sx
agx.usc.imadd {d0 = {case = 1, reg = 6}, s0 = {case = 2, reg = 2, sx = 1, hint = 1, size32 = 1}, s1 = {case = 2, reg = 2, sx = 1, hint = 1, size32 = 1}, s2 = {case = 2, reg = 6, sx = 1, hint = 1, size32 = 1}}
// imadd r3, r2.sx, r2.sx, r3.sx
agx.usc.imadd {d0 = {case = 1, reg = 6}, s0 = {case = 2, reg = 4, sx = 1, hint = 1, size32 = 1}, s1 = {case = 2, reg = 4, sx = 1, hint = 1, size32 = 1}, s2 = {case = 2, reg = 6, sx = 1, hint = 1, size32 = 1}}
// imul r3, r3.sx, r3.sx
agx.usc.imul {d0 = {case = 1, reg = 6}, s0 = {case = 2, reg = 6, sx = 1, hint = 1, size32 = 1}, s1 = {case = 2, reg = 6, sx = 1, hint = 1, size32 = 1}}
// imul dr6, r1, 88
agx.usc.imul {d0 = {case = 0, reg = 12}, s0 = {case = 2, reg = 2, hint = 1, size32 = 1}, s1 = {case = 0, imm = 88}}
// imul dr8, r1, 88
agx.usc.imul {d0 = {case = 0, reg = 16}, s0 = {case = 2, reg = 2, hint = 1, size32 = 1}, s1 = {case = 0, imm = 88}}
// jmp_if_skipping_doorbell 6
agx.usc.jmp_if_skipping_doorbell {offset = 6}
// jmp_none 284
agx.usc.jmp_none {offset = 284}
// jmp_none 352
agx.usc.jmp_none {offset = 352}
// jmp_none 158
agx.usc.jmp_none {offset = 158}
// jmp_none 220
agx.usc.jmp_none {offset = 220}
// jmp_none 250
agx.usc.jmp_none {offset = 250}
// iter r6, cf1
agx.usc.iter {long = 1, d0 = {case = 0, reg = 12, size32 = 1, count = 1}, s0 = {case = 0, cf = 1}, s1 = {case = 2}}
// iter r7, cf0
agx.usc.iter {long = 1, d0 = {case = 0, reg = 14, size32 = 1, count = 1}, s0 = {case = 0, cf = 0}, s1 = {case = 2}}
// hadd r0h, ^r0h, 0.234375
agx.usc.hadd {d0 = {case = 0, reg = 1}, s0 = {case = 2, reg = 1, hint = 3}, s1 = {case = 0, fimm = 15}}
// hadd r1l, r0l, 1.0
agx.usc.hadd {long = 1, d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 0, hint = 1}, s1 = {case = 0, fimm = 48}}
// hadd r5h, r1l, r0h
agx.usc.hadd {long = 1, d0 = {case = 0, reg = 11}, s0 = {case = 2, reg = 2, hint = 1}, s1 = {case = 2, reg = 1, hint = 1}}
// doorbell 32
agx.usc.doorbell {imm = 32}
// doorbell 48
agx.usc.doorbell {imm = 48}
// doorbell 49
agx.usc.doorbell {imm = 49}
// lstore r0, 0, i32, x
agx.usc.lstore {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 0, size32 = 1, mask = 1}, s1 = {case = 1}, s2 = {case = 1, imm = 0}}
// lstore r2_r3, 0, i32, xy
agx.usc.lstore {long = 1, format = 2, mask = 3, s0 = {case = 0, reg = 4, size32 = 1, mask = 3}, s1 = {case = 1}, s2 = {case = 1, imm = 0}}
// lstore r3, r2l, 0, i32, x
agx.usc.lstore {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 6, size32 = 1, mask = 1}, s1 = {case = 0, reg = 4}, s2 = {case = 1, imm = 0}}
// lstore r4_r5_r6_r7, u5h, 0, i32, xyzw
agx.usc.lstore {long = 1, format = 2, mask = 15, s0 = {case = 0, reg = 8, size32 = 1, mask = 15}, s1 = {case = 2, uniform = 11}, s2 = {case = 1, imm = 0}}
// lstore r4_r5_r6_r7, u6l, 0, i32, xyzw
agx.usc.lstore {long = 1, format = 2, mask = 15, s0 = {case = 0, reg = 8, size32 = 1, mask = 15}, s1 = {case = 2, uniform = 12}, s2 = {case = 1, imm = 0}}
// lstore r4_r5_r6, 0, i32, xyz
agx.usc.lstore {long = 1, format = 2, mask = 7, s0 = {case = 0, reg = 8, size32 = 1, mask = 7}, s1 = {case = 1}, s2 = {case = 1, imm = 0}}
// lstore r4_r5_r6_r7, 0, i32, xyzw
agx.usc.lstore {long = 1, format = 2, mask = 15, s0 = {case = 0, reg = 8, size32 = 1, mask = 15}, s1 = {case = 1}, s2 = {case = 1, imm = 0}}
// fadd r1, ^r1, 0.234375
agx.usc.fadd {d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 2, reg = 2, hint = 3, size32 = 1}, s1 = {case = 0, fimm = 15}}
// fadd r0, r10.neg, r11
agx.usc.fadd {long = 1, d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 20, neg = 1, hint = 1, size32 = 1}, s1 = {case = 2, reg = 22, hint = 1, size32 = 1}}
// fadd r1l, r0h.abs, -0.0
agx.usc.fadd {long = 1, d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 1, abs = 1, hint = 1}, s1 = {case = 0, fimm = 128}}
// fadd r1l, r0h.neg, -0.0
agx.usc.fadd {long = 1, d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 1, neg = 1, hint = 1}, s1 = {case = 0, fimm = 128}}
// fadd r7, r5.neg, -0.0
agx.usc.fadd {long = 1, d0 = {case = 0, reg = 14, size32 = 1}, s0 = {case = 2, reg = 10, neg = 1, hint = 1, size32 = 1}, s1 = {case = 0, fimm = 128}}
// shl r0, 1, r0
agx.usc.shl {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 0, imm = 1}, s1 = {case = 2, reg = 0, hint = 1, size32 = 1}}
// extr r0, r2, r3, 30, 0
agx.usc.extr {bitmask = 0, d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 4, hint = 1, size32 = 1}, s1 = {case = 2, reg = 6, hint = 1, size32 = 1}, s2 = {case = 0, imm = 30}}
// extr r0, r12, r13, 24, 0
agx.usc.extr {bitmask = 0, d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 24, hint = 1, size32 = 1}, s1 = {case = 2, reg = 26, hint = 1, size32 = 1}, s2 = {case = 0, imm = 24}}
// shl r1, 1, r1
agx.usc.shl {d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 0, imm = 1}, s1 = {case = 2, reg = 2, hint = 1, size32 = 1}}
// shl r1, r6, 8
agx.usc.shl {d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 0, imm = 8}}
// extr r1, r14, r0, 28, 0
agx.usc.extr {bitmask = 0, d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 2, reg = 28, hint = 1, size32 = 1}, s1 = {case = 2, reg = 0, hint = 1, size32 = 1}, s2 = {case = 0, imm = 28}}
// shl r4, r2, 7
agx.usc.shl {d0 = {case = 0, reg = 8, size32 = 1}, s0 = {case = 2, reg = 4, hint = 1, size32 = 1}, s1 = {case = 0, imm = 7}}
// extr r6, r6, r7, 28, 0
agx.usc.extr {bitmask = 0, d0 = {case = 0, reg = 12, size32 = 1}, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 2, reg = 14, hint = 1, size32 = 1}, s2 = {case = 0, imm = 28}}
// shr r0, r0, r1
agx.usc.shr {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}, s1 = {case = 2, reg = 2, hint = 1, size32 = 1}}
// shr r0, r4, 2
agx.usc.shr {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 8, hint = 1, size32 = 1}, s1 = {case = 0, imm = 2}}
// bfeil r1, 0, r2, 27, 3
agx.usc.bfeil {bitmask = 3, d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 0, imm = 0}, s1 = {case = 2, reg = 4, hint = 1, size32 = 1}, s2 = {case = 0, imm = 27}}
// bfeil r1, 0, r15, 4, 4
agx.usc.bfeil {bitmask = 4, d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 0, imm = 0}, s1 = {case = 2, reg = 30, hint = 1, size32 = 1}, s2 = {case = 0, imm = 4}}
// bfeil r4, 0, r4, 9, 1
agx.usc.bfeil {bitmask = 1, d0 = {case = 0, reg = 8, size32 = 1}, s0 = {case = 0, imm = 0}, s1 = {case = 2, reg = 8, hint = 1, size32 = 1}, s2 = {case = 0, imm = 9}}
// shr r6, r4, 2
agx.usc.shr {d0 = {case = 0, reg = 12, size32 = 1}, s0 = {case = 2, reg = 8, hint = 1, size32 = 1}, s1 = {case = 0, imm = 2}}
// shr r6, r6, r8
agx.usc.shr {d0 = {case = 0, reg = 12, size32 = 1}, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 2, reg = 16, hint = 1, size32 = 1}}
// shr r7, r7, r8
agx.usc.shr {d0 = {case = 0, reg = 14, size32 = 1}, s0 = {case = 2, reg = 14, hint = 1, size32 = 1}, s1 = {case = 2, reg = 16, hint = 1, size32 = 1}}
// bfeil r7, 0, r7, 10, 14
agx.usc.bfeil {bitmask = 14, d0 = {case = 0, reg = 14, size32 = 1}, s0 = {case = 0, imm = 0}, s1 = {case = 2, reg = 14, hint = 1, size32 = 1}, s2 = {case = 0, imm = 10}}
// bfeil r8, 0, r7, 24, 4
agx.usc.bfeil {bitmask = 4, d0 = {case = 0, reg = 16, size32 = 1}, s0 = {case = 0, imm = 0}, s1 = {case = 2, reg = 14, hint = 1, size32 = 1}, s2 = {case = 0, imm = 24}}
// shr r11, r9, 28
agx.usc.shr {d0 = {case = 0, reg = 22, size32 = 1}, s0 = {case = 2, reg = 18, hint = 1, size32 = 1}, s1 = {case = 0, imm = 28}}
// shr r11, r6, 28
agx.usc.shr {d0 = {case = 0, reg = 22, size32 = 1}, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 0, imm = 28}}
// smpf r4_r5_r6_r7, ts0, ss1, r4, u10l, 2d, xyzw, lod_min, a
agx.usc.smpf {dim = 2, mask = 15, lod_type = 2, d0 = {case = 0, reg = 8, size32 = 1, mask = 15}, s0 = {case = 0}, s1 = {case = 0, ts = 0}, s2 = {case = 0, ss = 1}, s3 = {case = 0, reg = 8}, s4 = {case = 3, uniform = 20}, s5 = {case = 0}}
// smpf r0, du54, r5, r4l, r0, u64l, r15, shadow, 2d_array, x, lod_min, a
agx.usc.smpf {long = 1, shadow = 1, dim = 3, mask = 1, lod_type = 2, d0 = {case = 0, reg = 0, size32 = 1, mask = 1}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 10}, s2 = {case = 1, reg = 8}, s3 = {case = 0, reg = 0}, s4 = {case = 3, uniform = 128}, s5 = {case = 1, reg = 30}}
// smpf r4_r5_r6_r7, du54, r1, r0h, r2, 0, 2d, xyzw, auto_lod, gather_g, a
agx.usc.smpf {long = 1, dim = 2, mask = 15, gather = 3, d0 = {case = 0, reg = 8, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// smpf r4_r5_r6_r7, du54, r1, r0h, r2, 0, 2d, xyzw, auto_lod, gather_b, a
agx.usc.smpf {long = 1, dim = 2, mask = 15, gather = 5, d0 = {case = 0, reg = 8, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// smpf r4_r5_r6_r7, du54, r1, r0h, r2, 0, 2d, xyzw, auto_lod, gather_a, a
agx.usc.smpf {long = 1, dim = 2, mask = 15, gather = 7, d0 = {case = 0, reg = 8, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// smpf r4_r5, du54, r1, r0h, r2, u67l_u67h, 2d, xy, auto_lod_bias_min, a
agx.usc.smpf {long = 1, dim = 2, mask = 3, lod_type = 9, d0 = {case = 0, reg = 8, size32 = 1, mask = 3}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 5, uniform = 134}, s5 = {case = 0}}
// smpf r8_r9_r10_r11, du54, r1, r0h, r2, 0, 2d, xyzw, auto_lod, gather_r, a
agx.usc.smpf {long = 1, dim = 2, mask = 15, gather = 1, d0 = {case = 0, reg = 16, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// smpf r8_r9_r10_r11, du54, r1, r0h, r2, 0, 2d, xyzw, auto_lod, gather_g, a
agx.usc.smpf {long = 1, dim = 2, mask = 15, gather = 3, d0 = {case = 0, reg = 16, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// smpf r8_r9_r10_r11, du54, r1, r0h, r2, 0, 2d, xyzw, auto_lod, gather_b, a
agx.usc.smpf {long = 1, dim = 2, mask = 15, gather = 5, d0 = {case = 0, reg = 16, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// smpf r8_r9_r10_r11, du54, r1, r0h, r2, 0, 2d, xyzw, auto_lod, gather_a, a
agx.usc.smpf {long = 1, dim = 2, mask = 15, gather = 7, d0 = {case = 0, reg = 16, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// smpf r8_r9_r10_r11, du54, r1, r0h, r2, 0, sparse, 2d, xyzw, auto_lod, gather_r, a
agx.usc.smpf {long = 1, sparse = 1, dim = 2, mask = 15, gather = 1, d0 = {case = 0, reg = 16, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// smpf r8_r9_r10_r11, du54, r1, r0h, r2, 0, sparse, 2d, xyzw, auto_lod, gather_g, a
agx.usc.smpf {long = 1, sparse = 1, dim = 2, mask = 15, gather = 3, d0 = {case = 0, reg = 16, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// smpf r8_r9_r10_r11, du54, r1, r0h, r2, 0, sparse, 2d, xyzw, auto_lod, gather_b, a
agx.usc.smpf {long = 1, sparse = 1, dim = 2, mask = 15, gather = 5, d0 = {case = 0, reg = 16, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// smpf r8_r9_r10_r11, du54, r4, r0h, r2, r1l_r1h, sparse, 2d, xyzw, auto_lod_bias_min, a
agx.usc.smpf {long = 1, sparse = 1, dim = 2, mask = 15, lod_type = 13, d0 = {case = 0, reg = 16, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 8}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 6, reg = 2}, s5 = {case = 0}}
// smpf r8, du54, r1, r0h, r2, u67l_u67h, 2d, x, auto_lod_bias_min, a
agx.usc.smpf {long = 1, dim = 2, mask = 1, lod_type = 9, d0 = {case = 0, reg = 16, size32 = 1, mask = 1}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 5, uniform = 134}, s5 = {case = 0}}
// smpf r8_r9_r10_r11, du54, r3, r0h, r4, r2l_r2h, r1l, 3d, xyzw, auto_lod_bias_min, a
agx.usc.smpf {long = 1, dim = 5, mask = 15, lod_type = 13, d0 = {case = 0, reg = 16, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 6}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 8}, s4 = {case = 6, reg = 4}, s5 = {case = 2, reg = 2}}
// smpf r8_r9_r10_r11, du54, r1, r0h, r4, u68l_u68h, cube_array, xyzw, auto_lod_bias_min, a
agx.usc.smpf {long = 1, dim = 7, mask = 15, lod_type = 9, d0 = {case = 0, reg = 16, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 8}, s4 = {case = 5, uniform = 136}, s5 = {case = 0}}
// smpf r12_r13_r14_r15, du54, r1, r0h, r4, u67l_u67h, 2d, xyzw, auto_lod_bias_min, a
agx.usc.smpf {long = 1, dim = 2, mask = 15, lod_type = 9, d0 = {case = 0, reg = 24, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 8}, s4 = {case = 5, uniform = 134}, s5 = {case = 0}}
// smpf r16_r17_r18_r19, du54, r1, r0h, r2, 0, sparse, 2d, xyzw, auto_lod, gather_r, a
agx.usc.smpf {long = 1, sparse = 1, dim = 2, mask = 15, gather = 1, d0 = {case = 0, reg = 32, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// smpf r16_r17_r18_r19, du54, r1, r0h, r2, 0, sparse, 2d, xyzw, auto_lod, gather_g, a
agx.usc.smpf {long = 1, sparse = 1, dim = 2, mask = 15, gather = 3, d0 = {case = 0, reg = 32, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// smpf r16_r17_r18_r19, du54, r1, r0h, r2, 0, sparse, 2d, xyzw, auto_lod, gather_b, a
agx.usc.smpf {long = 1, sparse = 1, dim = 2, mask = 15, gather = 5, d0 = {case = 0, reg = 32, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// smpf r16_r17_r18_r19, du54, r1, r0h, r12, u64l, sparse, 2d, xyzw, lod_min, a
agx.usc.smpf {long = 1, sparse = 1, dim = 2, mask = 15, lod_type = 2, d0 = {case = 0, reg = 32, size32 = 1, mask = 15}, s0 = {case = 1, uniform = 108}, s1 = {case = 3, reg = 2}, s2 = {case = 1, reg = 1}, s3 = {case = 0, reg = 24}, s4 = {case = 3, uniform = 128}, s5 = {case = 0}}
// ballot r6
agx.usc.ballot {d0 = {case = 0, reg = 12, size32 = 1}}
// ballot r6, r1l, 0, ieq
agx.usc.icmp_ballot {quad = 1, d0 = {case = 0, reg = 12, size32 = 1}, s0 = {case = 2, reg = 2, hint = 1}, s1 = {case = 0, imm = 0}}
// ballot r10
agx.usc.ballot {d0 = {case = 0, reg = 20, size32 = 1}}
// ballot r54, r17, r21, ieq
agx.usc.icmp_ballot {quad = 1, d0 = {case = 0, reg = 108, size32 = 1}, s0 = {case = 2, reg = 34, hint = 1, size32 = 1}, s1 = {case = 2, reg = 42, hint = 1, size32 = 1}}
// stack_load r1l_r1h, 16, i16, xy, a
agx.usc.stack_load {long = 1, format = 1, mask = 3, d0 = {case = 0, reg = 2, mask = 3}, s0 = {case = 1, imm = 16}}
// stack_load r4, 0, i32, x, a
agx.usc.stack_load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 8, size32 = 1, mask = 1}, s0 = {case = 1, imm = 0}}
// stack_load r6, 4, i32, x, a
agx.usc.stack_load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 12, size32 = 1, mask = 1}, s0 = {case = 1, imm = 4}}
// stack_load r6, 8, i32, x, a
agx.usc.stack_load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 12, size32 = 1, mask = 1}, s0 = {case = 1, imm = 8}}
// stack_load r6, 40, i32, x, a
agx.usc.stack_load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 12, size32 = 1, mask = 1}, s0 = {case = 1, imm = 40}}
// stack_load r7, 60, i32, x, a
agx.usc.stack_load {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 14, size32 = 1, mask = 1}, s0 = {case = 1, imm = 60}}
// stack_load r23l_r23h, 12, i16, xy, a
agx.usc.stack_load {long = 1, format = 1, mask = 3, d0 = {case = 0, reg = 46, mask = 3}, s0 = {case = 1, imm = 12}}
// stack_load r24l_r24h, 8, i16, xy, a
agx.usc.stack_load {long = 1, format = 1, mask = 3, d0 = {case = 0, reg = 48, mask = 3}, s0 = {case = 1, imm = 8}}
// stack_load r25l_r25h, 4, i16, xy, a
agx.usc.stack_load {long = 1, format = 1, mask = 3, d0 = {case = 0, reg = 50, mask = 3}, s0 = {case = 1, imm = 4}}
// stack_load r26l_r26h, 0, i16, xy, a
agx.usc.stack_load {long = 1, format = 1, mask = 3, d0 = {case = 0, reg = 52, mask = 3}, s0 = {case = 1, imm = 0}}
// hfma r0l, r0l.neg, r2l, r0h
agx.usc.hfma {d0 = {case = 0, reg = 0}, s0 = {case = 2, reg = 0, neg = 1, hint = 1}, s1 = {case = 2, reg = 4, hint = 1}, s2 = {case = 2, reg = 1, hint = 1}}
// hfma r0h, r0h, r1h, r1l
agx.usc.hfma {d0 = {case = 0, reg = 1}, s0 = {case = 2, reg = 1, hint = 1}, s1 = {case = 2, reg = 3, hint = 1}, s2 = {case = 2, reg = 2, hint = 1}}
// hfma r0h, r2h.neg, r1h, r1l
agx.usc.hfma {d0 = {case = 0, reg = 1}, s0 = {case = 2, reg = 5, neg = 1, hint = 1}, s1 = {case = 2, reg = 3, hint = 1}, s2 = {case = 2, reg = 2, hint = 1}}
// hfma r2l, r5l.neg, r2h, r1h
agx.usc.hfma {d0 = {case = 0, reg = 4}, s0 = {case = 2, reg = 10, neg = 1, hint = 1}, s1 = {case = 2, reg = 5, hint = 1}, s2 = {case = 2, reg = 3, hint = 1}}
// hfma r2l, r5l.neg, r3h, r2l
agx.usc.hfma {d0 = {case = 0, reg = 4}, s0 = {case = 2, reg = 10, neg = 1, hint = 1}, s1 = {case = 2, reg = 7, hint = 1}, s2 = {case = 2, reg = 4, hint = 1}}
// hfma r2h, r1h, r1h, r2h
agx.usc.hfma {d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 3, hint = 1}, s1 = {case = 2, reg = 3, hint = 1}, s2 = {case = 2, reg = 5, hint = 1}}
// hfma r2h, r2h, r3l, r3h
agx.usc.hfma {d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 5, hint = 1}, s1 = {case = 2, reg = 6, hint = 1}, s2 = {case = 2, reg = 7, hint = 1}}
// hfma r2h, r3l, r3l, r2h
agx.usc.hfma {d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 6, hint = 1}, s1 = {case = 2, reg = 6, hint = 1}, s2 = {case = 2, reg = 5, hint = 1}}
// hfma r2h, r4l, r4l, r2h
agx.usc.hfma {d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 8, hint = 1}, s1 = {case = 2, reg = 8, hint = 1}, s2 = {case = 2, reg = 5, hint = 1}}
// hfma r2h, r4h, r4h, r2h
agx.usc.hfma {d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 9, hint = 1}, s1 = {case = 2, reg = 9, hint = 1}, s2 = {case = 2, reg = 5, hint = 1}}
// hfma r3l, r0h.neg, r1h, 1.0
agx.usc.hfma {d0 = {case = 0, reg = 6}, s0 = {case = 2, reg = 1, neg = 1, hint = 1}, s1 = {case = 2, reg = 3, hint = 1}, s2 = {case = 0, fimm = 48}}
// hfma r3l, r3l, r3h, 1.0
agx.usc.hfma {d0 = {case = 0, reg = 6}, s0 = {case = 2, reg = 6, hint = 1}, s1 = {case = 2, reg = 7, hint = 1}, s2 = {case = 0, fimm = 48}}
// hfma r3l, r3l, r3h, r4l
agx.usc.hfma {d0 = {case = 0, reg = 6}, s0 = {case = 2, reg = 6, hint = 1}, s1 = {case = 2, reg = 7, hint = 1}, s2 = {case = 2, reg = 8, hint = 1}}
// hfma r3l, r4l, r3h, r3l
agx.usc.hfma {d0 = {case = 0, reg = 6}, s0 = {case = 2, reg = 8, hint = 1}, s1 = {case = 2, reg = 7, hint = 1}, s2 = {case = 2, reg = 6, hint = 1}}
// hfma r3h, r0l, r0l, r3h
agx.usc.hfma {d0 = {case = 0, reg = 7}, s0 = {case = 2, reg = 0, hint = 1}, s1 = {case = 2, reg = 0, hint = 1}, s2 = {case = 2, reg = 7, hint = 1}}
// hfma r3h, r0h, r0h, r3h
agx.usc.hfma {d0 = {case = 0, reg = 7}, s0 = {case = 2, reg = 1, hint = 1}, s1 = {case = 2, reg = 1, hint = 1}, s2 = {case = 2, reg = 7, hint = 1}}
// hfma r5l, u8l, r0h, r4h
agx.usc.hfma {d0 = {case = 0, reg = 10}, s0 = {case = 1, uniform = 16}, s1 = {case = 2, reg = 1, hint = 1}, s2 = {case = 2, reg = 9, hint = 1}}
// hfma r5l, r2h, r1h, r5l
agx.usc.hfma {d0 = {case = 0, reg = 10}, s0 = {case = 2, reg = 5, hint = 1}, s1 = {case = 2, reg = 3, hint = 1}, s2 = {case = 2, reg = 10, hint = 1}}
// hfma r5l, r3l.neg, r4h, r4l
agx.usc.hfma {d0 = {case = 0, reg = 10}, s0 = {case = 2, reg = 6, neg = 1, hint = 1}, s1 = {case = 2, reg = 9, hint = 1}, s2 = {case = 2, reg = 8, hint = 1}}
// hfma r0h, r0h.neg, r2l, r1l.neg
agx.usc.hfma {long = 1, d0 = {case = 0, reg = 1}, s0 = {case = 2, reg = 1, neg = 1, hint = 1}, s1 = {case = 2, reg = 4, hint = 1}, s2 = {case = 2, reg = 2, neg = 1, hint = 1}}
// hfma r1l, r3l, r4h, r4l.neg
agx.usc.hfma {long = 1, d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 6, hint = 1}, s1 = {case = 2, reg = 9, hint = 1}, s2 = {case = 2, reg = 8, neg = 1, hint = 1}}
// hfma r2l, r5l.neg, r4h, r3l.neg
agx.usc.hfma {long = 1, d0 = {case = 0, reg = 4}, s0 = {case = 2, reg = 10, neg = 1, hint = 1}, s1 = {case = 2, reg = 9, hint = 1}, s2 = {case = 2, reg = 6, neg = 1, hint = 1}}
// hfma r4h, u8l, r0l, u9l
agx.usc.hfma {long = 1, d0 = {case = 0, reg = 9}, s0 = {case = 1, uniform = 16}, s1 = {case = 2, reg = 0, hint = 1}, s2 = {case = 1, uniform = 18}}
// wait a
agx.usc.wait {}
// wait b
agx.usc.wait {group = 1}
// ffma r0, u9h, r0, r10
agx.usc.ffma {long = 1, d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 1, uniform = 19}, s1 = {case = 2, reg = 0, hint = 1, size32 = 1}, s2 = {case = 2, reg = 20, hint = 1, size32 = 1}}
// ffma r4, r3, u8, u6
agx.usc.ffma {long = 1, d0 = {case = 0, reg = 8, size32 = 1}, s0 = {case = 2, reg = 6, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 16, size32 = 1}, s2 = {case = 1, uniform = 12, size32 = 1}}
// ffma r5, r3, u9, u7
agx.usc.ffma {long = 1, d0 = {case = 0, reg = 10, size32 = 1}, s0 = {case = 2, reg = 6, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 18, size32 = 1}, s2 = {case = 1, uniform = 14, size32 = 1}}
// ffma r5, r6, u9, r5
agx.usc.ffma {long = 1, d0 = {case = 0, reg = 10, size32 = 1}, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 18, size32 = 1}, s2 = {case = 2, reg = 10, hint = 1, size32 = 1}}
// intl r2, r2l, r2h
agx.usc.intl {d0 = {case = 0, reg = 4, size32 = 1}, s0 = {case = 2, reg = 4, hint = 1}, s1 = {case = 2, reg = 5, hint = 1}}
// ffs r10, r10
agx.usc.ffs {d0 = {case = 0, reg = 20, size32 = 1}, s0 = {case = 2, reg = 20, hint = 1, size32 = 1}}
// u32_to_f r0l, r0, rte
agx.usc.u32_to_f {round = 1, d0 = {case = 0, reg = 0}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}}
// s32_to_f r0l, r0, rte
agx.usc.s32_to_f {round = 1, d0 = {case = 0, reg = 0}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}}
// f_to_u32 r0, r0l, rtz
agx.usc.f_to_u32 {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1}}
// f_to_u32 r0, r12, rtz
agx.usc.f_to_u32 {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 24, hint = 1, size32 = 1}}
// f_to_s32 r0, r0l, rtz
agx.usc.f_to_s32 {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1}}
// f_to_s32 r0, r12, rtz
agx.usc.f_to_s32 {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 24, hint = 1, size32 = 1}}
// u32_to_f r0, r0, rte
agx.usc.u32_to_f {round = 1, d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}}
// s32_to_f r0, r0, rte
agx.usc.s32_to_f {round = 1, d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}}
// f_to_u32 r1, r1, rtz
agx.usc.f_to_u32 {d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 2, reg = 2, hint = 1, size32 = 1}}
// f_to_s32 r1, r1, rtz
agx.usc.f_to_s32 {d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 2, reg = 2, hint = 1, size32 = 1}}
// u32_to_f r1, r1, rte
agx.usc.u32_to_f {round = 1, d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 2, reg = 2, hint = 1, size32 = 1}}
// s32_to_f r1, r1, rte
agx.usc.s32_to_f {round = 1, d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 2, reg = 2, hint = 1, size32 = 1}}
// f_to_u32 r2, r2, rtz
agx.usc.f_to_u32 {d0 = {case = 0, reg = 4, size32 = 1}, s0 = {case = 2, reg = 4, hint = 1, size32 = 1}}
// f_to_s32 r2, r2, rtz
agx.usc.f_to_s32 {d0 = {case = 0, reg = 4, size32 = 1}, s0 = {case = 2, reg = 4, hint = 1, size32 = 1}}
// u32_to_f r3, r1, rte
agx.usc.u32_to_f {round = 1, d0 = {case = 0, reg = 6, size32 = 1}, s0 = {case = 2, reg = 2, hint = 1, size32 = 1}}
// u32_to_f r3, r2, rte
agx.usc.u32_to_f {round = 1, d0 = {case = 0, reg = 6, size32 = 1}, s0 = {case = 2, reg = 4, hint = 1, size32 = 1}}
// zs_emit 255, r2
agx.usc.zs_emit {s0 = {case = 1, imm = 255}, s1 = {case = 1, reg = 4}}
// update_exec
agx.usc.update_exec {}
// if r16.abs, r17.abs.neg, 1, fneq
agx.usc.if_fcmp {cond = 8, nest = 1, s0 = {case = 2, reg = 32, abs = 1, hint = 1, size32 = 1}, s1 = {case = 2, reg = 34, abs = 1, neg = 1, hint = 1, size32 = 1}}
// else 0.0, 0.0, 1, feq
agx.usc.else_fcmp {nest = 1, s0 = {case = 0, fimm = 0}, s1 = {case = 0, fimm = 0}}
// if 0.0, 0.0, 2, feq
agx.usc.if_fcmp {nest = 2, s0 = {case = 0, fimm = 0}, s1 = {case = 0, fimm = 0}}
// if r2l, u12l, 1, flt
agx.usc.if_fcmp {cond = 1, nest = 1, s0 = {case = 2, reg = 4, hint = 1}, s1 = {case = 1, uniform = 24}}
// store r0, du66, 0, i32, x, a
agx.usc.store {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 0, size32 = 1, mask = 1}, s1 = {case = 1, uniform = 132}, s2 = {case = 1, imm = 0}}
// store r0_r1, du0, r2, lsl 1, i32, xy, a
agx.usc.store {long = 1, shift = 1, format = 2, mask = 3, s0 = {case = 0, reg = 0, size32 = 1, mask = 3}, s1 = {case = 1, uniform = 0}, s2 = {case = 0, reg = 4, zx = 1}}
// store r0_r1, du64, 4, i32, xy, b
agx.usc.store {long = 1, format = 2, mask = 3, waitgroup = 1, s0 = {case = 0, reg = 0, size32 = 1, mask = 3}, s1 = {case = 1, uniform = 128}, s2 = {case = 1, imm = 4}}
// store r1, dr4, 0, i32, x, a
agx.usc.store {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 2, size32 = 1, mask = 1}, s1 = {case = 0, reg = 8}, s2 = {case = 1, imm = 0}}
// store r4_r5_r6_r7, du64, 0, i32, xyzw, a
agx.usc.store {long = 1, format = 2, mask = 15, s0 = {case = 0, reg = 8, size32 = 1, mask = 15}, s1 = {case = 1, uniform = 128}, s2 = {case = 1, imm = 0}}
// store r6, dr8, 4, i32, x, a
agx.usc.store {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 12, size32 = 1, mask = 1}, s1 = {case = 0, reg = 16}, s2 = {case = 1, imm = 4}}
// store r8, dr6, 0, i32, x, a
agx.usc.store {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 16, size32 = 1, mask = 1}, s1 = {case = 0, reg = 12}, s2 = {case = 1, imm = 0}}
// store r8_r9_r10_r11, du0, r4, lsl 2, i32, xyzw, a
agx.usc.store {long = 1, shift = 2, format = 2, mask = 15, s0 = {case = 0, reg = 16, size32 = 1, mask = 15}, s1 = {case = 1, uniform = 0}, s2 = {case = 0, reg = 8, zx = 1}}
// store r9, dr6, 2, i32, x, a
agx.usc.store {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 18, size32 = 1, mask = 1}, s1 = {case = 0, reg = 12}, s2 = {case = 1, imm = 2}}
// store r12, dr8, 0, i32, x, a
agx.usc.store {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 24, size32 = 1, mask = 1}, s1 = {case = 0, reg = 16}, s2 = {case = 1, imm = 0}}
// store r12, dr8, 0, i32, x, b
agx.usc.store {long = 1, format = 2, mask = 1, waitgroup = 1, s0 = {case = 0, reg = 24, size32 = 1, mask = 1}, s1 = {case = 0, reg = 16}, s2 = {case = 1, imm = 0}}
// store r12_r13, dr8, 2, i32, xy, a
agx.usc.store {long = 1, format = 2, mask = 3, s0 = {case = 0, reg = 24, size32 = 1, mask = 3}, s1 = {case = 0, reg = 16}, s2 = {case = 1, imm = 2}}
// store r12, dr10, r7, i32, x, b
agx.usc.store {long = 1, format = 2, mask = 1, waitgroup = 1, s0 = {case = 0, reg = 24, size32 = 1, mask = 1}, s1 = {case = 0, reg = 20}, s2 = {case = 0, reg = 14, zx = 1}}
// pixwait 512, 3
agx.usc.pixwait {i = 512, j = 3}
// pixwait 4, 0
agx.usc.pixwait {i = 4, j = 0}
// pixwait 8, 0
agx.usc.pixwait {i = 8, j = 0}
// pixwait 12, 0
agx.usc.pixwait {i = 12, j = 0}
// ld_tile r0l_r0h_r1l_r1h, 0, 255, 0, u8norm, xyzw
agx.usc.ld_tile {format = 4, mask = 15, offset = 0, d0 = {case = 0, reg = 0, mask = 15}, s0 = {case = 0, imm = 0}, s1 = {case = 1, imm = 255}}
// if r0h, 0, 1, ieq
agx.usc.if_icmp {nest = 1, s0 = {case = 2, reg = 1, hint = 1}, s1 = {case = 0, imm = 0}}
// if r6, 0, 1, ieq
agx.usc.if_icmp {nest = 1, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 0, imm = 0}}
// if r6, 1, 1, ieq
agx.usc.if_icmp {nest = 1, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 0, imm = 1}}
// if r6, 4, 1, ieq
agx.usc.if_icmp {nest = 1, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 0, imm = 4}}
// if r6, 15, 1, ieq
agx.usc.if_icmp {nest = 1, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 0, imm = 15}}
// if r8, 0, 1, ieq
agx.usc.if_icmp {nest = 1, s0 = {case = 2, reg = 16, hint = 1, size32 = 1}, s1 = {case = 0, imm = 0}}
// if r0h, 0, 1, ine
agx.usc.if_icmp {cond = 8, nest = 1, s0 = {case = 2, reg = 1, hint = 1}, s1 = {case = 0, imm = 0}}
// pop_exec 1
agx.usc.pop_exec {nest = 1}
// if r6, r4, 1, ult
agx.usc.if_icmp {cond = 1, nest = 1, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 2, reg = 8, hint = 1, size32 = 1}}
// atomic _, r3, du10, r1.sx, imin, coherent1, a
agx.usc.atomic {op = 5, coherency = 1, d0 = {case = 1}, s0 = {case = 1, reg = 6}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 2}}
// atomic _, r3, du10, r1.sx, or, coherent1, a
agx.usc.atomic {op = 9, coherency = 1, d0 = {case = 1}, s0 = {case = 1, reg = 6}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 2}}
// atomic r1, r4, du10, r5.sx, imin, coherent1, a
agx.usc.atomic {op = 5, coherency = 1, d0 = {case = 0, reg = 2}, s0 = {case = 1, reg = 8}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 10}}
// atomic r1, r4, du10, r5.sx, or, coherent1, a
agx.usc.atomic {op = 9, coherency = 1, d0 = {case = 0, reg = 2}, s0 = {case = 1, reg = 8}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 10}}
// iter r0l_r0h_r1l_r1h, cf1, cf0
agx.usc.iterproj {long = 1, d0 = {case = 0, reg = 0}, s0 = {case = 0, cf = 1}, s1 = {case = 0, cf = 0}, s2 = {case = 2}}
// iter r0_r1, cf1, cf0, 0, sample
agx.usc.iterproj {long = 1, interpolation = 1, d0 = {case = 0, reg = 0, size32 = 1, count = 2}, s0 = {case = 0, cf = 1}, s1 = {case = 0, cf = 0}, s2 = {case = 1, imm = 0}}
// iter r0_r1_r2, cf1, cf0, centroid
agx.usc.iterproj {long = 1, interpolation = 2, d0 = {case = 0, reg = 0, size32 = 1, count = 3}, s0 = {case = 0, cf = 1}, s1 = {case = 0, cf = 0}, s2 = {case = 2}}
// iter r0_r1_r2, cf1, cf0, elide, kill
agx.usc.iterproj {long = 1, elide = 1, kill = 1, d0 = {case = 0, reg = 0, size32 = 1, count = 3}, s0 = {case = 0, cf = 1}, s1 = {case = 0, cf = 0}, s2 = {case = 2}}
// iter r4l_r4h_r5l, cf5, cf0
agx.usc.iterproj {long = 1, d0 = {case = 0, reg = 8, count = 3}, s0 = {case = 0, cf = 5}, s1 = {case = 0, cf = 0}, s2 = {case = 2}}
// iter r4_r5_r6_r7, cf1, cf0, r3l, sample
agx.usc.iterproj {long = 1, interpolation = 3, d0 = {case = 0, reg = 8, size32 = 1}, s0 = {case = 0, cf = 1}, s1 = {case = 0, cf = 0}, s2 = {case = 0, reg = 6}}
// iter r4_r5, cf1, cf0, r1l, sample
agx.usc.iterproj {long = 1, interpolation = 3, d0 = {case = 0, reg = 8, size32 = 1, count = 2}, s0 = {case = 0, cf = 1}, s1 = {case = 0, cf = 0}, s2 = {case = 0, reg = 2}}
// iter r4_r5, cf1, cf0, r3l, sample
agx.usc.iterproj {long = 1, interpolation = 3, d0 = {case = 0, reg = 8, size32 = 1, count = 2}, s0 = {case = 0, cf = 1}, s1 = {case = 0, cf = 0}, s2 = {case = 0, reg = 6}}
// iter r4_r5_r6, cf1, cf0, r1l, sample
agx.usc.iterproj {long = 1, interpolation = 3, d0 = {case = 0, reg = 8, size32 = 1, count = 3}, s0 = {case = 0, cf = 1}, s1 = {case = 0, cf = 0}, s2 = {case = 0, reg = 2}}
// ldimm r0l, 0
agx.usc.ldimm16 {imm = 0, d0 = {case = 0, reg = 0}}
// ldimm r0, 1073741824
agx.usc.ldimm32 {imm = 1073741824, d0 = {case = 0, reg = 0, size32 = 1}}
// ldimm r0h, 0
agx.usc.ldimm16 {imm = 0, d0 = {case = 0, reg = 1}}
// ldimm r1h, 15360
agx.usc.ldimm16 {imm = 15360, d0 = {case = 0, reg = 3}}
// ldimm r1h, 15944
agx.usc.ldimm16 {imm = 15944, d0 = {case = 0, reg = 3}}
// ldimm r2l, 13312
agx.usc.ldimm16 {imm = 13312, d0 = {case = 0, reg = 4}}
// ldimm r2, 3735879680
agx.usc.ldimm32 {imm = 3735879680, d0 = {case = 0, reg = 4, size32 = 1}}
// ldimm r2h, 29696
agx.usc.ldimm16 {imm = 29696, d0 = {case = 0, reg = 5}}
// ldimm r3l, 32768
agx.usc.ldimm16 {imm = 32768, d0 = {case = 0, reg = 6}}
// ldimm r3l, 10975
agx.usc.ldimm16 {imm = 10975, d0 = {case = 0, reg = 6}}
// ldimm r3l, 32767
agx.usc.ldimm16 {imm = 32767, d0 = {case = 0, reg = 6}}
// ldimm r3, 134217727
agx.usc.ldimm32 {imm = 134217727, d0 = {case = 0, reg = 6, size32 = 1}}
// ldimm r3h, 48712
agx.usc.ldimm16 {imm = 48712, d0 = {case = 0, reg = 7}}
// ldimm r4l, 0
agx.usc.ldimm16 {imm = 0, d0 = {case = 0, reg = 8}}
// ldimm r4l, 12852
agx.usc.ldimm16 {imm = 12852, d0 = {case = 0, reg = 8}}
// ldimm r4l, 41526
agx.usc.ldimm16 {imm = 41526, d0 = {case = 0, reg = 8}}
// ldimm r4l, 46419
agx.usc.ldimm16 {imm = 46419, d0 = {case = 0, reg = 8}}
// ldimm r4l, 44931
agx.usc.ldimm16 {imm = 44931, d0 = {case = 0, reg = 8}}
// ldimm r4, 0
agx.usc.ldimm32 {imm = 0, d0 = {case = 0, reg = 8, size32 = 1}}
// ldimm r4, 4294967295
agx.usc.ldimm32 {imm = 4294967295, d0 = {case = 0, reg = 8, size32 = 1}}
// ldimm r4h, 0
agx.usc.ldimm16 {imm = 0, d0 = {case = 0, reg = 9}}
// ldimm r5, 0
agx.usc.ldimm32 {imm = 0, d0 = {case = 0, reg = 10, size32 = 1}}
// ldimm r5h, 15360
agx.usc.ldimm16 {imm = 15360, d0 = {case = 0, reg = 11}}
// ldimm r9, 16383
agx.usc.ldimm32 {imm = 16383, d0 = {case = 0, reg = 18, size32 = 1}}
// ldimm r9, 4294967295
agx.usc.ldimm32 {imm = 4294967295, d0 = {case = 0, reg = 18, size32 = 1}}
// ldimm r10, 4294967280
agx.usc.ldimm32 {imm = 4294967280, d0 = {case = 0, reg = 20, size32 = 1}}
// barrier
agx.usc.barrier {}
// lload r1, 0, i32, x
agx.usc.lload {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 2, size32 = 1, mask = 1}, s0 = {case = 1}, s1 = {case = 1, imm = 0}}
// lload r2, r0l, 0, i32, x
agx.usc.lload {long = 1, format = 2, mask = 1, d0 = {case = 0, reg = 4, size32 = 1, mask = 1}, s0 = {case = 0, reg = 0}, s1 = {case = 1, imm = 0}}
// lload r4_r5, 0, i32, xy
agx.usc.lload {long = 1, format = 2, mask = 3, d0 = {case = 0, reg = 8, size32 = 1, mask = 3}, s0 = {case = 1}, s1 = {case = 1, imm = 0}}
// lload r4_r5_r6, 0, i32, xyz
agx.usc.lload {long = 1, format = 2, mask = 7, d0 = {case = 0, reg = 8, size32 = 1, mask = 7}, s0 = {case = 1}, s1 = {case = 1, imm = 0}}
// lload r4_r5_r6_r7, 0, i32, xyzw
agx.usc.lload {long = 1, format = 2, mask = 15, d0 = {case = 0, reg = 8, size32 = 1, mask = 15}, s0 = {case = 1}, s1 = {case = 1, imm = 0}}
// fadd r11, r8, -0.0, sat
agx.usc.fadd {long = 1, saturate = 1, d0 = {case = 0, reg = 22, size32 = 1}, s0 = {case = 2, reg = 16, hint = 1, size32 = 1}, s1 = {case = 0, fimm = 128}}
// shuffle r0h, r0h, 1, quad, xor
agx.usc.shuffle {op = 1, d0 = {case = 0, reg = 1}, s0 = {case = 2, reg = 1, hint = 1}, s1 = {case = 0, imm = 1}}
// shuffle r0h, r0h, 2, quad, xor
agx.usc.shuffle {op = 1, d0 = {case = 0, reg = 1}, s0 = {case = 2, reg = 1, hint = 1}, s1 = {case = 0, imm = 2}}
// shuffle r0h, r0h, 3, quad, xor
agx.usc.shuffle {op = 1, d0 = {case = 0, reg = 1}, s0 = {case = 2, reg = 1, hint = 1}, s1 = {case = 0, imm = 3}}
// shuffle r4l, r6l, r0h, quad
agx.usc.shuffle {d0 = {case = 0, reg = 8}, s0 = {case = 2, reg = 12, hint = 1}, s1 = {case = 2, reg = 1, hint = 1}}
// shuffle r4h, r6l, 1, quad
agx.usc.shuffle {d0 = {case = 0, reg = 9}, s0 = {case = 2, reg = 12, hint = 1}, s1 = {case = 0, imm = 1}}
// shuffle r4h, r6l, r0h, quad
agx.usc.shuffle {d0 = {case = 0, reg = 9}, s0 = {case = 2, reg = 12, hint = 1}, s1 = {case = 2, reg = 1, hint = 1}}
// shuffle r4h, r6l, 2, quad
agx.usc.shuffle {d0 = {case = 0, reg = 9}, s0 = {case = 2, reg = 12, hint = 1}, s1 = {case = 0, imm = 2}}
// shuffle r6, r6, r0h
agx.usc.shuffle {quad = 1, d0 = {case = 0, reg = 12, size32 = 1}, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 2, reg = 1, hint = 1}}
// shuffle r6h, r6l, 0, quad
agx.usc.shuffle {d0 = {case = 0, reg = 13}, s0 = {case = 2, reg = 12, hint = 1}, s1 = {case = 0, imm = 0}}
// shuffle r6h, r6l, 3, quad
agx.usc.shuffle {d0 = {case = 0, reg = 13}, s0 = {case = 2, reg = 12, hint = 1}, s1 = {case = 0, imm = 3}}
// simd r1l, r2l, prefix, and
agx.usc.simd {prefix = 1, d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 4, hint = 1}}
// simd r1l, r2l, prefix, or
agx.usc.simd {prefix = 1, op = 2, d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 4, hint = 1}}
// simd r1l, r2l, prefix, xor
agx.usc.simd {prefix = 1, op = 4, d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 4, hint = 1}}
// simd r1l, r2l, prefix, smin
agx.usc.simd {prefix = 1, op = 20, d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 4, hint = 1}}
// simd r2l, r3l, prefix, or
agx.usc.simd {prefix = 1, op = 2, d0 = {case = 0, reg = 4}, s0 = {case = 2, reg = 6, hint = 1}}
// simd r2l, r3l, prefix, xor
agx.usc.simd {prefix = 1, op = 4, d0 = {case = 0, reg = 4}, s0 = {case = 2, reg = 6, hint = 1}}
// simd r2h, r2l, prefix, iadd
agx.usc.simd {prefix = 1, op = 16, d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 4, hint = 1}}
// simd r2h, r2l, prefix, or
agx.usc.simd {prefix = 1, op = 2, d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 4, hint = 1}}
// simd r2h, r2l, prefix, xor
agx.usc.simd {prefix = 1, op = 4, d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 4, hint = 1}}
// simd r2h, r2l, prefix, smax
agx.usc.simd {prefix = 1, op = 22, d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 4, hint = 1}}
// simd r3h, r3l, prefix, or
agx.usc.simd {prefix = 1, op = 2, d0 = {case = 0, reg = 7}, s0 = {case = 2, reg = 6, hint = 1}}
// simd r3h, r3l, prefix, xor
agx.usc.simd {prefix = 1, op = 4, d0 = {case = 0, reg = 7}, s0 = {case = 2, reg = 6, hint = 1}}
// simd r6h, r6l, prefix, iadd
agx.usc.simd {prefix = 1, op = 16, d0 = {case = 0, reg = 13}, s0 = {case = 2, reg = 12, hint = 1}}
// simd r7, r6, prefix, iadd
agx.usc.simd {prefix = 1, op = 16, d0 = {case = 0, reg = 14, size32 = 1}, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}}
// smpi r0_r1_r2_r3, ts0, ss0, r2, 0, 2d, xyzw, auto_lod, a
agx.usc.smpi {dim = 2, mask = 15, d0 = {case = 0, reg = 0, size32 = 1, mask = 15}, s0 = {case = 0}, s1 = {case = 0, ts = 0}, s2 = {case = 0, ss = 0}, s3 = {case = 0, reg = 4}, s4 = {case = 0, imm = 0}, s5 = {case = 0}}
// mov r0l, thread_in_grid_x
agx.usc.mfsr {sr = 80, d0 = {case = 0, reg = 0}}
// mov r0h, thread_in_grid_y
agx.usc.mfsr {sr = 81, d0 = {case = 0, reg = 1}}
// mov r1, threadgroup_in_grid_x
agx.usc.mfsr {d0 = {case = 0, reg = 2, size32 = 1}}
// mov r1, thread_in_grid_x
agx.usc.mfsr {sr = 80, d0 = {case = 0, reg = 2, size32 = 1}}
// mov r1, core_index
agx.usc.mfsr {sr = 20, d0 = {case = 0, reg = 2, size32 = 1}}
// mov r2, threadgroup_in_grid_y
agx.usc.mfsr {sr = 1, d0 = {case = 0, reg = 4, size32 = 1}}
// mov r2, thread_in_grid_x
agx.usc.mfsr {sr = 80, d0 = {case = 0, reg = 4, size32 = 1}}
// mov r2, thread_in_grid_y
agx.usc.mfsr {sr = 81, d0 = {case = 0, reg = 4, size32 = 1}}
// mov r2, helper_arg_l
agx.usc.mfsr {sr = 146, d0 = {case = 0, reg = 4, size32 = 1}}
// mov r3, threadgroup_in_grid_z
agx.usc.mfsr {sr = 2, d0 = {case = 0, reg = 6, size32 = 1}}
// mov r3, helper_arg_h
agx.usc.mfsr {sr = 147, d0 = {case = 0, reg = 6, size32 = 1}}
// mov r3, thread_in_threadgroup_x
agx.usc.mfsr {sr = 48, d0 = {case = 0, reg = 6, size32 = 1}}
// mov r6, helper_op
agx.usc.mfsr {sr = 144, d0 = {case = 0, reg = 12, size32 = 1}}
// mov r7, helper_arg_l
agx.usc.mfsr {sr = 146, d0 = {case = 0, reg = 14, size32 = 1}}
// mov r8, thread_in_threadgroup_y
agx.usc.mfsr {sr = 49, d0 = {case = 0, reg = 16, size32 = 1}}
// mov r10l, active_thread_index_in_simdgroup
agx.usc.mfsr {sr = 58, d0 = {case = 0, reg = 20}}
// map r8, 0, 0
agx.usc.map {target = 0, v = 0, s0 = {case = 0, reg = 16}}
// unmap r8, 0, 3
agx.usc.unmap {target = 0, v = 3, s0 = {case = 0, reg = 16}}
// map r9, 0, 1
agx.usc.map {target = 0, v = 1, s0 = {case = 0, reg = 18}}
// map r10, 0, 2
agx.usc.map {target = 0, v = 2, s0 = {case = 0, reg = 20}}
// map r11, 0, 3
agx.usc.map {target = 0, v = 3, s0 = {case = 0, reg = 22}}
// unmap r12, 0, 0
agx.usc.unmap {target = 0, v = 0, s0 = {case = 0, reg = 24}}
// unmap r12, 0, 1
agx.usc.unmap {target = 0, v = 1, s0 = {case = 0, reg = 24}}
// unmap r12, 0, 2
agx.usc.unmap {target = 0, v = 2, s0 = {case = 0, reg = 24}}
// mov r0, r0l
agx.usc.mov {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1}}
// and r0, r0, r9
agx.usc.and {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}, s1 = {case = 2, reg = 18, hint = 1, size32 = 1}}
// andn2 r0, r0, r1
agx.usc.andn2 {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}, s1 = {case = 2, reg = 2, hint = 1, size32 = 1}}
// and r0, r0, 7
agx.usc.and {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}, s1 = {case = 0, imm = 7}}
// and r0, r0, 31
agx.usc.and {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}, s1 = {case = 0, imm = 31}}
// and r0, r15, 15
agx.usc.and {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 2, reg = 30, hint = 1, size32 = 1}, s1 = {case = 0, imm = 15}}
// mov r0, u8
agx.usc.mov {d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 1, uniform = 16, size32 = 1}}
// mov r0h, r10
agx.usc.mov {d0 = {case = 0, reg = 1}, s0 = {case = 2, reg = 20, hint = 1, size32 = 1}}
// mov r1l, u10l
agx.usc.mov {d0 = {case = 0, reg = 2}, s0 = {case = 1, uniform = 20}}
// and r1l, r1l, r3l
agx.usc.and {d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 2, hint = 1}, s1 = {case = 2, reg = 6, hint = 1}}
// or r1l, r2h, r1l
agx.usc.or {d0 = {case = 0, reg = 2}, s0 = {case = 2, reg = 5, hint = 1}, s1 = {case = 2, reg = 2, hint = 1}}
// mov r1, 0
agx.usc.mov {d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 0, imm = 0}}
// mov r1, r0
agx.usc.mov {d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}}
// not r1, r1
agx.usc.not {d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 2, reg = 2, hint = 1, size32 = 1}}
// and r1, r1, u71
agx.usc.and {d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 2, reg = 2, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 142, size32 = 1}}
// and r1, r1, 31
agx.usc.and {d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 2, reg = 2, hint = 1, size32 = 1}, s1 = {case = 0, imm = 31}}
// and r1, r1, 63
agx.usc.and {d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 2, reg = 2, hint = 1, size32 = 1}, s1 = {case = 0, imm = 63}}
// mov r1, r1h
agx.usc.mov {d0 = {case = 0, reg = 2, size32 = 1}, s0 = {case = 2, reg = 3, hint = 1}}
// mov r1h, r2l
agx.usc.mov {d0 = {case = 0, reg = 3}, s0 = {case = 2, reg = 4, hint = 1}}
// mov r1h, r3l
agx.usc.mov {d0 = {case = 0, reg = 3}, s0 = {case = 2, reg = 6, hint = 1}}
// mov r2, r0l
agx.usc.mov {d0 = {case = 0, reg = 4, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1}}
// and r2, r1, u70
agx.usc.and {d0 = {case = 0, reg = 4, size32 = 1}, s0 = {case = 2, reg = 2, hint = 1, size32 = 1}, s1 = {case = 1, uniform = 140, size32 = 1}}
// and r2, r2, r3
agx.usc.and {d0 = {case = 0, reg = 4, size32 = 1}, s0 = {case = 2, reg = 4, hint = 1, size32 = 1}, s1 = {case = 2, reg = 6, hint = 1, size32 = 1}}
// mov r2, u54
agx.usc.mov {d0 = {case = 0, reg = 4, size32 = 1}, s0 = {case = 1, uniform = 108, size32 = 1}}
// and r2h, r2h, r3l
agx.usc.and {d0 = {case = 0, reg = 5}, s0 = {case = 2, reg = 5, hint = 1}, s1 = {case = 2, reg = 6, hint = 1}}
// mov r3, r0h
agx.usc.mov {d0 = {case = 0, reg = 6, size32 = 1}, s0 = {case = 2, reg = 1, hint = 1}}
// mov r3, u55
agx.usc.mov {d0 = {case = 0, reg = 6, size32 = 1}, s0 = {case = 1, uniform = 110, size32 = 1}}
// mov r4l, r4h
agx.usc.mov {d0 = {case = 0, reg = 8}, s0 = {case = 2, reg = 9, hint = 1}}
// mov r4, r0
agx.usc.mov {d0 = {case = 0, reg = 8, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}}
// mov r4, r1l
agx.usc.mov {d0 = {case = 0, reg = 8, size32 = 1}, s0 = {case = 2, reg = 2, hint = 1}}
// or r4, r2, r1
agx.usc.or {d0 = {case = 0, reg = 8, size32 = 1}, s0 = {case = 2, reg = 4, hint = 1, size32 = 1}, s1 = {case = 2, reg = 2, hint = 1, size32 = 1}}
// mov r5, r0
agx.usc.mov {d0 = {case = 0, reg = 10, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}}
// mov r6, r0
agx.usc.mov {d0 = {case = 0, reg = 12, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}}
// mov r6, r4
agx.usc.mov {d0 = {case = 0, reg = 12, size32 = 1}, s0 = {case = 2, reg = 8, hint = 1, size32 = 1}}
// and r6, r6, r9
agx.usc.and {d0 = {case = 0, reg = 12, size32 = 1}, s0 = {case = 2, reg = 12, hint = 1, size32 = 1}, s1 = {case = 2, reg = 18, hint = 1, size32 = 1}}
// mov r7, r0
agx.usc.mov {d0 = {case = 0, reg = 14, size32 = 1}, s0 = {case = 2, reg = 0, hint = 1, size32 = 1}}
// mov r7, r5
agx.usc.mov {d0 = {case = 0, reg = 14, size32 = 1}, s0 = {case = 2, reg = 10, hint = 1, size32 = 1}}
// and r8, r8, 31
agx.usc.and {d0 = {case = 0, reg = 16, size32 = 1}, s0 = {case = 2, reg = 16, hint = 1, size32 = 1}, s1 = {case = 0, imm = 31}}
// mov r9l, r3l
agx.usc.mov {d0 = {case = 0, reg = 18}, s0 = {case = 2, reg = 6, hint = 1}}
// mov r9h, r8l
agx.usc.mov {d0 = {case = 0, reg = 19}, s0 = {case = 2, reg = 16, hint = 1}}
// mov r10, r4
agx.usc.mov {d0 = {case = 0, reg = 20, size32 = 1}, s0 = {case = 2, reg = 8, hint = 1, size32 = 1}}
// mov r11, r2
agx.usc.mov {d0 = {case = 0, reg = 22, size32 = 1}, s0 = {case = 2, reg = 4, hint = 1, size32 = 1}}
// mov r11, r4
agx.usc.mov {d0 = {case = 0, reg = 22, size32 = 1}, s0 = {case = 2, reg = 8, hint = 1, size32 = 1}}
// mov r11, r5
agx.usc.mov {d0 = {case = 0, reg = 22, size32 = 1}, s0 = {case = 2, reg = 10, hint = 1, size32 = 1}}
// mov r11, r26
agx.usc.mov {d0 = {case = 0, reg = 22, size32 = 1}, s0 = {case = 2, reg = 52, hint = 1, size32 = 1}}
// mov r12, $r23
agx.usc.mov {d0 = {case = 0, reg = 24, size32 = 1}, s0 = {case = 2, reg = 46, hint = 2, size32 = 1}}
// mov r13, r24
agx.usc.mov {d0 = {case = 0, reg = 26, size32 = 1}, s0 = {case = 2, reg = 48, hint = 1, size32 = 1}}
// mov r23, $r12
agx.usc.mov {d0 = {case = 0, reg = 46, size32 = 1}, s0 = {case = 2, reg = 24, hint = 2, size32 = 1}}
// mov r24, r13
agx.usc.mov {d0 = {case = 0, reg = 48, size32 = 1}, s0 = {case = 2, reg = 26, hint = 1, size32 = 1}}
// mov r25, $r11
agx.usc.mov {d0 = {case = 0, reg = 50, size32 = 1}, s0 = {case = 2, reg = 22, hint = 2, size32 = 1}}
// load r0h, du6, r2, i16, x, a
agx.usc.load {long = 1, format = 1, mask = 1, d0 = {case = 0, reg = 1, mask = 1}, s0 = {case = 1, uniform = 12}, s1 = {case = 0, reg = 4, zx = 1}}
// stop
agx.usc.stop {}
// iadd $r2, 0, $r11, lsl 1
agx.usc.iadd {shift = 1, d0 = {case = 1, reg = 4, cache = 1}, s0 = {case = 0, imm = 0}, s1 = {case = 2, reg = 22, hint = 2, size32 = 1}}
// iadd $r2, r11, r25
agx.usc.iadd {d0 = {case = 1, reg = 4, cache = 1}, s0 = {case = 2, reg = 22, hint = 1, size32 = 1}, s1 = {case = 2, reg = 50, hint = 1, size32 = 1}}
// st_var r0, 8, last
agx.usc.st_var {last = 1, s0 = {case = 0, reg = 0}, s1 = {case = 1, imm = 8}}
// atomic _, r3, du10, r1.sx, xchg, coherent1, a
agx.usc.atomic {op = 2, coherency = 1, d0 = {case = 1}, s0 = {case = 1, reg = 6}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 2}}
// atomic _, r3, du10, r1.sx, xor, coherent1, a
agx.usc.atomic {op = 10, coherency = 1, d0 = {case = 1}, s0 = {case = 1, reg = 6}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 2}}
// atomic r1, r4, du10, r5.sx, xchg, coherent1, a
agx.usc.atomic {op = 2, coherency = 1, d0 = {case = 0, reg = 2}, s0 = {case = 1, reg = 8}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 10}}
// atomic r1, r4, du10, r5.sx, xor, coherent1, a
agx.usc.atomic {op = 10, coherency = 1, d0 = {case = 0, reg = 2}, s0 = {case = 1, reg = 8}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 10}}
// ldcf r0_r1_r2, cf0
agx.usc.ldcf {long = 1, d0 = {case = 0, reg = 0, size32 = 1}, s0 = {case = 0, cf = 0}, s1 = {case = 2}}
// ldcf r4_r5_r6, cf1
agx.usc.ldcf {long = 1, d0 = {case = 0, reg = 8, size32 = 1}, s0 = {case = 0, cf = 1}, s1 = {case = 2}}
// ldcf r4_r5_r6, cf2
agx.usc.ldcf {long = 1, d0 = {case = 0, reg = 8, size32 = 1}, s0 = {case = 0, cf = 2}, s1 = {case = 2}}
// ldcf r4_r5_r6, cf3
agx.usc.ldcf {long = 1, d0 = {case = 0, reg = 8, size32 = 1}, s0 = {case = 0, cf = 3}, s1 = {case = 2}}
// load ss1, du4, r1, a
agx.usc.sampler_state_store {d0 = {case = 0, ss = 1}, s0 = {case = 0, uniform = 8}, s1 = {case = 0, reg = 2}}
// load ss1, du8, 88, b
agx.usc.sampler_state_store {group = 1, d0 = {case = 0, ss = 1}, s0 = {case = 0, uniform = 16}, s1 = {case = 1, imm = 88}}
// imgwblk r0l, ts0, r0, 0, 2d, u8norm
agx.usc.imgwblk {long = 1, dim = 2, format = 4, s0 = {case = 0, reg = 0}, s1 = {case = 0}, s2 = {case = 0, ts = 0}, s3 = {case = 0, reg = 0}, s4 = {case = 1, imm = 0}}
// imgwblk r1l, ts2, r2, 0, explicit_coords, 2d, u8norm
agx.usc.imgwblk {long = 1, explicit_coords = 1, dim = 2, format = 4, s0 = {case = 0, reg = 2}, s1 = {case = 0}, s2 = {case = 0, ts = 2}, s3 = {case = 0, reg = 4}, s4 = {case = 1, imm = 0}}
// imgwblk r2l, ts0, r3, 0, 2d_ms_array, u8norm
agx.usc.imgwblk {long = 1, dim = 8, format = 4, s0 = {case = 0, reg = 4}, s1 = {case = 0}, s2 = {case = 0, ts = 0}, s3 = {case = 0, reg = 6}, s4 = {case = 1, imm = 0}}
// stack_adjust 8
agx.usc.stack_adjust {s0 = {case = 1, imm = 8}}
// stack_adjust 56
agx.usc.stack_adjust {long = 1, s0 = {case = 1, imm = 56}}
// stack_adjust -8
agx.usc.stack_adjust {long = 1, s0 = {case = 1, imm = 65528}}
// stack_store r1l_r1h, 16, i16, xy, a
agx.usc.stack_store {long = 1, format = 1, mask = 3, s0 = {case = 0, reg = 2, mask = 3}, s1 = {case = 1, imm = 16}}
// stack_store r4l, 8, i16, x, a
agx.usc.stack_store {long = 1, format = 1, mask = 1, s0 = {case = 0, reg = 8, mask = 1}, s1 = {case = 1, imm = 8}}
// stack_store r4, 0, i32, x, a
agx.usc.stack_store {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 8, size32 = 1, mask = 1}, s1 = {case = 1, imm = 0}}
// stack_store r4, 20, i32, x, a
agx.usc.stack_store {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 8, size32 = 1, mask = 1}, s1 = {case = 1, imm = 20}}
// stack_store r4, 4, i32, x, b
agx.usc.stack_store {long = 1, format = 2, mask = 1, waitgroup = 1, s0 = {case = 0, reg = 8, size32 = 1, mask = 1}, s1 = {case = 1, imm = 4}}
// stack_store r4, 12, i32, x, a
agx.usc.stack_store {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 8, size32 = 1, mask = 1}, s1 = {case = 1, imm = 12}}
// stack_store r7, 24, i32, x, a
agx.usc.stack_store {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 14, size32 = 1, mask = 1}, s1 = {case = 1, imm = 24}}
// stack_store r10, 20, i32, x, a
agx.usc.stack_store {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 20, size32 = 1, mask = 1}, s1 = {case = 1, imm = 20}}
// stack_store r11, 16, i32, x, a
agx.usc.stack_store {long = 1, format = 2, mask = 1, s0 = {case = 0, reg = 22, size32 = 1, mask = 1}, s1 = {case = 1, imm = 16}}
// stack_store r23l_r23h, 12, i16, xy, a
agx.usc.stack_store {long = 1, format = 1, mask = 3, s0 = {case = 0, reg = 46, mask = 3}, s1 = {case = 1, imm = 12}}
// stack_store r24l_r24h, 8, i16, xy, a
agx.usc.stack_store {long = 1, format = 1, mask = 3, s0 = {case = 0, reg = 48, mask = 3}, s1 = {case = 1, imm = 8}}
// stack_store r25l_r25h, 4, i16, xy, a
agx.usc.stack_store {long = 1, format = 1, mask = 3, s0 = {case = 0, reg = 50, mask = 3}, s1 = {case = 1, imm = 4}}
// stack_store r26l_r26h, 0, i16, xy, a
agx.usc.stack_store {long = 1, format = 1, mask = 3, s0 = {case = 0, reg = 52, mask = 3}, s1 = {case = 1, imm = 0}}
// sample_mask r0l, r0h
agx.usc.sample_mask {s0 = {case = 0, reg = 0}, s1 = {case = 0, reg = 1}}
// sample_mask r0l, 0
agx.usc.sample_mask {s0 = {case = 0, reg = 0}, s1 = {case = 1, imm = 0}}
// sample_mask r0h, r0l
agx.usc.sample_mask {s0 = {case = 0, reg = 1}, s1 = {case = 0, reg = 0}}
// sample_mask r0h, 0
agx.usc.sample_mask {s0 = {case = 0, reg = 1}, s1 = {case = 1, imm = 0}}
// sample_mask r0h, 255
agx.usc.sample_mask {s0 = {case = 0, reg = 1}, s1 = {case = 1, imm = 255}}
// sample_mask 255, 0
agx.usc.sample_mask {s0 = {case = 1, imm = 255}, s1 = {case = 1, imm = 0}}
// mov du64, dr0
agx.usc.uniform_store {long = 1, d0 = {case = 0, uniform = 128}, s0 = {case = 0, reg = 0}}
// mov u72, r0
agx.usc.uniform_store {long = 1, d0 = {case = 1, uniform = 144}, s0 = {case = 1, reg = 0}}
// mov u10, r0
agx.usc.uniform_store {long = 1, d0 = {case = 1, uniform = 20}, s0 = {case = 1, reg = 0}}
// mov du74, dr0
agx.usc.uniform_store {long = 1, d0 = {case = 0, uniform = 148}, s0 = {case = 0, reg = 0}}
// store r0l_r0h, du2, r2, lsl 1, i16, xy, a
agx.usc.store {long = 1, shift = 1, format = 1, mask = 3, s0 = {case = 0, reg = 0, mask = 3}, s1 = {case = 1, uniform = 4}, s2 = {case = 0, reg = 4, zx = 1}}
// mov u69, r0
agx.usc.uniform_store {long = 1, d0 = {case = 1, uniform = 138}, s0 = {case = 1, reg = 0}}
// mov u70, r1
agx.usc.uniform_store {long = 1, d0 = {case = 1, uniform = 140}, s0 = {case = 1, reg = 2}}
// mov u71, r1
agx.usc.uniform_store {long = 1, d0 = {case = 1, uniform = 142}, s0 = {case = 1, reg = 2}}
// mov u66, r2
agx.usc.uniform_store {long = 1, d0 = {case = 1, uniform = 132}, s0 = {case = 1, reg = 4}}
// mov u68, r4
agx.usc.uniform_store {long = 1, d0 = {case = 1, uniform = 136}, s0 = {case = 1, reg = 8}}
// mov u21l_u21h_u22l, r4l_r4h_r5l
agx.usc.uniform_store {long = 1, d0 = {case = 3, uniform = 42}, s0 = {case = 3, reg = 8}}
// mov u20h_u21l, r5
agx.usc.uniform_store {long = 1, d0 = {case = 4, uniform = 41}, s0 = {case = 1, reg = 10}}
// mov u67, r6
agx.usc.uniform_store {long = 1, d0 = {case = 1, uniform = 134}, s0 = {case = 1, reg = 12}}
// iadd $r1, $r3, 4, sat
agx.usc.iadd {saturate = 1, d0 = {case = 1, reg = 2, cache = 1}, s0 = {case = 2, reg = 6, hint = 2, size32 = 1}, s1 = {case = 0, imm = 4}}
// pop_exec 2, cache
agx.usc.pop_exec {cache = 1, nest = 2}
// if $r2, 0, 1, cache, seq
agx.usc.if_icmp {cache = 1, cond = 4, nest = 1, s0 = {case = 2, reg = 4, hint = 2, size32 = 1}, s1 = {case = 0, imm = 0}}
// atomic _, r6_r7, du12, r3.sx, cmpxchg, coherent1, a
agx.usc.atomic {op = 3, coherency = 1, d0 = {case = 1}, s0 = {case = 0, reg = 12}, s1 = {case = 1, uniform = 24}, s2 = {case = 0, reg = 6}}
// atomic _, r3, du10, r1.sx, imax, coherent1, a
agx.usc.atomic {op = 7, coherency = 1, d0 = {case = 1}, s0 = {case = 1, reg = 6}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 2}}
// atomic r1, r8_r9, du12, r1.sx, cmpxchg, coherent1, a
agx.usc.atomic {op = 3, coherency = 1, d0 = {case = 0, reg = 2}, s0 = {case = 0, reg = 16}, s1 = {case = 1, uniform = 24}, s2 = {case = 0, reg = 2}}
// atomic r1, r4, du10, r5.sx, imax, coherent1, a
agx.usc.atomic {op = 7, coherency = 1, d0 = {case = 0, reg = 2}, s0 = {case = 1, reg = 8}, s1 = {case = 1, uniform = 20}, s2 = {case = 0, reg = 10}}
// load ts0, du8, 64, a
agx.usc.tex_state_store {d0 = {case = 0, ts = 0}, s0 = {case = 0, uniform = 16}, s1 = {case = 1, imm = 64}}
// load ts1, du0, r1, a
agx.usc.tex_state_store {d0 = {case = 0, ts = 1}, s0 = {case = 0, uniform = 0}, s1 = {case = 0, reg = 2}}
// load ts2, du2, r1, a
agx.usc.tex_state_store {d0 = {case = 0, ts = 2}, s0 = {case = 0, uniform = 4}, s1 = {case = 0, reg = 2}}
// load ts2, du6, r1, a
agx.usc.tex_state_store {d0 = {case = 0, ts = 2}, s0 = {case = 0, uniform = 12}, s1 = {case = 0, reg = 2}}
// imgw r20_r21_r22_r23, ts5, r16, 0, 2d
agx.usc.imgw {dim = 2, s0 = {case = 1, reg = 40}, s1 = {case = 0}, s2 = {case = 0, ts = 5}, s3 = {case = 0, reg = 32}, s4 = {case = 1, imm = 0}}
// imgw r8_r9_r10_r11, du54, r1, r6, 0, 2d
agx.usc.imgw {long = 1, dim = 2, s0 = {case = 1, reg = 16}, s1 = {case = 1, uniform = 108}, s2 = {case = 3, reg = 2}, s3 = {case = 0, reg = 12}, s4 = {case = 1, imm = 0}}
// unknown_barrier_2
agx.usc.unknown_barrier_2 {}
// unknown_barrier_1
agx.usc.unknown_barrier_1 {}
// flush_memory_to_texture
agx.usc.flush_memory_to_texture {}
// memory_barrier
agx.usc.memory_barrier {}
// memory_barrier_3
agx.usc.memory_barrier_3 {}
// memory_barrier_2
agx.usc.memory_barrier_2 {}
// image_barrier_3
agx.usc.image_barrier_3 {}
// image_barrier_1
agx.usc.image_barrier_1 {}
// image_barrier_4
agx.usc.image_barrier_4 {}
// image_barrier_2
agx.usc.image_barrier_2 {}

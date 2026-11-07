// add (16) r10<1>:f r11<1;1,0>:f r12<1;1,0>:f
xe3.eu.add {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<1;1,0>:f", src1 = "r12<1;1,0>:f"}
// add (32) r10<1>:f r12<1;1,0>:f r14<1;1,0>:f
xe3.eu.add {exec = 32, dst = "r10<1;1,0>:f", src0 = "r12<1;1,0>:f", src1 = "r14<1;1,0>:f"}
// add (8) r10<1>:d r11<1;1,0>:d -r12<1;1,0>:d
xe3.eu.add {exec = 8, dst = "r10<1;1,0>:d", src0 = "r11<1;1,0>:d", src1 = "-r12<1;1,0>:d"}
// mul (16) r10<1>:f -(abs)r11<1;1,0>:f (abs)r12<1;1,0>:f
xe3.eu.mul {exec = 16, dst = "r10<1;1,0>:f", src0 = "-(abs)r11<1;1,0>:f", src1 = "(abs)r12<1;1,0>:f"}
// add.sat (16) r10<1>:f r11<1;1,0>:f 0x3f800000:f
xe3.eu.add {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<1;1,0>:f", src1 = "0x3f800000:f", sat}
// mov (16) r20<1>:ud 0x12345678:ud
xe3.eu.mov {exec = 16, dst = "r20<1;1,0>:ud", src0 = "0x12345678:ud"}
// mov (16) r20<1>:d -7:d
xe3.eu.mov {exec = 16, dst = "r20<1;1,0>:d", src0 = "0xfffffff9:d"}
// mov (16) r11<1>:d r21.3<32;8,4>:ub
xe3.eu.mov {exec = 16, dst = "r11<1;1,0>:d", src0 = "r21.3<32;8,4>:ub"}
// mov (16) r10<1>:f r20.0<32;8,4>:ub
xe3.eu.mov {exec = 16, dst = "r10<1;1,0>:f", src0 = "r20<32;8,4>:ub"}
// (W) mov (1) r3.2<1>:ud r4.1<0;1,0>:ud
xe3.eu.mov {exec = 1, dst = "r3.8<1;1,0>:ud", src0 = "r4.4<0;1,0>:ud", w}
// mov (16) r3.1<2>:uw r4.3<0;1,0>:uw
xe3.eu.mov {exec = 16, dst = "r3.2<0;1,2>:uw", src0 = "r4.6<0;1,0>:uw"}
// mov (8) r30<1>:ud r31<2;1,0>:ud
xe3.eu.mov {exec = 8, dst = "r30<1;1,0>:ud", src0 = "r31<2;1,0>:ud"}
// mov (16) r30<1>:f r31<8;8,1>:f
xe3.eu.mov {exec = 16, dst = "r30<1;1,0>:f", src0 = "r31<8;8,1>:f"}
// mov (16) r30<1>:d r31<1;1,0>:f
xe3.eu.mov {exec = 16, dst = "r30<1;1,0>:d", src0 = "r31<1;1,0>:f"}
// mov (16) r30<1>:uw 0x76543210:uv
xe3.eu.mov {exec = 16, dst = "r30<1;1,0>:uw", src0 = "0x76543210:uv"}
// mov (8) r30<1>:df 0x3ff0000000000000:df
xe3.eu.mov {exec = 8, dst = "r30<1;1,0>:df", src0 = "0x3ff0000000000000:df"}
// mov (16|M16) r30<1>:f r31<1;1,0>:f
xe3.eu.mov {exec = 16, chan = 16, dst = "r30<1;1,0>:f", src0 = "r31<1;1,0>:f"}
// rndd (16) r40<1>:f r41<1;1,0>:f
xe3.eu.rndd {exec = 16, dst = "r40<1;1,0>:f", src0 = "r41<1;1,0>:f"}
// frc (16) r40<1>:f r41<1;1,0>:f
xe3.eu.frc {exec = 16, dst = "r40<1;1,0>:f", src0 = "r41<1;1,0>:f"}
// and (16) r40<1>:ud r41<1;1,0>:ud 0xff:ud
xe3.eu.and {exec = 16, dst = "r40<1;1,0>:ud", src0 = "r41<1;1,0>:ud", src1 = "0xff:ud"}
// shl (16) r40<1>:ud r41<1;1,0>:ud 0x2:ud
xe3.eu.shl {exec = 16, dst = "r40<1;1,0>:ud", src0 = "r41<1;1,0>:ud", src1 = "0x2:ud"}
// cmp (16) (lt)f0.0 null<1>:f r2<1;1,0>:f 0x3f800000:f
xe3.eu.cmp {exec = 16, dst = "null<1;1,0>:f", src0 = "r2<1;1,0>:f", src1 = "0x3f800000:f", cond = "lt", flag = "f0.0"}
// cmp (16) (ge)f1.1 r9<1>:f r2<1;1,0>:f r3<1;1,0>:f
xe3.eu.cmp {exec = 16, dst = "r9<1;1,0>:f", src0 = "r2<1;1,0>:f", src1 = "r3<1;1,0>:f", cond = "ge", flag = "f1.1"}
// (f0.0) sel (16) r5<1>:f r6<1;1,0>:f r7<1;1,0>:f
xe3.eu.sel {exec = 16, dst = "r5<1;1,0>:f", src0 = "r6<1;1,0>:f", src1 = "r7<1;1,0>:f", pred = "normal", flag = "f0.0"}
// (~f1.0) sel (16) r5<1>:f r6<1;1,0>:f r7<1;1,0>:f
xe3.eu.sel {exec = 16, dst = "r5<1;1,0>:f", src0 = "r6<1;1,0>:f", src1 = "r7<1;1,0>:f", pred = "normal", pred_inv, flag = "f1.0"}
// sel (16) (lt)f0.0 r5<1>:f r6<1;1,0>:f r7<1;1,0>:f
xe3.eu.sel {exec = 16, dst = "r5<1;1,0>:f", src0 = "r6<1;1,0>:f", src1 = "r7<1;1,0>:f", cond = "lt", flag = "f0.0"}
// math.inv (16) r10<1>:f r11<1;1,0>:f null<1;1,0>:f
xe3.eu.math {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<1;1,0>:f", src1 = "null<1;1,0>:f", fn = "inv"}
// math.rsq (16) r10<1>:f r11<1;1,0>:f null<1;1,0>:f
xe3.eu.math {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<1;1,0>:f", src1 = "null<1;1,0>:f", fn = "rsq"}
// math.exp (16) r10<1>:f r11<1;1,0>:f null<1;1,0>:f
xe3.eu.math {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<1;1,0>:f", src1 = "null<1;1,0>:f", fn = "exp"}
// math.sin (16) r10<1>:f r11<1;1,0>:f null<1;1,0>:f
xe3.eu.math {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<1;1,0>:f", src1 = "null<1;1,0>:f", fn = "sin"}
// mad (16) r10<1>:f r11<1;0>:f r12<1;0>:f r13<1>:f
xe3.eu.mad {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<1;1,0>:f", src1 = "r12<1;1,0>:f", src2 = "r13<1;1,0>:f"}
// mad (16) r10<1>:f r11<0;0>:f r12<1;0>:f r13<0>:f
xe3.eu.mad {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<0;1,0>:f", src1 = "r12<1;1,0>:f", src2 = "r13<0;1,0>:f"}
// mad (16) r10<1>:f -r11<1;0>:f r12<1;0>:f (abs)r13<1>:f
xe3.eu.mad {exec = 16, dst = "r10<1;1,0>:f", src0 = "-r11<1;1,0>:f", src1 = "r12<1;1,0>:f", src2 = "(abs)r13<1;1,0>:f"}
// add3 (16) r10<1>:d r11<1;0>:d r12<1;0>:d r13<1>:d
xe3.eu.add3 {exec = 16, dst = "r10<1;1,0>:d", src0 = "r11<1;1,0>:d", src1 = "r12<1;1,0>:d", src2 = "r13<1;1,0>:d"}
// csel (16) (lt)f0.0 r10<1>:f r11<1;0>:f r12<1;0>:f r13<1>:f
xe3.eu.csel {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<1;1,0>:f", src1 = "r12<1;1,0>:f", src2 = "r13<1;1,0>:f", cond = "lt", flag = "f0.0"}
// add (16) r10<1>:f r11<1;1,0>:f r12<1;1,0>:f {F@1}
xe3.eu.add {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<1;1,0>:f", src1 = "r12<1;1,0>:f", swsb = "F@1"}
// add (16) r10<1>:d r11<1;1,0>:d r12<1;1,0>:d {I@3}
xe3.eu.add {exec = 16, dst = "r10<1;1,0>:d", src0 = "r11<1;1,0>:d", src1 = "r12<1;1,0>:d", swsb = "I@3"}
// add (16) r10<1>:f r11<1;1,0>:f r12<1;1,0>:f {A@7}
xe3.eu.add {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<1;1,0>:f", src1 = "r12<1;1,0>:f", swsb = "A@7"}
// add (16) r10<1>:f r11<1;1,0>:f r12<1;1,0>:f {$5.dst}
xe3.eu.add {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<1;1,0>:f", src1 = "r12<1;1,0>:f", swsb = "$5.dst"}
// add (16) r10<1>:f r11<1;1,0>:f r12<1;1,0>:f {$31.src}
xe3.eu.add {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<1;1,0>:f", src1 = "r12<1;1,0>:f", swsb = "$31.src"}
// add (16) r10<1>:f r11<1;1,0>:f r12<1;1,0>:f {F@2,$4.dst}
xe3.eu.add {exec = 16, dst = "r10<1;1,0>:f", src0 = "r11<1;1,0>:f", src1 = "r12<1;1,0>:f", swsb = "F@2,$4.dst"}
// sync.nop (1) null<0;1,0>:ub {$3.dst}
xe3.eu.sync {exec = 1, src0 = "null<0;1,0>:ub", swsb = "$3.dst", fn = "nop"}
// sync.allrd (1) null<0;1,0>:ub
xe3.eu.sync {exec = 1, src0 = "null<0;1,0>:ub", fn = "allrd"}
// send.ugm (16) r6 r5 null:0 0x0 0x08200580 {$1}
xe3.eu.send {exec = 16, dst = "r6<1;1,0>:ud", src0 = "r5<1;1,0>:ud", swsb = "$1", sfid = "ugm", desc = 0x08200580}
// send.ugm (16) null r5 r7:2 0x80 0x04000584 {$2}
xe3.eu.send {exec = 16, src0 = "r5<1;1,0>:ud", src1 = "r7<1;1,0>:ud", swsb = "$2", sfid = "ugm", desc = 0x04000584, src1_len = 2}
// send.smpl (16) r20 r10 null:0 0x0 0x0a42c001 {$3}
xe3.eu.send {exec = 16, dst = "r20<1;1,0>:ud", src0 = "r10<1;1,0>:ud", swsb = "$3", sfid = "sampler", desc = 0x0a42c001}
// send.render (16) null r116 r124:4 0x100 0x0c031000 {EOT}
xe3.eu.send {exec = 16, src0 = "r116<1;1,0>:ud", src1 = "r124<1;1,0>:ud", sfid = "render", desc = 0x0c031000, src1_len = 4, eot}
// send.ugm (16) r40 r36 null:0 0x0 0x08200580
xe3.eu.send {exec = 16, dst = "r40<1;1,0>:ud", src0 = "r36<1;1,0>:ud", sfid = "ugm", desc = 0x08200580}
// (f0.0) while (16|M0) -96
xe3.eu.while {exec = 16, pred = "normal", flag = "f0.0", jip = -96}
// (f1.0) while (16|M0) -1024
xe3.eu.while {exec = 16, pred = "normal", flag = "f1.0", jip = -1024}
// sync.allwr (1) null<0;1,0>:ub
xe3.eu.sync {exec = 1, src0 = "null<0;1,0>:ub", fn = "allwr"}
// dpas.8x8 (16) r10:f r10:f r30:hf r40:hf
xe3.eu.dpas {exec = 16, dst = "r10<1;1,0>:f", src0 = "r10<1;1,0>:f", src1 = "r30<1;1,0>:hf", src2 = "r40<1;1,0>:hf", sdepth = 8, rcount = 8}
// dpas.8x8 (16) r10:f r10:f r30:bf r40:bf {$3}
xe3.eu.dpas {exec = 16, dst = "r10<1;1,0>:f", src0 = "r10<1;1,0>:f", src1 = "r30<1;1,0>:bf", src2 = "r40<1;1,0>:bf", swsb = "$3", sdepth = 8, rcount = 8}
// dpas.8x8 (16) r10:f r10:f r30:hf r40:hf {$4.dst}
xe3.eu.dpas {exec = 16, dst = "r10<1;1,0>:f", src0 = "r10<1;1,0>:f", src1 = "r30<1;1,0>:hf", src2 = "r40<1;1,0>:hf", swsb = "$4.dst", sdepth = 8, rcount = 8}
// dpas.8x4 (16) r20:f null:f r30:hf r40:hf
xe3.eu.dpas {exec = 16, dst = "r20<1;1,0>:f", src0 = "null<1;1,0>:f", src1 = "r30<1;1,0>:hf", src2 = "r40<1;1,0>:hf", sdepth = 8, rcount = 4}
// dpas.8x8 (16) r10:d r10:d r30:b r40:b
xe3.eu.dpas {exec = 16, dst = "r10<1;1,0>:d", src0 = "r10<1;1,0>:d", src1 = "r30<1;1,0>:b", src2 = "r40<1;1,0>:b", sdepth = 8, rcount = 8}
// dpas.8x8 (16) r10:d r10:d r30:ub r40:b
xe3.eu.dpas {exec = 16, dst = "r10<1;1,0>:d", src0 = "r10<1;1,0>:d", src1 = "r30<1;1,0>:ub", src2 = "r40<1;1,0>:b", sdepth = 8, rcount = 8}
// (W) load_block2d.ugm.d16.a64 (1|M0) r10:8 [r80:1]
xe3.eu.send {exec = 1, dst = "r10<1;1,0>:ud", src0 = "r80<1;1,0>:ud", w, sfid = "ugm", desc = 0x02800203}
// (W) load_block2d.ugm.d16v.a64 (1|M0) r10:8 [r80:1]
xe3.eu.send {exec = 1, dst = "r10<1;1,0>:ud", src0 = "r80<1;1,0>:ud", w, sfid = "ugm", desc = 0x02800283}
// (W) load_block2d.ugm.d16v.a64 (1|M0) r10:16 [r80:1] {$5}
xe3.eu.send {exec = 1, dst = "r10<1;1,0>:ud", src0 = "r80<1;1,0>:ud", w, swsb = "$5", sfid = "ugm", desc = 0x03000283}
// (W) load_block2d.ugm.d32t.a64 (1|M0) r10:8 [r80:1]
xe3.eu.send {exec = 1, dst = "r10<1;1,0>:ud", src0 = "r80<1;1,0>:ud", w, sfid = "ugm", desc = 0x02808403}
// (W) load_block2d.ugm.d16.a64 (1|M0) r10:16 [r80:1 + (8, -2)]
xe3.eu.send {exec = 1, dst = "r10<1;1,0>:ud", src0 = "r80<1;1,0>:ud", w, sfid = "ugm", desc = 0x03000203, ex_desc = 0xff808000}
// (W) load_block2d.ugm.d16.a64 (1|M0) null:0 [r80:1]
xe3.eu.send {exec = 1, src0 = "r80<1;1,0>:ud", w, sfid = "ugm", desc = 0x02000203}
// (W) load_block2d.ugm.d16.a64.wt.wb (1|M0) r10:8 [r80:1]
xe3.eu.send {exec = 1, dst = "r10<1;1,0>:ud", src0 = "r80<1;1,0>:ud", w, sfid = "ugm", desc = 0x02880203}
// (W) load_block2d.ugm.d16.a64.uc.uc (1|M0) r10:8 [r80:1]
xe3.eu.send {exec = 1, dst = "r10<1;1,0>:ud", src0 = "r80<1;1,0>:ud", w, sfid = "ugm", desc = 0x02820203}
// (W) store_block2d.ugm.d32.a64 (1|M0) [r80:1] r20:8
xe3.eu.send {exec = 1, src0 = "r80<1;1,0>:ud", src1 = "r20<1;1,0>:ud", w, sfid = "ugm", desc = 0x02000407, src1_len = 8}
// (W) store_block2d.ugm.d16.a64.uc.wb (1|M0) [r80:1] r20:8
xe3.eu.send {exec = 1, src0 = "r80<1;1,0>:ud", src1 = "r20<1;1,0>:ud", w, sfid = "ugm", desc = 0x02040207, src1_len = 8}

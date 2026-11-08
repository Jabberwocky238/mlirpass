// The instructions of acgpu's `ints` kernel as the M4 ran them (160 of 160 results right, 2026-11-08), in its order;
// tests/agx/g16.expected their bytes (scripts/agx_g16_metal.swift ran them).
agx.g16.get_sr {dst = 0, selector = 160}
agx.g16.load {dst = 2, index = 0, binding = 0, components = 2, shift = 3, wait = 1}
agx.g16.mov_imm {dst = 1, value = 31}
agx.g16.mov_imm {dst = 14, value = 0}
agx.g16.mov_imm {dst = 24, value = 0}
agx.g16.mov_imm {dst = 25, value = 1}
agx.g16.mov_imm {dst = 26, value = 4294967295}
agx.g16.iadd {dst = 4, a = 2, b = 3, wait = 32}
agx.g16.isub {dst = 5, a = 2, b = 3}
agx.g16.imad {dst = 6, a = 2, b = 3, c = 24}
agx.g16.and {dst = 27, a = 3, b = 1}
agx.g16.shl {dst = 7, a = 2, b = 27}
agx.g16.shr {dst = 8, a = 2, b = 27}
agx.g16.asr {dst = 9, a = 2, b = 27}
agx.g16.and {dst = 10, a = 2, b = 3}
agx.g16.or {dst = 11, a = 2, b = 3}
agx.g16.xor {dst = 12, a = 2, b = 3}
agx.g16.smin {dst = 13, a = 2, b = 3}
agx.g16.smax {dst = 14, a = 2, b = 3}
agx.g16.umin {dst = 15, a = 2, b = 3}
agx.g16.umax {dst = 16, a = 2, b = 3}
agx.g16.select {dst = 17, a = 2, b = 3, t = 2, f = 3, cond = "ilt"}
agx.g16.select {dst = 18, a = 2, b = 3, t = 25, f = 24, cond = "ult"}
agx.g16.select {dst = 28, a = 2, b = 3, t = 24, f = 26, cond = "ilt"}
agx.g16.select {dst = 19, a = 3, b = 2, t = 24, f = 28, cond = "ilt"}
agx.g16.i2f {dst = 20, a = 2, signed = true}
agx.g16.i2f {dst = 21, a = 2}
agx.g16.mov_imm {dst = 29, value = 1052602532}
agx.g16.mov_imm {dst = 30, value = 1065353216}
agx.g16.fmul {dst = 31, a = 20, b = 29}
agx.g16.fmul {dst = 32, a = 31, b = 30, abs = 1}
agx.g16.f2i {dst = 22, a = 31, signed = true}
agx.g16.f2i {dst = 23, a = 32}
agx.g16.store {data = 4, index = 0, binding = 1, components = 4, shift = 4}
agx.g16.store {data = 8, index = 0, binding = 2, components = 4, shift = 4}
agx.g16.store {data = 12, index = 0, binding = 3, components = 4, shift = 4}
agx.g16.store {data = 16, index = 0, binding = 4, components = 4, shift = 4}
agx.g16.store {data = 20, index = 0, binding = 5, components = 4, shift = 4}
agx.g16.halt {}

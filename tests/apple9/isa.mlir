// The instructions of acgpu's `ints` kernel as the M4 ran them (160 of 160 results right, 2026-11-08), in its order;
// tests/apple9/isa.expected their bytes (scripts/apple9_metal.swift ran them).
apple9.get_sr {dst = 0, selector = 160}
apple9.load {dst = 2, index = 0, binding = 0, components = 2, shift = 3, wait = 1}
apple9.mov_imm {dst = 1, value = 31}
apple9.mov_imm {dst = 14, value = 0}
apple9.mov_imm {dst = 24, value = 0}
apple9.mov_imm {dst = 25, value = 1}
apple9.mov_imm {dst = 26, value = 4294967295}
apple9.iadd {dst = 4, a = 2, b = 3, wait = 32}
apple9.isub {dst = 5, a = 2, b = 3}
apple9.imad {dst = 6, a = 2, b = 3, c = 24}
apple9.and {dst = 27, a = 3, b = 1}
apple9.shl {dst = 7, a = 2, b = 27}
apple9.shr {dst = 8, a = 2, b = 27}
apple9.asr {dst = 9, a = 2, b = 27}
apple9.and {dst = 10, a = 2, b = 3}
apple9.or {dst = 11, a = 2, b = 3}
apple9.xor {dst = 12, a = 2, b = 3}
apple9.smin {dst = 13, a = 2, b = 3}
apple9.smax {dst = 14, a = 2, b = 3}
apple9.umin {dst = 15, a = 2, b = 3}
apple9.umax {dst = 16, a = 2, b = 3}
apple9.select {dst = 17, a = 2, b = 3, t = 2, f = 3, cond = "ilt"}
apple9.select {dst = 18, a = 2, b = 3, t = 25, f = 24, cond = "ult"}
apple9.select {dst = 28, a = 2, b = 3, t = 24, f = 26, cond = "ilt"}
apple9.select {dst = 19, a = 3, b = 2, t = 24, f = 28, cond = "ilt"}
apple9.i2f {dst = 20, a = 2, signed = true}
apple9.i2f {dst = 21, a = 2}
apple9.mov_imm {dst = 29, value = 1052602532}
apple9.mov_imm {dst = 30, value = 1065353216}
apple9.fmul {dst = 31, a = 20, b = 29}
apple9.fmul {dst = 32, a = 31, b = 30, abs = 1}
apple9.f2i {dst = 22, a = 31, signed = true}
apple9.f2i {dst = 23, a = 32}
apple9.store {data = 4, index = 0, binding = 1, components = 4, shift = 4}
apple9.store {data = 8, index = 0, binding = 2, components = 4, shift = 4}
apple9.store {data = 12, index = 0, binding = 3, components = 4, shift = 4}
apple9.store {data = 16, index = 0, binding = 4, components = 4, shift = 4}
apple9.store {data = 20, index = 0, binding = 5, components = 4, shift = 4}
apple9.halt {}

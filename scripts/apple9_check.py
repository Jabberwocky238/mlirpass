#!/usr/bin/env python3
"""The Apple9 target on the hardware: acgpu's `ints` kernel as mlirpass compiles it (tests/apple9/ints.expected, which
tests/apple9.rs keeps equal to the compiler's output) run on this Mac's GPU (an M4) and every result checked against
the i32 / f32 semantics of tests/apple9/ints.mlir. macOS with an Apple9 GPU only.

How it runs (the ABI of the apple9 target): the kernel's code replaces the main of a donor kernel
(scripts/apple9_donor.metal: binding 0 the memory, binding 1 the parameter words) in a Metal binary archive
(scripts/apple9_metal.swift `run --text`); 32 invocations, workgroups of 16; the parameters src = 0, dst = 8 n are byte
offsets into the memory: n pairs (a, b), then 20 results each.

    swiftc -O scripts/apple9_metal.swift -o target/apple9-metal
    python3 scripts/apple9_check.py           # prints `N of N right`; exit 1 on any wrong result
"""
import os, struct, subprocess, sys

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
RUNNER = os.path.join(ROOT, 'target', 'apple9-metal')

lines = open(os.path.join(ROOT, 'tests/apple9/ints.expected')).read().split('\n')
code = ''.join(lines[1:]).strip()

# edge cases: equal, negative, signed and unsigned order disagreeing, shift amounts past 31
PAIRS = [(7, 3), (3, 7), (5, 5), (0xfffffffb, 3), (3, 0xfffffffb), (0x80000000, 33), (123456789, 0xffffffff), (0x12345678, 4)] * 4
n = len(PAIRS)
src, dst = 0, 8 * n
words = [w for a, b in PAIRS for w in (a, b)] + [0] * (20 * n)
args = [os.path.abspath(RUNNER), 'run', os.path.join(ROOT, 'scripts/apple9_donor.metal'), 'donor', '--text', code, '--threads', str(n), '--group', '16',
        f'u32:{len(words)}:' + ','.join(f'{w:x}' for w in words), f'u32:2:{src:x},{dst:x}']
out = subprocess.run(args, capture_output=True, text=True)
if out.returncode:
    sys.exit(out.stdout + out.stderr)
memory = next([int(x, 16) for x in l.split()[2:]] for l in out.stdout.splitlines() if l.startswith('buf 0 '))


def s32(x): return x - (1 << 32) if x & 0x80000000 else x
def u32(x): return x & 0xffffffff
def bits(f): return struct.unpack('<I', struct.pack('<f', f))[0]
def f32(b): return struct.unpack('<f', struct.pack('<I', b))[0]


NAMES = ['add', 'sub', 'mul', 'shl', 'shr', 'asr', 'and', 'or', 'xor', 'smin', 'smax', 'umin', 'umax', 'select', 'ult', 'eq',
         'sitofp', 'uitofp', 'fptosi', 'fptoui']
K = f32(bits(0.37))
bad = 0
for t, (a, b) in enumerate(PAIRS):
    s = b & 31
    fa = f32(bits(s32(a)))
    fk = f32(bits(fa * K))  # the f32 product, correctly rounded
    want = [u32(a + b), u32(a - b), u32(a * b), u32(a << s), a >> s, u32(s32(a) >> s), a & b, a | b, a ^ b, u32(min(s32(a), s32(b))),
            u32(max(s32(a), s32(b))), min(a, b), max(a, b), a if s32(a) < s32(b) else b, int(a < b), 0xffffffff if a == b else 0,
            bits(s32(a)), bits(a), u32(int(fk)), min(int(abs(fk)), 0xffffffff)]
    got = memory[dst // 4 + 20 * t:dst // 4 + 20 * t + 20]
    for k, (g, w) in enumerate(zip(got, want)):
        if g != w:
            bad += 1
            print(f'invocation {t} ({a:#x}, {b:#x}) {NAMES[k]}: got {g:#010x}, want {w:#010x}')
print(f'{20 * n - bad} of {20 * n} right ({len(code) // 2} bytes of code, {lines[0]})')
sys.exit(1 if bad else 0)

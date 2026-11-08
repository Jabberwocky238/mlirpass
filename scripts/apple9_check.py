#!/usr/bin/env python3
"""The Apple9 target on the hardware: kernels as mlirpass compiles them (tests/apple9/<kernel>.expected, which
tests/apple9.rs keeps equal to the compiler's output) run on this Mac's GPU (an M4), every result checked against the
semantics of tests/apple9/<kernel>.mlir: `ints` (i32 arithmetic), `floats` (f32: IEEE, one rounding, denormals
flushed to zero) and `control` (ifs and loops, the condition differing between the lanes). macOS with an Apple9 GPU only.

How it runs (the ABI of the apple9 target): the kernel's code replaces the main of a donor kernel
(scripts/apple9_donor.metal: binding 0 the memory, binding 1 the parameter words) in a Metal binary archive
(scripts/apple9_metal.swift `run --text`); workgroups of 32 (the target's); the parameters src = 0, dst are byte offsets into the
memory: the inputs, then 20 results an invocation.

    swiftc -O scripts/apple9_metal.swift -o target/apple9-metal
    python3 scripts/apple9_check.py [KERNEL ...]     # each: `N of N right`; exit 1 on any wrong result
"""
import math, os, random, struct, subprocess, sys
from fractions import Fraction as Fr

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
RUNNER = os.path.join(ROOT, 'target', 'apple9-metal')


def F(x): return struct.unpack('<I', struct.pack('<f', x))[0]
def B(u): return struct.unpack('<f', struct.pack('<I', u))[0]
def s32(x): return x - (1 << 32) if x & 0x80000000 else x
def u32(x): return x & 0xffffffff
def isnan(u): return (u & 0x7fffffff) > 0x7f800000


def run(kernel, n, inputs, words_in, out=20):
    """Kernel `kernel`'s code over n invocations: the memory `inputs` then `out` result words each; the results."""
    lines = open(os.path.join(ROOT, f'tests/apple9/{kernel}.expected')).read().split('\n')
    code = ''.join(lines[1:]).strip()
    dst = 4 * len(inputs)
    words = inputs + [0] * (out * n)
    args = [os.path.abspath(RUNNER), 'run', os.path.join(ROOT, 'scripts/apple9_donor.metal'), 'donor', '--text', code, '--threads', str(n), '--group', '32',
            f'u32:{len(words)}:' + ','.join(f'{w:x}' for w in words), f'u32:2:0,{dst:x}']
    ran = subprocess.run(args, capture_output=True, text=True)
    if ran.returncode:
        sys.exit(ran.stdout + ran.stderr)
    memory = next([int(x, 16) for x in l.split()[2:]] for l in ran.stdout.splitlines() if l.startswith('buf 0 '))
    return [memory[dst // 4 + out * t:dst // 4 + out * t + out] for t in range(n)], len(code) // 2, lines[0]


def ints():
    pairs = [(7, 3), (3, 7), (5, 5), (0xfffffffb, 3), (3, 0xfffffffb), (0x80000000, 33), (123456789, 0xffffffff), (0x12345678, 4)] * 16
    got, size, head = run('ints', len(pairs), [w for a, b in pairs for w in (a, b)], 2)
    names = ['add', 'sub', 'mul', 'shl', 'shr', 'asr', 'and', 'or', 'xor', 'smin', 'smax', 'umin', 'umax', 'select', 'ult', 'eq', 'sitofp', 'uitofp', 'fptosi', 'fptoui']
    k = B(F(0.37))
    bad = []
    for t, (a, b) in enumerate(pairs):
        s = b & 31
        fk = B(F(B(F(s32(a))) * k))  # the f32 product, correctly rounded
        want = [u32(a + b), u32(a - b), u32(a * b), u32(a << s), a >> s, u32(s32(a) >> s), a & b, a | b, a ^ b, u32(min(s32(a), s32(b))), u32(max(s32(a), s32(b))),
                min(a, b), max(a, b), a if s32(a) < s32(b) else b, int(a < b), 0xffffffff if a == b else 0, F(s32(a)), F(a), u32(int(fk)), min(int(abs(fk)), 0xffffffff)]
        bad += [f'invocation {t} ({a:#x}, {b:#x}) {names[i]}: got {g:#010x}, want {w:#010x}' for i, (g, w) in enumerate(zip(got[t], want)) if g != w]
    return 20 * len(pairs), bad, size, head


def rnd(x):
    """An exact rational correctly rounded to f32 (nearest even); a result below the normal range flushes to ±0."""
    if x == 0:
        return 0
    s = 0x80000000 if x < 0 else 0
    x = abs(x)
    e = x.numerator.bit_length() - x.denominator.bit_length()
    while Fr(2) ** e > x: e -= 1
    while Fr(2) ** (e + 1) <= x: e += 1
    if e < -126:
        return s  # (a result rounding up to the smallest normal is not produced by these operands)
    q = x / Fr(2) ** (e - 23)
    m = math.floor(q)
    r = q - m
    if r > Fr(1, 2) or (r == Fr(1, 2) and m & 1): m += 1
    if m >= 1 << 24: m >>= 1; e += 1
    if e > 127: return s | 0x7f800000
    return s | ((e + 127) << 23) | (m & 0x7fffff)


def root(a):
    """The correctly rounded square root of a positive f32 (integer square root of the scaled value)."""
    x, k = Fr(a), 0
    while x < 2 ** 60: x *= 4; k += 1
    while x >= 2 ** 62: x /= 4; k -= 1
    r = math.isqrt(math.floor(x * 2 ** 40))
    lo, hi = rnd(Fr(r, 2 ** 20) / Fr(2) ** k), rnd(Fr(r + 1, 2 ** 20) / Fr(2) ** k)
    if lo == hi: return lo
    mid = (Fr(B(lo)) + Fr(B(hi))) / 2
    return hi if mid * mid < Fr(a) else lo


def floats():
    nan, inf = float('nan'), float('inf')
    special = [(1.5, 0.25, 3.0), (-1.5, 2.5, -0.5), (2.5, 2.5, 7.0), (-2.5, 1.0, 1.0), (0.0, -0.0, 1.0), (-0.0, 5.0, 2.0), (nan, 1.0, 2.0), (1.0, nan, 2.0),
               (inf, 2.0, -1.0), (-inf, -inf, 0.5), (2.0, inf, 1.0), (5.0, 0.0, 1.0), (0.1, 3.0, 0.3), (B(0x7f7fffff), 0.5, 1.0), (B(0x00800000), 2.0, 0.0),
               (B(0x3f7fffff), B(0x3f800001), -1.0), (16777216.0, 1.0, 0.5), (-0.5, -0.0, 0.0), (9.0, 3.0, -9.0), (-4.0, 1.0, 2.0)]
    random.seed(9)
    def rf(): return B((random.getrandbits(1) << 31) | (random.randint(127 - 60, 127 + 60) << 23) | random.getrandbits(23))
    cases = special + [(rf(), rf(), rf()) for _ in range(492)]
    cases = [tuple(B(F(x)) for x in c) for c in cases]
    got, size, head = run('floats', len(cases), [F(x) for a, b, c in cases for x in (a, b, c, 0.0)], 4)
    names = ['add', 'sub', 'mul', 'fma', 'neg', 'abs', 'minnum', 'maxnum', 'floor', 'ceil', 'trunc', 'roundeven', 'div', 'sqrt', 'olt', 'oge', 'oeq', 'une', 'uno', 'ugt']
    bad = []
    for t, (a, b, c) in enumerate(cases):
        n_ = [math.isnan(v) for v in (a, b, c)]
        fin = lambda *v: all(math.isfinite(x) for x in v)
        def arith(f, *v):
            # IEEE on the finite operands exactly; the special ones by Python's float (signed zeros, infinities, NaN)
            if fin(*v) and not any(x == 0 for x in v): return rnd(f(*[Fr(x) for x in v]))
            try: r = f(*v)
            except ZeroDivisionError: r = math.copysign(inf, v[0]) * math.copysign(1, v[1]) if v[0] != 0 else nan
            return 'nan' if math.isnan(r) else F(r)
        def rounding(f):
            if not math.isfinite(a): return F(a)
            r = float(f(a))
            return F(math.copysign(r, a)) if r == 0 else F(r)
        minmax = lambda pick: F(b) if n_[0] else F(a) if n_[1] else None if a == b == 0 else F(pick(a, b))
        sel = lambda cond: F(a if cond else c)
        want = [arith(lambda x, y: x + y, a, b), arith(lambda x, y: x - y, a, b), arith(lambda x, y: x * y, a, b),
                (rnd(Fr(a) * Fr(b) + Fr(c)) if fin(a, b, c) and a * b + c != 0 else None),
                F(a) ^ 0x80000000, F(a) & 0x7fffffff, minmax(min), minmax(max),
                rounding(math.floor), rounding(math.ceil), rounding(math.trunc), rounding(round),
                arith(lambda x, y: x / y, a, b), ('nan' if n_[0] or a < 0 else F(a) if a == 0 or a == inf else root(a)),
                sel(a < b), sel(a >= b), sel(a == b), sel(not a == b), sel(n_[0] or n_[1]), sel(not a <= b)]
        for i, (g, w) in enumerate(zip(got[t], want)):
            if w is None: continue  # either sign of a zero result (fma's, minNum's of ±0) is IEEE's
            if (w == 'nan' and not isnan(g)) or (w != 'nan' and g != w):
                bad.append(f'invocation {t} ({a!r}, {b!r}, {c!r}) {names[i]}: got {g:#010x} ({B(g)!r}), want {w if w == "nan" else f"{w:#010x} ({B(w)!r})"}')
    return 20 * len(cases), bad, size, head


def control():
    random.seed(5)
    values = [0, 1, 2, 5, 6, 7, 8, 13, 40, 0xfffffffd, 0x80000000] + [u32(random.randint(-5, 45)) for _ in range(501)]
    got, size, head = run('control', len(values), values, 1, out=4)
    names = ['if', 'loop', 'nested', 'odd']
    bad = []
    for t, a in enumerate(values):
        s = 0
        for k in range(max(s32(a), 0)): s = u32(s * 5 + k)
        acc = a
        for k in range(a & 7): acc = u32(acc + k) if k & 1 else acc ^ 3
        want = [u32(a * 3) if s32(a) > 5 else u32(a + 9), s, acc, u32(a + 1000) if a & 1 else 0]
        bad += [f'invocation {t} ({a:#x}) {names[i]}: got {g:#010x}, want {w:#010x}' for i, (g, w) in enumerate(zip(got[t], want)) if g != w]
    return 4 * len(values), bad, size, head


wrong = 0
for name in sys.argv[1:] or ['ints', 'floats', 'control']:
    total, bad, size, head = {'ints': ints, 'floats': floats, 'control': control}[name]()
    for line in bad[:20]: print(line)
    print(f'{name}: {total - len(bad)} of {total} right ({size} bytes of code, {head})')
    wrong += len(bad)
sys.exit(1 if wrong else 0)

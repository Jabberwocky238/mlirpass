#include <metal_stdlib>
using namespace metal;
// The donor a kernel runs in: binding 0 the memory, binding 1 the parameter words, both used; a long main and many live
// registers (so Metal allots at least as many GPRs as the kernel put in its place uses); 16 KiB of threadgroup memory
// (one array: its root at 0) behind a barrier.
kernel void donor(device uint *mem [[buffer(0)]], device const uint *p [[buffer(1)]], uint i [[thread_position_in_grid]]) {
  threadgroup uint shared[4096];
  uint v[80];
  for (uint k = 0; k < 80; k++) v[k] = mem[p[0] + i + 7u * k] * (k + 1u) ^ p[1];
  uint s = 0;
  for (uint k = 0; k < 80; k++) s += v[k] * v[(13u * k + 5u) % 80u] ^ (v[(k + 31u) % 80u] >> (k & 7u));
  shared[(i * 13u) & 4095u] = s;
  threadgroup_barrier(mem_flags::mem_threadgroup);
  mem[p[1] + i] = s + shared[(i * 7u + s) & 4095u];
}

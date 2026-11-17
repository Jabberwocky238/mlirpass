// stage: none
#version 450
void f_memory_barrier_0();
void f_memory_barrier_1();
void f_control_barrier_0();
void f_control_barrier_1();
void f_memory_barrier_0() {
  memoryBarrier();
  return;
}
void f_memory_barrier_1() {
  memoryBarrier();
  return;
}
void f_control_barrier_0() {
  barrier();
  return;
}
void f_control_barrier_1() {
  barrier();
  return;
}

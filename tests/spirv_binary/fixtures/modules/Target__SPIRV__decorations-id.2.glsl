// stage: none
#version 450
layout(std430, set = 0, binding = 1) buffer g_counter_block {
  layout(offset = 0) int[1] m0;
} g_counter;
layout(std430, set = 0, binding = 0) buffer g_var_block {
  layout(offset = 0) float[4] m0;
} g_var;

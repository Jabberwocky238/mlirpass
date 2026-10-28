// Runs one SPIR-V compute shader on a Vulkan device (the tests point the loader at lavapipe).
//
//   vkrun <shader.spv> <entry> <groups x> <groups y> <groups z> <buffer file>...
//
// Buffer file i is storage buffer (set 0, binding i), read before the dispatch and written
// back after it. Prints the timings `VulkanRuntime::submitCommandBuffers` prints.


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <vulkan/vulkan.h>

#define CHECK(x)                                                                         \
  do {                                                                                   \
    VkResult r_ = (x);                                                                   \
    if (r_ != VK_SUCCESS) {                                                              \
      fprintf(stderr, "%s failed: %d\n", #x, r_);                                        \
      exit(1);                                                                           \
    }                                                                                    \
  } while (0)

static void *slurp(const char *path, size_t *size) {
  FILE *f = fopen(path, "rb");
  if (!f) {
    perror(path);
    exit(1);
  }
  fseek(f, 0, SEEK_END);
  *size = (size_t)ftell(f);
  fseek(f, 0, SEEK_SET);
  void *data = malloc(*size ? *size : 1);
  if (fread(data, 1, *size, f) != *size) {
    perror(path);
    exit(1);
  }
  fclose(f);
  return data;
}

int main(int argc, char **argv) {
  if (argc < 6) {
    fprintf(stderr, "usage: vkrun shader.spv entry gx gy gz buffers...\n");
    return 2;
  }
  int nbuf = argc - 6;
  VkApplicationInfo app = {VK_STRUCTURE_TYPE_APPLICATION_INFO, NULL, "vkrun", 1, NULL, 0, VK_API_VERSION_1_1};
  VkInstanceCreateInfo ici = {VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO, NULL, 0, &app, 0, NULL, 0, NULL};
  VkInstance inst;
  CHECK(vkCreateInstance(&ici, NULL, &inst));
  uint32_t ndev = 1;
  VkPhysicalDevice phys;
  vkEnumeratePhysicalDevices(inst, &ndev, &phys);
  if (ndev == 0) {
    fprintf(stderr, "no Vulkan device\n");
    return 1;
  }
  uint32_t nq = 0;
  vkGetPhysicalDeviceQueueFamilyProperties(phys, &nq, NULL);
  VkQueueFamilyProperties *qp = calloc(nq, sizeof *qp);
  vkGetPhysicalDeviceQueueFamilyProperties(phys, &nq, qp);
  uint32_t qf = 0;
  while (qf < nq && !(qp[qf].queueFlags & VK_QUEUE_COMPUTE_BIT))
    qf++;
  float prio = 1.0f;
  VkDeviceQueueCreateInfo qci = {VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO, NULL, 0, qf, 1, &prio};
  // Everything the device has: the tests' shaders ask for what their target env allows.
  VkPhysicalDeviceFeatures feats;
  vkGetPhysicalDeviceFeatures(phys, &feats);
  VkPhysicalDeviceVulkan11Features f11 = {VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_1_FEATURES};
  VkPhysicalDeviceVulkan12Features f12 = {VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_2_FEATURES, &f11};
  VkPhysicalDeviceFeatures2 f2 = {VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_FEATURES_2, &f12};
  vkGetPhysicalDeviceFeatures2(phys, &f2);
  VkDeviceCreateInfo dci = {VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO, &f2, 0, 1, &qci, 0, NULL, 0, NULL, NULL};
  VkDevice dev;
  CHECK(vkCreateDevice(phys, &dci, NULL, &dev));
  VkQueue queue;
  vkGetDeviceQueue(dev, qf, 0, &queue);

  VkPhysicalDeviceMemoryProperties mp;
  vkGetPhysicalDeviceMemoryProperties(phys, &mp);
  VkBuffer *bufs = calloc(nbuf, sizeof *bufs);
  VkDeviceMemory *mems = calloc(nbuf, sizeof *mems);
  size_t *sizes = calloc(nbuf, sizeof *sizes);
  void **maps = calloc(nbuf, sizeof *maps);
  for (int i = 0; i < nbuf; i++) {
    void *data = slurp(argv[6 + i], &sizes[i]);
    VkDeviceSize sz = sizes[i] ? sizes[i] : 4;
    VkBufferCreateInfo bci = {VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO, NULL, 0, sz, VK_BUFFER_USAGE_STORAGE_BUFFER_BIT, VK_SHARING_MODE_EXCLUSIVE, 0, NULL};
    CHECK(vkCreateBuffer(dev, &bci, NULL, &bufs[i]));
    VkMemoryRequirements req;
    vkGetBufferMemoryRequirements(dev, bufs[i], &req);
    uint32_t mt = 0;
    VkMemoryPropertyFlags want = VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT;
    while (mt < mp.memoryTypeCount && !((req.memoryTypeBits & (1u << mt)) && (mp.memoryTypes[mt].propertyFlags & want) == want))
      mt++;
    VkMemoryAllocateInfo mai = {VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO, NULL, req.size, mt};
    CHECK(vkAllocateMemory(dev, &mai, NULL, &mems[i]));
    CHECK(vkBindBufferMemory(dev, bufs[i], mems[i], 0));
    CHECK(vkMapMemory(dev, mems[i], 0, sz, 0, &maps[i]));
    memcpy(maps[i], data, sizes[i]);
    free(data);
  }

  VkDescriptorSetLayoutBinding *lb = calloc(nbuf, sizeof *lb);
  for (int i = 0; i < nbuf; i++)
    lb[i] = (VkDescriptorSetLayoutBinding){(uint32_t)i, VK_DESCRIPTOR_TYPE_STORAGE_BUFFER, 1, VK_SHADER_STAGE_COMPUTE_BIT, NULL};
  VkDescriptorSetLayoutCreateInfo dlci = {VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO, NULL, 0, (uint32_t)nbuf, lb};
  VkDescriptorSetLayout dsl;
  CHECK(vkCreateDescriptorSetLayout(dev, &dlci, NULL, &dsl));
  VkPipelineLayoutCreateInfo plci = {VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO, NULL, 0, 1, &dsl, 0, NULL};
  VkPipelineLayout pl;
  CHECK(vkCreatePipelineLayout(dev, &plci, NULL, &pl));

  size_t spv_size;
  void *spv = slurp(argv[1], &spv_size);
  VkShaderModuleCreateInfo smci = {VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO, NULL, 0, spv_size, spv};
  VkShaderModule sm;
  CHECK(vkCreateShaderModule(dev, &smci, NULL, &sm));
  VkComputePipelineCreateInfo cpci = {VK_STRUCTURE_TYPE_COMPUTE_PIPELINE_CREATE_INFO, NULL, 0,
                                      {VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO, NULL, 0, VK_SHADER_STAGE_COMPUTE_BIT, sm, argv[2], NULL},
                                      pl, VK_NULL_HANDLE, 0};
  VkPipeline pipe;
  CHECK(vkCreateComputePipelines(dev, VK_NULL_HANDLE, 1, &cpci, NULL, &pipe));

  VkDescriptorPoolSize ps = {VK_DESCRIPTOR_TYPE_STORAGE_BUFFER, (uint32_t)(nbuf ? nbuf : 1)};
  VkDescriptorPoolCreateInfo dpci = {VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO, NULL, 0, 1, 1, &ps};
  VkDescriptorPool pool;
  CHECK(vkCreateDescriptorPool(dev, &dpci, NULL, &pool));
  VkDescriptorSetAllocateInfo dsai = {VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO, NULL, pool, 1, &dsl};
  VkDescriptorSet ds;
  CHECK(vkAllocateDescriptorSets(dev, &dsai, &ds));
  for (int i = 0; i < nbuf; i++) {
    VkDescriptorBufferInfo bi = {bufs[i], 0, VK_WHOLE_SIZE};
    VkWriteDescriptorSet w = {VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET, NULL, ds, (uint32_t)i, 0, 1, VK_DESCRIPTOR_TYPE_STORAGE_BUFFER, NULL, &bi, NULL};
    vkUpdateDescriptorSets(dev, 1, &w, 0, NULL);
  }

  VkCommandPoolCreateInfo cpi = {VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO, NULL, 0, qf};
  VkCommandPool cp;
  CHECK(vkCreateCommandPool(dev, &cpi, NULL, &cp));
  VkCommandBufferAllocateInfo cbai = {VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO, NULL, cp, VK_COMMAND_BUFFER_LEVEL_PRIMARY, 1};
  VkCommandBuffer cb;
  CHECK(vkAllocateCommandBuffers(dev, &cbai, &cb));
  VkCommandBufferBeginInfo cbbi = {VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO, NULL, VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT, NULL};
  CHECK(vkBeginCommandBuffer(cb, &cbbi));
  VkQueryPoolCreateInfo qpci = {VK_STRUCTURE_TYPE_QUERY_POOL_CREATE_INFO, NULL, 0, VK_QUERY_TYPE_TIMESTAMP, 2, 0};
  VkQueryPool qpool;
  int timed = qp[qf].timestampValidBits != 0 && vkCreateQueryPool(dev, &qpci, NULL, &qpool) == VK_SUCCESS;
  if (timed) {
    vkCmdResetQueryPool(cb, qpool, 0, 2);
    vkCmdWriteTimestamp(cb, VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT, qpool, 0);
  }
  vkCmdBindPipeline(cb, VK_PIPELINE_BIND_POINT_COMPUTE, pipe);
  vkCmdBindDescriptorSets(cb, VK_PIPELINE_BIND_POINT_COMPUTE, pl, 0, 1, &ds, 0, NULL);
  vkCmdDispatch(cb, (uint32_t)atoi(argv[3]), (uint32_t)atoi(argv[4]), (uint32_t)atoi(argv[5]));
  if (timed)
    vkCmdWriteTimestamp(cb, VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT, qpool, 1);
  CHECK(vkEndCommandBuffer(cb));
  VkSubmitInfo si = {VK_STRUCTURE_TYPE_SUBMIT_INFO, NULL, 0, NULL, NULL, 1, &cb, 0, NULL};
  struct timespec t0, t1, t2;
  clock_gettime(CLOCK_MONOTONIC, &t0);
  CHECK(vkQueueSubmit(queue, 1, &si, VK_NULL_HANDLE));
  clock_gettime(CLOCK_MONOTONIC, &t1);
  CHECK(vkQueueWaitIdle(queue));
  clock_gettime(CLOCK_MONOTONIC, &t2);
  if (timed) {
    uint64_t ts[2];
    VkPhysicalDeviceProperties props;
    vkGetPhysicalDeviceProperties(phys, &props);
    if (vkGetQueryPoolResults(dev, qpool, 0, 2, sizeof ts, ts, sizeof ts[0], VK_QUERY_RESULT_64_BIT | VK_QUERY_RESULT_WAIT_BIT) == VK_SUCCESS)
      printf("Compute shader execution time: %.3gus\n", (double)(ts[1] - ts[0]) * props.limits.timestampPeriod / 1000);
  }
  long us = 1000000;
  printf("Command buffer submit time: %ldus\nWait idle time: %ldus\n", (t1.tv_sec - t0.tv_sec) * us + (t1.tv_nsec - t0.tv_nsec) / 1000,
         (t2.tv_sec - t1.tv_sec) * us + (t2.tv_nsec - t1.tv_nsec) / 1000);

  for (int i = 0; i < nbuf; i++) {
    FILE *f = fopen(argv[6 + i], "wb");
    fwrite(maps[i], 1, sizes[i], f);
    fclose(f);
  }
  vkDestroyDevice(dev, NULL);
  vkDestroyInstance(inst, NULL);
  return 0;
}

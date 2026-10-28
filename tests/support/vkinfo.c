// Prints the `#spirv.target_env` of a Vulkan device, from what the device reports: SPIR-V
// version, capabilities and extensions from its features, vendor and device type, and resource
// limits with the cooperative matrix configurations it supports.
//
//   vkinfo [device index]

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <vulkan/vulkan.h>

static const char *component(VkComponentTypeKHR t) {
  switch ((int)t) {
  case VK_COMPONENT_TYPE_FLOAT16_KHR: return "f16";
  case VK_COMPONENT_TYPE_FLOAT32_KHR: return "f32";
  case VK_COMPONENT_TYPE_FLOAT64_KHR: return "f64";
  case VK_COMPONENT_TYPE_SINT8_KHR: return "i8";
  case VK_COMPONENT_TYPE_SINT16_KHR: return "i16";
  case VK_COMPONENT_TYPE_SINT32_KHR: return "i32";
  case VK_COMPONENT_TYPE_SINT64_KHR: return "i64";
  case VK_COMPONENT_TYPE_UINT8_KHR: return "ui8";
  case VK_COMPONENT_TYPE_UINT16_KHR: return "ui16";
  case VK_COMPONENT_TYPE_UINT32_KHR: return "ui32";
  case VK_COMPONENT_TYPE_UINT64_KHR: return "ui64";
  case 1000141000: return "bf16"; // VK_COMPONENT_TYPE_BFLOAT16_KHR
  default: return NULL;
  }
}

static const char *scope(VkScopeKHR s) {
  switch (s) {
  case VK_SCOPE_DEVICE_KHR: return "Device";
  case VK_SCOPE_WORKGROUP_KHR: return "Workgroup";
  case VK_SCOPE_SUBGROUP_KHR: return "Subgroup";
  case VK_SCOPE_QUEUE_FAMILY_KHR: return "QueueFamily";
  default: return "Subgroup";
  }
}

static const char *vendor(uint32_t id) {
  switch (id) {
  case 0x1002: return "AMD";
  case 0x106B: return "Apple";
  case 0x13B5: return "ARM";
  case 0x14E4: return "Broadcom";
  case 0x1010: return "Imagination";
  case 0x8086: return "Intel";
  case 0x10DE: return "NVIDIA";
  case 0x5143: return "Qualcomm";
  case 0x1AE0: return "SwiftShader";
  default: return NULL;
  }
}

static const char *device_type(VkPhysicalDeviceType t) {
  switch (t) {
  case VK_PHYSICAL_DEVICE_TYPE_CPU: return "CPU";
  case VK_PHYSICAL_DEVICE_TYPE_DISCRETE_GPU: return "DiscreteGPU";
  case VK_PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU: return "IntegratedGPU";
  default: return "Other";
  }
}

static int has_extension(VkPhysicalDevice phys, const char *name) {
  uint32_t n = 0;
  vkEnumerateDeviceExtensionProperties(phys, NULL, &n, NULL);
  VkExtensionProperties *e = calloc(n, sizeof *e);
  vkEnumerateDeviceExtensionProperties(phys, NULL, &n, e);
  int found = 0;
  for (uint32_t i = 0; i < n && !found; i++)
    found = strcmp(e[i].extensionName, name) == 0;
  free(e);
  return found;
}

// A comma-separated list being printed.
static int listed;
static void item(const char *s) {
  printf("%s%s", listed++ ? ", " : "", s);
}

int main(int argc, char **argv) {
  VkApplicationInfo app = {VK_STRUCTURE_TYPE_APPLICATION_INFO, NULL, "vkinfo", 1, NULL, 0, VK_API_VERSION_1_3};
  VkInstanceCreateInfo ici = {VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO, NULL, 0, &app, 0, NULL, 0, NULL};
  VkInstance inst;
  if (vkCreateInstance(&ici, NULL, &inst) != VK_SUCCESS) {
    fprintf(stderr, "vkCreateInstance failed\n");
    return 1;
  }
  uint32_t ndev = 0;
  vkEnumeratePhysicalDevices(inst, &ndev, NULL);
  uint32_t which = argc > 1 ? (uint32_t)atoi(argv[1]) : 0;
  if (which >= ndev) {
    fprintf(stderr, "no Vulkan device %u\n", which);
    return 1;
  }
  VkPhysicalDevice *devs = calloc(ndev, sizeof *devs);
  vkEnumeratePhysicalDevices(inst, &ndev, devs);
  VkPhysicalDevice phys = devs[which];

  VkPhysicalDeviceSubgroupSizeControlProperties sizes = {VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_SUBGROUP_SIZE_CONTROL_PROPERTIES};
  VkPhysicalDeviceVulkan11Properties p11 = {VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_1_PROPERTIES, &sizes};
  VkPhysicalDeviceProperties2 props = {VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2, &p11};
  vkGetPhysicalDeviceProperties2(phys, &props);
  VkPhysicalDeviceLimits *lim = &props.properties.limits;

  int coop = has_extension(phys, "VK_KHR_cooperative_matrix");
  VkPhysicalDeviceCooperativeMatrixFeaturesKHR fcoop = {VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_COOPERATIVE_MATRIX_FEATURES_KHR};
  VkPhysicalDeviceVulkan13Features f13 = {VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_3_FEATURES, coop ? &fcoop : NULL};
  VkPhysicalDeviceVulkan12Features f12 = {VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_2_FEATURES, &f13};
  VkPhysicalDeviceVulkan11Features f11 = {VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_1_FEATURES, &f12};
  VkPhysicalDeviceFeatures2 f = {VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_FEATURES_2, &f11};
  vkGetPhysicalDeviceFeatures2(phys, &f);

  // Vulkan 1.3 consumes SPIR-V 1.6; 1.2: 1.5; 1.1: 1.3.
  uint32_t api = props.properties.apiVersion;
  const char *spv = VK_API_VERSION_MINOR(api) >= 3 ? "v1.6" : VK_API_VERSION_MINOR(api) == 2 ? "v1.5" : VK_API_VERSION_MINOR(api) == 1 ? "v1.3" : "v1.0";

  printf("#spirv.target_env<#spirv.vce<%s, [", spv);
  listed = 0;
  item("Shader");
  if (f.features.shaderFloat64) item("Float64");
  if (f.features.shaderInt64) item("Int64");
  if (f.features.shaderInt16) item("Int16");
  if (f12.shaderFloat16) item("Float16");
  if (f12.shaderInt8) item("Int8");
  if (f11.storageBuffer16BitAccess) item("StorageBuffer16BitAccess");
  if (f11.uniformAndStorageBuffer16BitAccess) item("StorageUniform16");
  if (f11.storagePushConstant16) item("StoragePushConstant16");
  if (f12.storageBuffer8BitAccess) item("StorageBuffer8BitAccess");
  if (f12.uniformAndStorageBuffer8BitAccess) item("UniformAndStorageBuffer8BitAccess");
  if (f12.storagePushConstant8) item("StoragePushConstant8");
  VkSubgroupFeatureFlags ops = p11.subgroupSupportedOperations;
  if (ops & VK_SUBGROUP_FEATURE_BASIC_BIT) item("GroupNonUniform");
  if (ops & VK_SUBGROUP_FEATURE_VOTE_BIT) item("GroupNonUniformVote");
  if (ops & VK_SUBGROUP_FEATURE_ARITHMETIC_BIT) item("GroupNonUniformArithmetic");
  if (ops & VK_SUBGROUP_FEATURE_BALLOT_BIT) item("GroupNonUniformBallot");
  if (ops & VK_SUBGROUP_FEATURE_SHUFFLE_BIT) item("GroupNonUniformShuffle");
  if (ops & VK_SUBGROUP_FEATURE_SHUFFLE_RELATIVE_BIT) item("GroupNonUniformShuffleRelative");
  if (ops & VK_SUBGROUP_FEATURE_CLUSTERED_BIT) item("GroupNonUniformClustered");
  if (ops & VK_SUBGROUP_FEATURE_QUAD_BIT) item("GroupNonUniformQuad");
  if (f11.variablePointersStorageBuffer) item("VariablePointersStorageBuffer");
  if (f11.variablePointers) item("VariablePointers");
  if (f12.bufferDeviceAddress) item("PhysicalStorageBufferAddresses");
  if (f12.vulkanMemoryModel) item("VulkanMemoryModel");
  if (f12.vulkanMemoryModelDeviceScope) item("VulkanMemoryModelDeviceScope");
  if (f13.shaderIntegerDotProduct) item("DotProduct"), item("DotProductInputAll"), item("DotProductInput4x8BitPacked"), item("DotProductInput4x8Bit");
  if (coop && fcoop.cooperativeMatrix) item("CooperativeMatrixKHR");
  printf("], [");
  listed = 0;
  item("SPV_KHR_storage_buffer_storage_class");
  if (f11.storageBuffer16BitAccess) item("SPV_KHR_16bit_storage");
  if (f12.storageBuffer8BitAccess) item("SPV_KHR_8bit_storage");
  if (f11.variablePointersStorageBuffer) item("SPV_KHR_variable_pointers");
  if (f12.bufferDeviceAddress) item("SPV_KHR_physical_storage_buffer");
  if (f12.vulkanMemoryModel) item("SPV_KHR_vulkan_memory_model");
  if (f13.shaderIntegerDotProduct) item("SPV_KHR_integer_dot_product");
  if (coop && fcoop.cooperativeMatrix) item("SPV_KHR_cooperative_matrix");
  printf("]>, api=Vulkan, ");
  const char *v = vendor(props.properties.vendorID);
  if (v)
    printf("%s:%s:%u, ", v, device_type(props.properties.deviceType), props.properties.deviceID);
  // The limits as MLIR prints them: parameters at their default (16384, 128, [128, 128, 64], 32)
  // are left out.
  printf("#spirv.resource_limits<");
  listed = 0;
  char buf[128];
  if (lim->maxComputeSharedMemorySize != 16384)
    snprintf(buf, sizeof buf, "max_compute_shared_memory_size = %u", lim->maxComputeSharedMemorySize), item(buf);
  if (lim->maxComputeWorkGroupInvocations != 128)
    snprintf(buf, sizeof buf, "max_compute_workgroup_invocations = %u", lim->maxComputeWorkGroupInvocations), item(buf);
  const uint32_t *wg = lim->maxComputeWorkGroupSize;
  if (wg[0] != 128 || wg[1] != 128 || wg[2] != 64)
    snprintf(buf, sizeof buf, "max_compute_workgroup_size = [%u : i32, %u : i32, %u : i32]", wg[0], wg[1], wg[2]), item(buf);
  if (p11.subgroupSize != 32)
    snprintf(buf, sizeof buf, "subgroup_size = %u", p11.subgroupSize), item(buf);
  if (sizes.minSubgroupSize && sizes.maxSubgroupSize)
    snprintf(buf, sizeof buf, "min_subgroup_size = %u, max_subgroup_size = %u", sizes.minSubgroupSize, sizes.maxSubgroupSize), item(buf);
  if (coop && fcoop.cooperativeMatrix) {
    PFN_vkGetPhysicalDeviceCooperativeMatrixPropertiesKHR get =
        (PFN_vkGetPhysicalDeviceCooperativeMatrixPropertiesKHR)vkGetInstanceProcAddr(inst, "vkGetPhysicalDeviceCooperativeMatrixPropertiesKHR");
    uint32_t n = 0;
    get(phys, &n, NULL);
    VkCooperativeMatrixPropertiesKHR *cm = calloc(n, sizeof *cm);
    for (uint32_t i = 0; i < n; i++)
      cm[i].sType = VK_STRUCTURE_TYPE_COOPERATIVE_MATRIX_PROPERTIES_KHR;
    get(phys, &n, cm);
    printf("%scooperative_matrix_properties_khr = [", listed ? ", " : "");
    int props_listed = listed;
    listed = 0;
    for (uint32_t i = 0; i < n; i++) {
      const char *a = component(cm[i].AType), *b = component(cm[i].BType), *c = component(cm[i].CType), *r = component(cm[i].ResultType);
      if (!a || !b || !c || !r)
        continue;
      printf("%s#spirv.coop_matrix_props_khr<m_size = %u, n_size = %u, k_size = %u, a_type = %s, b_type = %s, c_type = %s, "
             "result_type = %s, acc_sat = %s, scope = <%s>>",
             listed++ ? ", " : "", cm[i].MSize, cm[i].NSize, cm[i].KSize, a, b, c, r, cm[i].saturatingAccumulation ? "true" : "false",
             scope(cm[i].scope));
    }
    printf("]");
    listed = props_listed + 1;
  }
  printf(">>\n");
  fprintf(stderr, "vkinfo: %s, Vulkan %u.%u.%u\n", props.properties.deviceName, VK_API_VERSION_MAJOR(api), VK_API_VERSION_MINOR(api), VK_API_VERSION_PATCH(api));
  vkDestroyInstance(inst, NULL);
  return 0;
}

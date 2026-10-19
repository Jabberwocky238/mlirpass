module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupFAdd <Workgroup> <Reduce> %arg0 : f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformFAdd <Workgroup> <Reduce> %arg0 : f32 -> f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupIAdd <Workgroup> <Reduce> %arg0 : i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformIAdd <Workgroup> <Reduce> %arg0 : i32 -> i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupFAdd <Subgroup> <Reduce> %arg0 : f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformFAdd <Subgroup> <Reduce> %arg0 : f32 -> f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupIAdd <Subgroup> <Reduce> %arg0 : i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformIAdd <Subgroup> <Reduce> %arg0 : i32 -> i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.KHR.GroupFMul <Workgroup> <Reduce> %arg0 : f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformFMul <Workgroup> <Reduce> %arg0 : f32 -> f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.KHR.GroupIMul <Workgroup> <Reduce> %arg0 : i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformIMul <Workgroup> <Reduce> %arg0 : i32 -> i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.KHR.GroupFMul <Subgroup> <Reduce> %arg0 : f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformFMul <Subgroup> <Reduce> %arg0 : f32 -> f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.KHR.GroupIMul <Subgroup> <Reduce> %arg0 : i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformIMul <Subgroup> <Reduce> %arg0 : i32 -> i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupFMin <Workgroup> <Reduce> %arg0 : f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformFMin <Workgroup> <Reduce> %arg0 : f32 -> f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupSMin <Workgroup> <Reduce> %arg0 : i32
        %1 = spirv.GroupUMin <Workgroup> <Reduce> %arg0 : i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformSMin <Workgroup> <Reduce> %arg0 : i32 -> i32
        %1 = spirv.GroupNonUniformUMin <Workgroup> <Reduce> %arg0 : i32 -> i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupFMin <Subgroup> <Reduce> %arg0 : f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformFMin <Subgroup> <Reduce> %arg0 : f32 -> f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupSMin <Subgroup> <Reduce> %arg0 : i32
        %1 = spirv.GroupUMin <Subgroup> <Reduce> %arg0 : i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformSMin <Subgroup> <Reduce> %arg0 : i32 -> i32
        %1 = spirv.GroupNonUniformUMin <Subgroup> <Reduce> %arg0 : i32 -> i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupFMax <Workgroup> <Reduce> %arg0 : f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformFMax <Workgroup> <Reduce> %arg0 : f32 -> f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupSMax <Workgroup> <Reduce> %arg0 : i32
        %1 = spirv.GroupUMax <Workgroup> <Reduce> %arg0 : i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformSMax <Workgroup> <Reduce> %arg0 : i32 -> i32
        %1 = spirv.GroupNonUniformUMax <Workgroup> <Reduce> %arg0 : i32 -> i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupFMax <Subgroup> <Reduce> %arg0 : f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformFMax <Subgroup> <Reduce> %arg0 : f32 -> f32
        spirv.Return
      }
    }
    func.func @test(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupSMax <Subgroup> <Reduce> %arg0 : i32
        %1 = spirv.GroupUMax <Subgroup> <Reduce> %arg0 : i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformSMax <Subgroup> <Reduce> %arg0 : i32 -> i32
        %1 = spirv.GroupNonUniformUMax <Subgroup> <Reduce> %arg0 : i32 -> i32
        spirv.Return
      }
    }
    func.func @test(%arg0: i32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test(%arg0: i32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %0 = spirv.GroupNonUniformSMax <Subgroup> <Reduce> %arg0 : i32 -> i32
        spirv.Return
      }
    }
    func.func @test(%arg0: vector<1xi32>) attributes {gpu.kernel} {
      return
    }
  }
}

// -----
// -----
// -----
// -----
// -----
// -----
// -----
// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupUniformArithmeticKHR, GroupNonUniformClustered], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.func @test_subgroup_reduce_clustered(%arg0: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %cst8_i32 = spirv.Constant 8 : i32
        %0 = spirv.GroupNonUniformFAdd <Subgroup> <ClusteredReduce> %arg0 cluster_size(%cst8_i32) : f32, i32 -> f32
        spirv.Return
      }
    }
    func.func @test_subgroup_reduce_clustered(%arg0: f32) attributes {gpu.kernel} {
      return
    }
  }
}

// -----

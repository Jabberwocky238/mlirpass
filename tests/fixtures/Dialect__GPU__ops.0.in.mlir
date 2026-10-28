#map = affine_map<(d0, d1) -> (d0 * 64 + d1)>
"builtin.module"() ({
  "builtin.module"() ({
    "func.func"() <{function_type = (index) -> (), sym_name = "no_args"}> ({
    ^bb0(%arg130: index):
      "gpu.launch"(%arg130, %arg130, %arg130, %arg130, %arg130, %arg130) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg131: index, %arg132: index, %arg133: index, %arg134: index, %arg135: index, %arg136: index, %arg137: index, %arg138: index, %arg139: index, %arg140: index, %arg141: index, %arg142: index):
        "gpu.terminator"() : () -> ()
      }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (index) -> (), sym_name = "launch_with_module_func_attr"}> ({
    ^bb0(%arg117: index):
      "gpu.launch"(%arg117, %arg117, %arg117, %arg117, %arg117, %arg117) <{function = @test_kernel_func, module = @test_module, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg118: index, %arg119: index, %arg120: index, %arg121: index, %arg122: index, %arg123: index, %arg124: index, %arg125: index, %arg126: index, %arg127: index, %arg128: index, %arg129: index):
        "gpu.terminator"() : () -> ()
      }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (index, index, f32, memref<?xf32, 1>) -> (), sym_name = "args"}> ({
    ^bb0(%arg101: index, %arg102: index, %arg103: f32, %arg104: memref<?xf32, 1>):
      "gpu.launch"(%arg101, %arg101, %arg101, %arg102, %arg102, %arg102) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg105: index, %arg106: index, %arg107: index, %arg108: index, %arg109: index, %arg110: index, %arg111: index, %arg112: index, %arg113: index, %arg114: index, %arg115: index, %arg116: index):
        "use"(%arg103) : (f32) -> ()
        "use"(%arg104) : (memref<?xf32, 1>) -> ()
        "gpu.terminator"() : () -> ()
      }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (index, index) -> (), sym_name = "launch_async"}> ({
    ^bb0(%arg87: index, %arg88: index):
      %96 = "gpu.wait"() : () -> !gpu.async.token
      %97 = "gpu.launch"(%96, %arg87, %arg87, %arg87, %arg88, %arg88, %arg88) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg89: index, %arg90: index, %arg91: index, %arg92: index, %arg93: index, %arg94: index, %arg95: index, %arg96: index, %arg97: index, %arg98: index, %arg99: index, %arg100: index):
        "gpu.terminator"() : () -> ()
      }) {workgroup_attributions = 0 : i64} : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (index, index) -> (), sym_name = "launch_async_no_deps"}> ({
    ^bb0(%arg61: index, %arg62: index):
      %94 = "gpu.launch"(%arg61, %arg61, %arg61, %arg62, %arg62, %arg62) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg75: index, %arg76: index, %arg77: index, %arg78: index, %arg79: index, %arg80: index, %arg81: index, %arg82: index, %arg83: index, %arg84: index, %arg85: index, %arg86: index):
        "gpu.terminator"() : () -> ()
      }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> !gpu.async.token
      %95 = "gpu.launch"(%arg61, %arg61, %arg61, %arg62, %arg62, %arg62) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg63: index, %arg64: index, %arg65: index, %arg66: index, %arg67: index, %arg68: index, %arg69: index, %arg70: index, %arg71: index, %arg72: index, %arg73: index, %arg74: index):
        "gpu.terminator"() : () -> ()
      }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> !gpu.async.token
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (index, index, f32, memref<?xf32, 1>) -> (), sym_name = "launch_with_attributions"}> ({
    ^bb0(%arg41: index, %arg42: index, %arg43: f32, %arg44: memref<?xf32, 1>):
      "gpu.launch"(%arg41, %arg41, %arg41, %arg42, %arg42, %arg42) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg45: index, %arg46: index, %arg47: index, %arg48: index, %arg49: index, %arg50: index, %arg51: index, %arg52: index, %arg53: index, %arg54: index, %arg55: index, %arg56: index, %arg57: memref<42xf32, 3>, %arg58: memref<2xf32, 3>, %arg59: memref<2xf32, 5>, %arg60: memref<1xf32, 5>):
        "use"(%arg43) : (f32) -> ()
        "use"(%arg44) : (memref<?xf32, 1>) -> ()
        "use"(%arg57, %arg58) : (memref<42xf32, 3>, memref<2xf32, 3>) -> ()
        "use"(%arg59) : (memref<2xf32, 5>) -> ()
        "use"(%arg60) : (memref<1xf32, 5>) -> ()
        "gpu.terminator"() : () -> ()
      }) {workgroup_attributions = 2 : i64} : (index, index, index, index, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "gpu.module"() <{sym_name = "kernels"}> ({
      "gpu.func"() <{function_type = (f32, memref<?xf32, 1>) -> ()}> ({
      ^bb0(%arg37: f32, %arg38: memref<?xf32, 1>):
        %59 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
        %60 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
        %61 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
        %62 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
        %63 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
        %64 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
        %65 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
        %66 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
        %67 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
        %68 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
        %69 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
        %70 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
        %71 = "gpu.global_id"() <{dimension = #gpu<dim x>}> : () -> index
        %72 = "gpu.global_id"() <{dimension = #gpu<dim y>}> : () -> index
        %73 = "gpu.global_id"() <{dimension = #gpu<dim z>}> : () -> index
        %74 = "gpu.subgroup_id"() : () -> index
        %75 = "gpu.num_subgroups"() : () -> index
        %76 = "gpu.subgroup_size"() : () -> index
        %77 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
        %78 = "vector.broadcast"(%arg37) : (f32) -> vector<4xf32>
        %79 = "gpu.all_reduce"(%77) <{op = #gpu<all_reduce_op add>}> ({
        }) : (f32) -> f32
        %80 = "gpu.all_reduce"(%77) <{op = #gpu<all_reduce_op add>, uniform}> ({
        }) : (f32) -> f32
        %81 = "gpu.all_reduce"(%77) ({
        ^bb0(%arg39: f32, %arg40: f32):
          %93 = "arith.addf"(%arg39, %arg40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "gpu.yield"(%93) : (f32) -> ()
        }) : (f32) -> f32
        %82 = "gpu.subgroup_reduce"(%77) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>}> : (f32) -> f32
        %83 = "gpu.subgroup_reduce"(%77) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>, uniform}> : (f32) -> f32
        %84 = "gpu.subgroup_reduce"(%78) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>}> : (vector<4xf32>) -> vector<4xf32>
        %85 = "arith.constant"() <{value = 7 : i32}> : () -> i32
        %86 = "arith.constant"() <{value = 3 : i32}> : () -> i32
        %87:2 = "gpu.shuffle"(%arg37, %86, %85) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
        %88:2 = "gpu.shuffle"(%arg37, %86, %85) <{mode = #gpu<shuffle_mode up>}> : (f32, i32, i32) -> (f32, i1)
        %89:2 = "gpu.shuffle"(%arg37, %86, %85) <{mode = #gpu<shuffle_mode down>}> : (f32, i32, i32) -> (f32, i1)
        %90:2 = "gpu.shuffle"(%arg37, %86, %85) <{mode = #gpu<shuffle_mode idx>}> : (f32, i32, i32) -> (f32, i1)
        %91:2 = "gpu.rotate"(%arg37) <{offset = 3 : i32, width = 16 : i32}> : (f32) -> (f32, i1)
        "gpu.barrier"() : () -> ()
        "some_op"(%65, %59) : (index, index) -> ()
        %92 = "memref.load"(%arg38, %65) : (memref<?xf32, 1>, index) -> f32
        "gpu.return"() : () -> ()
      }) {gpu.kernel, sym_name = "kernel_1", workgroup_attributions = 0 : i64} : () -> ()
      "gpu.func"() <{function_type = () -> ()}> ({
        "gpu.return"() : () -> ()
      }) {gpu.kernel, sym_name = "kernel_2", workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "gpu.binary"() <{objects = [#gpu.object<#nvvm.target, "">], offloadingHandler = #gpu.select_object, sym_name = "binary_1"}> : () -> ()
    "gpu.binary"() <{objects = [#gpu.object<#nvvm.target, "">, #gpu.object<#nvvm.target<chip = "sm_90">, "">], offloadingHandler = #gpu.select_object<#nvvm.target<chip = "sm_90">>, sym_name = "binary_2"}> : () -> ()
    "gpu.binary"() <{objects = [#gpu.object<#nvvm.target, "">, #gpu.object<#nvvm.target<chip = "sm_90">, "">], offloadingHandler = #gpu.select_object<1 : i64>, sym_name = "binary_3"}> : () -> ()
    "gpu.binary"() <{objects = [#gpu.object<#nvvm.target, bin = "">, #gpu.object<#nvvm.target, assembly = "">, #gpu.object<#nvvm.target, offload = "">, #gpu.object<#nvvm.target, properties = {O = 3 : i32}, offload = "">], offloadingHandler = #gpu.select_object, sym_name = "binary_4"}> : () -> ()
    "gpu.binary"() <{objects = [#gpu.object<#nvvm.target, properties = {O = 3 : i32}, "">], offloadingHandler = #gpu.select_object, sym_name = "binary_5"}> : () -> ()
    "func.func"() <{function_type = () -> (f32, memref<?xf32, 1>), sym_name = "two_value_generator", sym_visibility = "private"}> ({
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "foo"}> ({
      %50 = "op"() : () -> f32
      %51 = "op"() : () -> memref<?xf32, 1>
      %52 = "arith.constant"() <{value = 8 : index}> : () -> index
      %53 = "arith.constant"() <{value = 8 : i64}> : () -> i64
      %54 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %55 = "gpu.wait"() : () -> !gpu.async.token
      %56 = "llvm.mlir.zero"() : () -> !llvm.ptr
      "gpu.launch_func"(%52, %52, %52, %52, %52, %52, %50, %51) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<?xf32, 1>) -> ()
      "gpu.launch_func"(%52, %52, %52, %52, %52, %52, %52, %52, %52, %50, %51) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, 0>}> : (index, index, index, index, index, index, index, index, index, f32, memref<?xf32, 1>) -> ()
      "gpu.launch_func"(%52, %52, %52, %52, %52, %52, %54, %50, %51) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 2, 0>}> : (index, index, index, index, index, index, i32, f32, memref<?xf32, 1>) -> ()
      "gpu.launch_func"(%52, %52, %52, %52, %52, %52) <{kernel = @kernels::@kernel_2, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
      %57 = "gpu.launch_func"(%55, %52, %52, %52, %52, %52, %52) <{kernel = @kernels::@kernel_2, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
      "gpu.launch_func"(%53, %53, %53, %53, %53, %53, %50, %51, %56) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 1>}> : (i64, i64, i64, i64, i64, i64, f32, memref<?xf32, 1>, !llvm.ptr) -> ()
      "gpu.launch_func"(%54, %54, %54, %54, %54, %54, %50, %51) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (i32, i32, i32, i32, i32, i32, f32, memref<?xf32, 1>) -> ()
      "gpu.launch_func"(%54, %54, %54, %54, %54, %54, %50, %51) <{kernel = @binary_1::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (i32, i32, i32, i32, i32, i32, f32, memref<?xf32, 1>) -> ()
      %58:2 = "func.call"() <{callee = @two_value_generator}> : () -> (f32, memref<?xf32, 1>)
      "gpu.launch_func"(%52, %52, %52, %52, %52, %52, %58#0, %58#1) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<?xf32, 1>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "gpu.module"() <{sym_name = "gpu_funcs"}> ({
      "gpu.func"() <{function_type = (f32) -> ()}> ({
      ^bb0(%arg32: f32, %arg33: memref<42xf32, 3>, %arg34: memref<2xf32, 3>, %arg35: memref<2xf32, 5>, %arg36: memref<1xf32, 5>):
        "use"(%arg33, %arg34) : (memref<42xf32, 3>, memref<2xf32, 3>) -> ()
        "use"(%arg35) : (memref<2xf32, 5>) -> ()
        "use"(%arg36) : (memref<1xf32, 5>) -> ()
        "gpu.return"() : () -> ()
      }) {foo = "bar", gpu.kernel, sym_name = "kernel_1", workgroup_attributions = 2 : i64} : () -> ()
      "gpu.func"() <{function_type = (i32) -> ()}> ({
      ^bb0(%arg31: i32):
        "gpu.printf"(%arg31) <{format = "Value: %d"}> : (i32) -> ()
        "gpu.return"() : () -> ()
      }) {sym_name = "printf_test", workgroup_attributions = 0 : i64} : () -> ()
      "gpu.func"() <{function_type = (i32) -> ()}> ({
      ^bb0(%arg30: i32):
        "gpu.printf"() <{format = "]"}> : () -> ()
        %49 = "arith.cmpi"(%arg30, %arg30) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "scf.if"(%49) ({
          "gpu.printf"() <{format = ", "}> : () -> ()
          "scf.yield"() : () -> ()
        }, {
        }) : (i1) -> ()
        "gpu.return"() : () -> ()
      }) {sym_name = "printf_empty", workgroup_attributions = 0 : i64} : () -> ()
      "gpu.func"() <{function_type = (f32) -> ()}> ({
      ^bb0(%arg29: f32):
        "gpu.return"() : () -> ()
      }) {sym_name = "no_attribution", workgroup_attributions = 0 : i64} : () -> ()
      "gpu.func"() <{function_type = (f32) -> ()}> ({
      ^bb0(%arg28: f32):
        "gpu.return"() : () -> ()
      }) {foo = "bar", sym_name = "no_attribution_attrs", workgroup_attributions = 0 : i64} : () -> ()
      "gpu.func"() <{function_type = () -> ()}> ({
      ^bb0(%arg27: memref<42xf32, 3>):
        "gpu.return"() : () -> ()
      }) {sym_name = "workgroup_only", workgroup_attributions = 1 : i64} : () -> ()
      "gpu.func"() <{function_type = () -> ()}> ({
      ^bb0(%arg26: memref<2xf32, 5>):
        "gpu.return"() : () -> ()
      }) {sym_name = "private_only", workgroup_attributions = 0 : i64} : () -> ()
      "gpu.func"() <{function_type = (f32) -> ()}> ({
      ^bb0(%arg25: f32):
        "gpu.return"() : () -> ()
      }) {sym_name = "empty_attribution", workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "gpu.module"() <{sym_name = "explicit_attributions"}> ({
      "gpu.func"() <{function_type = (f32, memref<?xf32>) -> ()}> ({
      ^bb0(%arg21: f32, %arg22: memref<?xf32>, %arg23: memref<5xf32, 3>, %arg24: memref<5xf32, 5>):
        "gpu.return"() : () -> ()
      }) {gpu.kernel, sym_name = "kernel_1", workgroup_attributions = 1 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "alloc"}> ({
      %44 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<13xf32, 1>
      "gpu.dealloc"(%44) : (memref<13xf32, 1>) -> ()
      %45 = "gpu.wait"() : () -> !gpu.async.token
      %46:2 = "gpu.alloc"(%45) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (!gpu.async.token) -> (memref<13xf32, 1>, !gpu.async.token)
      %47 = "gpu.dealloc"(%46#1, %46#0) : (!gpu.async.token, memref<13xf32, 1>) -> !gpu.async.token
      %48 = "gpu.alloc"() <{hostShared, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<13xf32, 1>
      "gpu.dealloc"(%48) : (memref<13xf32, 1>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (!gpu.async.token) -> !gpu.async.token, sym_name = "async_token"}> ({
    ^bb0(%arg20: !gpu.async.token):
      "func.return"(%arg20) : (!gpu.async.token) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "async_wait"}> ({
      %41 = "gpu.wait"() : () -> !gpu.async.token
      %42 = "gpu.wait"(%41) : (!gpu.async.token) -> !gpu.async.token
      %43 = "gpu.wait"(%41, %42) : (!gpu.async.token, !gpu.async.token) -> !gpu.async.token
      "gpu.wait"(%41, %42) : (!gpu.async.token, !gpu.async.token) -> ()
      "gpu.wait"() : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (memref<3x7xf32>, memref<3x7xf32, 1>) -> (), sym_name = "memcpy"}> ({
    ^bb0(%arg18: memref<3x7xf32>, %arg19: memref<3x7xf32, 1>):
      "gpu.memcpy"(%arg18, %arg19) : (memref<3x7xf32>, memref<3x7xf32, 1>) -> ()
      %39 = "gpu.wait"() : () -> !gpu.async.token
      %40 = "gpu.memcpy"(%39, %arg18, %arg19) : (!gpu.async.token, memref<3x7xf32>, memref<3x7xf32, 1>) -> !gpu.async.token
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (memref<3x7xf32>, f32) -> (), sym_name = "memset"}> ({
    ^bb0(%arg16: memref<3x7xf32>, %arg17: f32):
      "gpu.memset"(%arg16, %arg17) : (memref<3x7xf32>, f32) -> ()
      %37 = "gpu.wait"() : () -> !gpu.async.token
      %38 = "gpu.memset"(%37, %arg16, %arg17) : (!gpu.async.token, memref<3x7xf32>, f32) -> !gpu.async.token
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (memref<32x32xf16, #map>) -> (), sym_name = "mmamatrix_valid_scalar_element_type"}> ({
    ^bb0(%arg15: memref<32x32xf16, #map>):
      %29 = "memref.alloca"() <{alignment = 32 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf16, 3>
      %30 = "arith.constant"() <{value = 16 : index}> : () -> index
      %31 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %32 = "gpu.subgroup_mma_load_matrix"(%29, %30, %30) <{leadDimension = 32 : index}> : (memref<32x32xf16, 3>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
      %33 = "gpu.subgroup_mma_load_matrix"(%arg15, %30, %30) <{leadDimension = 64 : index}> : (memref<32x32xf16, #map>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
      %34 = "gpu.subgroup_mma_constant_matrix"(%31) : (f32) -> !gpu.mma_matrix<16x16xf32, "COp">
      %35 = "gpu.subgroup_mma_elementwise"(%34, %34) <{opType = #gpu<mma_element_wise addf>}> : (!gpu.mma_matrix<16x16xf32, "COp">, !gpu.mma_matrix<16x16xf32, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
      %36 = "gpu.subgroup_mma_elementwise"(%35, %34) <{opType = #gpu<mma_element_wise maxf>}> : (!gpu.mma_matrix<16x16xf32, "COp">, !gpu.mma_matrix<16x16xf32, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (memref<32x4xvector<4xf32>>, index) -> (), sym_name = "mmamatrix_valid_vector_element_type"}> ({
    ^bb0(%arg13: memref<32x4xvector<4xf32>>, %arg14: index):
      %28 = "gpu.subgroup_mma_load_matrix"(%arg13, %arg14, %arg14) <{leadDimension = 4 : index}> : (memref<32x4xvector<4xf32>>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%28, %arg13, %arg14, %arg14) <{leadDimension = 4 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<32x4xvector<4xf32>>, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "set_default_device"}> ({
    ^bb0(%arg12: i32):
      "gpu.set_default_device"(%arg12) : (i32) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (index) -> (), sym_name = "sparse_ops"}> ({
    ^bb0(%arg11: index):
      %12 = "gpu.wait"() : () -> !gpu.async.token
      %13:2 = "gpu.alloc"(%12, %arg11) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xindex>, !gpu.async.token)
      %14:2 = "gpu.alloc"(%13#1, %arg11) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xf64>, !gpu.async.token)
      %15:2 = "gpu.create_coo"(%14#1, %arg11, %arg11, %arg11, %13#0, %13#0, %14#0) : (!gpu.async.token, index, index, index, memref<?xindex>, memref<?xindex>, memref<?xf64>) -> (!gpu.sparse.spmat_handle, !gpu.async.token)
      %16:2 = "gpu.create_csr"(%15#1, %arg11, %arg11, %arg11, %13#0, %13#0, %14#0) : (!gpu.async.token, index, index, index, memref<?xindex>, memref<?xindex>, memref<?xf64>) -> (!gpu.sparse.spmat_handle, !gpu.async.token)
      %17:2 = "gpu.create_dn_tensor"(%16#1, %14#0, %arg11) <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (!gpu.async.token, memref<?xf64>, index) -> (!gpu.sparse.dntensor_handle, !gpu.async.token)
      %18:2 = "gpu.spmv_buffer_size"(%17#1, %15#0, %17#0, %17#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.spmat_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle) -> (index, !gpu.async.token)
      %19 = "gpu.spmv"(%18#1, %15#0, %17#0, %17#0, %14#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.spmat_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle, memref<?xf64>) -> !gpu.async.token
      %20:2 = "gpu.create_dn_tensor"(%19, %14#0, %arg11, %arg11) <{operandSegmentSizes = array<i32: 1, 1, 2>}> : (!gpu.async.token, memref<?xf64>, index, index) -> (!gpu.sparse.dntensor_handle, !gpu.async.token)
      %21:2 = "gpu.spmm_buffer_size"(%20#1, %15#0, %20#0, %20#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>, resultSegmentSizes = array<i32: 1, 1>}> : (!gpu.async.token, !gpu.sparse.spmat_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle) -> (index, !gpu.async.token)
      %22 = "gpu.spmm"(%21#1, %15#0, %20#0, %20#0, %14#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1>}> : (!gpu.async.token, !gpu.sparse.spmat_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle, memref<?xf64>) -> !gpu.async.token
      %23:2 = "gpu.sddmm_buffer_size"(%22, %20#0, %20#0, %15#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.spmat_handle) -> (index, !gpu.async.token)
      %24 = "gpu.sddmm"(%23#1, %20#0, %20#0, %15#0, %14#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.spmat_handle, memref<?xf64>) -> !gpu.async.token
      %25 = "gpu.destroy_dn_tensor"(%24, %20#0) : (!gpu.async.token, !gpu.sparse.dntensor_handle) -> !gpu.async.token
      %26 = "gpu.destroy_sp_mat"(%25, %15#0) : (!gpu.async.token, !gpu.sparse.spmat_handle) -> !gpu.async.token
      %27 = "gpu.destroy_dn_tensor"(%26, %17#0) : (!gpu.async.token, !gpu.sparse.dntensor_handle) -> !gpu.async.token
      "gpu.wait"(%27) : (!gpu.async.token) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (!gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32>) -> (), sym_name = "extract_insert_mma"}> ({
    ^bb0(%arg9: !gpu.mma_matrix<16x16xf32, "COp">, %arg10: memref<16x16xf32>):
      %7 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %8 = "arith.constant"() <{value = 0 : index}> : () -> index
      %9 = "gpu.subgroup_mma_extract_thread_local"(%arg9, %8) : (!gpu.mma_matrix<16x16xf32, "COp">, index) -> f32
      %10 = "gpu.subgroup_mma_constant_matrix"(%7) : (f32) -> !gpu.mma_matrix<16x16xf32, "COp">
      %11 = "gpu.subgroup_mma_insert_thread_local"(%9, %10, %8) : (f32, !gpu.mma_matrix<16x16xf32, "COp">, index) -> !gpu.mma_matrix<16x16xf32, "COp">
      "gpu.subgroup_mma_store_matrix"(%11, %arg10, %8, %8) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32>, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) {gpu.container_module} : () -> ()
  "gpu.module"() <{sym_name = "module"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.return"() : () -> ()
    }) {sym_name = "func"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "module_with_one_target", targets = [#nvvm.target]}> ({
    "gpu.func"() <{function_type = (f32) -> ()}> ({
    ^bb0(%arg8: f32):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "module_with_two_target", targets = [#nvvm.target, #rocdl.target<chip = "gfx90a">]}> ({
    "gpu.func"() <{function_type = (f32) -> ()}> ({
    ^bb0(%arg7: f32):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{offloadingHandler = #gpu.select_object<0 : i64>, sym_name = "module_with_offload_handler", targets = [#nvvm.target]}> ({
  ^bb0:
  }) : () -> ()
  "gpu.binary"() <{objects = [#gpu.object<#rocdl.target, kernels = <[#gpu.kernel_metadata<"kernel0", (i32, f32) -> (), metadata = {sgpr_count = 255 : i64}>, #gpu.kernel_metadata<"kernel1", (i32) -> (), arg_attrs = [{llvm.read_only}]>]>, bin = "BLOB">], offloadingHandler = #gpu.select_object, sym_name = "kernel_attrs_1"}> : () -> ()
  "gpu.binary"() <{objects = [#gpu.object<#rocdl.target, kernels = <[#gpu.kernel_metadata<"a_kernel", () -> ()>, #gpu.kernel_metadata<"m_kernel", () -> ()>, #gpu.kernel_metadata<"z_kernel", () -> ()>]>, bin = "BLOB">], offloadingHandler = #gpu.select_object, sym_name = "kernel_attrs_2"}> : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "warp_execute_on_lane_0"}> ({
  ^bb0(%arg6: index):
    "gpu.warp_execute_on_lane_0"(%arg6) <{warp_size = 32 : i64}> ({
      "gpu.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "warp_execute_on_lane_0_2d"}> ({
  ^bb0(%arg5: index):
    %5 = "gpu.warp_execute_on_lane_0"(%arg5) <{warp_size = 32 : i64}> ({
      %6 = "arith.constant"() <{value = dense<2> : vector<4x32xi32>}> : () -> vector<4x32xi32>
      "gpu.yield"(%6) : (vector<4x32xi32>) -> ()
    }) : (index) -> vector<1x4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, vector<4xi32>) -> vector<4xi32>, sym_name = "warp_operand_result"}> ({
  ^bb0(%arg2: index, %arg3: vector<4xi32>):
    %2 = "gpu.warp_execute_on_lane_0"(%arg2, %arg3) <{warp_size = 32 : i64}> ({
    ^bb0(%arg4: vector<128xi32>):
      %3 = "arith.constant"() <{value = dense<2> : vector<128xi32>}> : () -> vector<128xi32>
      %4 = "arith.addi"(%arg4, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<128xi32>, vector<128xi32>) -> vector<128xi32>
      "gpu.yield"(%4) : (vector<128xi32>) -> ()
    }) : (index, vector<4xi32>) -> vector<4xi32>
    "func.return"(%2) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32) -> (f32, f32), sym_name = "subgroup_broadcast"}> ({
  ^bb0(%arg0: f32, %arg1: i32):
    %0 = "gpu.subgroup_broadcast"(%arg0) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (f32) -> f32
    %1 = "gpu.subgroup_broadcast"(%arg0, %arg1) <{broadcast_type = #gpu<broadcast specific_lane>}> : (f32, i32) -> f32
    "func.return"(%0, %1) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()


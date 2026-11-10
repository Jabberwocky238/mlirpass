#map = affine_map<(d0, d1) -> (d0 * 64 + d1)>
"builtin.module"() ({
  "builtin.module"() ({
    "func.func"() <{function_type = (index) -> (), sym_name = "no_args"}> ({
    ^bb0(%arg144: index):
      "gpu.launch"(%arg144, %arg144, %arg144, %arg144, %arg144, %arg144) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg145: index, %arg146: index, %arg147: index, %arg148: index, %arg149: index, %arg150: index, %arg151: index, %arg152: index, %arg153: index, %arg154: index, %arg155: index, %arg156: index):
        "gpu.terminator"() : () -> ()
      }) : (index, index, index, index, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (index) -> (), sym_name = "launch_cooperative"}> ({
    ^bb0(%arg131: index):
      "gpu.launch"(%arg131, %arg131, %arg131, %arg131, %arg131, %arg131) <{cooperative, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg132: index, %arg133: index, %arg134: index, %arg135: index, %arg136: index, %arg137: index, %arg138: index, %arg139: index, %arg140: index, %arg141: index, %arg142: index, %arg143: index):
        "gpu.terminator"() : () -> ()
      }) : (index, index, index, index, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (index) -> (), sym_name = "launch_with_module_func_attr"}> ({
    ^bb0(%arg118: index):
      "gpu.launch"(%arg118, %arg118, %arg118, %arg118, %arg118, %arg118) <{function = @test_kernel_func, module = @test_module, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg119: index, %arg120: index, %arg121: index, %arg122: index, %arg123: index, %arg124: index, %arg125: index, %arg126: index, %arg127: index, %arg128: index, %arg129: index, %arg130: index):
        "gpu.terminator"() : () -> ()
      }) : (index, index, index, index, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (index, index, f32, memref<?xf32, 1>) -> (), sym_name = "args"}> ({
    ^bb0(%arg102: index, %arg103: index, %arg104: f32, %arg105: memref<?xf32, 1>):
      "gpu.launch"(%arg102, %arg102, %arg102, %arg103, %arg103, %arg103) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg106: index, %arg107: index, %arg108: index, %arg109: index, %arg110: index, %arg111: index, %arg112: index, %arg113: index, %arg114: index, %arg115: index, %arg116: index, %arg117: index):
        "use"(%arg104) : (f32) -> ()
        "use"(%arg105) : (memref<?xf32, 1>) -> ()
        "gpu.terminator"() : () -> ()
      }) : (index, index, index, index, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (index, index) -> (), sym_name = "launch_async"}> ({
    ^bb0(%arg88: index, %arg89: index):
      %98 = "gpu.wait"() : () -> !gpu.async.token
      %99 = "gpu.launch"(%98, %arg88, %arg88, %arg88, %arg89, %arg89, %arg89) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg90: index, %arg91: index, %arg92: index, %arg93: index, %arg94: index, %arg95: index, %arg96: index, %arg97: index, %arg98: index, %arg99: index, %arg100: index, %arg101: index):
        "gpu.terminator"() : () -> ()
      }) : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (index, index) -> (), sym_name = "launch_async_no_deps"}> ({
    ^bb0(%arg62: index, %arg63: index):
      %96 = "gpu.launch"(%arg62, %arg62, %arg62, %arg63, %arg63, %arg63) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg76: index, %arg77: index, %arg78: index, %arg79: index, %arg80: index, %arg81: index, %arg82: index, %arg83: index, %arg84: index, %arg85: index, %arg86: index, %arg87: index):
        "gpu.terminator"() : () -> ()
      }) : (index, index, index, index, index, index) -> !gpu.async.token
      %97 = "gpu.launch"(%arg62, %arg62, %arg62, %arg63, %arg63, %arg63) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg64: index, %arg65: index, %arg66: index, %arg67: index, %arg68: index, %arg69: index, %arg70: index, %arg71: index, %arg72: index, %arg73: index, %arg74: index, %arg75: index):
        "gpu.terminator"() : () -> ()
      }) : (index, index, index, index, index, index) -> !gpu.async.token
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (index, index, f32, memref<?xf32, 1>) -> (), sym_name = "launch_with_attributions"}> ({
    ^bb0(%arg42: index, %arg43: index, %arg44: f32, %arg45: memref<?xf32, 1>):
      "gpu.launch"(%arg42, %arg42, %arg42, %arg43, %arg43, %arg43) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>, workgroup_attributions = 2 : i64}> ({
      ^bb0(%arg46: index, %arg47: index, %arg48: index, %arg49: index, %arg50: index, %arg51: index, %arg52: index, %arg53: index, %arg54: index, %arg55: index, %arg56: index, %arg57: index, %arg58: memref<42xf32, 3>, %arg59: memref<2xf32, 3>, %arg60: memref<2xf32, 5>, %arg61: memref<1xf32, 5>):
        "use"(%arg44) : (f32) -> ()
        "use"(%arg45) : (memref<?xf32, 1>) -> ()
        "use"(%arg58, %arg59) : (memref<42xf32, 3>, memref<2xf32, 3>) -> ()
        "use"(%arg60) : (memref<2xf32, 5>) -> ()
        "use"(%arg61) : (memref<1xf32, 5>) -> ()
        "gpu.terminator"() : () -> ()
      }) : (index, index, index, index, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "gpu.module"() <{sym_name = "kernels"}> ({
      "gpu.func"() <{function_type = (f32, memref<?xf32, 1>) -> (), kernel}> ({
      ^bb0(%arg38: f32, %arg39: memref<?xf32, 1>):
        %61 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
        %62 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
        %63 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
        %64 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
        %65 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
        %66 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
        %67 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
        %68 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
        %69 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
        %70 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
        %71 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
        %72 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
        %73 = "gpu.global_id"() <{dimension = #gpu<dim x>}> : () -> index
        %74 = "gpu.global_id"() <{dimension = #gpu<dim y>}> : () -> index
        %75 = "gpu.global_id"() <{dimension = #gpu<dim z>}> : () -> index
        %76 = "gpu.subgroup_id"() : () -> index
        %77 = "gpu.num_subgroups"() : () -> index
        %78 = "gpu.subgroup_size"() : () -> index
        %79 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
        %80 = "vector.broadcast"(%arg38) : (f32) -> vector<4xf32>
        %81 = "gpu.all_reduce"(%79) <{op = #gpu<all_reduce_op add>}> ({
        }) : (f32) -> f32
        %82 = "gpu.all_reduce"(%79) <{op = #gpu<all_reduce_op add>, uniform}> ({
        }) : (f32) -> f32
        %83 = "gpu.all_reduce"(%79) ({
        ^bb0(%arg40: f32, %arg41: f32):
          %95 = "arith.addf"(%arg40, %arg41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "gpu.yield"(%95) : (f32) -> ()
        }) : (f32) -> f32
        %84 = "gpu.subgroup_reduce"(%79) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>}> : (f32) -> f32
        %85 = "gpu.subgroup_reduce"(%79) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>, uniform}> : (f32) -> f32
        %86 = "gpu.subgroup_reduce"(%80) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>}> : (vector<4xf32>) -> vector<4xf32>
        %87 = "arith.constant"() <{value = 7 : i32}> : () -> i32
        %88 = "arith.constant"() <{value = 3 : i32}> : () -> i32
        %89:2 = "gpu.shuffle"(%arg38, %88, %87) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
        %90:2 = "gpu.shuffle"(%arg38, %88, %87) <{mode = #gpu<shuffle_mode up>}> : (f32, i32, i32) -> (f32, i1)
        %91:2 = "gpu.shuffle"(%arg38, %88, %87) <{mode = #gpu<shuffle_mode down>}> : (f32, i32, i32) -> (f32, i1)
        %92:2 = "gpu.shuffle"(%arg38, %88, %87) <{mode = #gpu<shuffle_mode idx>}> : (f32, i32, i32) -> (f32, i1)
        %93:2 = "gpu.rotate"(%arg38) <{offset = 3 : i32, width = 16 : i32}> : (f32) -> (f32, i1)
        "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
        "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
        "gpu.barrier"() <{address_spaces = [#gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
        "gpu.barrier"() <{address_spaces = [#gpu.address_space<global>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
        "gpu.barrier"() <{address_spaces = [#gpu.address_space<global>, #gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
        "gpu.barrier"() <{address_spaces = [#gpu.address_space<private>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
        "gpu.barrier"() <{address_spaces = [#gpu.address_space<constant>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
        "gpu.barrier"() <{address_spaces = [], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
        "some_op"(%67, %61) : (index, index) -> ()
        %94 = "memref.load"(%arg39, %67) : (memref<?xf32, 1>, index) -> f32
        "gpu.return"() : () -> ()
      }) {sym_name = "kernel_1"} : () -> ()
      "gpu.func"() <{function_type = () -> (), kernel}> ({
        "gpu.return"() : () -> ()
      }) {sym_name = "kernel_2"} : () -> ()
    }) : () -> ()
    "gpu.binary"() <{objects = [#gpu.object<#nvvm.target, "">], offloadingHandler = #gpu.select_object, sym_name = "binary_1"}> : () -> ()
    "gpu.binary"() <{objects = [#gpu.object<#nvvm.target, "">, #gpu.object<#nvvm.target<chip = "sm_90">, "">], offloadingHandler = #gpu.select_object<#nvvm.target<chip = "sm_90">>, sym_name = "binary_2"}> : () -> ()
    "gpu.binary"() <{objects = [#gpu.object<#nvvm.target, "">, #gpu.object<#nvvm.target<chip = "sm_90">, "">], offloadingHandler = #gpu.select_object<1 : i64>, sym_name = "binary_3"}> : () -> ()
    "gpu.binary"() <{objects = [#gpu.object<#nvvm.target, bin = "">, #gpu.object<#nvvm.target, assembly = "">, #gpu.object<#nvvm.target, offload = "">, #gpu.object<#nvvm.target, properties = {O = 3 : i32}, offload = "">], offloadingHandler = #gpu.select_object, sym_name = "binary_4"}> : () -> ()
    "gpu.binary"() <{objects = [#gpu.object<#nvvm.target, properties = {O = 3 : i32}, "">], offloadingHandler = #gpu.select_object, sym_name = "binary_5"}> : () -> ()
    "func.func"() <{function_type = () -> (f32, memref<?xf32, 1>), sym_name = "two_value_generator", sym_visibility = "private"}> ({
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "foo"}> ({
      %52 = "op"() : () -> f32
      %53 = "op"() : () -> memref<?xf32, 1>
      %54 = "arith.constant"() <{value = 8 : index}> : () -> index
      %55 = "arith.constant"() <{value = 8 : i64}> : () -> i64
      %56 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %57 = "gpu.wait"() : () -> !gpu.async.token
      %58 = "llvm.mlir.zero"() : () -> !llvm.ptr
      "gpu.launch_func"(%54, %54, %54, %54, %54, %54, %52, %53) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<?xf32, 1>) -> ()
      "gpu.launch_func"(%54, %54, %54, %54, %54, %54, %54, %54, %54, %52, %53) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, 0>}> : (index, index, index, index, index, index, index, index, index, f32, memref<?xf32, 1>) -> ()
      "gpu.launch_func"(%54, %54, %54, %54, %54, %54, %52, %53) <{cooperative, kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<?xf32, 1>) -> ()
      "gpu.launch_func"(%54, %54, %54, %54, %54, %54, %54, %54, %54, %52, %53) <{cooperative, kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, 0>}> : (index, index, index, index, index, index, index, index, index, f32, memref<?xf32, 1>) -> ()
      "gpu.launch_func"(%54, %54, %54, %54, %54, %54, %56, %52, %53) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 2, 0>}> : (index, index, index, index, index, index, i32, f32, memref<?xf32, 1>) -> ()
      "gpu.launch_func"(%54, %54, %54, %54, %54, %54) <{kernel = @kernels::@kernel_2, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
      %59 = "gpu.launch_func"(%57, %54, %54, %54, %54, %54, %54) <{kernel = @kernels::@kernel_2, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
      "gpu.launch_func"(%55, %55, %55, %55, %55, %55, %52, %53, %58) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 1>}> : (i64, i64, i64, i64, i64, i64, f32, memref<?xf32, 1>, !llvm.ptr) -> ()
      "gpu.launch_func"(%56, %56, %56, %56, %56, %56, %52, %53) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (i32, i32, i32, i32, i32, i32, f32, memref<?xf32, 1>) -> ()
      "gpu.launch_func"(%56, %56, %56, %56, %56, %56, %52, %53) <{kernel = @binary_1::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (i32, i32, i32, i32, i32, i32, f32, memref<?xf32, 1>) -> ()
      %60:2 = "func.call"() <{callee = @two_value_generator}> : () -> (f32, memref<?xf32, 1>)
      "gpu.launch_func"(%54, %54, %54, %54, %54, %54, %60#0, %60#1) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<?xf32, 1>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "gpu.module"() <{sym_name = "gpu_funcs"}> ({
      "gpu.func"() <{function_type = (f32) -> (), kernel, workgroup_attributions = 2 : i64}> ({
      ^bb0(%arg33: f32, %arg34: memref<42xf32, 3>, %arg35: memref<2xf32, 3>, %arg36: memref<2xf32, 5>, %arg37: memref<1xf32, 5>):
        "use"(%arg34, %arg35) : (memref<42xf32, 3>, memref<2xf32, 3>) -> ()
        "use"(%arg36) : (memref<2xf32, 5>) -> ()
        "use"(%arg37) : (memref<1xf32, 5>) -> ()
        "gpu.return"() : () -> ()
      }) {foo = "bar", sym_name = "kernel_1"} : () -> ()
      "gpu.func"() <{function_type = (i32) -> ()}> ({
      ^bb0(%arg32: i32):
        "gpu.printf"(%arg32) <{format = "Value: %d"}> : (i32) -> ()
        "gpu.return"() : () -> ()
      }) {sym_name = "printf_test"} : () -> ()
      "gpu.func"() <{function_type = (i32) -> ()}> ({
      ^bb0(%arg31: i32):
        "gpu.printf"() <{format = "]"}> : () -> ()
        %51 = "arith.cmpi"(%arg31, %arg31) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "scf.if"(%51) ({
          "gpu.printf"() <{format = ", "}> : () -> ()
          "scf.yield"() : () -> ()
        }, {
        }) : (i1) -> ()
        "gpu.return"() : () -> ()
      }) {sym_name = "printf_empty"} : () -> ()
      "gpu.func"() <{function_type = (f32) -> ()}> ({
      ^bb0(%arg30: f32):
        "gpu.return"() : () -> ()
      }) {sym_name = "no_attribution"} : () -> ()
      "gpu.func"() <{function_type = (f32) -> ()}> ({
      ^bb0(%arg29: f32):
        "gpu.return"() : () -> ()
      }) {foo = "bar", sym_name = "no_attribution_attrs"} : () -> ()
      "gpu.func"() <{function_type = () -> (), workgroup_attributions = 1 : i64}> ({
      ^bb0(%arg28: memref<42xf32, 3>):
        "gpu.return"() : () -> ()
      }) {sym_name = "workgroup_only"} : () -> ()
      "gpu.func"() <{function_type = () -> ()}> ({
      ^bb0(%arg27: memref<2xf32, 5>):
        "gpu.return"() : () -> ()
      }) {sym_name = "private_only"} : () -> ()
      "gpu.func"() <{function_type = (f32) -> ()}> ({
      ^bb0(%arg26: f32):
        "gpu.return"() : () -> ()
      }) {sym_name = "empty_attribution"} : () -> ()
    }) : () -> ()
    "gpu.module"() <{sym_name = "explicit_attributions"}> ({
      "gpu.func"() <{function_type = (f32, memref<?xf32>) -> (), workgroup_attributions = 1 : i64}> ({
      ^bb0(%arg22: f32, %arg23: memref<?xf32>, %arg24: memref<5xf32, 3>, %arg25: memref<5xf32, 5>):
        "gpu.return"() : () -> ()
      }) {gpu.kernel, sym_name = "kernel_1"} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "alloc"}> ({
      %46 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<13xf32, 1>
      "gpu.dealloc"(%46) : (memref<13xf32, 1>) -> ()
      %47 = "gpu.wait"() : () -> !gpu.async.token
      %48:2 = "gpu.alloc"(%47) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (!gpu.async.token) -> (memref<13xf32, 1>, !gpu.async.token)
      %49 = "gpu.dealloc"(%48#1, %48#0) : (!gpu.async.token, memref<13xf32, 1>) -> !gpu.async.token
      %50 = "gpu.alloc"() <{hostShared, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<13xf32, 1>
      "gpu.dealloc"(%50) : (memref<13xf32, 1>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (!gpu.async.token) -> !gpu.async.token, sym_name = "async_token"}> ({
    ^bb0(%arg21: !gpu.async.token):
      "func.return"(%arg21) : (!gpu.async.token) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "async_wait"}> ({
      %43 = "gpu.wait"() : () -> !gpu.async.token
      %44 = "gpu.wait"(%43) : (!gpu.async.token) -> !gpu.async.token
      %45 = "gpu.wait"(%43, %44) : (!gpu.async.token, !gpu.async.token) -> !gpu.async.token
      "gpu.wait"(%43, %44) : (!gpu.async.token, !gpu.async.token) -> ()
      "gpu.wait"() : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (memref<3x7xf32>, memref<3x7xf32, 1>) -> (), sym_name = "memcpy"}> ({
    ^bb0(%arg19: memref<3x7xf32>, %arg20: memref<3x7xf32, 1>):
      "gpu.memcpy"(%arg19, %arg20) : (memref<3x7xf32>, memref<3x7xf32, 1>) -> ()
      %41 = "gpu.wait"() : () -> !gpu.async.token
      %42 = "gpu.memcpy"(%41, %arg19, %arg20) : (!gpu.async.token, memref<3x7xf32>, memref<3x7xf32, 1>) -> !gpu.async.token
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (memref<3x7xf32>, f32) -> (), sym_name = "memset"}> ({
    ^bb0(%arg17: memref<3x7xf32>, %arg18: f32):
      "gpu.memset"(%arg17, %arg18) : (memref<3x7xf32>, f32) -> ()
      %39 = "gpu.wait"() : () -> !gpu.async.token
      %40 = "gpu.memset"(%39, %arg17, %arg18) : (!gpu.async.token, memref<3x7xf32>, f32) -> !gpu.async.token
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (memref<32x32xf16, #map>) -> (), sym_name = "mmamatrix_valid_scalar_element_type"}> ({
    ^bb0(%arg16: memref<32x32xf16, #map>):
      %31 = "memref.alloca"() <{alignment = 32 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf16, 3>
      %32 = "arith.constant"() <{value = 16 : index}> : () -> index
      %33 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %34 = "gpu.subgroup_mma_load_matrix"(%31, %32, %32) <{leadDimension = 32 : index}> : (memref<32x32xf16, 3>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
      %35 = "gpu.subgroup_mma_load_matrix"(%arg16, %32, %32) <{leadDimension = 64 : index}> : (memref<32x32xf16, #map>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
      %36 = "gpu.subgroup_mma_constant_matrix"(%33) : (f32) -> !gpu.mma_matrix<16x16xf32, "COp">
      %37 = "gpu.subgroup_mma_elementwise"(%36, %36) <{opType = #gpu<mma_element_wise addf>}> : (!gpu.mma_matrix<16x16xf32, "COp">, !gpu.mma_matrix<16x16xf32, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
      %38 = "gpu.subgroup_mma_elementwise"(%37, %36) <{opType = #gpu<mma_element_wise maxf>}> : (!gpu.mma_matrix<16x16xf32, "COp">, !gpu.mma_matrix<16x16xf32, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (memref<32x4xvector<4xf32>>, index) -> (), sym_name = "mmamatrix_valid_vector_element_type"}> ({
    ^bb0(%arg14: memref<32x4xvector<4xf32>>, %arg15: index):
      %30 = "gpu.subgroup_mma_load_matrix"(%arg14, %arg15, %arg15) <{leadDimension = 4 : index}> : (memref<32x4xvector<4xf32>>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%30, %arg14, %arg15, %arg15) <{leadDimension = 4 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<32x4xvector<4xf32>>, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "set_default_device"}> ({
    ^bb0(%arg13: i32):
      "gpu.set_default_device"(%arg13) : (i32) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (index) -> (), sym_name = "sparse_ops"}> ({
    ^bb0(%arg12: index):
      %14 = "gpu.wait"() : () -> !gpu.async.token
      %15:2 = "gpu.alloc"(%14, %arg12) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xindex>, !gpu.async.token)
      %16:2 = "gpu.alloc"(%15#1, %arg12) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xf64>, !gpu.async.token)
      %17:2 = "gpu.create_coo"(%16#1, %arg12, %arg12, %arg12, %15#0, %15#0, %16#0) : (!gpu.async.token, index, index, index, memref<?xindex>, memref<?xindex>, memref<?xf64>) -> (!gpu.sparse.spmat_handle, !gpu.async.token)
      %18:2 = "gpu.create_csr"(%17#1, %arg12, %arg12, %arg12, %15#0, %15#0, %16#0) : (!gpu.async.token, index, index, index, memref<?xindex>, memref<?xindex>, memref<?xf64>) -> (!gpu.sparse.spmat_handle, !gpu.async.token)
      %19:2 = "gpu.create_dn_tensor"(%18#1, %16#0, %arg12) <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (!gpu.async.token, memref<?xf64>, index) -> (!gpu.sparse.dntensor_handle, !gpu.async.token)
      %20:2 = "gpu.spmv_buffer_size"(%19#1, %17#0, %19#0, %19#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.spmat_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle) -> (index, !gpu.async.token)
      %21 = "gpu.spmv"(%20#1, %17#0, %19#0, %19#0, %16#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.spmat_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle, memref<?xf64>) -> !gpu.async.token
      %22:2 = "gpu.create_dn_tensor"(%21, %16#0, %arg12, %arg12) <{operandSegmentSizes = array<i32: 1, 1, 2>}> : (!gpu.async.token, memref<?xf64>, index, index) -> (!gpu.sparse.dntensor_handle, !gpu.async.token)
      %23:2 = "gpu.spmm_buffer_size"(%22#1, %17#0, %22#0, %22#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>, resultSegmentSizes = array<i32: 1, 1>}> : (!gpu.async.token, !gpu.sparse.spmat_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle) -> (index, !gpu.async.token)
      %24 = "gpu.spmm"(%23#1, %17#0, %22#0, %22#0, %16#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1>}> : (!gpu.async.token, !gpu.sparse.spmat_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle, memref<?xf64>) -> !gpu.async.token
      %25:2 = "gpu.sddmm_buffer_size"(%24, %22#0, %22#0, %17#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.spmat_handle) -> (index, !gpu.async.token)
      %26 = "gpu.sddmm"(%25#1, %22#0, %22#0, %17#0, %16#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.spmat_handle, memref<?xf64>) -> !gpu.async.token
      %27 = "gpu.destroy_dn_tensor"(%26, %22#0) : (!gpu.async.token, !gpu.sparse.dntensor_handle) -> !gpu.async.token
      %28 = "gpu.destroy_sp_mat"(%27, %17#0) : (!gpu.async.token, !gpu.sparse.spmat_handle) -> !gpu.async.token
      %29 = "gpu.destroy_dn_tensor"(%28, %19#0) : (!gpu.async.token, !gpu.sparse.dntensor_handle) -> !gpu.async.token
      "gpu.wait"(%29) : (!gpu.async.token) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (!gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32>) -> (), sym_name = "extract_insert_mma"}> ({
    ^bb0(%arg10: !gpu.mma_matrix<16x16xf32, "COp">, %arg11: memref<16x16xf32>):
      %9 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %10 = "arith.constant"() <{value = 0 : index}> : () -> index
      %11 = "gpu.subgroup_mma_extract_thread_local"(%arg10, %10) : (!gpu.mma_matrix<16x16xf32, "COp">, index) -> f32
      %12 = "gpu.subgroup_mma_constant_matrix"(%9) : (f32) -> !gpu.mma_matrix<16x16xf32, "COp">
      %13 = "gpu.subgroup_mma_insert_thread_local"(%11, %12, %10) : (f32, !gpu.mma_matrix<16x16xf32, "COp">, index) -> !gpu.mma_matrix<16x16xf32, "COp">
      "gpu.subgroup_mma_store_matrix"(%13, %arg11, %10, %10) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32>, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) {gpu.container_module} : () -> ()
  "gpu.module"() <{sym_name = "module"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.return"() : () -> ()
    }) {sym_name = "func"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "module_with_one_target", targets = [#nvvm.target]}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg9: f32):
      "gpu.return"() : () -> ()
    }) {sym_name = "kernel"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "module_with_two_target", targets = [#nvvm.target, #rocdl.target<chip = "gfx90a">]}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg8: f32):
      "gpu.return"() : () -> ()
    }) {sym_name = "kernel"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{offloadingHandler = #gpu.select_object<0 : i64>, sym_name = "module_with_offload_handler", targets = [#nvvm.target]}> ({
  ^bb0:
  }) : () -> ()
  "gpu.binary"() <{objects = [#gpu.object<#rocdl.target, kernels = <[#gpu.kernel_metadata<"kernel0", (i32, f32) -> (), metadata = {sgpr_count = 255 : i64}>, #gpu.kernel_metadata<"kernel1", (i32) -> (), arg_attrs = [{llvm.read_only}]>]>, bin = "BLOB">], offloadingHandler = #gpu.select_object, sym_name = "kernel_attrs_1"}> : () -> ()
  "gpu.binary"() <{objects = [#gpu.object<#rocdl.target, kernels = <[#gpu.kernel_metadata<"a_kernel", () -> ()>, #gpu.kernel_metadata<"m_kernel", () -> ()>, #gpu.kernel_metadata<"z_kernel", () -> ()>]>, bin = "BLOB">], offloadingHandler = #gpu.select_object, sym_name = "kernel_attrs_2"}> : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "warp_execute_on_lane_0"}> ({
  ^bb0(%arg7: index):
    "gpu.warp_execute_on_lane_0"(%arg7) <{warp_size = 32 : i64}> ({
      "gpu.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "warp_execute_on_lane_0_2d"}> ({
  ^bb0(%arg6: index):
    %7 = "gpu.warp_execute_on_lane_0"(%arg6) <{warp_size = 32 : i64}> ({
      %8 = "arith.constant"() <{value = dense<2> : vector<4x32xi32>}> : () -> vector<4x32xi32>
      "gpu.yield"(%8) : (vector<4x32xi32>) -> ()
    }) : (index) -> vector<1x4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, vector<4xi32>) -> vector<4xi32>, sym_name = "warp_operand_result"}> ({
  ^bb0(%arg3: index, %arg4: vector<4xi32>):
    %4 = "gpu.warp_execute_on_lane_0"(%arg3, %arg4) <{warp_size = 32 : i64}> ({
    ^bb0(%arg5: vector<128xi32>):
      %5 = "arith.constant"() <{value = dense<2> : vector<128xi32>}> : () -> vector<128xi32>
      %6 = "arith.addi"(%arg5, %5) <{overflowFlags = #arith.overflow<none>}> : (vector<128xi32>, vector<128xi32>) -> vector<128xi32>
      "gpu.yield"(%6) : (vector<128xi32>) -> ()
    }) : (index, vector<4xi32>) -> vector<4xi32>
    "func.return"(%4) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32) -> (f32, f32), sym_name = "subgroup_broadcast"}> ({
  ^bb0(%arg1: f32, %arg2: i32):
    %2 = "gpu.subgroup_broadcast"(%arg1) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (f32) -> f32
    %3 = "gpu.subgroup_broadcast"(%arg1, %arg2) <{broadcast_type = #gpu<broadcast specific_lane>}> : (f32, i32) -> f32
    "func.return"(%2, %3) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (i32, i64), sym_name = "ballot"}> ({
  ^bb0(%arg0: i1):
    %0 = "gpu.ballot"(%arg0) : (i1) -> i32
    %1 = "gpu.ballot"(%arg0) : (i1) -> i64
    "func.return"(%0, %1) : (i32, i64) -> ()
  }) : () -> ()
}) : () -> ()


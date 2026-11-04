"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>, sym_name = "m16n8k16_fp16"}> ({
  ^bb0(%arg198: vector<4x2xf16>, %arg199: vector<2x2xf16>, %arg200: vector<2x2xf16>):
    %101 = "nvgpu.mma.sync"(%arg198, %arg199, %arg200) <{mmaShape = [16, 8, 16]}> : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    "func.return"(%101) : (vector<2x2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf32>) -> vector<2x2xf32>, sym_name = "m16n8k16_fp16_fp32"}> ({
  ^bb0(%arg195: vector<4x2xf16>, %arg196: vector<2x2xf16>, %arg197: vector<2x2xf32>):
    %100 = "nvgpu.mma.sync"(%arg195, %arg196, %arg197) <{mmaShape = [16, 8, 16]}> : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf32>) -> vector<2x2xf32>
    "func.return"(%100) : (vector<2x2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x2xf16>, vector<1x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>, sym_name = "m16n8k8_fp16"}> ({
  ^bb0(%arg192: vector<2x2xf16>, %arg193: vector<1x2xf16>, %arg194: vector<2x2xf16>):
    %99 = "nvgpu.mma.sync"(%arg192, %arg193, %arg194) <{mmaShape = [16, 8, 8]}> : (vector<2x2xf16>, vector<1x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    "func.return"(%99) : (vector<2x2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4x4xi8>, vector<2x4xi8>, vector<2x2xi32>) -> vector<2x2xi32>, sym_name = "m16n8k32_int8"}> ({
  ^bb0(%arg189: vector<4x4xi8>, %arg190: vector<2x4xi8>, %arg191: vector<2x2xi32>):
    %98 = "nvgpu.mma.sync"(%arg189, %arg190, %arg191) <{mmaShape = [16, 8, 32]}> : (vector<4x4xi8>, vector<2x4xi8>, vector<2x2xi32>) -> vector<2x2xi32>
    "func.return"(%98) : (vector<2x2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x8xi4>, vector<1x8xi4>, vector<2x2xi32>) -> vector<2x2xi32>, sym_name = "m16n8k32_i4"}> ({
  ^bb0(%arg186: vector<2x8xi4>, %arg187: vector<1x8xi4>, %arg188: vector<2x2xi32>):
    %97 = "nvgpu.mma.sync"(%arg186, %arg187, %arg188) <{mmaShape = [16, 8, 32]}> : (vector<2x8xi4>, vector<1x8xi4>, vector<2x2xi32>) -> vector<2x2xi32>
    "func.return"(%97) : (vector<2x2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4x8xi4>, vector<2x8xi4>, vector<2x2xi32>) -> vector<2x2xi32>, sym_name = "m16n8k64_i4"}> ({
  ^bb0(%arg183: vector<4x8xi4>, %arg184: vector<2x8xi4>, %arg185: vector<2x2xi32>):
    %96 = "nvgpu.mma.sync"(%arg183, %arg184, %arg185) <{mmaShape = [16, 8, 64]}> : (vector<4x8xi4>, vector<2x8xi4>, vector<2x2xi32>) -> vector<2x2xi32>
    "func.return"(%96) : (vector<2x2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x1xf64>, vector<1x1xf64>, vector<1x2xf64>) -> vector<1x2xf64>, sym_name = "m8n8k4_f64"}> ({
  ^bb0(%arg180: vector<1x1xf64>, %arg181: vector<1x1xf64>, %arg182: vector<1x2xf64>):
    %95 = "nvgpu.mma.sync"(%arg180, %arg181, %arg182) <{mmaShape = [8, 8, 4]}> : (vector<1x1xf64>, vector<1x1xf64>, vector<1x2xf64>) -> vector<1x2xf64>
    "func.return"(%95) : (vector<1x2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x128xf16, 3>) -> vector<4x2xf16>, sym_name = "ldmatrix_x4"}> ({
  ^bb0(%arg179: memref<128x128xf16, 3>):
    %93 = "arith.constant"() <{value = 0 : index}> : () -> index
    %94 = "nvgpu.ldmatrix"(%arg179, %93, %93) <{numTiles = 4 : i32, transpose = false}> : (memref<128x128xf16, 3>, index, index) -> vector<4x2xf16>
    "func.return"(%94) : (vector<4x2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x128xf16, 3>) -> vector<1x2xf16>, sym_name = "ldmatrix_x1"}> ({
  ^bb0(%arg178: memref<128x128xf16, 3>):
    %91 = "arith.constant"() <{value = 0 : index}> : () -> index
    %92 = "nvgpu.ldmatrix"(%arg178, %91, %91) <{numTiles = 1 : i32, transpose = false}> : (memref<128x128xf16, 3>, index, index) -> vector<1x2xf16>
    "func.return"(%92) : (vector<1x2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x1xf32>, vector<1x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>, sym_name = "m16n8k4_tf32"}> ({
  ^bb0(%arg175: vector<2x1xf32>, %arg176: vector<1x1xf32>, %arg177: vector<2x2xf32>):
    %90 = "nvgpu.mma.sync"(%arg175, %arg176, %arg177) <{mmaShape = [16, 8, 4], tf32Enabled}> : (vector<2x1xf32>, vector<1x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    "func.return"(%90) : (vector<2x2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x128xf32>, memref<3x16x128xf32, 3>, index) -> (), sym_name = "async_cp"}> ({
  ^bb0(%arg172: memref<128x128xf32>, %arg173: memref<3x16x128xf32, 3>, %arg174: index):
    %87 = "nvgpu.device_async_copy"(%arg173, %arg174, %arg174, %arg174, %arg172, %arg174, %arg174) <{dstElements = 4 : index, operandSegmentSizes = array<i32: 1, 3, 1, 2, 0>}> : (memref<3x16x128xf32, 3>, index, index, index, memref<128x128xf32>, index, index) -> !nvgpu.device.async.token
    %88 = "nvgpu.device_async_create_group"(%87) : (!nvgpu.device.async.token) -> !nvgpu.device.async.token
    "nvgpu.device_async_wait"(%88) <{numGroups = 1 : i32}> : (!nvgpu.device.async.token) -> ()
    %89 = "nvgpu.device_async_copy"(%arg173, %arg174, %arg174, %arg174, %arg172, %arg174, %arg174) <{bypassL1, dstElements = 4 : index, operandSegmentSizes = array<i32: 1, 3, 1, 2, 0>}> : (memref<3x16x128xf32, 3>, index, index, index, memref<128x128xf32>, index, index) -> !nvgpu.device.async.token
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x64xi4>, memref<128x128xi4, 3>, index) -> !nvgpu.device.async.token, sym_name = "async_cp_i4"}> ({
  ^bb0(%arg169: memref<128x64xi4>, %arg170: memref<128x128xi4, 3>, %arg171: index):
    %86 = "nvgpu.device_async_copy"(%arg170, %arg171, %arg171, %arg169, %arg171, %arg171) <{dstElements = 32 : index, operandSegmentSizes = array<i32: 1, 2, 1, 2, 0>}> : (memref<128x128xi4, 3>, index, index, memref<128x64xi4>, index, index) -> !nvgpu.device.async.token
    "func.return"(%86) : (!nvgpu.device.async.token) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x128xf32>, memref<3x16x128xf32, 3>, index, index) -> (), sym_name = "async_cp_zfill_f32_align4"}> ({
  ^bb0(%arg165: memref<128x128xf32>, %arg166: memref<3x16x128xf32, 3>, %arg167: index, %arg168: index):
    %84 = "nvgpu.device_async_copy"(%arg166, %arg167, %arg167, %arg167, %arg165, %arg167, %arg167, %arg168) <{bypassL1, dstElements = 4 : index, operandSegmentSizes = array<i32: 1, 3, 1, 2, 1>}> : (memref<3x16x128xf32, 3>, index, index, index, memref<128x128xf32>, index, index, index) -> !nvgpu.device.async.token
    %85 = "nvgpu.device_async_create_group"(%84) : (!nvgpu.device.async.token) -> !nvgpu.device.async.token
    "nvgpu.device_async_wait"(%85) <{numGroups = 1 : i32}> : (!nvgpu.device.async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x128xf32>, memref<3x16x128xf32, 3>, index, index) -> (), sym_name = "async_cp_zfill_f32_align1"}> ({
  ^bb0(%arg161: memref<128x128xf32>, %arg162: memref<3x16x128xf32, 3>, %arg163: index, %arg164: index):
    %82 = "nvgpu.device_async_copy"(%arg162, %arg163, %arg163, %arg163, %arg161, %arg163, %arg163, %arg164) <{dstElements = 1 : index, operandSegmentSizes = array<i32: 1, 3, 1, 2, 1>}> : (memref<3x16x128xf32, 3>, index, index, index, memref<128x128xf32>, index, index, index) -> !nvgpu.device.async.token
    %83 = "nvgpu.device_async_create_group"(%82) : (!nvgpu.device.async.token) -> !nvgpu.device.async.token
    "nvgpu.device_async_wait"(%83) <{numGroups = 1 : i32}> : (!nvgpu.device.async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4x2xf16>, vector<4x2xf16>, vector<2x2xf16>, vector<2xi16>) -> vector<2x2xf16>, sym_name = "mma_sp_sync_f16_16832"}> ({
  ^bb0(%arg157: vector<4x2xf16>, %arg158: vector<4x2xf16>, %arg159: vector<2x2xf16>, %arg160: vector<2xi16>):
    %81 = "nvgpu.mma.sp.sync"(%arg157, %arg158, %arg159, %arg160) <{mmaShape = [16, 8, 32], sparsitySelector = 0 : i32}> : (vector<4x2xf16>, vector<4x2xf16>, vector<2x2xf16>, vector<2xi16>) -> vector<2x2xf16>
    "func.return"(%81) : (vector<2x2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x2xf16>, vector<2x2xf16>, vector<2x2xf16>, vector<2xi16>) -> vector<2x2xf16>, sym_name = "mma_sp_sync_f16_16816"}> ({
  ^bb0(%arg153: vector<2x2xf16>, %arg154: vector<2x2xf16>, %arg155: vector<2x2xf16>, %arg156: vector<2xi16>):
    %80 = "nvgpu.mma.sp.sync"(%arg153, %arg154, %arg155, %arg156) <{mmaShape = [16, 8, 16], sparsitySelector = 0 : i32}> : (vector<2x2xf16>, vector<2x2xf16>, vector<2x2xf16>, vector<2xi16>) -> vector<2x2xf16>
    "func.return"(%80) : (vector<2x2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x2xf16>, vector<2x2xf16>, vector<2x2xf16>, vector<2xi16>) -> vector<2x2xf16>, sym_name = "mma_sp_sync_f16_16816_01"}> ({
  ^bb0(%arg149: vector<2x2xf16>, %arg150: vector<2x2xf16>, %arg151: vector<2x2xf16>, %arg152: vector<2xi16>):
    %79 = "nvgpu.mma.sp.sync"(%arg149, %arg150, %arg151, %arg152) <{mmaShape = [16, 8, 16], sparsitySelector = 1 : i32}> : (vector<2x2xf16>, vector<2x2xf16>, vector<2x2xf16>, vector<2xi16>) -> vector<2x2xf16>
    "func.return"(%79) : (vector<2x2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4x4xi8>, vector<4x4xi8>, vector<2x2xi32>, vector<2xi16>) -> vector<2x2xi32>, sym_name = "mma_sp_sync_i8_16864"}> ({
  ^bb0(%arg145: vector<4x4xi8>, %arg146: vector<4x4xi8>, %arg147: vector<2x2xi32>, %arg148: vector<2xi16>):
    %78 = "nvgpu.mma.sp.sync"(%arg145, %arg146, %arg147, %arg148) <{mmaShape = [16, 8, 64], sparsitySelector = 0 : i32}> : (vector<4x4xi8>, vector<4x4xi8>, vector<2x2xi32>, vector<2xi16>) -> vector<2x2xi32>
    "func.return"(%78) : (vector<2x2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "mbarrier"}> ({
    %73 = "arith.constant"() <{value = 128 : index}> : () -> index
    %74 = "arith.constant"() <{value = 0 : index}> : () -> index
    %75 = "nvgpu.mbarrier.create"() : () -> !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>
    "nvgpu.mbarrier.init"(%75, %73, %74) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, index, index) -> ()
    %76 = "nvgpu.mbarrier.arrive"(%75, %74) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, index) -> !nvgpu.mbarrier.token
    %77 = "nvgpu.mbarrier.test.wait"(%75, %76, %74) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.mbarrier.token, index) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "mbarrier_nocomplete"}> ({
    %67 = "arith.constant"() <{value = 128 : index}> : () -> index
    %68 = "arith.constant"() <{value = 12 : index}> : () -> index
    %69 = "arith.constant"() <{value = 0 : index}> : () -> index
    %70 = "nvgpu.mbarrier.create"() : () -> !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>
    "nvgpu.mbarrier.init"(%70, %67, %69) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, index, index) -> ()
    %71 = "nvgpu.mbarrier.arrive.nocomplete"(%70, %69, %68) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, index, index) -> !nvgpu.mbarrier.token
    %72 = "nvgpu.mbarrier.test.wait"(%70, %71, %69) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.mbarrier.token, index) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>, num_barriers = 5>) -> (), sym_name = "mbarrier_get"}> ({
  ^bb0(%arg144: !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>, num_barriers = 5>):
    %63 = "arith.constant"() <{value = 2 : index}> : () -> index
    %64 = "nvgpu.mbarrier.get"(%arg144, %63) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>, num_barriers = 5>, index) -> i32
    %65 = "arith.constant"() <{value = 4 : index}> : () -> index
    %66 = "nvgpu.mbarrier.get"(%arg144, %65) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>, num_barriers = 5>, index) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>, num_barriers = 5>, !nvgpu.mbarrier.token) -> (), sym_name = "mbarrier_wait"}> ({
  ^bb0(%arg141: !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>, num_barriers = 5>, %arg142: !nvgpu.mbarrier.token):
    %57 = "arith.constant"() <{value = 0 : index}> : () -> index
    %58 = "arith.constant"() <{value = 1 : index}> : () -> index
    %59 = "arith.constant"() <{value = 100 : index}> : () -> index
    %60 = "arith.constant"() <{value = 5 : index}> : () -> index
    "scf.for"(%57, %59, %58) ({
    ^bb0(%arg143: index):
      %61 = "arith.remui"(%arg143, %60) : (index, index) -> index
      %62 = "nvgpu.mbarrier.test.wait"(%arg141, %arg142, %61) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>, num_barriers = 5>, !nvgpu.mbarrier.token, index) -> i1
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "mbarrier_txcount"}> ({
    %47 = "arith.constant"() <{value = 128 : index}> : () -> index
    %48 = "arith.constant"() <{value = 0 : index}> : () -> index
    %49 = "nvgpu.mbarrier.create"() : () -> !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>
    "nvgpu.mbarrier.init"(%49, %47, %48) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, index, index) -> ()
    %50 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
    %51 = "arith.index_cast"(%50) : (i32) -> index
    %52 = "arith.cmpi"(%51, %48) <{predicate = 0 : i64}> : (index, index) -> i1
    "scf.if"(%52) ({
      %56 = "arith.constant"() <{value = 256 : index}> : () -> index
      "nvgpu.mbarrier.arrive.expect_tx"(%49, %56, %48) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, index, index) -> ()
      "scf.yield"() : () -> ()
    }, {
      %55 = "arith.constant"() <{value = 0 : index}> : () -> index
      "nvgpu.mbarrier.arrive.expect_tx"(%49, %55, %48) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    %53 = "arith.constant"() <{value = false}> : () -> i1
    %54 = "arith.constant"() <{value = 10000000 : index}> : () -> index
    "nvgpu.mbarrier.try_wait.parity"(%49, %53, %54, %48) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, i1, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "mbarrier_txcount_pred"}> ({
    %39 = "arith.constant"() <{value = 1 : index}> : () -> index
    %40 = "arith.constant"() <{value = 0 : index}> : () -> index
    %41 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
    %42 = "arith.cmpi"(%41, %40) <{predicate = 0 : i64}> : (index, index) -> i1
    %43 = "nvgpu.mbarrier.create"() : () -> !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>
    "nvgpu.mbarrier.init"(%43, %39, %40, %42) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, index, index, i1) -> ()
    %44 = "arith.constant"() <{value = 256 : index}> : () -> index
    "nvgpu.mbarrier.arrive.expect_tx"(%43, %44, %40, %42) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, index, index, i1) -> ()
    %45 = "arith.constant"() <{value = false}> : () -> i1
    %46 = "arith.constant"() <{value = 10000000 : index}> : () -> index
    "nvgpu.mbarrier.try_wait.parity"(%43, %45, %46, %40) : (!nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, i1, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, memref<128xf32, 3>, memref<32x8xf32, 3>, memref<2x32x16xf32, 3>, memref<2x2x32x32xf32, 3>, memref<2x2x2x32x32xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>) -> (), sym_name = "async_tma_load"}> ({
  ^bb0(%arg130: !nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, %arg131: !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, %arg132: !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, %arg133: !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, %arg134: !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, %arg135: memref<128xf32, 3>, %arg136: memref<32x8xf32, 3>, %arg137: memref<2x32x16xf32, 3>, %arg138: memref<2x2x32x32xf32, 3>, %arg139: memref<2x2x2x32x32xf32, 3>, %arg140: !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>):
    %36 = "arith.constant"() <{value = 0 : index}> : () -> index
    %37 = "arith.constant"() <{value = 0 : index}> : () -> index
    %38 = "arith.constant"() <{value = 0 : index}> : () -> index
    "nvgpu.tma.async.load"(%arg135, %arg140, %arg130, %37, %36) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 0, 0>}> : (memref<128xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, index, index) -> ()
    "nvgpu.tma.async.load"(%arg136, %arg140, %arg131, %37, %38, %36) <{operandSegmentSizes = array<i32: 1, 1, 1, 2, 1, 0, 0>}> : (memref<32x8xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, index, index, index) -> ()
    "nvgpu.tma.async.load"(%arg137, %arg140, %arg132, %37, %38, %37, %36) <{operandSegmentSizes = array<i32: 1, 1, 1, 3, 1, 0, 0>}> : (memref<2x32x16xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, index, index, index, index) -> ()
    "nvgpu.tma.async.load"(%arg138, %arg140, %arg133, %37, %38, %38, %37, %36) <{operandSegmentSizes = array<i32: 1, 1, 1, 4, 1, 0, 0>}> : (memref<2x2x32x32xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, index, index, index, index, index) -> ()
    "nvgpu.tma.async.load"(%arg139, %arg140, %arg134, %37, %38, %38, %37, %37, %36) <{operandSegmentSizes = array<i32: 1, 1, 1, 5, 1, 0, 0>}> : (memref<2x2x2x32x32xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!nvgpu.tensormap.descriptor<tensor = memref<128xf32, #gpu.address_space<workgroup>>, swizzle = none, l2promo = none, oob = nan, interleave = none>, memref<128xf32, #gpu.address_space<workgroup>>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>) -> (), sym_name = "async_tma_load_gpu_address_space"}> ({
  ^bb0(%arg127: !nvgpu.tensormap.descriptor<tensor = memref<128xf32, #gpu.address_space<workgroup>>, swizzle = none, l2promo = none, oob = nan, interleave = none>, %arg128: memref<128xf32, #gpu.address_space<workgroup>>, %arg129: !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>):
    %33 = "arith.constant"() <{value = 0 : index}> : () -> index
    %34 = "arith.constant"() <{value = 0 : index}> : () -> index
    %35 = "arith.constant"() <{value = 0 : index}> : () -> index
    "nvgpu.tma.async.load"(%arg128, %arg129, %arg127, %34, %33) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 0, 0>}> : (memref<128xf32, #gpu.address_space<workgroup>>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<128xf32, #gpu.address_space<workgroup>>, swizzle = none, l2promo = none, oob = nan, interleave = none>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, memref<128xf32, 3>, memref<32x8xf32, 3>, memref<2x32x16xf32, 3>, memref<2x2x32x32xf32, 3>, memref<2x2x2x32x32xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, i1) -> (), sym_name = "async_tma_load_pred"}> ({
  ^bb0(%arg115: !nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, %arg116: !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, %arg117: !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, %arg118: !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, %arg119: !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, %arg120: memref<128xf32, 3>, %arg121: memref<32x8xf32, 3>, %arg122: memref<2x32x16xf32, 3>, %arg123: memref<2x2x32x32xf32, 3>, %arg124: memref<2x2x2x32x32xf32, 3>, %arg125: !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, %arg126: i1):
    %30 = "arith.constant"() <{value = 0 : index}> : () -> index
    %31 = "arith.constant"() <{value = 0 : index}> : () -> index
    %32 = "arith.constant"() <{value = 0 : index}> : () -> index
    "nvgpu.tma.async.load"(%arg120, %arg125, %arg115, %31, %30, %arg126) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 0, 1>}> : (memref<128xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, index, index, i1) -> ()
    "nvgpu.tma.async.load"(%arg121, %arg125, %arg116, %31, %32, %30, %arg126) <{operandSegmentSizes = array<i32: 1, 1, 1, 2, 1, 0, 1>}> : (memref<32x8xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, index, index, index, i1) -> ()
    "nvgpu.tma.async.load"(%arg122, %arg125, %arg117, %31, %32, %31, %30, %arg126) <{operandSegmentSizes = array<i32: 1, 1, 1, 3, 1, 0, 1>}> : (memref<2x32x16xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, index, index, index, index, i1) -> ()
    "nvgpu.tma.async.load"(%arg123, %arg125, %arg118, %31, %32, %32, %31, %30, %arg126) <{operandSegmentSizes = array<i32: 1, 1, 1, 4, 1, 0, 1>}> : (memref<2x2x32x32xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, index, index, index, index, index, i1) -> ()
    "nvgpu.tma.async.load"(%arg124, %arg125, %arg119, %31, %32, %32, %31, %31, %30, %arg126) <{operandSegmentSizes = array<i32: 1, 1, 1, 5, 1, 0, 1>}> : (memref<2x2x2x32x32xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, index, index, index, index, index, index, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, memref<128xf32, 3>, memref<32x8xf32, 3>, memref<2x32x16xf32, 3>, memref<2x2x32x32xf32, 3>, memref<2x2x2x32x32xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, i16) -> (), sym_name = "async_tma_load_multicast"}> ({
  ^bb0(%arg103: !nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, %arg104: !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, %arg105: !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, %arg106: !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, %arg107: !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, %arg108: memref<128xf32, 3>, %arg109: memref<32x8xf32, 3>, %arg110: memref<2x32x16xf32, 3>, %arg111: memref<2x2x32x32xf32, 3>, %arg112: memref<2x2x2x32x32xf32, 3>, %arg113: !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, %arg114: i16):
    %27 = "arith.constant"() <{value = 0 : index}> : () -> index
    %28 = "arith.constant"() <{value = 0 : index}> : () -> index
    %29 = "arith.constant"() <{value = 0 : index}> : () -> index
    "nvgpu.tma.async.load"(%arg108, %arg113, %arg103, %28, %27, %arg114) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 0>}> : (memref<128xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, index, index, i16) -> ()
    "nvgpu.tma.async.load"(%arg109, %arg113, %arg104, %28, %29, %27, %arg114) <{operandSegmentSizes = array<i32: 1, 1, 1, 2, 1, 1, 0>}> : (memref<32x8xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, index, index, index, i16) -> ()
    "nvgpu.tma.async.load"(%arg110, %arg113, %arg105, %28, %29, %28, %27, %arg114) <{operandSegmentSizes = array<i32: 1, 1, 1, 3, 1, 1, 0>}> : (memref<2x32x16xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, index, index, index, index, i16) -> ()
    "nvgpu.tma.async.load"(%arg111, %arg113, %arg106, %28, %29, %29, %28, %27, %arg114) <{operandSegmentSizes = array<i32: 1, 1, 1, 4, 1, 1, 0>}> : (memref<2x2x32x32xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, index, index, index, index, index, i16) -> ()
    "nvgpu.tma.async.load"(%arg112, %arg113, %arg107, %28, %29, %29, %28, %28, %27, %arg114) <{operandSegmentSizes = array<i32: 1, 1, 1, 5, 1, 1, 0>}> : (memref<2x2x2x32x32xf32, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, index, index, index, index, index, index, i16) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, memref<128xf32, 3>, memref<32x8xf32, 3>, memref<2x32x16xf32, 3>, memref<2x2x32x32xf32, 3>, memref<2x2x2x32x32xf32, 3>) -> (), sym_name = "async_tma_store"}> ({
  ^bb0(%arg93: !nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, %arg94: !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, %arg95: !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, %arg96: !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, %arg97: !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, %arg98: memref<128xf32, 3>, %arg99: memref<32x8xf32, 3>, %arg100: memref<2x32x16xf32, 3>, %arg101: memref<2x2x32x32xf32, 3>, %arg102: memref<2x2x2x32x32xf32, 3>):
    %24 = "arith.constant"() <{value = 0 : index}> : () -> index
    %25 = "arith.constant"() <{value = 0 : index}> : () -> index
    %26 = "arith.constant"() <{value = 0 : index}> : () -> index
    "nvgpu.tma.async.store"(%arg98, %arg93, %25) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (memref<128xf32, 3>, !nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, index) -> ()
    "nvgpu.tma.async.store"(%arg99, %arg94, %25, %26) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>}> : (memref<32x8xf32, 3>, !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, index, index) -> ()
    "nvgpu.tma.async.store"(%arg100, %arg95, %25, %26, %25) <{operandSegmentSizes = array<i32: 1, 1, 3, 0>}> : (memref<2x32x16xf32, 3>, !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, index, index, index) -> ()
    "nvgpu.tma.async.store"(%arg101, %arg96, %25, %26, %26, %25) <{operandSegmentSizes = array<i32: 1, 1, 4, 0>}> : (memref<2x2x32x32xf32, 3>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, index, index, index, index) -> ()
    "nvgpu.tma.async.store"(%arg102, %arg97, %25, %26, %26, %25, %25) <{operandSegmentSizes = array<i32: 1, 1, 5, 0>}> : (memref<2x2x2x32x32xf32, 3>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, memref<128xf32, 3>, memref<32x8xf32, 3>, memref<2x32x16xf32, 3>, memref<2x2x32x32xf32, 3>, memref<2x2x2x32x32xf32, 3>, i1) -> (), sym_name = "async_tma_store_predicate"}> ({
  ^bb0(%arg82: !nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, %arg83: !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, %arg84: !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, %arg85: !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, %arg86: !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, %arg87: memref<128xf32, 3>, %arg88: memref<32x8xf32, 3>, %arg89: memref<2x32x16xf32, 3>, %arg90: memref<2x2x32x32xf32, 3>, %arg91: memref<2x2x2x32x32xf32, 3>, %arg92: i1):
    %21 = "arith.constant"() <{value = 0 : index}> : () -> index
    %22 = "arith.constant"() <{value = 0 : index}> : () -> index
    %23 = "arith.constant"() <{value = 0 : index}> : () -> index
    "nvgpu.tma.async.store"(%arg87, %arg82, %22, %arg92) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (memref<128xf32, 3>, !nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, index, i1) -> ()
    "nvgpu.tma.async.store"(%arg88, %arg83, %22, %23, %arg92) <{operandSegmentSizes = array<i32: 1, 1, 2, 1>}> : (memref<32x8xf32, 3>, !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>, index, index, i1) -> ()
    "nvgpu.tma.async.store"(%arg89, %arg84, %22, %23, %22, %arg92) <{operandSegmentSizes = array<i32: 1, 1, 3, 1>}> : (memref<2x32x16xf32, 3>, !nvgpu.tensormap.descriptor<tensor = memref<2x32x16xf32, 3>, swizzle = swizzle_64b, l2promo = l2promo_64b, oob = zero, interleave = none>, index, index, index, i1) -> ()
    "nvgpu.tma.async.store"(%arg90, %arg85, %22, %23, %23, %22, %arg92) <{operandSegmentSizes = array<i32: 1, 1, 4, 1>}> : (memref<2x2x32x32xf32, 3>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x32x32xf32, 3>, swizzle = swizzle_128b, l2promo = l2promo_128b, oob = zero, interleave = none>, index, index, index, index, i1) -> ()
    "nvgpu.tma.async.store"(%arg91, %arg86, %22, %23, %23, %22, %22, %arg92) <{operandSegmentSizes = array<i32: 1, 1, 5, 1>}> : (memref<2x2x2x32x32xf32, 3>, !nvgpu.tensormap.descriptor<tensor = memref<2x2x2x32x32xf32, 3>, swizzle = none, l2promo = none, oob = zero, interleave = none>, index, index, index, index, index, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64x128xf32>, memref<128xf32>) -> (), sym_name = "create_tensor_map"}> ({
  ^bb0(%arg80: memref<64x128xf32>, %arg81: memref<128xf32>):
    %15 = "arith.constant"() <{value = 64 : index}> : () -> index
    %16 = "arith.constant"() <{value = 128 : index}> : () -> index
    %17 = "memref.cast"(%arg80) : (memref<64x128xf32>) -> memref<*xf32>
    %18 = "nvgpu.tma.create.descriptor"(%17, %15, %16) : (memref<*xf32>, index, index) -> !nvgpu.tensormap.descriptor<tensor = memref<32x8xf32, 3>, swizzle = swizzle_32b, l2promo = none, oob = zero, interleave = none>
    %19 = "memref.cast"(%arg81) : (memref<128xf32>) -> memref<*xf32>
    %20 = "nvgpu.tma.create.descriptor"(%19, %16) : (memref<*xf32>, index) -> !nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, i1) -> (), sym_name = "tma_prefetch"}> ({
  ^bb0(%arg78: !nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, %arg79: i1):
    "nvgpu.tma.prefetch.descriptor"(%arg78) : (!nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>) -> ()
    "nvgpu.tma.prefetch.descriptor"(%arg78, %arg79) : (!nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>) -> (), sym_name = "tma_fence"}> ({
  ^bb0(%arg77: !nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>):
    "nvgpu.tma.fence.descriptor"(%arg77) : (!nvgpu.tensormap.descriptor<tensor = memref<128xf32, 3>, swizzle = none, l2promo = none, oob = nan, interleave = none>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "mymodule"}> ({
    "memref.global"() <{sym_name = "dynamicShmem", sym_visibility = "private", type = memref<0xf16, 3>}> : () -> ()
    "func.func"() <{function_type = (!nvgpu.tensormap.descriptor<tensor = memref<128x64xf16, 3>, swizzle = swizzle_128b, l2promo = none, oob = zero, interleave = none>, !nvgpu.tensormap.descriptor<tensor = memref<64x64xf16, strided<[64, 1], offset: 8192>, 3>, swizzle = swizzle_128b, l2promo = none, oob = zero, interleave = none>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>) -> (), sym_name = "async_tma_load"}> ({
    ^bb0(%arg74: !nvgpu.tensormap.descriptor<tensor = memref<128x64xf16, 3>, swizzle = swizzle_128b, l2promo = none, oob = zero, interleave = none>, %arg75: !nvgpu.tensormap.descriptor<tensor = memref<64x64xf16, strided<[64, 1], offset: 8192>, 3>, swizzle = swizzle_128b, l2promo = none, oob = zero, interleave = none>, %arg76: !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>):
      %9 = "arith.constant"() <{value = 0 : index}> : () -> index
      %10 = "memref.get_global"() <{name = @dynamicShmem}> : () -> memref<0xf16, 3>
      %11 = "memref.reinterpret_cast"(%10) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 128, 64>, static_strides = array<i64: 64, 1>}> : (memref<0xf16, 3>) -> memref<128x64xf16, 3>
      %12 = "memref.reinterpret_cast"(%10) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4, 64, 64>, static_strides = array<i64: 4096, 64, 1>}> : (memref<0xf16, 3>) -> memref<4x64x64xf16, 3>
      %13 = "memref.subview"(%12) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 2, 0, 0>, static_sizes = array<i64: 1, 64, 64>, static_strides = array<i64: 1, 1, 1>}> : (memref<4x64x64xf16, 3>) -> memref<1x64x64xf16, strided<[4096, 64, 1], offset: 8192>, 3>
      %14 = "memref.subview"(%13) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 1, 64, 64>, static_strides = array<i64: 1, 1, 1>}> : (memref<1x64x64xf16, strided<[4096, 64, 1], offset: 8192>, 3>) -> memref<64x64xf16, strided<[64, 1], offset: 8192>, 3>
      "nvgpu.tma.async.load"(%11, %arg76, %arg74, %9, %9, %9) <{operandSegmentSizes = array<i32: 1, 1, 1, 2, 1, 0, 0>}> : (memref<128x64xf16, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<128x64xf16, 3>, swizzle = swizzle_128b, l2promo = none, oob = zero, interleave = none>, index, index, index) -> ()
      "nvgpu.tma.async.load"(%14, %arg76, %arg75, %9, %9, %9) <{operandSegmentSizes = array<i32: 1, 1, 1, 2, 1, 0, 0>}> : (memref<64x64xf16, strided<[64, 1], offset: 8192>, 3>, !nvgpu.mbarrier.group<memorySpace = #gpu.address_space<workgroup>>, !nvgpu.tensormap.descriptor<tensor = memref<64x64xf16, strided<[64, 1], offset: 8192>, 3>, swizzle = swizzle_128b, l2promo = none, oob = zero, interleave = none>, index, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "memref.global"() <{sym_name = "dynamicShmem", sym_visibility = "private", type = memref<0xf16, 3>}> : () -> ()
  "func.func"() <{function_type = (!nvgpu.tensormap.descriptor<tensor = memref<128x64xf16, 3>, swizzle = swizzle_128b, l2promo = none, oob = zero, interleave = none>) -> !nvgpu.warpgroup.descriptor<tensor = memref<128x64xf16, 3>>, sym_name = "create_wgmma_descriptor"}> ({
  ^bb0(%arg73: !nvgpu.tensormap.descriptor<tensor = memref<128x64xf16, 3>, swizzle = swizzle_128b, l2promo = none, oob = zero, interleave = none>):
    %6 = "memref.get_global"() <{name = @dynamicShmem}> : () -> memref<0xf16, 3>
    %7 = "memref.reinterpret_cast"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 128, 64>, static_strides = array<i64: 64, 1>}> : (memref<0xf16, 3>) -> memref<128x64xf16, 3>
    %8 = "nvgpu.warpgroup.generate.descriptor"(%7, %arg73) : (memref<128x64xf16, 3>, !nvgpu.tensormap.descriptor<tensor = memref<128x64xf16, 3>, swizzle = swizzle_128b, l2promo = none, oob = zero, interleave = none>) -> !nvgpu.warpgroup.descriptor<tensor = memref<128x64xf16, 3>>
    "func.return"(%8) : (!nvgpu.warpgroup.descriptor<tensor = memref<128x64xf16, 3>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!nvgpu.warpgroup.descriptor<tensor = memref<128x64xf16, 3>>, !nvgpu.warpgroup.descriptor<tensor = memref<64x128xf16, 3>>, !nvgpu.warpgroup.accumulator<fragmented = vector<128x128xf32>>) -> (), sym_name = "warpgroup_mma_128_128_64"}> ({
  ^bb0(%arg70: !nvgpu.warpgroup.descriptor<tensor = memref<128x64xf16, 3>>, %arg71: !nvgpu.warpgroup.descriptor<tensor = memref<64x128xf16, 3>>, %arg72: !nvgpu.warpgroup.accumulator<fragmented = vector<128x128xf32>>):
    %5 = "nvgpu.warpgroup.mma"(%arg70, %arg71, %arg72) <{transposeB}> : (!nvgpu.warpgroup.descriptor<tensor = memref<128x64xf16, 3>>, !nvgpu.warpgroup.descriptor<tensor = memref<64x128xf16, 3>>, !nvgpu.warpgroup.accumulator<fragmented = vector<128x128xf32>>) -> !nvgpu.warpgroup.accumulator<fragmented = vector<128x128xf32>>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!nvgpu.warpgroup.accumulator<fragmented = vector<128x128xf32>>, memref<128x128xf32, 3>) -> (), sym_name = "warpgroup_mma_store"}> ({
  ^bb0(%arg68: !nvgpu.warpgroup.accumulator<fragmented = vector<128x128xf32>>, %arg69: memref<128x128xf32, 3>):
    "nvgpu.warpgroup.mma.store"(%arg68, %arg69) : (!nvgpu.warpgroup.accumulator<fragmented = vector<128x128xf32>>, memref<128x128xf32, 3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64x8xf32>, memref<64x16xf32>, memref<64x24xf32>, memref<64x32xf32>, memref<64x40xf32>, memref<64x48xf32>, memref<64x56xf32>, memref<64x64xf32>, memref<64x72xf32>, memref<64x80xf32>, memref<64x88xf32>, memref<64x96xf32>, memref<64x104xf32>, memref<64x112xf32>, memref<64x120xf32>, memref<64x128xf32>, memref<64x136xf32>, memref<64x144xf32>, memref<64x152xf32>, memref<64x160xf32>, memref<64x168xf32>, memref<64x176xf32>, memref<64x184xf32>, memref<64x192xf32>, memref<64x200xf32>, memref<64x208xf32>, memref<64x216xf32>, memref<64x224xf32>, memref<64x232xf32>, memref<64x240xf32>, memref<64x248xf32>, memref<64x256xf32>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x16xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x24xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x32xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x40xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x48xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x56xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x64xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x72xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x80xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x88xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x96xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x104xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x112xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x120xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x128xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x136xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x144xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x152xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x160xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x168xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x176xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x184xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x192xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x200xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x208xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x216xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x224xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x232xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x240xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x248xf32>>, !nvgpu.warpgroup.accumulator<fragmented = vector<64x256xf32>>) -> (), sym_name = "warpgroup_mma_store_multiple"}> ({
  ^bb0(%arg5: memref<64x8xf32>, %arg6: memref<64x16xf32>, %arg7: memref<64x24xf32>, %arg8: memref<64x32xf32>, %arg9: memref<64x40xf32>, %arg10: memref<64x48xf32>, %arg11: memref<64x56xf32>, %arg12: memref<64x64xf32>, %arg13: memref<64x72xf32>, %arg14: memref<64x80xf32>, %arg15: memref<64x88xf32>, %arg16: memref<64x96xf32>, %arg17: memref<64x104xf32>, %arg18: memref<64x112xf32>, %arg19: memref<64x120xf32>, %arg20: memref<64x128xf32>, %arg21: memref<64x136xf32>, %arg22: memref<64x144xf32>, %arg23: memref<64x152xf32>, %arg24: memref<64x160xf32>, %arg25: memref<64x168xf32>, %arg26: memref<64x176xf32>, %arg27: memref<64x184xf32>, %arg28: memref<64x192xf32>, %arg29: memref<64x200xf32>, %arg30: memref<64x208xf32>, %arg31: memref<64x216xf32>, %arg32: memref<64x224xf32>, %arg33: memref<64x232xf32>, %arg34: memref<64x240xf32>, %arg35: memref<64x248xf32>, %arg36: memref<64x256xf32>, %arg37: !nvgpu.warpgroup.accumulator<fragmented = vector<64x16xf32>>, %arg38: !nvgpu.warpgroup.accumulator<fragmented = vector<64x24xf32>>, %arg39: !nvgpu.warpgroup.accumulator<fragmented = vector<64x32xf32>>, %arg40: !nvgpu.warpgroup.accumulator<fragmented = vector<64x40xf32>>, %arg41: !nvgpu.warpgroup.accumulator<fragmented = vector<64x48xf32>>, %arg42: !nvgpu.warpgroup.accumulator<fragmented = vector<64x56xf32>>, %arg43: !nvgpu.warpgroup.accumulator<fragmented = vector<64x64xf32>>, %arg44: !nvgpu.warpgroup.accumulator<fragmented = vector<64x72xf32>>, %arg45: !nvgpu.warpgroup.accumulator<fragmented = vector<64x80xf32>>, %arg46: !nvgpu.warpgroup.accumulator<fragmented = vector<64x88xf32>>, %arg47: !nvgpu.warpgroup.accumulator<fragmented = vector<64x96xf32>>, %arg48: !nvgpu.warpgroup.accumulator<fragmented = vector<64x104xf32>>, %arg49: !nvgpu.warpgroup.accumulator<fragmented = vector<64x112xf32>>, %arg50: !nvgpu.warpgroup.accumulator<fragmented = vector<64x120xf32>>, %arg51: !nvgpu.warpgroup.accumulator<fragmented = vector<64x128xf32>>, %arg52: !nvgpu.warpgroup.accumulator<fragmented = vector<64x136xf32>>, %arg53: !nvgpu.warpgroup.accumulator<fragmented = vector<64x144xf32>>, %arg54: !nvgpu.warpgroup.accumulator<fragmented = vector<64x152xf32>>, %arg55: !nvgpu.warpgroup.accumulator<fragmented = vector<64x160xf32>>, %arg56: !nvgpu.warpgroup.accumulator<fragmented = vector<64x168xf32>>, %arg57: !nvgpu.warpgroup.accumulator<fragmented = vector<64x176xf32>>, %arg58: !nvgpu.warpgroup.accumulator<fragmented = vector<64x184xf32>>, %arg59: !nvgpu.warpgroup.accumulator<fragmented = vector<64x192xf32>>, %arg60: !nvgpu.warpgroup.accumulator<fragmented = vector<64x200xf32>>, %arg61: !nvgpu.warpgroup.accumulator<fragmented = vector<64x208xf32>>, %arg62: !nvgpu.warpgroup.accumulator<fragmented = vector<64x216xf32>>, %arg63: !nvgpu.warpgroup.accumulator<fragmented = vector<64x224xf32>>, %arg64: !nvgpu.warpgroup.accumulator<fragmented = vector<64x232xf32>>, %arg65: !nvgpu.warpgroup.accumulator<fragmented = vector<64x240xf32>>, %arg66: !nvgpu.warpgroup.accumulator<fragmented = vector<64x248xf32>>, %arg67: !nvgpu.warpgroup.accumulator<fragmented = vector<64x256xf32>>):
    "nvgpu.warpgroup.mma.store"(%arg37, %arg6) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x16xf32>>, memref<64x16xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg38, %arg7) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x24xf32>>, memref<64x24xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg39, %arg8) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x32xf32>>, memref<64x32xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg40, %arg9) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x40xf32>>, memref<64x40xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg41, %arg10) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x48xf32>>, memref<64x48xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg42, %arg11) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x56xf32>>, memref<64x56xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg43, %arg12) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x64xf32>>, memref<64x64xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg44, %arg13) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x72xf32>>, memref<64x72xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg45, %arg14) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x80xf32>>, memref<64x80xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg46, %arg15) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x88xf32>>, memref<64x88xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg47, %arg16) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x96xf32>>, memref<64x96xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg48, %arg17) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x104xf32>>, memref<64x104xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg49, %arg18) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x112xf32>>, memref<64x112xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg50, %arg19) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x120xf32>>, memref<64x120xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg51, %arg20) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x128xf32>>, memref<64x128xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg52, %arg21) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x136xf32>>, memref<64x136xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg53, %arg22) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x144xf32>>, memref<64x144xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg54, %arg23) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x152xf32>>, memref<64x152xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg55, %arg24) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x160xf32>>, memref<64x160xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg56, %arg25) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x168xf32>>, memref<64x168xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg57, %arg26) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x176xf32>>, memref<64x176xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg58, %arg27) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x184xf32>>, memref<64x184xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg59, %arg28) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x192xf32>>, memref<64x192xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg60, %arg29) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x200xf32>>, memref<64x200xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg61, %arg30) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x208xf32>>, memref<64x208xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg62, %arg31) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x216xf32>>, memref<64x216xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg63, %arg32) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x224xf32>>, memref<64x224xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg64, %arg33) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x232xf32>>, memref<64x232xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg65, %arg34) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x240xf32>>, memref<64x240xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg66, %arg35) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x248xf32>>, memref<64x248xf32>) -> ()
    "nvgpu.warpgroup.mma.store"(%arg67, %arg36) : (!nvgpu.warpgroup.accumulator<fragmented = vector<64x256xf32>>, memref<64x256xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "warpgroup_mma_init"}> ({
    %4 = "nvgpu.warpgroup.mma.init.accumulator"() : () -> !nvgpu.warpgroup.accumulator<fragmented = vector<128x128xf32>>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!nvgpu.warpgroup.descriptor<tensor = memref<128x64xf16, 3>>, !nvgpu.warpgroup.descriptor<tensor = memref<64x128xf16, 3>>, memref<128x128xf32, 3>) -> (), sym_name = "warpgroup_matrix_multiply_m128n128k64"}> ({
  ^bb0(%arg2: !nvgpu.warpgroup.descriptor<tensor = memref<128x64xf16, 3>>, %arg3: !nvgpu.warpgroup.descriptor<tensor = memref<64x128xf16, 3>>, %arg4: memref<128x128xf32, 3>):
    %2 = "nvgpu.warpgroup.mma.init.accumulator"() : () -> !nvgpu.warpgroup.accumulator<fragmented = vector<128x128xf32>>
    %3 = "nvgpu.warpgroup.mma"(%arg2, %arg3, %2) <{transposeB}> : (!nvgpu.warpgroup.descriptor<tensor = memref<128x64xf16, 3>>, !nvgpu.warpgroup.descriptor<tensor = memref<64x128xf16, 3>>, !nvgpu.warpgroup.accumulator<fragmented = vector<128x128xf32>>) -> !nvgpu.warpgroup.accumulator<fragmented = vector<128x128xf32>>
    "nvgpu.warpgroup.mma.store"(%3, %arg4) : (!nvgpu.warpgroup.accumulator<fragmented = vector<128x128xf32>>, memref<128x128xf32, 3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg1: !transform.any_op):
      %1 = "transform.structured.match"(%arg1) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_conversion_patterns"(%1) <{legal_dialects = ["arith", "func", "llvm", "memref", "nvvm", "vector", "scf"], partial_conversion}> ({
        "transform.apply_conversion_patterns.nvgpu.nvgpu_to_nvvm"() : () -> ()
      }, {
        "transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter"() {use_opaque_pointers = true} : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
  "func.func"() <{function_type = (vector<32x16xf32>) -> (), sym_name = "rcp_approx_ftz_f32"}> ({
  ^bb0(%arg0: vector<32x16xf32>):
    %0 = "nvgpu.rcp"(%arg0) <{ftz, rounding = #nvgpu<rcp_rounding_mode approx>}> : (vector<32x16xf32>) -> vector<32x16xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()


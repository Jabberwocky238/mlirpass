module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01v bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
    spirv.func @load_store_scalar(%arg0: i32) -> f32 "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %var01v_addr = spirv.mlir.addressof @var01v : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %cst4_i32 = spirv.Constant 4 : i32
      %0 = spirv.SDiv %arg0, %cst4_i32 : i32
      %1 = spirv.SMod %arg0, %cst4_i32 : i32
      %2 = spirv.AccessChain %var01v_addr[%cst0_i32, %0, %1] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %3 = spirv.Load "StorageBuffer" %2 : f32
      spirv.Store "StorageBuffer" %2, %3 : f32
      spirv.ReturnValue %3 : f32
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01v bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
    spirv.func @load_store_scalar_64bit(%arg0: i64) -> f32 "None" {
      %cst0_i64 = spirv.Constant 0 : i64
      %var01v_addr = spirv.mlir.addressof @var01v : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %cst4_i64 = spirv.Constant 4 : i64
      %0 = spirv.SDiv %arg0, %cst4_i64 : i64
      %1 = spirv.SMod %arg0, %cst4_i64 : i64
      %2 = spirv.AccessChain %var01v_addr[%cst0_i64, %0, %1] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i64, i64, i64 -> !spirv.ptr<f32, StorageBuffer>
      %3 = spirv.Load "StorageBuffer" %2 : f32
      spirv.Store "StorageBuffer" %2, %3 : f32
      spirv.ReturnValue %3 : f32
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01v bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
    spirv.func @multiple_uses(%arg0: i32, %arg1: i32) -> f32 "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %var01v_addr = spirv.mlir.addressof @var01v : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %cst4_i32 = spirv.Constant 4 : i32
      %0 = spirv.SDiv %arg0, %cst4_i32 : i32
      %1 = spirv.SMod %arg0, %cst4_i32 : i32
      %2 = spirv.AccessChain %var01v_addr[%cst0_i32, %0, %1] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %3 = spirv.Load "StorageBuffer" %2 : f32
      %cst4_i32_0 = spirv.Constant 4 : i32
      %4 = spirv.SDiv %arg1, %cst4_i32_0 : i32
      %5 = spirv.SMod %arg1, %cst4_i32_0 : i32
      %6 = spirv.AccessChain %var01v_addr[%cst0_i32, %4, %5] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %7 = spirv.Load "StorageBuffer" %6 : f32
      %8 = spirv.FAdd %3, %7 : f32
      spirv.ReturnValue %8 : f32
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01s bind(0, 1) {aliased} : !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
    spirv.GlobalVariable @var01v bind(0, 1) {aliased} : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<3xf32>, stride=16> [0])>, StorageBuffer>
    spirv.func @vector3(%arg0: i32) -> f32 "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %var01s_addr = spirv.mlir.addressof @var01s : !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %0 = spirv.AccessChain %var01s_addr[%cst0_i32, %arg0] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %1 = spirv.Load "StorageBuffer" %0 : f32
      spirv.ReturnValue %1 : f32
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01s bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
    spirv.GlobalVariable @var01v bind(1, 0) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
    spirv.func @not_aliased(%arg0: i32) -> f32 "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %var01s_addr = spirv.mlir.addressof @var01s : !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %0 = spirv.AccessChain %var01s_addr[%cst0_i32, %arg0] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %1 = spirv.Load "StorageBuffer" %0 : f32
      spirv.Store "StorageBuffer" %0, %1 : f32
      spirv.ReturnValue %1 : f32
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01v bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
    spirv.func @multiple_aliases(%arg0: i32) -> f32 "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %var01v_addr = spirv.mlir.addressof @var01v : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %cst4_i32 = spirv.Constant 4 : i32
      %0 = spirv.SDiv %arg0, %cst4_i32 : i32
      %1 = spirv.SMod %arg0, %cst4_i32 : i32
      %2 = spirv.AccessChain %var01v_addr[%cst0_i32, %0, %1] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %3 = spirv.Load "StorageBuffer" %2 : f32
      %var01v_addr_0 = spirv.mlir.addressof @var01v : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %cst4_i32_1 = spirv.Constant 4 : i32
      %4 = spirv.SDiv %arg0, %cst4_i32_1 : i32
      %5 = spirv.SMod %arg0, %cst4_i32_1 : i32
      %6 = spirv.AccessChain %var01v_addr_0[%cst0_i32, %4, %5] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %7 = spirv.Load "StorageBuffer" %6 : f32
      %var01v_addr_2 = spirv.mlir.addressof @var01v : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %8 = spirv.AccessChain %var01v_addr_2[%cst0_i32, %arg0, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %9 = spirv.Load "StorageBuffer" %8 : f32
      %10 = spirv.FAdd %3, %7 : f32
      %11 = spirv.FAdd %10, %9 : f32
      spirv.ReturnValue %11 : f32
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01s_i32 bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
    spirv.func @different_scalar_type(%arg0: i32, %arg1: f32) -> i32 "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %var01s_i32_addr = spirv.mlir.addressof @var01s_i32 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
      %0 = spirv.AccessChain %var01s_i32_addr[%cst0_i32, %arg0] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
      %1 = spirv.Load "StorageBuffer" %0 : i32
      %var01s_i32_addr_0 = spirv.mlir.addressof @var01s_i32 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
      %2 = spirv.AccessChain %var01s_i32_addr_0[%cst0_i32, %arg0] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
      %3 = spirv.Bitcast %arg1 : f32 to i32
      spirv.Store "StorageBuffer" %2, %3 : i32
      spirv.ReturnValue %1 : i32
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01v bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
    spirv.func @different_primitive_type(%arg0: i32, %arg1: i32) -> i32 "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %var01v_addr = spirv.mlir.addressof @var01v : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %cst4_i32 = spirv.Constant 4 : i32
      %0 = spirv.SDiv %arg0, %cst4_i32 : i32
      %1 = spirv.SMod %arg0, %cst4_i32 : i32
      %2 = spirv.AccessChain %var01v_addr[%cst0_i32, %0, %1] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %3 = spirv.Load "StorageBuffer" %2 : f32
      %4 = spirv.Bitcast %3 : f32 to i32
      %5 = spirv.Bitcast %arg1 : i32 to f32
      spirv.Store "StorageBuffer" %2, %5 : f32
      spirv.ReturnValue %4 : i32
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01s_f32 bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
    spirv.func @load_different_scalar_bitwidth(%arg0: i32) -> i64 "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %var01s_f32_addr = spirv.mlir.addressof @var01s_f32 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %cst2_i32 = spirv.Constant 2 : i32
      %0 = spirv.IMul %arg0, %cst2_i32 : i32
      %1 = spirv.AccessChain %var01s_f32_addr[%cst0_i32, %0] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %2 = spirv.Load "StorageBuffer" %1 : f32
      %cst1_i32 = spirv.Constant 1 : i32
      %3 = spirv.IAdd %0, %cst1_i32 : i32
      %4 = spirv.AccessChain %var01s_f32_addr[%cst0_i32, %3] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %5 = spirv.Load "StorageBuffer" %4 : f32
      %6 = spirv.CompositeConstruct %2, %5 : (f32, f32) -> vector<2xf32>
      %7 = spirv.Bitcast %6 : vector<2xf32> to i64
      spirv.ReturnValue %7 : i64
    }
  }
}

// -----
// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01_vec2 bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>
    spirv.func @load_different_vector_sizes(%arg0: i32) -> vector<4xf32> "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %var01_vec2_addr = spirv.mlir.addressof @var01_vec2 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>
      %cst2_i32 = spirv.Constant 2 : i32
      %0 = spirv.IMul %arg0, %cst2_i32 : i32
      %1 = spirv.AccessChain %var01_vec2_addr[%cst0_i32, %0] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<vector<2xf32>, StorageBuffer>
      %2 = spirv.Load "StorageBuffer" %1 : vector<2xf32>
      %cst1_i32 = spirv.Constant 1 : i32
      %3 = spirv.IAdd %0, %cst1_i32 : i32
      %4 = spirv.AccessChain %var01_vec2_addr[%cst0_i32, %3] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<vector<2xf32>, StorageBuffer>
      %5 = spirv.Load "StorageBuffer" %4 : vector<2xf32>
      %6 = spirv.CompositeConstruct %2, %5 : (vector<2xf32>, vector<2xf32>) -> vector<4xf32>
      %var01_vec2_addr_0 = spirv.mlir.addressof @var01_vec2 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>
      %cst2_i32_1 = spirv.Constant 2 : i32
      %7 = spirv.SDiv %arg0, %cst2_i32_1 : i32
      %8 = spirv.SMod %arg0, %cst2_i32_1 : i32
      %9 = spirv.AccessChain %var01_vec2_addr_0[%cst0_i32, %7, %8] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %10 = spirv.Load "StorageBuffer" %9 : f32
      %11 = spirv.CompositeInsert %10, %6[0 : i32] : f32 into vector<4xf32>
      spirv.ReturnValue %11 : vector<4xf32>
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01_v4f32 bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
    spirv.func @load_mixed_scalar_vector_primitive_types(%arg0: i32) -> vector<4xf32> "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %var01_v4f32_addr = spirv.mlir.addressof @var01_v4f32 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %0 = spirv.AccessChain %var01_v4f32_addr[%cst0_i32, %arg0] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<vector<4xf32>, StorageBuffer>
      %1 = spirv.Load "StorageBuffer" %0 : vector<4xf32>
      %var01_v4f32_addr_0 = spirv.mlir.addressof @var01_v4f32 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %cst4_i32 = spirv.Constant 4 : i32
      %2 = spirv.SDiv %arg0, %cst4_i32 : i32
      %3 = spirv.SMod %arg0, %cst4_i32 : i32
      %4 = spirv.AccessChain %var01_v4f32_addr_0[%cst0_i32, %2, %3] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %5 = spirv.Load "StorageBuffer" %4 : f32
      %var01_v4f32_addr_1 = spirv.mlir.addressof @var01_v4f32 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %cst2_i32 = spirv.Constant 2 : i32
      %6 = spirv.SDiv %arg0, %cst2_i32 : i32
      %7 = spirv.SMod %arg0, %cst2_i32 : i32
      %8 = spirv.AccessChain %var01_v4f32_addr_1[%cst0_i32, %6, %7] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %9 = spirv.Load "StorageBuffer" %8 : f32
      %cst1_i32 = spirv.Constant 1 : i32
      %10 = spirv.IAdd %7, %cst1_i32 : i32
      %11 = spirv.AccessChain %var01_v4f32_addr_1[%cst0_i32, %6, %10] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %12 = spirv.Load "StorageBuffer" %11 : f32
      %13 = spirv.CompositeConstruct %9, %12 : (f32, f32) -> vector<2xf32>
      %14 = spirv.Bitcast %13 : vector<2xf32> to i64
      %15 = spirv.SConvert %14 : i64 to i32
      %16 = spirv.Bitcast %15 : i32 to f32
      %17 = spirv.CompositeInsert %5, %1[0 : i32] : f32 into vector<4xf32>
      %18 = spirv.CompositeInsert %16, %17[1 : i32] : f32 into vector<4xf32>
      spirv.ReturnValue %18 : vector<4xf32>
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01_v2f2 bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=16> [0])>, StorageBuffer>
    spirv.func @load_mixed_scalar_vector_primitive_types(%arg0: i32) -> i64 "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %var01_v2f2_addr = spirv.mlir.addressof @var01_v2f2 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=16> [0])>, StorageBuffer>
      %cst1_i32 = spirv.Constant 1 : i32
      %0 = spirv.SDiv %arg0, %cst1_i32 : i32
      %1 = spirv.SMod %arg0, %cst1_i32 : i32
      %2 = spirv.AccessChain %var01_v2f2_addr[%cst0_i32, %0, %1] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %3 = spirv.Load "StorageBuffer" %2 : f32
      %cst1_i32_0 = spirv.Constant 1 : i32
      %4 = spirv.IAdd %1, %cst1_i32_0 : i32
      %5 = spirv.AccessChain %var01_v2f2_addr[%cst0_i32, %0, %4] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %6 = spirv.Load "StorageBuffer" %5 : f32
      %7 = spirv.CompositeConstruct %3, %6 : (f32, f32) -> vector<2xf32>
      %8 = spirv.Bitcast %7 : vector<2xf32> to i64
      spirv.ReturnValue %8 : i64
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01_v2f2 bind(0, 1) {aliased} : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=16> [0])>, StorageBuffer>
    spirv.GlobalVariable @var01_i16 bind(0, 1) {aliased} : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i16, stride=2> [0])>, StorageBuffer>
    spirv.func @scalar_type_bitwidth_smaller_than_vector(%arg0: i32) -> i16 "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %var01_i16_addr = spirv.mlir.addressof @var01_i16 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i16, stride=2> [0])>, StorageBuffer>
      %0 = spirv.AccessChain %var01_i16_addr[%cst0_i32, %arg0] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i16, stride=2> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i16, StorageBuffer>
      %1 = spirv.Load "StorageBuffer" %0 : i16
      spirv.ReturnValue %1 : i16
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var00_v4f16 bind(0, 0) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf16>, stride=8> [0])>, StorageBuffer>
    spirv.func @vector_type_same_size_different_element_type(%arg0: i32) -> vector<4xf32> "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %var00_v4f16_addr = spirv.mlir.addressof @var00_v4f16 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf16>, stride=8> [0])>, StorageBuffer>
      %cst2_i32 = spirv.Constant 2 : i32
      %0 = spirv.IMul %arg0, %cst2_i32 : i32
      %1 = spirv.AccessChain %var00_v4f16_addr[%cst0_i32, %0] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf16>, stride=8> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<vector<4xf16>, StorageBuffer>
      %2 = spirv.Load "StorageBuffer" %1 : vector<4xf16>
      %cst1_i32 = spirv.Constant 1 : i32
      %3 = spirv.IAdd %0, %cst1_i32 : i32
      %4 = spirv.AccessChain %var00_v4f16_addr[%cst0_i32, %3] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf16>, stride=8> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<vector<4xf16>, StorageBuffer>
      %5 = spirv.Load "StorageBuffer" %4 : vector<4xf16>
      %6 = spirv.Bitcast %2 : vector<4xf16> to vector<2xf32>
      %7 = spirv.Bitcast %5 : vector<4xf16> to vector<2xf32>
      %8 = spirv.CompositeConstruct %6, %7 : (vector<2xf32>, vector<2xf32>) -> vector<4xf32>
      spirv.ReturnValue %8 : vector<4xf32>
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @var01_v2f16 bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>
    spirv.func @aliased(%arg0: i32) -> vector<3xf32> "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %cst_vec_3xf32 = spirv.Constant dense<0.000000e+00> : vector<3xf32>
      %var01_v2f16_addr = spirv.mlir.addressof @var01_v2f16 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>
      %0 = spirv.AccessChain %var01_v2f16_addr[%cst0_i32, %arg0] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<vector<2xf16>, StorageBuffer>
      %1 = spirv.Load "StorageBuffer" %0 : vector<2xf16>
      %var01_v2f16_addr_0 = spirv.mlir.addressof @var01_v2f16 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>
      %cst2_i32 = spirv.Constant 2 : i32
      %2 = spirv.IMul %arg0, %cst2_i32 : i32
      %3 = spirv.AccessChain %var01_v2f16_addr_0[%cst0_i32, %2] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<vector<2xf16>, StorageBuffer>
      %4 = spirv.Load "StorageBuffer" %3 : vector<2xf16>
      %cst1_i32 = spirv.Constant 1 : i32
      %5 = spirv.IAdd %2, %cst1_i32 : i32
      %6 = spirv.AccessChain %var01_v2f16_addr_0[%cst0_i32, %5] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<vector<2xf16>, StorageBuffer>
      %7 = spirv.Load "StorageBuffer" %6 : vector<2xf16>
      %8 = spirv.Bitcast %4 : vector<2xf16> to f32
      %9 = spirv.Bitcast %7 : vector<2xf16> to f32
      %10 = spirv.CompositeConstruct %8, %9 : (f32, f32) -> vector<2xf32>
      %11 = spirv.Bitcast %1 : vector<2xf16> to f32
      %12 = spirv.CompositeConstruct %11, %10 : (f32, vector<2xf32>) -> vector<3xf32>
      spirv.ReturnValue %12 : vector<3xf32>
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.func @main(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>) "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %0 = spirv.AccessChain %arg0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      spirv.Return
    }
  }
}


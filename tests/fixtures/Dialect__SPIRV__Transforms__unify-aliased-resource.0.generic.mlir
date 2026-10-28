"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01v", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> f32, sym_name = "load_store_scalar"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01v}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %2 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %3 = "spirv.SDiv"(%arg0, %2) : (i32, i32) -> i32
      %4 = "spirv.SMod"(%arg0, %2) : (i32, i32) -> i32
      %5 = "spirv.AccessChain"(%1, %0, %3, %4) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %6 = "spirv.Load"(%5) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      "spirv.Store"(%5, %6) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.ReturnValue"(%6) : (f32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01v", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64) -> f32, sym_name = "load_store_scalar_64bit"}> ({
    ^bb0(%arg0: i64):
      %0 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
      %1 = "spirv.mlir.addressof"() <{variable = @var01v}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %2 = "spirv.Constant"() <{value = 4 : i64}> : () -> i64
      %3 = "spirv.SDiv"(%arg0, %2) : (i64, i64) -> i64
      %4 = "spirv.SMod"(%arg0, %2) : (i64, i64) -> i64
      %5 = "spirv.AccessChain"(%1, %0, %3, %4) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i64, i64, i64) -> !spirv.ptr<f32, StorageBuffer>
      %6 = "spirv.Load"(%5) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      "spirv.Store"(%5, %6) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.ReturnValue"(%6) : (f32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01v", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> f32, sym_name = "multiple_uses"}> ({
    ^bb0(%arg0: i32, %arg1: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01v}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %2 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %3 = "spirv.SDiv"(%arg0, %2) : (i32, i32) -> i32
      %4 = "spirv.SMod"(%arg0, %2) : (i32, i32) -> i32
      %5 = "spirv.AccessChain"(%1, %0, %3, %4) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %6 = "spirv.Load"(%5) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %7 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %8 = "spirv.SDiv"(%arg1, %7) : (i32, i32) -> i32
      %9 = "spirv.SMod"(%arg1, %7) : (i32, i32) -> i32
      %10 = "spirv.AccessChain"(%1, %0, %8, %9) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %11 = "spirv.Load"(%10) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %12 = "spirv.FAdd"(%6, %11) : (f32, f32) -> f32
      "spirv.ReturnValue"(%12) : (f32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01v", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<3xf32>, stride=16> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> f32, sym_name = "vector3"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01s}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      "spirv.ReturnValue"(%3) : (f32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "var01v", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> f32, sym_name = "not_aliased"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01s}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      "spirv.Store"(%2, %3) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.ReturnValue"(%3) : (f32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01v", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> f32, sym_name = "multiple_aliases"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01v}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %2 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %3 = "spirv.SDiv"(%arg0, %2) : (i32, i32) -> i32
      %4 = "spirv.SMod"(%arg0, %2) : (i32, i32) -> i32
      %5 = "spirv.AccessChain"(%1, %0, %3, %4) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %6 = "spirv.Load"(%5) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %7 = "spirv.mlir.addressof"() <{variable = @var01v}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %8 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %9 = "spirv.SDiv"(%arg0, %8) : (i32, i32) -> i32
      %10 = "spirv.SMod"(%arg0, %8) : (i32, i32) -> i32
      %11 = "spirv.AccessChain"(%7, %0, %9, %10) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %12 = "spirv.Load"(%11) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %13 = "spirv.mlir.addressof"() <{variable = @var01v}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %14 = "spirv.AccessChain"(%13, %0, %arg0, %0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %15 = "spirv.Load"(%14) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %16 = "spirv.FAdd"(%6, %12) : (f32, f32) -> f32
      %17 = "spirv.FAdd"(%16, %15) : (f32, f32) -> f32
      "spirv.ReturnValue"(%17) : (f32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s_i32", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, f32) -> i32, sym_name = "different_scalar_type"}> ({
    ^bb0(%arg0: i32, %arg1: f32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01s_i32}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<i32, StorageBuffer>) -> i32
      %4 = "spirv.mlir.addressof"() <{variable = @var01s_i32}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
      %5 = "spirv.AccessChain"(%4, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
      %6 = "spirv.Bitcast"(%arg1) : (f32) -> i32
      "spirv.Store"(%5, %6) : (!spirv.ptr<i32, StorageBuffer>, i32) -> ()
      "spirv.ReturnValue"(%3) : (i32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01v", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> i32, sym_name = "different_primitive_type"}> ({
    ^bb0(%arg0: i32, %arg1: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01v}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %2 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %3 = "spirv.SDiv"(%arg0, %2) : (i32, i32) -> i32
      %4 = "spirv.SMod"(%arg0, %2) : (i32, i32) -> i32
      %5 = "spirv.AccessChain"(%1, %0, %3, %4) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %6 = "spirv.Load"(%5) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %7 = "spirv.Bitcast"(%6) : (f32) -> i32
      %8 = "spirv.Bitcast"(%arg1) : (i32) -> f32
      "spirv.Store"(%5, %8) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.ReturnValue"(%7) : (i32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s_f32", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i64, sym_name = "load_different_scalar_bitwidth"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01s_f32}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %2 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
      %3 = "spirv.IMul"(%arg0, %2) : (i32, i32) -> i32
      %4 = "spirv.AccessChain"(%1, %0, %3) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %5 = "spirv.Load"(%4) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %6 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %7 = "spirv.IAdd"(%3, %6) : (i32, i32) -> i32
      %8 = "spirv.AccessChain"(%1, %0, %7) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %9 = "spirv.Load"(%8) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %10 = "spirv.CompositeConstruct"(%5, %9) : (f32, f32) -> vector<2xf32>
      %11 = "spirv.Bitcast"(%10) : (vector<2xf32>) -> i64
      "spirv.ReturnValue"(%11) : (i64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_vec2", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> vector<4xf32>, sym_name = "load_different_vector_sizes"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01_vec2}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>
      %2 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
      %3 = "spirv.IMul"(%arg0, %2) : (i32, i32) -> i32
      %4 = "spirv.AccessChain"(%1, %0, %3) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<vector<2xf32>, StorageBuffer>
      %5 = "spirv.Load"(%4) : (!spirv.ptr<vector<2xf32>, StorageBuffer>) -> vector<2xf32>
      %6 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %7 = "spirv.IAdd"(%3, %6) : (i32, i32) -> i32
      %8 = "spirv.AccessChain"(%1, %0, %7) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<vector<2xf32>, StorageBuffer>
      %9 = "spirv.Load"(%8) : (!spirv.ptr<vector<2xf32>, StorageBuffer>) -> vector<2xf32>
      %10 = "spirv.CompositeConstruct"(%5, %9) : (vector<2xf32>, vector<2xf32>) -> vector<4xf32>
      %11 = "spirv.mlir.addressof"() <{variable = @var01_vec2}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>
      %12 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
      %13 = "spirv.SDiv"(%arg0, %12) : (i32, i32) -> i32
      %14 = "spirv.SMod"(%arg0, %12) : (i32, i32) -> i32
      %15 = "spirv.AccessChain"(%11, %0, %13, %14) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %16 = "spirv.Load"(%15) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %17 = "spirv.CompositeInsert"(%16, %10) <{indices = [0 : i32]}> : (f32, vector<4xf32>) -> vector<4xf32>
      "spirv.ReturnValue"(%17) : (vector<4xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_v4f32", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> vector<4xf32>, sym_name = "load_mixed_scalar_vector_primitive_types"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01_v4f32}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<vector<4xf32>, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, StorageBuffer>) -> vector<4xf32>
      %4 = "spirv.mlir.addressof"() <{variable = @var01_v4f32}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %5 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %6 = "spirv.SDiv"(%arg0, %5) : (i32, i32) -> i32
      %7 = "spirv.SMod"(%arg0, %5) : (i32, i32) -> i32
      %8 = "spirv.AccessChain"(%4, %0, %6, %7) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %9 = "spirv.Load"(%8) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %10 = "spirv.mlir.addressof"() <{variable = @var01_v4f32}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %11 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
      %12 = "spirv.SDiv"(%arg0, %11) : (i32, i32) -> i32
      %13 = "spirv.SMod"(%arg0, %11) : (i32, i32) -> i32
      %14 = "spirv.AccessChain"(%10, %0, %12, %13) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %15 = "spirv.Load"(%14) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %16 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %17 = "spirv.IAdd"(%13, %16) : (i32, i32) -> i32
      %18 = "spirv.AccessChain"(%10, %0, %12, %17) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %19 = "spirv.Load"(%18) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %20 = "spirv.CompositeConstruct"(%15, %19) : (f32, f32) -> vector<2xf32>
      %21 = "spirv.Bitcast"(%20) : (vector<2xf32>) -> i64
      %22 = "spirv.SConvert"(%21) : (i64) -> i32
      %23 = "spirv.Bitcast"(%22) : (i32) -> f32
      %24 = "spirv.CompositeInsert"(%9, %3) <{indices = [0 : i32]}> : (f32, vector<4xf32>) -> vector<4xf32>
      %25 = "spirv.CompositeInsert"(%23, %24) <{indices = [1 : i32]}> : (f32, vector<4xf32>) -> vector<4xf32>
      "spirv.ReturnValue"(%25) : (vector<4xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_v2f2", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=16> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i64, sym_name = "load_mixed_scalar_vector_primitive_types"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01_v2f2}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=16> [0])>, StorageBuffer>
      %2 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %3 = "spirv.SDiv"(%arg0, %2) : (i32, i32) -> i32
      %4 = "spirv.SMod"(%arg0, %2) : (i32, i32) -> i32
      %5 = "spirv.AccessChain"(%1, %0, %3, %4) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %6 = "spirv.Load"(%5) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %7 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %8 = "spirv.IAdd"(%4, %7) : (i32, i32) -> i32
      %9 = "spirv.AccessChain"(%1, %0, %3, %8) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %10 = "spirv.Load"(%9) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %11 = "spirv.CompositeConstruct"(%6, %10) : (f32, f32) -> vector<2xf32>
      %12 = "spirv.Bitcast"(%11) : (vector<2xf32>) -> i64
      "spirv.ReturnValue"(%12) : (i64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_v2f2", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=16> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_i16", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<i16, stride=2> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i16, sym_name = "scalar_type_bitwidth_smaller_than_vector"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01_i16}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i16, stride=2> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i16, stride=2> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i16, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<i16, StorageBuffer>) -> i16
      "spirv.ReturnValue"(%3) : (i16) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "var00_v4f16", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf16>, stride=8> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> vector<4xf32>, sym_name = "vector_type_same_size_different_element_type"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var00_v4f16}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf16>, stride=8> [0])>, StorageBuffer>
      %2 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
      %3 = "spirv.IMul"(%arg0, %2) : (i32, i32) -> i32
      %4 = "spirv.AccessChain"(%1, %0, %3) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf16>, stride=8> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<vector<4xf16>, StorageBuffer>
      %5 = "spirv.Load"(%4) : (!spirv.ptr<vector<4xf16>, StorageBuffer>) -> vector<4xf16>
      %6 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %7 = "spirv.IAdd"(%3, %6) : (i32, i32) -> i32
      %8 = "spirv.AccessChain"(%1, %0, %7) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf16>, stride=8> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<vector<4xf16>, StorageBuffer>
      %9 = "spirv.Load"(%8) : (!spirv.ptr<vector<4xf16>, StorageBuffer>) -> vector<4xf16>
      %10 = "spirv.Bitcast"(%5) : (vector<4xf16>) -> vector<2xf32>
      %11 = "spirv.Bitcast"(%9) : (vector<4xf16>) -> vector<2xf32>
      %12 = "spirv.CompositeConstruct"(%10, %11) : (vector<2xf32>, vector<2xf32>) -> vector<4xf32>
      "spirv.ReturnValue"(%12) : (vector<4xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_v2f16", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> vector<3xf32>, sym_name = "aliased"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.Constant"() <{value = dense<0.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
      %2 = "spirv.mlir.addressof"() <{variable = @var01_v2f16}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>
      %3 = "spirv.AccessChain"(%2, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<vector<2xf16>, StorageBuffer>
      %4 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf16>, StorageBuffer>) -> vector<2xf16>
      %5 = "spirv.mlir.addressof"() <{variable = @var01_v2f16}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>
      %6 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
      %7 = "spirv.IMul"(%arg0, %6) : (i32, i32) -> i32
      %8 = "spirv.AccessChain"(%5, %0, %7) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<vector<2xf16>, StorageBuffer>
      %9 = "spirv.Load"(%8) : (!spirv.ptr<vector<2xf16>, StorageBuffer>) -> vector<2xf16>
      %10 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %11 = "spirv.IAdd"(%7, %10) : (i32, i32) -> i32
      %12 = "spirv.AccessChain"(%5, %0, %11) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<vector<2xf16>, StorageBuffer>
      %13 = "spirv.Load"(%12) : (!spirv.ptr<vector<2xf16>, StorageBuffer>) -> vector<2xf16>
      %14 = "spirv.Bitcast"(%9) : (vector<2xf16>) -> f32
      %15 = "spirv.Bitcast"(%13) : (vector<2xf16>) -> f32
      %16 = "spirv.CompositeConstruct"(%14, %15) : (f32, f32) -> vector<2xf32>
      %17 = "spirv.Bitcast"(%4) : (vector<2xf16>) -> f32
      %18 = "spirv.CompositeConstruct"(%17, %16) : (f32, vector<2xf32>) -> vector<3xf32>
      "spirv.ReturnValue"(%18) : (vector<3xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "main"}> ({
    ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.AccessChain"(%arg0, %0, %0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()


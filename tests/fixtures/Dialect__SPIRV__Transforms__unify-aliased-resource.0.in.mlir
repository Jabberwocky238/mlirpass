"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01v", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> f32, sym_name = "load_store_scalar"}> ({
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
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01v", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64) -> f32, sym_name = "load_store_scalar_64bit"}> ({
    ^bb0(%arg0: i64):
      %0 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
      %1 = "spirv.mlir.addressof"() <{variable = @var01s}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<f32, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      "spirv.Store"(%2, %3) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.ReturnValue"(%3) : (f32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01v", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> f32, sym_name = "multiple_uses"}> ({
    ^bb0(%arg0: i32, %arg1: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01s}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %4 = "spirv.AccessChain"(%1, %0, %arg1) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %5 = "spirv.Load"(%4) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %6 = "spirv.FAdd"(%3, %5) : (f32, f32) -> f32
      "spirv.ReturnValue"(%6) : (f32) -> ()
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
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "var01v", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> {aliased} : () -> ()
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
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s_1", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01v", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01v_1", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> f32, sym_name = "multiple_aliases"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01s}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %4 = "spirv.mlir.addressof"() <{variable = @var01s_1}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %5 = "spirv.AccessChain"(%4, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %6 = "spirv.Load"(%5) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %7 = "spirv.mlir.addressof"() <{variable = @var01v_1}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %8 = "spirv.AccessChain"(%7, %0, %arg0, %0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %9 = "spirv.Load"(%8) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %10 = "spirv.FAdd"(%3, %6) : (f32, f32) -> f32
      %11 = "spirv.FAdd"(%10, %9) : (f32, f32) -> f32
      "spirv.ReturnValue"(%11) : (f32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s_i32", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s_f32", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, f32) -> i32, sym_name = "different_scalar_type"}> ({
    ^bb0(%arg0: i32, %arg1: f32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01s_i32}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<i32, StorageBuffer>) -> i32
      %4 = "spirv.mlir.addressof"() <{variable = @var01s_f32}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %5 = "spirv.AccessChain"(%4, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%5, %arg1) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.ReturnValue"(%3) : (i32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01v", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> i32, sym_name = "different_primitive_type"}> ({
    ^bb0(%arg0: i32, %arg1: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01s}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<i32, StorageBuffer>) -> i32
      "spirv.Store"(%2, %arg1) : (!spirv.ptr<i32, StorageBuffer>, i32) -> ()
      "spirv.ReturnValue"(%3) : (i32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s_i64", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<i64, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s_f32", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i64, sym_name = "load_different_scalar_bitwidth"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01s_i64}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i64, stride=4> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i64, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i64, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<i64, StorageBuffer>) -> i64
      "spirv.ReturnValue"(%3) : (i64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s_i64", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<i64, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01s_f32", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "store_different_scalar_bitwidth"}> ({
    ^bb0(%arg0: i32, %arg1: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01s_f32}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %4 = "spirv.FConvert"(%3) : (f32) -> f64
      %5 = "spirv.Bitcast"(%4) : (f64) -> i64
      %6 = "spirv.mlir.addressof"() <{variable = @var01s_i64}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i64, stride=4> [0])>, StorageBuffer>
      %7 = "spirv.AccessChain"(%6, %0, %arg1) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i64, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i64, StorageBuffer>
      "spirv.Store"(%7, %5) : (!spirv.ptr<i64, StorageBuffer>, i64) -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_scalar", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_vec2", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_vec4", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> vector<4xf32>, sym_name = "load_different_vector_sizes"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01_vec4}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<vector<4xf32>, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, StorageBuffer>) -> vector<4xf32>
      %4 = "spirv.mlir.addressof"() <{variable = @var01_scalar}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %5 = "spirv.AccessChain"(%4, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %6 = "spirv.Load"(%5) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %7 = "spirv.CompositeInsert"(%6, %3) <{indices = [0 : i32]}> : (f32, vector<4xf32>) -> vector<4xf32>
      "spirv.ReturnValue"(%7) : (vector<4xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_v4f32", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_f32", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_i64", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<i64, stride=8> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> vector<4xf32>, sym_name = "load_mixed_scalar_vector_primitive_types"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01_v4f32}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<vector<4xf32>, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, StorageBuffer>) -> vector<4xf32>
      %4 = "spirv.mlir.addressof"() <{variable = @var01_f32}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>
      %5 = "spirv.AccessChain"(%4, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %6 = "spirv.Load"(%5) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %7 = "spirv.mlir.addressof"() <{variable = @var01_i64}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i64, stride=8> [0])>, StorageBuffer>
      %8 = "spirv.AccessChain"(%7, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i64, stride=8> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i64, StorageBuffer>
      %9 = "spirv.Load"(%8) : (!spirv.ptr<i64, StorageBuffer>) -> i64
      %10 = "spirv.SConvert"(%9) : (i64) -> i32
      %11 = "spirv.Bitcast"(%10) : (i32) -> f32
      %12 = "spirv.CompositeInsert"(%6, %3) <{indices = [0 : i32]}> : (f32, vector<4xf32>) -> vector<4xf32>
      %13 = "spirv.CompositeInsert"(%11, %12) <{indices = [1 : i32]}> : (f32, vector<4xf32>) -> vector<4xf32>
      "spirv.ReturnValue"(%13) : (vector<4xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_v2f2", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=16> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_i64", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<i64, stride=8> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i64, sym_name = "load_mixed_scalar_vector_primitive_types"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var01_i64}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i64, stride=8> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i64, stride=8> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i64, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<i64, StorageBuffer>) -> i64
      "spirv.ReturnValue"(%3) : (i64) -> ()
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
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "var00_v4f32", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "var00_v4f16", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf16>, stride=8> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> vector<4xf32>, sym_name = "vector_type_same_size_different_element_type"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var00_v4f32}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>
      %2 = "spirv.AccessChain"(%1, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xf32>, stride=16> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<vector<4xf32>, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, StorageBuffer>) -> vector<4xf32>
      "spirv.ReturnValue"(%3) : (vector<4xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_v2f16", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var01_v2f32", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>}> {aliased} : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> vector<3xf32>, sym_name = "aliased"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.Constant"() <{value = dense<0.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
      %2 = "spirv.mlir.addressof"() <{variable = @var01_v2f16}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>
      %3 = "spirv.AccessChain"(%2, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf16>, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<vector<2xf16>, StorageBuffer>
      %4 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf16>, StorageBuffer>) -> vector<2xf16>
      %5 = "spirv.mlir.addressof"() <{variable = @var01_v2f32}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>
      %6 = "spirv.AccessChain"(%5, %0, %arg0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<vector<2xf32>, StorageBuffer>
      %7 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, StorageBuffer>) -> vector<2xf32>
      %8 = "spirv.Bitcast"(%4) : (vector<2xf16>) -> f32
      %9 = "spirv.CompositeConstruct"(%8, %7) : (f32, vector<2xf32>) -> vector<3xf32>
      "spirv.ReturnValue"(%9) : (vector<3xf32>) -> ()
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


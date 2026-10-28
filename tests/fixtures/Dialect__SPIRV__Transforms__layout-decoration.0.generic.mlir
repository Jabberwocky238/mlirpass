"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var0", type = !spirv.ptr<!spirv.struct<(i32 [0], !spirv.struct<(f32 [0], i32 [4])> [4], f32 [12])>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 0 : i32, sym_name = "var1", type = !spirv.ptr<!spirv.struct<(!spirv.array<64 x i32, stride=4> [0], f32 [256])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "var2", type = !spirv.ptr<!spirv.struct<(!spirv.struct<(!spirv.array<64 x i32, stride=4> [0], f32 [256])> [0], i32 [260])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var3", type = !spirv.ptr<!spirv.struct<(!spirv.array<16 x !spirv.struct<(f32 [0], f32 [4], !spirv.array<16 x f32, stride=4> [8])>, stride=72> [0], f32 [1152])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 1 : i32, sym_name = "var4", type = !spirv.ptr<!spirv.struct<(!spirv.struct<(!spirv.struct<(i1 [0], i8 [1], i16 [2], i32 [4], i64 [8])> [0], f32 [16], i1 [20])> [0], i1 [24])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 3 : i32, descriptor_set = 1 : i32, sym_name = "var5", type = !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "kernel"}> ({
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var0}> : () -> !spirv.ptr<!spirv.struct<(i32 [0], !spirv.struct<(f32 [0], i32 [4])> [4], f32 [12])>, Uniform>
      %2 = "spirv.AccessChain"(%1, %0) : (!spirv.ptr<!spirv.struct<(i32 [0], !spirv.struct<(f32 [0], i32 [4])> [4], f32 [12])>, Uniform>, i32) -> !spirv.ptr<i32, Uniform>
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "var0", type = !spirv.ptr<!spirv.struct<(!spirv.struct<(!spirv.struct<(!spirv.struct<(!spirv.struct<(i1 [0], i1 [1], f64 [8])> [0], i1 [16])> [0], i1 [24])> [0], i1 [32])> [0], i1 [40])>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var1", type = !spirv.ptr<!spirv.struct<(!spirv.struct<(i16 [0], !spirv.struct<(i1 [0], f64 [8])> [8], f32 [24])> [0], f32 [32])>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var2", type = !spirv.ptr<!spirv.struct<(!spirv.struct<(i16 [0], !spirv.struct<(i1 [0], !spirv.array<16 x !spirv.array<16 x i64, stride=8>, stride=128> [8])> [8], f32 [2064])> [0], f32 [2072])>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var3", type = !spirv.ptr<!spirv.struct<(!spirv.struct<(!spirv.array<64 x i64, stride=8> [0], i1 [512])> [0], i1 [520])>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var4", type = !spirv.ptr<!spirv.struct<(i1 [0], !spirv.struct<(i64 [0], i1 [8], i1 [9], i1 [10], i1 [11])> [8], i1 [24])>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var5", type = !spirv.ptr<!spirv.struct<(i1 [0], !spirv.struct<(i1 [0], i1 [1], i1 [2], i1 [3], i64 [8])> [8], i1 [24])>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var6", type = !spirv.ptr<!spirv.struct<(i1 [0], !spirv.struct<(i64 [0], i32 [8], i16 [12], i8 [14], i1 [15])> [8], i1 [24])>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var7", type = !spirv.ptr<!spirv.struct<(i1 [0], !spirv.struct<(!spirv.struct<(i1 [0], i64 [8])> [0], i1 [16])> [8], i1 [32])>, Uniform>}> : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "var0", type = !spirv.ptr<!spirv.struct<(vector<2xi32> [0], f32 [8])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var1", type = !spirv.ptr<!spirv.struct<(vector<3xi32> [0], f32 [12])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var2", type = !spirv.ptr<!spirv.struct<(vector<4xi32> [0], f32 [16])>, StorageBuffer>}> : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "emptyStructAsMember", type = !spirv.ptr<!spirv.struct<(!spirv.struct<()> [0])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "arrayType", type = !spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "InputStorage", type = !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32>)>, Input>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "customLayout", type = !spirv.ptr<!spirv.struct<(f32 [256], i32 [512])>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "emptyStruct", type = !spirv.ptr<!spirv.struct<()>, Uniform>}> : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "var0", type = !spirv.ptr<!spirv.struct<(i32 [0])>, PushConstant>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var1", type = !spirv.ptr<!spirv.struct<(i32 [0])>, PhysicalStorageBuffer>}> : () -> ()
  }) : () -> ()
}) : () -> ()

// -----

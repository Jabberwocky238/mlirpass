"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var0", type = !spirv.ptr<!spirv.struct<(i32, !spirv.struct<(f32, i32)>, f32)>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 0 : i32, sym_name = "var1", type = !spirv.ptr<!spirv.struct<(!spirv.array<64 x i32>, f32)>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "var2", type = !spirv.ptr<!spirv.struct<(!spirv.struct<(!spirv.array<64 x i32>, f32)>, i32)>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var3", type = !spirv.ptr<!spirv.struct<(!spirv.array<16 x !spirv.struct<(f32, f32, !spirv.array<16 x f32>)>>, f32)>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 1 : i32, sym_name = "var4", type = !spirv.ptr<!spirv.struct<(!spirv.struct<(!spirv.struct<(i1, i8, i16, i32, i64)>, f32, i1)>, i1)>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 3 : i32, descriptor_set = 1 : i32, sym_name = "var5", type = !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32>)>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "kernel"}> ({
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.mlir.addressof"() <{variable = @var0}> : () -> !spirv.ptr<!spirv.struct<(i32, !spirv.struct<(f32, i32)>, f32)>, Uniform>
      %2 = "spirv.AccessChain"(%1, %0) : (!spirv.ptr<!spirv.struct<(i32, !spirv.struct<(f32, i32)>, f32)>, Uniform>, i32) -> !spirv.ptr<i32, Uniform>
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "var0", type = !spirv.ptr<!spirv.struct<(!spirv.struct<(!spirv.struct<(!spirv.struct<(!spirv.struct<(i1, i1, f64)>, i1)>, i1)>, i1)>, i1)>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var1", type = !spirv.ptr<!spirv.struct<(!spirv.struct<(i16, !spirv.struct<(i1, f64)>, f32)>, f32)>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var2", type = !spirv.ptr<!spirv.struct<(!spirv.struct<(i16, !spirv.struct<(i1, !spirv.array<16 x !spirv.array<16 x i64>>)>, f32)>, f32)>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var3", type = !spirv.ptr<!spirv.struct<(!spirv.struct<(!spirv.array<64 x i64>, i1)>, i1)>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var4", type = !spirv.ptr<!spirv.struct<(i1, !spirv.struct<(i64, i1, i1, i1, i1)>, i1)>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var5", type = !spirv.ptr<!spirv.struct<(i1, !spirv.struct<(i1, i1, i1, i1, i64)>, i1)>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var6", type = !spirv.ptr<!spirv.struct<(i1, !spirv.struct<(i64, i32, i16, i8, i1)>, i1)>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var7", type = !spirv.ptr<!spirv.struct<(i1, !spirv.struct<(!spirv.struct<(i1, i64)>, i1)>, i1)>, Uniform>}> : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "var0", type = !spirv.ptr<!spirv.struct<(vector<2xi32>, f32)>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var1", type = !spirv.ptr<!spirv.struct<(vector<3xi32>, f32)>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var2", type = !spirv.ptr<!spirv.struct<(vector<4xi32>, f32)>, StorageBuffer>}> : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "emptyStructAsMember", type = !spirv.ptr<!spirv.struct<(!spirv.struct<()>)>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "arrayType", type = !spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "InputStorage", type = !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32>)>, Input>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "customLayout", type = !spirv.ptr<!spirv.struct<(f32 [256], i32 [512])>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "emptyStruct", type = !spirv.ptr<!spirv.struct<()>, Uniform>}> : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "var0", type = !spirv.ptr<!spirv.struct<(i32)>, PushConstant>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "var1", type = !spirv.ptr<!spirv.struct<(i32)>, PhysicalStorageBuffer>}> : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "recursive", type = !spirv.ptr<!spirv.struct<rec, (!spirv.ptr<!spirv.struct<rec>, StorageBuffer>)>, StorageBuffer>}> : () -> ()
  }) : () -> ()
}) : () -> ()


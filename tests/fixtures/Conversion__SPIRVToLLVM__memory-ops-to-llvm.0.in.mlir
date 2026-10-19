"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "access_chain"}> ({
    %31 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %32 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(f32, !spirv.array<4 x f32>)>, Function>
    %33 = "spirv.AccessChain"(%32, %31, %31) : (!spirv.ptr<!spirv.struct<(f32, !spirv.array<4 x f32>)>, Function>, i32, i32) -> !spirv.ptr<f32, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "access_chain_array"}> ({
  ^bb0(%arg5: i32):
    %28 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, Function>
    %29 = "spirv.AccessChain"(%28, %arg5) : (!spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, Function>, i32) -> !spirv.ptr<!spirv.array<4 x f32>, Function>
    %30 = "spirv.Load"(%29) <{memory_access = #spirv.memory_access<Volatile>}> : (!spirv.ptr<!spirv.array<4 x f32>, Function>) -> !spirv.array<4 x f32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "var", type = !spirv.ptr<f32, Input>}> : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "struct", type = !spirv.ptr<!spirv.struct<(f32, !spirv.array<10 x f32>)>, Private>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "func"}> ({
      %27 = "spirv.mlir.addressof"() <{variable = @struct}> : () -> !spirv.ptr<!spirv.struct<(f32, !spirv.array<10 x f32>)>, Private>
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "bar", type = !spirv.ptr<i32, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "foo"}> ({
      %26 = "spirv.mlir.addressof"() <{variable = @bar}> : () -> !spirv.ptr<i32, StorageBuffer>
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "name"}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "bar", type = !spirv.ptr<i32, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "foo"}> ({
      %25 = "spirv.mlir.addressof"() <{variable = @bar}> : () -> !spirv.ptr<i32, StorageBuffer>
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{location = 1 : i32, sym_name = "bar", type = !spirv.ptr<i32, Output>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "foo"}> ({
      %24 = "spirv.mlir.addressof"() <{variable = @bar}> : () -> !spirv.ptr<i32, Output>
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{descriptor_set = 0 : i32, location = 3 : i32, sym_name = "bar", type = !spirv.ptr<f32, UniformConstant>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "foo"}> ({
      %23 = "spirv.mlir.addressof"() <{variable = @bar}> : () -> !spirv.ptr<f32, UniformConstant>
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "load"}> ({
    %21 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    %22 = "spirv.Load"(%21) : (!spirv.ptr<f32, Function>) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "load_none"}> ({
    %19 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    %20 = "spirv.Load"(%19) <{memory_access = #spirv.memory_access<None>}> : (!spirv.ptr<f32, Function>) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "load_with_alignment"}> ({
    %17 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    %18 = "spirv.Load"(%17) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<f32, Function>) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "load_volatile"}> ({
    %15 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    %16 = "spirv.Load"(%15) <{memory_access = #spirv.memory_access<Volatile>}> : (!spirv.ptr<f32, Function>) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "load_nontemporal"}> ({
    %13 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    %14 = "spirv.Load"(%13) <{memory_access = #spirv.memory_access<Nontemporal>}> : (!spirv.ptr<f32, Function>) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "store"}> ({
  ^bb0(%arg4: f32):
    %12 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    "spirv.Store"(%12, %arg4) : (!spirv.ptr<f32, Function>, f32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.struct<(f64)>) -> (), sym_name = "store_composite"}> ({
  ^bb0(%arg3: !spirv.struct<(f64)>):
    %11 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(f64)>, Function>
    "spirv.Store"(%11, %arg3) : (!spirv.ptr<!spirv.struct<(f64)>, Function>, !spirv.struct<(f64)>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "store_with_alignment"}> ({
  ^bb0(%arg2: f32):
    %10 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    "spirv.Store"(%10, %arg2) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<f32, Function>, f32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "store_volatile"}> ({
  ^bb0(%arg1: f32):
    %9 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    "spirv.Store"(%9, %arg1) <{memory_access = #spirv.memory_access<Volatile>}> : (!spirv.ptr<f32, Function>, f32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "store_nontemporal"}> ({
  ^bb0(%arg0: f32):
    %8 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    "spirv.Store"(%8, %arg0) <{memory_access = #spirv.memory_access<Nontemporal>}> : (!spirv.ptr<f32, Function>, f32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "variable_scalar"}> ({
    %6 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    %7 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i8, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "variable_scalar_with_initialization"}> ({
    %4 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %5 = "spirv.Variable"(%4) <{storage_class = #spirv.storage_class<Function>}> : (i64) -> !spirv.ptr<i64, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "variable_vector"}> ({
    %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "variable_vector_with_initialization"}> ({
    %1 = "spirv.Constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    %2 = "spirv.Variable"(%1) <{storage_class = #spirv.storage_class<Function>}> : (vector<3xi1>) -> !spirv.ptr<vector<3xi1>, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "variable_array"}> ({
    %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.array<10 x i32>, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()


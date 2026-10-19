module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_variable_pointers]>, #spirv.resource_limits<max_compute_workgroup_size = [128, 128, 64]>>} {
  llvm.mlir.global linkonce @__spv__foo_bar_arg_0_descriptor_set0_binding0() {addr_space = 0 : i32} : !llvm.struct<(array<6 x i32>)>
  llvm.func @__spv__foo_bar()
  llvm.func @malloc(i64) -> !llvm.ptr
  spirv.module @__spv__foo Logical GLSL450 requires #spirv.vce<v1.0, [Shader], [SPV_KHR_variable_pointers]> {
    spirv.GlobalVariable @bar_arg_0 bind(0, 0) : !spirv.ptr<!spirv.struct<(!spirv.array<6 x i32, stride=4> [0])>, StorageBuffer>
    spirv.func @__spv__foo_bar() "None" attributes {workgroup_attributions = 0 : i64} {
      %bar_arg_0_addr = spirv.mlir.addressof @bar_arg_0 : !spirv.ptr<!spirv.struct<(!spirv.array<6 x i32, stride=4> [0])>, StorageBuffer>
      spirv.Return
    }
    spirv.EntryPoint "GLCompute" @__spv__foo_bar
    spirv.ExecutionMode @__spv__foo_bar "LocalSize", 1, 1, 1
  }
  llvm.func @main() attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(6 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.call @malloc(%4) : (i64) -> !llvm.ptr
    %6 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %5, %7[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.mlir.constant(0 : index) : i64
    %10 = llvm.insertvalue %9, %8[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %0, %10[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %1, %11[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.mlir.constant(1 : index) : i64
    %14 = llvm.mlir.constant(6 : index) : i64
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.mlir.zero : !llvm.ptr
    %17 = llvm.getelementptr %16[%14] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.extractvalue %12[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.mlir.addressof @__spv__foo_bar_arg_0_descriptor_set0_binding0 : !llvm.ptr
    "llvm.intr.memcpy"(%20, %19, %18) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @__spv__foo_bar() : () -> ()
    "llvm.intr.memcpy"(%19, %20, %18) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_main() attributes {llvm.emit_c_interface} {
    llvm.call @main() : () -> ()
    llvm.return
  }
}

// -----
module {
  spirv.module @spirv.sym Logical GLSL450 {
    spirv.func @spirv.sym_bar() "None" {
      spirv.Return
    }
    spirv.EntryPoint "GLCompute" @spirv.sym_bar
    spirv.ExecutionMode @spirv.sym_bar "LocalSize", 1, 1, 1
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.func @__spv___bar() "None" {
      spirv.Return
    }
    spirv.EntryPoint "GLCompute" @__spv___bar
    spirv.ExecutionMode @__spv___bar "LocalSize", 1, 1, 1
  }
}


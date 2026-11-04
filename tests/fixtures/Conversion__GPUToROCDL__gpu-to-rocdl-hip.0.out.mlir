module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.mlir.global internal constant @printfFormat_1("Hello: %d\0A\00") {addr_space = 0 : i32}
    llvm.func @__ockl_printf_append_args(i64, i32, i64, i64, i64, i64, i64, i64, i64, i32) -> i64
    llvm.mlir.global internal constant @printfFormat_0("Hello, world\0A\00") {addr_space = 0 : i32}
    llvm.func @__ockl_printf_append_string_n(i64, !llvm.ptr, i64, i32) -> i64
    llvm.func @__ockl_printf_begin(i64) -> i64
    llvm.func @test_const_printf() {
      %0 = llvm.mlir.constant(0 : i64) : i64
      %1 = llvm.call @__ockl_printf_begin(%0) : (i64) -> i64
      %2 = llvm.mlir.addressof @printfFormat_0 : !llvm.ptr
      %3 = llvm.getelementptr %2[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<14 x i8>
      %4 = llvm.mlir.constant(14 : i64) : i64
      %5 = llvm.mlir.constant(1 : i32) : i32
      %6 = llvm.mlir.constant(0 : i32) : i32
      %7 = llvm.call @__ockl_printf_append_string_n(%1, %3, %4, %5) : (i64, !llvm.ptr, i64, i32) -> i64
      llvm.return
    }
    llvm.func @test_printf(%arg0: i32) {
      %0 = llvm.mlir.constant(0 : i64) : i64
      %1 = llvm.call @__ockl_printf_begin(%0) : (i64) -> i64
      %2 = llvm.mlir.addressof @printfFormat_1 : !llvm.ptr
      %3 = llvm.getelementptr %2[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<11 x i8>
      %4 = llvm.mlir.constant(11 : i64) : i64
      %5 = llvm.mlir.constant(1 : i32) : i32
      %6 = llvm.mlir.constant(0 : i32) : i32
      %7 = llvm.call @__ockl_printf_append_string_n(%1, %3, %4, %6) : (i64, !llvm.ptr, i64, i32) -> i64
      %8 = llvm.mlir.constant(1 : i32) : i32
      %9 = llvm.zext %arg0 : i32 to i64
      %10 = llvm.call @__ockl_printf_append_args(%7, %8, %9, %0, %0, %0, %0, %0, %0, %5) : (i64, i32, i64, i64, i64, i64, i64, i64, i64, i32) -> i64
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @fake_gpu_module_for_test attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    builtin.module @test_module {
      llvm.mlir.global internal constant @printfFormat_0("Hello: %d\0A\00") {addr_space = 0 : i32}
      llvm.func @__ockl_printf_append_string_n(i64, !llvm.ptr, i64, i32) -> i64
      llvm.func @__ockl_printf_append_args(i64, i32, i64, i64, i64, i64, i64, i64, i64, i32) -> i64
      llvm.func @__ockl_printf_begin(i64) -> i64
      llvm.func @test_printf(%arg0: i32) {
        %0 = llvm.mlir.constant(0 : i64) : i64
        %1 = llvm.call @__ockl_printf_begin(%0) : (i64) -> i64
        %2 = llvm.mlir.addressof @printfFormat_0 : !llvm.ptr
        %3 = llvm.getelementptr %2[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<11 x i8>
        %4 = llvm.mlir.constant(11 : i64) : i64
        %5 = llvm.mlir.constant(1 : i32) : i32
        %6 = llvm.mlir.constant(0 : i32) : i32
        %7 = llvm.call @__ockl_printf_append_string_n(%1, %3, %4, %6) : (i64, !llvm.ptr, i64, i32) -> i64
        %8 = llvm.mlir.constant(1 : i32) : i32
        %9 = llvm.zext %arg0 : i32 to i64
        %10 = llvm.call @__ockl_printf_append_args(%7, %8, %9, %0, %0, %0, %0, %0, %0, %5) : (i64, i32, i64, i64, i64, i64, i64, i64, i64, i32) -> i64
        llvm.return
      }
    }
  }
}


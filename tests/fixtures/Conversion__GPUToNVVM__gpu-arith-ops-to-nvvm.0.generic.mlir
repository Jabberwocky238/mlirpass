"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_54"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmaxf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fminf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmax", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmin", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f64, f64)> (f32, f32, f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_fminmax", visibility_ = 0 : i64}> ({
    ^bb0(%arg5: f32, %arg6: f32, %arg7: f64, %arg8: f64):
      %1 = "llvm.call"(%arg5, %arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmaxf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %2 = "llvm.call"(%arg5, %arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fminf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %3 = "llvm.call"(%arg7, %arg8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmax, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %4 = "llvm.call"(%arg7, %arg8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f64, f64)>
      %6 = "llvm.insertvalue"(%5, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f64, f64)>, f32) -> !llvm.struct<(f32, f32, f64, f64)>
      %7 = "llvm.insertvalue"(%6, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f64, f64)>, f32) -> !llvm.struct<(f32, f32, f64, f64)>
      %8 = "llvm.insertvalue"(%7, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f64, f64)>, f64) -> !llvm.struct<(f32, f32, f64, f64)>
      %9 = "llvm.insertvalue"(%8, %4) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f64, f64)>, f64) -> !llvm.struct<(f32, f32, f64, f64)>
      "llvm.return"(%9) : (!llvm.struct<(f32, f32, f64, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f32, f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_fminmax", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f32, %arg2: f32, %arg3: f64, %arg4: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3, %arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_fminmax, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (f32, f32, f64, f64) -> !llvm.struct<(f32, f32, f64, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f32, f64, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
}) : () -> ()


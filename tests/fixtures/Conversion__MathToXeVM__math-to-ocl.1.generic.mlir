"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z20__spirv_ocl_copysignf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_atan2f", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_powf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (f32, f32, f32), sym_name = "math_bin_f32"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z20__spirv_ocl_copysignf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
    %1 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_atan2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
    %2 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_powf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
    "func.return"(%0, %1, %2) : (f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z20__spirv_ocl_copysignd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_atan2d", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_powd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f64, f64) -> (f64, f64, f64), sym_name = "math_bin_f64"}> ({
  ^bb0(%arg0: f64, %arg1: f64):
    %0 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z20__spirv_ocl_copysignd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
    %1 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_atan2d, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
    %2 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_powd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
    "func.return"(%0, %1, %2) : (f64, f64, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_expm1f", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<32xvector<4xf32>>, memref<32xvector<4xf32>>, index) -> (), sym_name = "expm1_vector"}> ({
  ^bb0(%arg0: memref<32xvector<4xf32>>, %arg1: memref<32xvector<4xf32>>, %arg2: index):
    %0 = "memref.load"(%arg0, %arg2) : (memref<32xvector<4xf32>>, index) -> vector<4xf32>
    %1 = "llvm.mlir.poison"() : () -> vector<4xf32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %3 = "llvm.extractelement"(%0, %2) : (vector<4xf32>, i64) -> f32
    %4 = "llvm.call"(%3) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_expm1f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %5 = "llvm.insertelement"(%1, %4, %2) : (vector<4xf32>, f32, i64) -> vector<4xf32>
    %6 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %7 = "llvm.extractelement"(%0, %6) : (vector<4xf32>, i64) -> f32
    %8 = "llvm.call"(%7) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_expm1f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %9 = "llvm.insertelement"(%5, %8, %6) : (vector<4xf32>, f32, i64) -> vector<4xf32>
    %10 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %11 = "llvm.extractelement"(%0, %10) : (vector<4xf32>, i64) -> f32
    %12 = "llvm.call"(%11) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_expm1f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %13 = "llvm.insertelement"(%9, %12, %10) : (vector<4xf32>, f32, i64) -> vector<4xf32>
    %14 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %15 = "llvm.extractelement"(%0, %14) : (vector<4xf32>, i64) -> f32
    %16 = "llvm.call"(%15) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_expm1f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %17 = "llvm.insertelement"(%13, %16, %14) : (vector<4xf32>, f32, i64) -> vector<4xf32>
    "memref.store"(%17, %arg1, %arg2) : (vector<4xf32>, memref<32xvector<4xf32>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z22__spirv_ocl_native_sind", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z22__spirv_ocl_native_sinf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_fast_sin"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z22__spirv_ocl_native_sinf, fastmathFlags = #llvm.fastmath<afn>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z22__spirv_ocl_native_sind, fastmathFlags = #llvm.fastmath<afn>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_acosf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_acosd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_acos"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_acosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_acosd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_acoshf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_acoshd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_acosh"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_acoshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_acoshd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_asinf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_asind", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_asin"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_asinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_asind, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_asinhf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_asinhd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_asinh"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_asinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_asinhd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_atanf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_atand", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_atan"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_atanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_atand, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_atanhf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_atanhd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_atanh"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_atanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_atanhd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_cbrtf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_cbrtd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_cbrt"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_cbrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_cbrtd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_cosf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_cosd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_cos"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_cosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_cosd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_coshf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_coshd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_cosh"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_coshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_coshd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_erff", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_erfd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_erf"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_erff, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_erfd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_erfcf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_erfcd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_erfc"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_erfcf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_erfcd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_expf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_expd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_exp"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_expd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_exp2f", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_exp2d", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_exp2"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_exp2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_exp2d, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_expm1f", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_expm1d", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_expm1"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_expm1f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_expm1d, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_logf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_logd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_log"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_logf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_logd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_log10f", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_log10d", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_log10"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_log10f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_log10d, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_log1pf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_log1pd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_log1p"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_log1pf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_log1pd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_log2f", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_log2d", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_log2"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_log2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_log2d, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_rsqrtf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z17__spirv_ocl_rsqrtd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_rsqrt"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_rsqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_ocl_rsqrtd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_sinf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_sind", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_sin"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_sinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_sind, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_sinhf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_sinhd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_sinh"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_sinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_sinhd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_sqrtf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_sqrtd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_sqrt"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_sqrtd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_tanf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z15__spirv_ocl_tand", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_tan"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15__spirv_ocl_tand, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_tanhf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_tanhd", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_tanh"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_tanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_tanhd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_cbrtf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_erfcf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, bf16) -> (f16, bf16), sym_name = "math_unary_16bit"}> ({
  ^bb0(%arg0: f16, %arg1: bf16):
    %0 = "llvm.fpext"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_cbrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.fptrunc"(%1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
    %3 = "llvm.fpext"(%arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (bf16) -> f32
    %4 = "llvm.call"(%3) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_erfcf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %5 = "llvm.fptrunc"(%4) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> bf16
    "func.return"(%2, %5) : (f16, bf16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z25__spirv_ocl_native_divideff", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "_Z16__spirv_ocl_sqrtf", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "math_sqrt_div"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16__spirv_ocl_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %1 = "llvm.call"(%arg0, %0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z25__spirv_ocl_native_divideff, fastmathFlags = #llvm.fastmath<afn>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()


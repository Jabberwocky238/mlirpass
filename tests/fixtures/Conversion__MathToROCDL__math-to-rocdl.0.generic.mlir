"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_fmod_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_fmod_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_fmod_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "arith_remf"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0, %arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_fmod_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f16, f16) -> f16
    %1 = "llvm.call"(%arg1, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_fmod_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
    %2 = "llvm.call"(%arg2, %arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_fmod_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_acos_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_acos_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_acos_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_acos"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_acos_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_acos_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_acos_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_acosh_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_acosh_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_acosh_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_acosh"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_acosh_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_acosh_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_acosh_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_asin_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_asin_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_asin_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_asin"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_asin_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_asin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_asin_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_asinh_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_asinh_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_asinh_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_asinh"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_asinh_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_asinh_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_asinh_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atan_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atan_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atan_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_atan"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atan_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atan_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atan_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atanh_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atanh_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atanh_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_atanh"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atanh_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atanh_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atanh_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atan2_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atan2_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atan2_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_atan2"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0, %arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atan2_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f16, f16) -> f16
    %1 = "llvm.call"(%arg1, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atan2_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
    %2 = "llvm.call"(%arg2, %arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atan2_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cbrt_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cbrt_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cbrt_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_cbrt"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cbrt_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cbrt_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cbrt_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_ceil_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_ceil_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_ceil_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_ceil"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_ceil_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_ceil_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_ceil_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cos_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cos_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cos_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_cos"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cos_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cos_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cos_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cosh_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cosh_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cosh_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_cosh"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cosh_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cosh_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cosh_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sinh_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sinh_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sinh_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_sinh"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sinh_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sinh_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sinh_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_exp_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_exp_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f64) -> (f16, f64), sym_name = "math_exp"}> ({
  ^bb0(%arg0: f16, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_exp_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_exp_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f16, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_exp2_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_exp2_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_exp2_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_exp2"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_exp2_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_exp2_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_exp2_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_expm1_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_expm1_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_expm1_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_expm1"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_expm1_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_expm1_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_expm1_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_floor_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_floor_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_floor_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_floor"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_floor_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_floor_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_floor_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f64) -> (f16, f64), sym_name = "math_log"}> ({
  ^bb0(%arg0: f16, %arg1: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1) : (f16, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log10_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log10_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log10_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_log10"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log10_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log10_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log10_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log1p_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log1p_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log1p_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_log1p"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log1p_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log1p_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log1p_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_pow_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_pow_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_pow_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_powf"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0, %arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_pow_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f16, f16) -> f16
    %1 = "llvm.call"(%arg1, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_pow_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
    %2 = "llvm.call"(%arg2, %arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_pow_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_rsqrt_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_rsqrt_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_rsqrt_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_rsqrt"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_rsqrt_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_rsqrt_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_rsqrt_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_sin"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_tanh_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_tanh_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_tanh_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_tanh"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_tanh_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_tanh_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_tanh_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_tan_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_tan_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_tan_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_tan"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_tan_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_tan_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_tan_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_erf_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_erf_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_erf_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_erf"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_erf_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_erf_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_erf_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_erfc_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_erfc_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_erfc_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_erfc"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_erfc_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_erfc_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_erfc_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64, bf16) -> (f16, f32, f64, bf16), sym_name = "math_casting"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64, %arg3: bf16):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
    %3 = "llvm.fpext"(%arg3) : (bf16) -> f32
    %4 = "llvm.call"(%3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    %5 = "llvm.fptrunc"(%4) : (f32) -> bf16
    "func.return"(%0, %1, %2, %5) : (f16, f32, f64, bf16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16, i32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_pown_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, i32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_pown_f32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, i32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_pown_f64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16, f32, f64, i32) -> (f16, f32, f64), sym_name = "math_fpowi"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64, %arg3: i32):
    %0 = "llvm.call"(%arg0, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_pown_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f16, i32) -> f16
    %1 = "llvm.call"(%arg1, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_pown_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, i32) -> f32
    %2 = "llvm.call"(%arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_pown_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, i32) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "test.some_op_with_region"() ({
  ^bb0(%arg0: f64):
    %0 = "math.atan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "test.possible_terminator"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (vector<f16>) -> vector<f16>, sym_name = "math_sin_vector_0d"}> ({
  ^bb0(%arg0: vector<f16>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<f16>) -> vector<1xf16>
    %1 = "llvm.mlir.poison"() : () -> vector<1xf16>
    %2 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %3 = "llvm.extractelement"(%0, %2) : (vector<1xf16>, i64) -> f16
    %4 = "llvm.call"(%3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %5 = "llvm.insertelement"(%1, %4, %2) : (vector<1xf16>, f16, i64) -> vector<1xf16>
    %6 = "builtin.unrealized_conversion_cast"(%5) : (vector<1xf16>) -> vector<f16>
    "func.return"(%6) : (vector<f16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf16>, sym_name = "math_sin_vector_1d"}> ({
  ^bb0(%arg0: vector<4xf16>):
    %0 = "llvm.mlir.poison"() : () -> vector<4xf16>
    %1 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %2 = "llvm.extractelement"(%arg0, %1) : (vector<4xf16>, i64) -> f16
    %3 = "llvm.call"(%2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %4 = "llvm.insertelement"(%0, %3, %1) : (vector<4xf16>, f16, i64) -> vector<4xf16>
    %5 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %6 = "llvm.extractelement"(%arg0, %5) : (vector<4xf16>, i64) -> f16
    %7 = "llvm.call"(%6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %8 = "llvm.insertelement"(%4, %7, %5) : (vector<4xf16>, f16, i64) -> vector<4xf16>
    %9 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %10 = "llvm.extractelement"(%arg0, %9) : (vector<4xf16>, i64) -> f16
    %11 = "llvm.call"(%10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %12 = "llvm.insertelement"(%8, %11, %9) : (vector<4xf16>, f16, i64) -> vector<4xf16>
    %13 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %14 = "llvm.extractelement"(%arg0, %13) : (vector<4xf16>, i64) -> f16
    %15 = "llvm.call"(%14) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %16 = "llvm.insertelement"(%12, %15, %13) : (vector<4xf16>, f16, i64) -> vector<4xf16>
    "func.return"(%16) : (vector<4xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f16", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x2xf16>) -> vector<2x2xf16>, sym_name = "math_sin_vector_2d"}> ({
  ^bb0(%arg0: vector<2x2xf16>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2x2xf16>) -> !llvm.array<2 x vector<2xf16>>
    %1 = "llvm.mlir.poison"() : () -> !llvm.array<2 x vector<2xf16>>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<2xf16>>) -> vector<2xf16>
    %3 = "llvm.mlir.poison"() : () -> vector<2xf16>
    %4 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %5 = "llvm.extractelement"(%2, %4) : (vector<2xf16>, i64) -> f16
    %6 = "llvm.call"(%5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %7 = "llvm.insertelement"(%3, %6, %4) : (vector<2xf16>, f16, i64) -> vector<2xf16>
    %8 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %9 = "llvm.extractelement"(%2, %8) : (vector<2xf16>, i64) -> f16
    %10 = "llvm.call"(%9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %11 = "llvm.insertelement"(%7, %10, %8) : (vector<2xf16>, f16, i64) -> vector<2xf16>
    %12 = "llvm.insertvalue"(%1, %11) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<2xf16>>, vector<2xf16>) -> !llvm.array<2 x vector<2xf16>>
    %13 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<2xf16>>) -> vector<2xf16>
    %14 = "llvm.mlir.poison"() : () -> vector<2xf16>
    %15 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %16 = "llvm.extractelement"(%13, %15) : (vector<2xf16>, i64) -> f16
    %17 = "llvm.call"(%16) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %18 = "llvm.insertelement"(%14, %17, %15) : (vector<2xf16>, f16, i64) -> vector<2xf16>
    %19 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %20 = "llvm.extractelement"(%13, %19) : (vector<2xf16>, i64) -> f16
    %21 = "llvm.call"(%20) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
    %22 = "llvm.insertelement"(%18, %21, %19) : (vector<2xf16>, f16, i64) -> vector<2xf16>
    %23 = "llvm.insertvalue"(%12, %22) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<2xf16>>, vector<2xf16>) -> !llvm.array<2 x vector<2xf16>>
    %24 = "builtin.unrealized_conversion_cast"(%23) : (!llvm.array<2 x vector<2xf16>>) -> vector<2x2xf16>
    "func.return"(%24) : (vector<2x2xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16, f16, f16) -> f16, sym_name = "clampf_f16"}> ({
  ^bb0(%arg3: f16, %arg4: f16, %arg5: f16):
    %1 = "math.clampf"(%arg3, %arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f16, f16, f16) -> f16
    "func.return"(%1) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> f32, sym_name = "clampf_f32"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
    %0 = "math.clampf"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf16>, vector<2xf16>) -> vector<2xf16>, sym_name = "clampf_vector_f16"}> ({
  ^bb0(%arg0: vector<2xf16>, %arg1: vector<2xf16>, %arg2: vector<2xf16>):
    %0 = "math.clampf"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<2xf16>, vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    "func.return"(%0) : (vector<2xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "clampf_vector_f32"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>):
    %0 = "math.clampf"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>, sym_name = "clampf_vector_2d_f16"}> ({
  ^bb0(%arg0: vector<2x2xf16>, %arg1: vector<2x2xf16>, %arg2: vector<2x2xf16>):
    %0 = "math.clampf"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    "func.return"(%0) : (vector<2x2xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (bf16, bf16, bf16) -> bf16, sym_name = "clampf_bf16"}> ({
  ^bb0(%arg0: bf16, %arg1: bf16, %arg2: bf16):
    %0 = "math.clampf"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16, bf16) -> bf16
    "func.return"(%0) : (bf16) -> ()
  }) : () -> ()
}) : () -> ()


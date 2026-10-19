module {
  func.func @arith_constants() {
    %0 = "emitc.constant"() <{value = 0 : index}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "emitc.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "emitc.constant"() <{value = dense<0> : tensor<i32>}> : () -> tensor<i32>
    %4 = "emitc.constant"() <{value = dense<[[1, 2], [-3, 9], [0, 0], [2, -1]]> : tensor<4x2xi64>}> : () -> tensor<4x2xi64>
    return
  }
}

// -----
module {
  func.func @arith_ops(%arg0: f32, %arg1: f32) {
    %0 = emitc.add %arg0, %arg1 : (f32, f32) -> f32
    %1 = emitc.div %arg0, %arg1 : (f32, f32) -> f32
    %2 = emitc.mul %arg0, %arg1 : (f32, f32) -> f32
    %3 = emitc.sub %arg0, %arg1 : (f32, f32) -> f32
    return
  }
}

// -----
module {
  func.func @arith_integer_ops(%arg0: i32, %arg1: i32) {
    %0 = emitc.cast %arg0 : i32 to ui32
    %1 = emitc.cast %arg1 : i32 to ui32
    %2 = emitc.add %0, %1 : (ui32, ui32) -> ui32
    %3 = emitc.cast %2 : ui32 to i32
    %4 = emitc.cast %arg0 : i32 to ui32
    %5 = emitc.cast %arg1 : i32 to ui32
    %6 = emitc.sub %4, %5 : (ui32, ui32) -> ui32
    %7 = emitc.cast %6 : ui32 to i32
    %8 = emitc.cast %arg0 : i32 to ui32
    %9 = emitc.cast %arg1 : i32 to ui32
    %10 = emitc.mul %8, %9 : (ui32, ui32) -> ui32
    %11 = emitc.cast %10 : ui32 to i32
    return
  }
}

// -----
module {
  func.func @arith_integer_ops_signed_nsw(%arg0: i32, %arg1: i32) {
    %0 = emitc.add %arg0, %arg1 : (i32, i32) -> i32
    %1 = emitc.sub %arg0, %arg1 : (i32, i32) -> i32
    %2 = emitc.mul %arg0, %arg1 : (i32, i32) -> i32
    return
  }
}

// -----
module {
  func.func @arith_index(%arg0: i32, %arg1: i32) {
    %0 = emitc.cast %arg0 : i32 to !emitc.ptrdiff_t
    %1 = emitc.cast %0 : !emitc.ptrdiff_t to !emitc.size_t
    %2 = emitc.cast %arg1 : i32 to !emitc.ptrdiff_t
    %3 = emitc.cast %2 : !emitc.ptrdiff_t to !emitc.size_t
    %4 = emitc.add %1, %3 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %5 = emitc.sub %1, %3 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %6 = emitc.mul %1, %3 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    return
  }
}

// -----
module {
  func.func @arith_bitwise(%arg0: i32, %arg1: i32) {
    %0 = emitc.cast %arg0 : i32 to ui32
    %1 = emitc.cast %arg1 : i32 to ui32
    %2 = emitc.bitwise_and %0, %1 : (ui32, ui32) -> ui32
    %3 = emitc.cast %2 : ui32 to i32
    %4 = emitc.cast %arg0 : i32 to ui32
    %5 = emitc.cast %arg1 : i32 to ui32
    %6 = emitc.bitwise_or %4, %5 : (ui32, ui32) -> ui32
    %7 = emitc.cast %6 : ui32 to i32
    %8 = emitc.cast %arg0 : i32 to ui32
    %9 = emitc.cast %arg1 : i32 to ui32
    %10 = emitc.bitwise_xor %8, %9 : (ui32, ui32) -> ui32
    %11 = emitc.cast %10 : ui32 to i32
    return
  }
}

// -----
module {
  func.func @arith_bitwise_bool(%arg0: i1, %arg1: i1) {
    %0 = emitc.bitwise_and %arg0, %arg1 : (i1, i1) -> i1
    %1 = emitc.bitwise_or %arg0, %arg1 : (i1, i1) -> i1
    %2 = emitc.bitwise_xor %arg0, %arg1 : (i1, i1) -> i1
    return
  }
}

// -----
module {
  func.func @arith_signed_integer_div_rem(%arg0: i32, %arg1: i32) {
    %0 = emitc.div %arg0, %arg1 : (i32, i32) -> i32
    %1 = emitc.rem %arg0, %arg1 : (i32, i32) -> i32
    return
  }
}

// -----
module {
  func.func @arith_shift_left(%arg0: i32, %arg1: i32) {
    %0 = emitc.cast %arg0 : i32 to ui32
    %1 = emitc.cast %arg1 : i32 to ui32
    %2 = "emitc.constant"() <{value = 32 : ui32}> : () -> ui32
    %3 = emitc.cmp lt, %1, %2 : (ui32, ui32) -> i1
    %4 = "emitc.constant"() <{value = 0 : ui32}> : () -> ui32
    %5 = emitc.expression %0, %1, %3, %4 : (ui32, ui32, i1, ui32) -> ui32 {
      %7 = bitwise_left_shift %0, %1 : (ui32, ui32) -> ui32
      %8 = conditional %3, %7, %4 : ui32
      yield %8 : ui32
    }
    %6 = emitc.cast %5 : ui32 to i32
    return
  }
}

// -----
module {
  func.func @arith_shift_right(%arg0: i32, %arg1: i32) {
    %0 = emitc.cast %arg0 : i32 to ui32
    %1 = emitc.cast %arg1 : i32 to ui32
    %2 = "emitc.constant"() <{value = 32 : ui32}> : () -> ui32
    %3 = emitc.cmp lt, %1, %2 : (ui32, ui32) -> i1
    %4 = "emitc.constant"() <{value = 0 : ui32}> : () -> ui32
    %5 = emitc.expression %0, %1, %3, %4 : (ui32, ui32, i1, ui32) -> ui32 {
      %12 = bitwise_right_shift %0, %1 : (ui32, ui32) -> ui32
      %13 = conditional %3, %12, %4 : ui32
      yield %13 : ui32
    }
    %6 = emitc.cast %5 : ui32 to i32
    %7 = emitc.cast %arg1 : i32 to ui32
    %8 = "emitc.constant"() <{value = 32 : ui32}> : () -> ui32
    %9 = emitc.cmp lt, %7, %8 : (ui32, ui32) -> i1
    %10 = "emitc.constant"() <{value = 0 : i32}> : () -> i32
    %11 = emitc.expression %arg0, %7, %9, %10 : (i32, ui32, i1, i32) -> i32 {
      %12 = bitwise_right_shift %arg0, %7 : (i32, ui32) -> i32
      %13 = conditional %9, %12, %10 : i32
      yield %13 : i32
    }
    return
  }
}

// -----
module {
  func.func @arith_shift_left_index(%arg0: i32) {
    %0 = "emitc.constant"() <{value = 42 : index}> : () -> !emitc.size_t
    %1 = emitc.cast %arg0 : i32 to !emitc.ptrdiff_t
    %2 = emitc.cast %1 : !emitc.ptrdiff_t to !emitc.size_t
    %3 = "emitc.constant"() <{value = 8 : index}> : () -> !emitc.size_t
    %4 = emitc.call_opaque "sizeof"(%3) : (!emitc.size_t) -> !emitc.size_t
    %5 = emitc.mul %3, %4 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %6 = emitc.cmp lt, %2, %5 : (!emitc.size_t, !emitc.size_t) -> i1
    %7 = "emitc.constant"() <{value = 0 : index}> : () -> !emitc.size_t
    %8 = emitc.expression %0, %2, %6, %7 : (!emitc.size_t, !emitc.size_t, i1, !emitc.size_t) -> !emitc.size_t {
      %9 = bitwise_left_shift %0, %2 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
      %10 = conditional %6, %9, %7 : !emitc.size_t
      yield %10 : !emitc.size_t
    }
    return
  }
}

// -----
module {
  func.func @arith_shift_right_index(%arg0: i32) {
    %0 = "emitc.constant"() <{value = 42 : index}> : () -> !emitc.size_t
    %1 = emitc.cast %arg0 : i32 to !emitc.ptrdiff_t
    %2 = emitc.cast %1 : !emitc.ptrdiff_t to !emitc.size_t
    %3 = "emitc.constant"() <{value = 8 : index}> : () -> !emitc.size_t
    %4 = emitc.call_opaque "sizeof"(%3) : (!emitc.size_t) -> !emitc.size_t
    %5 = emitc.mul %3, %4 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %6 = emitc.cmp lt, %2, %5 : (!emitc.size_t, !emitc.size_t) -> i1
    %7 = "emitc.constant"() <{value = 0 : index}> : () -> !emitc.size_t
    %8 = emitc.expression %0, %2, %6, %7 : (!emitc.size_t, !emitc.size_t, i1, !emitc.size_t) -> !emitc.size_t {
      %17 = bitwise_right_shift %0, %2 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
      %18 = conditional %6, %17, %7 : !emitc.size_t
      yield %18 : !emitc.size_t
    }
    %9 = emitc.cast %0 : !emitc.size_t to !emitc.ptrdiff_t
    %10 = "emitc.constant"() <{value = 8 : index}> : () -> !emitc.size_t
    %11 = emitc.call_opaque "sizeof"(%10) : (!emitc.size_t) -> !emitc.size_t
    %12 = emitc.mul %10, %11 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %13 = emitc.cmp lt, %2, %12 : (!emitc.size_t, !emitc.size_t) -> i1
    %14 = "emitc.constant"() <{value = 0 : index}> : () -> !emitc.ptrdiff_t
    %15 = emitc.expression %9, %2, %13, %14 : (!emitc.ptrdiff_t, !emitc.size_t, i1, !emitc.ptrdiff_t) -> !emitc.ptrdiff_t {
      %17 = bitwise_right_shift %9, %2 : (!emitc.ptrdiff_t, !emitc.size_t) -> !emitc.ptrdiff_t
      %18 = conditional %13, %17, %14 : !emitc.ptrdiff_t
      yield %18 : !emitc.ptrdiff_t
    }
    %16 = emitc.cast %15 : !emitc.ptrdiff_t to !emitc.size_t
    return
  }
}

// -----
module {
  func.func @arith_select(%arg0: i1, %arg1: tensor<8xi32>, %arg2: tensor<8xi32>) {
    %0 = emitc.conditional %arg0, %arg1, %arg2 : tensor<8xi32>
    return
  }
}

// -----
module {
  func.func @arith_cmpf_false(%arg0: f32, %arg1: f32) -> i1 {
    %0 = "emitc.constant"() <{value = false}> : () -> i1
    return %0 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_oeq(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp eq, %arg0, %arg1 : (f32, f32) -> i1
    %1 = emitc.cmp eq, %arg0, %arg0 : (f32, f32) -> i1
    %2 = emitc.cmp eq, %arg1, %arg1 : (f32, f32) -> i1
    %3 = emitc.logical_and %1, %2 : i1, i1
    %4 = emitc.logical_and %3, %0 : i1, i1
    return %4 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_ogt(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp gt, %arg0, %arg1 : (f32, f32) -> i1
    %1 = emitc.cmp eq, %arg0, %arg0 : (f32, f32) -> i1
    %2 = emitc.cmp eq, %arg1, %arg1 : (f32, f32) -> i1
    %3 = emitc.logical_and %1, %2 : i1, i1
    %4 = emitc.logical_and %3, %0 : i1, i1
    return %4 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_oge(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp ge, %arg0, %arg1 : (f32, f32) -> i1
    %1 = emitc.cmp eq, %arg0, %arg0 : (f32, f32) -> i1
    %2 = emitc.cmp eq, %arg1, %arg1 : (f32, f32) -> i1
    %3 = emitc.logical_and %1, %2 : i1, i1
    %4 = emitc.logical_and %3, %0 : i1, i1
    return %4 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_olt(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp lt, %arg0, %arg1 : (f32, f32) -> i1
    %1 = emitc.cmp eq, %arg0, %arg0 : (f32, f32) -> i1
    %2 = emitc.cmp eq, %arg1, %arg1 : (f32, f32) -> i1
    %3 = emitc.logical_and %1, %2 : i1, i1
    %4 = emitc.logical_and %3, %0 : i1, i1
    return %4 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_ole(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp le, %arg0, %arg1 : (f32, f32) -> i1
    %1 = emitc.cmp eq, %arg0, %arg0 : (f32, f32) -> i1
    %2 = emitc.cmp eq, %arg1, %arg1 : (f32, f32) -> i1
    %3 = emitc.logical_and %1, %2 : i1, i1
    %4 = emitc.logical_and %3, %0 : i1, i1
    return %4 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_one(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp ne, %arg0, %arg1 : (f32, f32) -> i1
    %1 = emitc.cmp eq, %arg0, %arg0 : (f32, f32) -> i1
    %2 = emitc.cmp eq, %arg1, %arg1 : (f32, f32) -> i1
    %3 = emitc.logical_and %1, %2 : i1, i1
    %4 = emitc.logical_and %3, %0 : i1, i1
    return %4 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_ord(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp eq, %arg0, %arg0 : (f32, f32) -> i1
    %1 = emitc.cmp eq, %arg1, %arg1 : (f32, f32) -> i1
    %2 = emitc.logical_and %0, %1 : i1, i1
    return %2 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_ueq(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp eq, %arg0, %arg1 : (f32, f32) -> i1
    %1 = emitc.cmp ne, %arg0, %arg0 : (f32, f32) -> i1
    %2 = emitc.cmp ne, %arg1, %arg1 : (f32, f32) -> i1
    %3 = emitc.logical_or %1, %2 : i1, i1
    %4 = emitc.logical_or %3, %0 : i1, i1
    return %4 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_ugt(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp gt, %arg0, %arg1 : (f32, f32) -> i1
    %1 = emitc.cmp ne, %arg0, %arg0 : (f32, f32) -> i1
    %2 = emitc.cmp ne, %arg1, %arg1 : (f32, f32) -> i1
    %3 = emitc.logical_or %1, %2 : i1, i1
    %4 = emitc.logical_or %3, %0 : i1, i1
    return %4 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_uge(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp ge, %arg0, %arg1 : (f32, f32) -> i1
    %1 = emitc.cmp ne, %arg0, %arg0 : (f32, f32) -> i1
    %2 = emitc.cmp ne, %arg1, %arg1 : (f32, f32) -> i1
    %3 = emitc.logical_or %1, %2 : i1, i1
    %4 = emitc.logical_or %3, %0 : i1, i1
    return %4 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_ult(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp lt, %arg0, %arg1 : (f32, f32) -> i1
    %1 = emitc.cmp ne, %arg0, %arg0 : (f32, f32) -> i1
    %2 = emitc.cmp ne, %arg1, %arg1 : (f32, f32) -> i1
    %3 = emitc.logical_or %1, %2 : i1, i1
    %4 = emitc.logical_or %3, %0 : i1, i1
    return %4 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_ule(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp le, %arg0, %arg1 : (f32, f32) -> i1
    %1 = emitc.cmp ne, %arg0, %arg0 : (f32, f32) -> i1
    %2 = emitc.cmp ne, %arg1, %arg1 : (f32, f32) -> i1
    %3 = emitc.logical_or %1, %2 : i1, i1
    %4 = emitc.logical_or %3, %0 : i1, i1
    return %4 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_une(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp ne, %arg0, %arg1 : (f32, f32) -> i1
    %1 = emitc.cmp ne, %arg0, %arg0 : (f32, f32) -> i1
    %2 = emitc.cmp ne, %arg1, %arg1 : (f32, f32) -> i1
    %3 = emitc.logical_or %1, %2 : i1, i1
    %4 = emitc.logical_or %3, %0 : i1, i1
    return %4 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_uno(%arg0: f32, %arg1: f32) -> i1 {
    %0 = emitc.cmp ne, %arg0, %arg0 : (f32, f32) -> i1
    %1 = emitc.cmp ne, %arg1, %arg1 : (f32, f32) -> i1
    %2 = emitc.logical_or %0, %1 : i1, i1
    return %2 : i1
  }
}

// -----
module {
  func.func @arith_cmpf_true(%arg0: f32, %arg1: f32) -> i1 {
    %0 = "emitc.constant"() <{value = true}> : () -> i1
    return %0 : i1
  }
}

// -----
module {
  func.func @arith_cmpi_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = emitc.cmp eq, %arg0, %arg1 : (i32, i32) -> i1
    return %0 : i1
  }
  func.func @arith_cmpi_ult(%arg0: i32, %arg1: i32) -> i1 {
    %0 = emitc.cast %arg0 : i32 to ui32
    %1 = emitc.cast %arg1 : i32 to ui32
    %2 = emitc.cmp lt, %0, %1 : (ui32, ui32) -> i1
    return %2 : i1
  }
  func.func @arith_cmpi_predicates(%arg0: i32, %arg1: i32) {
    %0 = emitc.cast %arg0 : i32 to ui32
    %1 = emitc.cast %arg1 : i32 to ui32
    %2 = emitc.cmp lt, %0, %1 : (ui32, ui32) -> i1
    %3 = emitc.cmp lt, %arg0, %arg1 : (i32, i32) -> i1
    %4 = emitc.cast %arg0 : i32 to ui32
    %5 = emitc.cast %arg1 : i32 to ui32
    %6 = emitc.cmp le, %4, %5 : (ui32, ui32) -> i1
    %7 = emitc.cmp le, %arg0, %arg1 : (i32, i32) -> i1
    %8 = emitc.cast %arg0 : i32 to ui32
    %9 = emitc.cast %arg1 : i32 to ui32
    %10 = emitc.cmp gt, %8, %9 : (ui32, ui32) -> i1
    %11 = emitc.cmp gt, %arg0, %arg1 : (i32, i32) -> i1
    %12 = emitc.cast %arg0 : i32 to ui32
    %13 = emitc.cast %arg1 : i32 to ui32
    %14 = emitc.cmp ge, %12, %13 : (ui32, ui32) -> i1
    %15 = emitc.cmp ge, %arg0, %arg1 : (i32, i32) -> i1
    %16 = emitc.cmp eq, %arg0, %arg1 : (i32, i32) -> i1
    %17 = emitc.cmp ne, %arg0, %arg1 : (i32, i32) -> i1
    return
  }
  func.func @arith_cmpi_index(%arg0: i32, %arg1: i32) -> i1 {
    %0 = emitc.cast %arg0 : i32 to !emitc.ptrdiff_t
    %1 = emitc.cast %0 : !emitc.ptrdiff_t to !emitc.size_t
    %2 = emitc.cast %arg0 : i32 to !emitc.ptrdiff_t
    %3 = emitc.cast %2 : !emitc.ptrdiff_t to !emitc.size_t
    %4 = emitc.cmp lt, %1, %3 : (!emitc.size_t, !emitc.size_t) -> i1
    %5 = emitc.cast %1 : !emitc.size_t to !emitc.ptrdiff_t
    %6 = emitc.cast %3 : !emitc.size_t to !emitc.ptrdiff_t
    %7 = emitc.cmp lt, %5, %6 : (!emitc.ptrdiff_t, !emitc.ptrdiff_t) -> i1
    return %7 : i1
  }
}

// -----
module {
  func.func @arith_negf(%arg0: f32) -> f32 {
    %0 = emitc.unary_minus %arg0 : (f32) -> f32
    return %0 : f32
  }
}

// -----
module {
  func.func @arith_float_to_int_cast_ops(%arg0: f32, %arg1: f64) {
    %0 = emitc.cast %arg0 : f32 to i32
    %1 = emitc.cast %arg1 : f64 to i32
    %2 = emitc.cast %arg0 : f32 to i16
    %3 = emitc.cast %arg1 : f64 to i16
    %4 = emitc.cast %arg0 : f32 to ui32
    %5 = emitc.cast %4 : ui32 to i32
    %6 = emitc.cast %arg0 : f32 to ui16
    %7 = emitc.cast %6 : ui16 to i16
    return
  }
  func.func @arith_int_to_float_cast_ops(%arg0: i8, %arg1: i64) {
    %0 = emitc.cast %arg0 : i8 to f32
    %1 = emitc.cast %arg1 : i64 to f32
    %2 = emitc.cast %arg0 : i8 to ui8
    %3 = emitc.cast %2 : ui8 to f32
    return
  }
}

// -----
module {
  func.func @arith_trunci(%arg0: i32) -> i8 {
    %0 = emitc.cast %arg0 : i32 to ui32
    %1 = emitc.cast %0 : ui32 to ui8
    %2 = emitc.cast %1 : ui8 to i8
    %3 = "emitc.constant"() <{value = 1 : i32}> : () -> i32
    %4 = emitc.bitwise_and %arg0, %3 : (i32, i32) -> i32
    %5 = emitc.cast %4 : i32 to i1
    return %2 : i8
  }
}

// -----
module {
  func.func @arith_trunci_to_i1(%arg0: i32) -> i1 {
    %0 = "emitc.constant"() <{value = 1 : i32}> : () -> i32
    %1 = emitc.bitwise_and %arg0, %0 : (i32, i32) -> i32
    %2 = emitc.cast %1 : i32 to i1
    return %2 : i1
  }
}

// -----
module {
  func.func @arith_extsi(%arg0: i32) {
    %0 = emitc.cast %arg0 : i32 to i64
    return
  }
}

// -----
module {
  func.func @arith_extui(%arg0: i32) {
    %0 = emitc.cast %arg0 : i32 to ui32
    %1 = emitc.cast %0 : ui32 to ui64
    %2 = emitc.cast %1 : ui64 to i64
    return
  }
}

// -----
module {
  func.func @arith_extui_i1_to_i32(%arg0: i1) {
    %0 = emitc.cast %arg0 : i1 to ui1
    %1 = emitc.cast %0 : ui1 to ui32
    %2 = emitc.cast %1 : ui32 to i32
    return
  }
}

// -----
module {
  func.func @arith_index_cast(%arg0: i32) -> i32 {
    %0 = emitc.cast %arg0 : i32 to !emitc.ptrdiff_t
    %1 = emitc.cast %0 : !emitc.ptrdiff_t to !emitc.size_t
    %2 = emitc.cast %1 : !emitc.size_t to !emitc.ptrdiff_t
    %3 = emitc.cast %2 : !emitc.ptrdiff_t to i32
    %4 = "emitc.constant"() <{value = 1 : index}> : () -> !emitc.size_t
    %5 = emitc.bitwise_and %1, %4 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %6 = emitc.cast %5 : !emitc.size_t to i1
    return %3 : i32
  }
}

// -----
module {
  func.func @arith_index_castui(%arg0: i32) -> i32 {
    %0 = emitc.cast %arg0 : i32 to ui32
    %1 = emitc.cast %0 : ui32 to !emitc.size_t
    %2 = emitc.cast %1 : !emitc.size_t to ui32
    %3 = emitc.cast %2 : ui32 to i32
    %4 = "emitc.constant"() <{value = 1 : index}> : () -> !emitc.size_t
    %5 = emitc.bitwise_and %1, %4 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %6 = emitc.cast %5 : !emitc.size_t to i1
    return %3 : i32
  }
}

// -----
module {
  func.func @arith_divui_remui(%arg0: i32, %arg1: i32) -> i32 {
    %0 = emitc.cast %arg0 : i32 to ui32
    %1 = emitc.cast %arg1 : i32 to ui32
    %2 = emitc.div %0, %1 : (ui32, ui32) -> ui32
    %3 = emitc.cast %2 : ui32 to i32
    %4 = emitc.cast %arg0 : i32 to ui32
    %5 = emitc.cast %arg1 : i32 to ui32
    %6 = emitc.rem %4, %5 : (ui32, ui32) -> ui32
    %7 = emitc.cast %6 : ui32 to i32
    return %3 : i32
  }
}

// -----
module {
  func.func @arith_extf(%arg0: f16) -> f64 {
    %0 = emitc.cast %arg0 : f16 to f32
    %1 = emitc.cast %0 : f32 to f64
    return %1 : f64
  }
}

// -----
module {
  func.func @arith_truncf(%arg0: f64) -> f16 {
    %0 = emitc.cast %arg0 : f64 to f32
    %1 = emitc.cast %0 : f32 to f16
    return %1 : f16
  }
}


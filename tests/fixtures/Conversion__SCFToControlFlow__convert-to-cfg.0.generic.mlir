"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "simple_std_for_loop"}> ({
  ^bb0(%arg54: index, %arg55: index, %arg56: index):
    "cf.br"(%arg54)[^bb1] : (index) -> ()
  ^bb1(%131: index):  // 2 preds: ^bb0, ^bb2
    %132 = "arith.cmpi"(%131, %arg55) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%132)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %133 = "arith.constant"() <{value = 1 : index}> : () -> index
    %134 = "arith.addi"(%131, %arg56) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%134)[^bb1] : (index) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "unsigned_loop"}> ({
  ^bb0(%arg51: index, %arg52: index, %arg53: index):
    "cf.br"(%arg51)[^bb1] : (index) -> ()
  ^bb1(%127: index):  // 2 preds: ^bb0, ^bb2
    %128 = "arith.cmpi"(%127, %arg52) <{predicate = 6 : i64}> : (index, index) -> i1
    "cf.cond_br"(%128)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %129 = "arith.constant"() <{value = 1 : index}> : () -> index
    %130 = "arith.addi"(%127, %arg53) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%130)[^bb1] : (index) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "simple_std_2_for_loops"}> ({
  ^bb0(%arg48: index, %arg49: index, %arg50: index):
    "cf.br"(%arg48)[^bb1] : (index) -> ()
  ^bb1(%119: index):  // 2 preds: ^bb0, ^bb5
    %120 = "arith.cmpi"(%119, %arg49) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%120)[^bb2, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %121 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"(%arg48)[^bb3] : (index) -> ()
  ^bb3(%122: index):  // 2 preds: ^bb2, ^bb4
    %123 = "arith.cmpi"(%122, %arg49) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%123)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %124 = "arith.constant"() <{value = 1 : index}> : () -> index
    %125 = "arith.addi"(%122, %arg50) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%125)[^bb3] : (index) -> ()
  ^bb5:  // pred: ^bb3
    %126 = "arith.addi"(%119, %arg50) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%126)[^bb1] : (index) -> ()
  ^bb6:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "simple_std_if"}> ({
  ^bb0(%arg47: i1):
    "cf.cond_br"(%arg47)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %118 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "simple_std_if_else"}> ({
  ^bb0(%arg46: i1):
    "cf.cond_br"(%arg46)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %116 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    %117 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "simple_std_2_ifs"}> ({
  ^bb0(%arg45: i1):
    "cf.cond_br"(%arg45)[^bb1, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %113 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.cond_br"(%arg45)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %114 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb4] : () -> ()
  ^bb3:  // pred: ^bb1
    %115 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // 2 preds: ^bb2, ^bb3
    "cf.br"()[^bb5] : () -> ()
  ^bb5:  // 2 preds: ^bb0, ^bb4
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, i1) -> (), sym_name = "simple_std_for_loop_with_2_ifs"}> ({
  ^bb0(%arg41: index, %arg42: index, %arg43: index, %arg44: i1):
    "cf.br"(%arg41)[^bb1] : (index) -> ()
  ^bb1(%106: index):  // 2 preds: ^bb0, ^bb7
    %107 = "arith.cmpi"(%106, %arg42) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%107)[^bb2, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %108 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.cond_br"(%arg44)[^bb3, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %109 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.cond_br"(%arg44)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %110 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb6] : () -> ()
  ^bb5:  // pred: ^bb3
    %111 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb6] : () -> ()
  ^bb6:  // 2 preds: ^bb4, ^bb5
    "cf.br"()[^bb7] : () -> ()
  ^bb7:  // 2 preds: ^bb2, ^bb6
    %112 = "arith.addi"(%106, %arg43) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%112)[^bb1] : (index) -> ()
  ^bb8:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (i1, i1), sym_name = "simple_if_yield"}> ({
  ^bb0(%arg40: i1):
    "cf.cond_br"(%arg40)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %100 = "arith.constant"() <{value = false}> : () -> i1
    %101 = "arith.constant"() <{value = true}> : () -> i1
    "cf.br"(%100, %101)[^bb3] : (i1, i1) -> ()
  ^bb2:  // pred: ^bb0
    %102 = "arith.constant"() <{value = false}> : () -> i1
    %103 = "arith.constant"() <{value = true}> : () -> i1
    "cf.br"(%103, %102)[^bb3] : (i1, i1) -> ()
  ^bb3(%104: i1, %105: i1):  // 2 preds: ^bb1, ^bb2
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    "func.return"(%104, %105) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> index, sym_name = "nested_if_yield"}> ({
  ^bb0(%arg39: i1):
    "cf.cond_br"(%arg39)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %92 = "arith.constant"() <{value = true}> : () -> i1
    "cf.br"(%92)[^bb3] : (i1) -> ()
  ^bb2:  // pred: ^bb0
    %93 = "arith.constant"() <{value = false}> : () -> i1
    "cf.br"(%93)[^bb3] : (i1) -> ()
  ^bb3(%94: i1):  // 2 preds: ^bb1, ^bb2
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    "cf.cond_br"(%94)[^bb5, ^bb10] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb5:  // pred: ^bb4
    "cf.cond_br"(%arg39)[^bb6, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb6:  // pred: ^bb5
    %95 = "arith.constant"() <{value = 40 : index}> : () -> index
    "cf.br"(%95)[^bb8] : (index) -> ()
  ^bb7:  // pred: ^bb5
    %96 = "arith.constant"() <{value = 41 : index}> : () -> index
    "cf.br"(%96)[^bb8] : (index) -> ()
  ^bb8(%97: index):  // 2 preds: ^bb6, ^bb7
    "cf.br"()[^bb9] : () -> ()
  ^bb9:  // pred: ^bb8
    "cf.br"(%97)[^bb11] : (index) -> ()
  ^bb10:  // pred: ^bb4
    %98 = "arith.constant"() <{value = 42 : index}> : () -> index
    "cf.br"(%98)[^bb11] : (index) -> ()
  ^bb11(%99: index):  // 2 preds: ^bb9, ^bb10
    "cf.br"()[^bb12] : () -> ()
  ^bb12:  // pred: ^bb11
    "func.return"(%99) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, index, index) -> (), sym_name = "parallel_loop"}> ({
  ^bb0(%arg34: index, %arg35: index, %arg36: index, %arg37: index, %arg38: index):
    %84 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"(%arg34)[^bb1] : (index) -> ()
  ^bb1(%85: index):  // 2 preds: ^bb0, ^bb5
    %86 = "arith.cmpi"(%85, %arg36) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%86)[^bb2, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"(%arg35)[^bb3] : (index) -> ()
  ^bb3(%87: index):  // 2 preds: ^bb2, ^bb4
    %88 = "arith.cmpi"(%87, %arg37) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%88)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %89 = "arith.constant"() <{value = 1 : index}> : () -> index
    %90 = "arith.addi"(%87, %84) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%90)[^bb3] : (index) -> ()
  ^bb5:  // pred: ^bb3
    %91 = "arith.addi"(%85, %arg38) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%91)[^bb1] : (index) -> ()
  ^bb6:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (f32, f32), sym_name = "for_yield"}> ({
  ^bb0(%arg31: index, %arg32: index, %arg33: index):
    %76 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %77 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "cf.br"(%arg31, %76, %77)[^bb1] : (index, f32, f32) -> ()
  ^bb1(%78: index, %79: f32, %80: f32):  // 2 preds: ^bb0, ^bb2
    %81 = "arith.cmpi"(%78, %arg32) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%81)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %82 = "arith.addf"(%79, %80) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %83 = "arith.addi"(%78, %arg33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%83, %82, %82)[^bb1] : (index, f32, f32) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"(%79, %80) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> f32, sym_name = "nested_for_yield"}> ({
  ^bb0(%arg28: index, %arg29: index, %arg30: index):
    %66 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "cf.br"(%arg28, %66)[^bb1] : (index, f32) -> ()
  ^bb1(%67: index, %68: f32):  // 2 preds: ^bb0, ^bb5
    %69 = "arith.cmpi"(%67, %arg29) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%69)[^bb2, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"(%arg28, %68)[^bb3] : (index, f32) -> ()
  ^bb3(%70: index, %71: f32):  // 2 preds: ^bb2, ^bb4
    %72 = "arith.cmpi"(%70, %arg29) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%72)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %73 = "arith.addf"(%71, %71) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %74 = "arith.addi"(%70, %arg30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%74, %73)[^bb3] : (index, f32) -> ()
  ^bb5:  // pred: ^bb3
    %75 = "arith.addi"(%67, %arg30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%75, %71)[^bb1] : (index, f32) -> ()
  ^bb6:  // pred: ^bb1
    "func.return"(%68) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "generate", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, f32) -> f32, sym_name = "simple_parallel_reduce_loop"}> ({
  ^bb0(%arg24: index, %arg25: index, %arg26: index, %arg27: f32):
    "cf.br"(%arg24, %arg27)[^bb1] : (index, f32) -> ()
  ^bb1(%60: index, %61: f32):  // 2 preds: ^bb0, ^bb2
    %62 = "arith.cmpi"(%60, %arg25) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%62)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %63 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %64 = "arith.mulf"(%61, %63) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %65 = "arith.addi"(%60, %arg26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%65, %64)[^bb1] : (index, f32) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"(%61) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, index, index, f32) -> (f32, i64), sym_name = "parallel_reduce_loop"}> ({
  ^bb0(%arg18: index, %arg19: index, %arg20: index, %arg21: index, %arg22: index, %arg23: f32):
    %44 = "arith.constant"() <{value = 1 : index}> : () -> index
    %45 = "arith.constant"() <{value = 42 : i64}> : () -> i64
    "cf.br"(%arg18, %arg23, %45)[^bb1] : (index, f32, i64) -> ()
  ^bb1(%46: index, %47: f32, %48: i64):  // 2 preds: ^bb0, ^bb5
    %49 = "arith.cmpi"(%46, %arg20) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%49)[^bb2, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"(%arg19, %47, %48)[^bb3] : (index, f32, i64) -> ()
  ^bb3(%50: index, %51: f32, %52: i64):  // 2 preds: ^bb2, ^bb4
    %53 = "arith.cmpi"(%50, %arg21) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%53)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %54 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %55 = "func.call"() <{callee = @generate}> : () -> i64
    %56 = "arith.addf"(%51, %54) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %57 = "arith.ori"(%52, %55) : (i64, i64) -> i64
    %58 = "arith.addi"(%50, %44) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%58, %56, %57)[^bb3] : (index, f32, i64) -> ()
  ^bb5:  // pred: ^bb3
    %59 = "arith.addi"(%46, %arg22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%59, %51, %52)[^bb1] : (index, f32, i64) -> ()
  ^bb6:  // pred: ^bb1
    "func.return"(%47, %48) : (f32, i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "unknown_op_inside_loop"}> ({
  ^bb0(%arg15: index, %arg16: index, %arg17: index):
    "cf.br"(%arg15)[^bb1] : (index) -> ()
  ^bb1(%41: index):  // 2 preds: ^bb0, ^bb2
    %42 = "arith.cmpi"(%41, %arg16) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%42)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "unknown.op"() : () -> ()
    %43 = "arith.addi"(%41, %arg17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%43)[^bb1] : (index) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "minimal_while"}> ({
    %40 = "test.make_condition"() : () -> i1
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    "cf.cond_br"(%40)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "test.some_payload"() : () -> ()
    "cf.br"()[^bb1] : () -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "do_while"}> ({
  ^bb0(%arg14: f32):
    "cf.br"(%arg14)[^bb1] : (f32) -> ()
  ^bb1(%38: f32):  // 2 preds: ^bb0, ^bb1
    %39 = "test.make_condition"() : () -> i1
    "cf.cond_br"(%39, %38)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, f32) -> ()
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, f32) -> (), sym_name = "while_values"}> ({
  ^bb0(%arg12: i32, %arg13: f32):
    %29 = "test.make_condition"() : () -> i1
    %30 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %31 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "cf.br"(%arg12, %arg13)[^bb1] : (i32, f32) -> ()
  ^bb1(%32: i32, %33: f32):  // 2 preds: ^bb0, ^bb2
    %34 = "arith.extui"(%arg12) : (i32) -> i64
    %35 = "arith.extf"(%33) : (f32) -> f64
    "cf.cond_br"(%29, %34, %35)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (i1, i64, f64) -> ()
  ^bb2(%36: i64, %37: f64):  // pred: ^bb1
    "cf.br"(%30, %31)[^bb1] : (i32, f32) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> i64, sym_name = "nested_while_ops"}> ({
  ^bb0(%arg11: f32):
    "cf.br"(%arg11)[^bb1] : (f32) -> ()
  ^bb1(%18: f32):  // 2 preds: ^bb0, ^bb8
    %19 = "test.outer_before_pre"() : () -> i1
    "cf.br"(%18)[^bb2] : (f32) -> ()
  ^bb2(%20: f32):  // 2 preds: ^bb1, ^bb3
    %21:2 = "test.inner_before"(%20) : (f32) -> (i1, i64)
    "cf.cond_br"(%21#0, %21#1)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i64) -> ()
  ^bb3(%22: i64):  // pred: ^bb2
    %23 = "test.inner_after"(%22) : (i64) -> f32
    "cf.br"(%23)[^bb2] : (f32) -> ()
  ^bb4:  // pred: ^bb2
    "test.outer_before_post"() : () -> ()
    "cf.cond_br"(%19, %21#1)[^bb5, ^bb9] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i64) -> ()
  ^bb5(%24: i64):  // pred: ^bb4
    "test.outer_after_pre"(%24) : (i64) -> ()
    "cf.br"(%24)[^bb6] : (i64) -> ()
  ^bb6(%25: i64):  // 2 preds: ^bb5, ^bb7
    %26:2 = "test.inner2_before"(%25) : (i64) -> (i1, f32)
    "cf.cond_br"(%26#0, %26#1)[^bb7, ^bb8] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, f32) -> ()
  ^bb7(%27: f32):  // pred: ^bb6
    %28 = "test.inner2_after"(%27) : (f32) -> i64
    "cf.br"(%28)[^bb6] : (i64) -> ()
  ^bb8:  // pred: ^bb6
    "test.outer_after_post"() : () -> ()
    "cf.br"(%26#1)[^bb1] : (f32) -> ()
  ^bb9:  // pred: ^bb4
    "func.return"(%21#1) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, i1, i1) -> (), sym_name = "ifs_in_parallel"}> ({
  ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: i1, %arg10: i1):
    "cf.br"(%arg6)[^bb1] : (index) -> ()
  ^bb1(%12: index):  // 2 preds: ^bb0, ^bb8
    %13 = "arith.cmpi"(%12, %arg7) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%13)[^bb2, ^bb9] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "cf.cond_br"(%arg9)[^bb3, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "cf.cond_br"(%arg10)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %14 = "test.if2"() : () -> index
    "cf.br"(%14)[^bb6] : (index) -> ()
  ^bb5:  // pred: ^bb3
    %15 = "test.else2"() : () -> index
    "cf.br"(%15)[^bb6] : (index) -> ()
  ^bb6(%16: index):  // 2 preds: ^bb4, ^bb5
    "cf.br"()[^bb7] : () -> ()
  ^bb7:  // pred: ^bb6
    "cf.br"()[^bb8] : () -> ()
  ^bb8:  // 2 preds: ^bb2, ^bb7
    %17 = "arith.addi"(%12, %arg8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%17)[^bb1] : (index) -> ()
  ^bb9:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "func_execute_region_elim_multi_yield"}> ({
    "test.foo"() : () -> ()
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %8 = "test.cmp"() : () -> i1
    "cf.cond_br"(%8)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %9 = "test.val1"() : () -> i64
    "cf.br"(%9)[^bb4] : (i64) -> ()
  ^bb3:  // pred: ^bb1
    %10 = "test.val2"() : () -> i64
    "cf.br"(%10)[^bb4] : (i64) -> ()
  ^bb4(%11: i64):  // 2 preds: ^bb2, ^bb3
    "test.bar"(%11) : (i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, i32, i32, i32) -> i32, sym_name = "index_switch"}> ({
  ^bb0(%arg2: index, %arg3: i32, %arg4: i32, %arg5: i32):
    %6 = "arith.index_cast"(%arg2) : (index) -> i64
    "cf.switch"(%6)[^bb3, ^bb1, ^bb2] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi64>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i64) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%arg3)[^bb4] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "cf.br"(%arg4)[^bb4] : (i32) -> ()
  ^bb3:  // pred: ^bb0
    "cf.br"(%arg5)[^bb4] : (i32) -> ()
  ^bb4(%7: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    "func.return"(%7) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "index_switch_large_cases"}> ({
  ^bb0(%arg1: index):
    %5 = "arith.index_cast"(%arg1) : (index) -> i64
    "cf.switch"(%5)[^bb4, ^bb1, ^bb2, ^bb3] <{case_operand_segments = array<i32: 0, 0, 0>, case_values = dense<[0, 4294967296, 8589934592]> : vector<3xi64>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i64) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"()[^bb5] : () -> ()
  ^bb2:  // pred: ^bb0
    "cf.br"()[^bb5] : () -> ()
  ^bb3:  // pred: ^bb0
    "cf.br"()[^bb5] : () -> ()
  ^bb4:  // pred: ^bb0
    "cf.br"()[^bb5] : () -> ()
  ^bb5:  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "forall"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"(%0)[^bb1] : (index) -> ()
  ^bb1(%2: index):  // 2 preds: ^bb0, ^bb2
    %3 = "arith.cmpi"(%2, %arg0) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%3)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "test.foo"(%2) : (index) -> ()
    %4 = "arith.addi"(%2, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%4)[^bb1] : (index) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#loop_unroll = #llvm.loop_unroll<full = true>
#loop_unroll1 = #llvm.loop_unroll<disable = true>
#loop_annotation = #llvm.loop_annotation<unroll = #loop_unroll>
#loop_annotation1 = #llvm.loop_annotation<unroll = #loop_unroll1>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "simple_std_for_loops_annotation"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    "cf.br"(%arg0)[^bb1] : (index) -> ()
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb5
    %1 = "arith.cmpi"(%0, %arg1) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%1)[^bb2, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 4 : index}> : () -> index
    "cf.br"(%2)[^bb3] : (index) -> ()
  ^bb3(%5: index):  // 2 preds: ^bb2, ^bb4
    %6 = "arith.cmpi"(%5, %4) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%6)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "arith.addi"(%5, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%8)[^bb3] {llvm.loop_annotation = #loop_annotation} : (index) -> ()
  ^bb5:  // pred: ^bb3
    %9 = "arith.addi"(%0, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%9)[^bb1] {llvm.loop_annotation = #loop_annotation1} : (index) -> ()
  ^bb6:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#loop_unroll = #llvm.loop_unroll<disable = true>
#loop_annotation = #llvm.loop_annotation<unroll = #loop_unroll>
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "simple_while_loops_annotation"}> ({
  ^bb0(%arg0: i1):
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> {llvm.loop_annotation = #loop_annotation} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#loop_unroll = #llvm.loop_unroll<disable = true>
#loop_annotation = #llvm.loop_annotation<unroll = #loop_unroll>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "do_while_loops_annotation"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "cf.br"(%0)[^bb1] : (i32) -> ()
  ^bb1(%1: i32):  // 2 preds: ^bb0, ^bb2
    %2 = "test.make_condition"() : () -> i1
    "cf.cond_br"(%2, %0)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
  ^bb2(%3: i32):  // pred: ^bb1
    "cf.br"(%0)[^bb1] {llvm.loop_annotation = #loop_annotation} : (i32) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()


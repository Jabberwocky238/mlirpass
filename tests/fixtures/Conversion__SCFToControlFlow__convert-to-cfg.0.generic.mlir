"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "simple_std_for_loop"}> ({
  ^bb0(%arg53: index, %arg54: index, %arg55: index):
    "cf.br"(%arg53)[^bb1] : (index) -> ()
  ^bb1(%130: index):  // 2 preds: ^bb0, ^bb2
    %131 = "arith.cmpi"(%130, %arg54) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%131)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %132 = "arith.constant"() <{value = 1 : index}> : () -> index
    %133 = "arith.addi"(%130, %arg55) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%133)[^bb1] : (index) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "unsigned_loop"}> ({
  ^bb0(%arg50: index, %arg51: index, %arg52: index):
    "cf.br"(%arg50)[^bb1] : (index) -> ()
  ^bb1(%126: index):  // 2 preds: ^bb0, ^bb2
    %127 = "arith.cmpi"(%126, %arg51) <{predicate = 6 : i64}> : (index, index) -> i1
    "cf.cond_br"(%127)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %128 = "arith.constant"() <{value = 1 : index}> : () -> index
    %129 = "arith.addi"(%126, %arg52) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%129)[^bb1] : (index) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "simple_std_2_for_loops"}> ({
  ^bb0(%arg47: index, %arg48: index, %arg49: index):
    "cf.br"(%arg47)[^bb1] : (index) -> ()
  ^bb1(%118: index):  // 2 preds: ^bb0, ^bb5
    %119 = "arith.cmpi"(%118, %arg48) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%119)[^bb2, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %120 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"(%arg47)[^bb3] : (index) -> ()
  ^bb3(%121: index):  // 2 preds: ^bb2, ^bb4
    %122 = "arith.cmpi"(%121, %arg48) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%122)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %123 = "arith.constant"() <{value = 1 : index}> : () -> index
    %124 = "arith.addi"(%121, %arg49) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%124)[^bb3] : (index) -> ()
  ^bb5:  // pred: ^bb3
    %125 = "arith.addi"(%118, %arg49) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%125)[^bb1] : (index) -> ()
  ^bb6:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "simple_std_if"}> ({
  ^bb0(%arg46: i1):
    "cf.cond_br"(%arg46)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %117 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "simple_std_if_else"}> ({
  ^bb0(%arg45: i1):
    "cf.cond_br"(%arg45)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %115 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    %116 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "simple_std_2_ifs"}> ({
  ^bb0(%arg44: i1):
    "cf.cond_br"(%arg44)[^bb1, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %112 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.cond_br"(%arg44)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %113 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb4] : () -> ()
  ^bb3:  // pred: ^bb1
    %114 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // 2 preds: ^bb2, ^bb3
    "cf.br"()[^bb5] : () -> ()
  ^bb5:  // 2 preds: ^bb0, ^bb4
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, i1) -> (), sym_name = "simple_std_for_loop_with_2_ifs"}> ({
  ^bb0(%arg40: index, %arg41: index, %arg42: index, %arg43: i1):
    "cf.br"(%arg40)[^bb1] : (index) -> ()
  ^bb1(%105: index):  // 2 preds: ^bb0, ^bb7
    %106 = "arith.cmpi"(%105, %arg41) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%106)[^bb2, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %107 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.cond_br"(%arg43)[^bb3, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %108 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.cond_br"(%arg43)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %109 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb6] : () -> ()
  ^bb5:  // pred: ^bb3
    %110 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"()[^bb6] : () -> ()
  ^bb6:  // 2 preds: ^bb4, ^bb5
    "cf.br"()[^bb7] : () -> ()
  ^bb7:  // 2 preds: ^bb2, ^bb6
    %111 = "arith.addi"(%105, %arg42) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%111)[^bb1] : (index) -> ()
  ^bb8:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (i1, i1), sym_name = "simple_if_yield"}> ({
  ^bb0(%arg39: i1):
    "cf.cond_br"(%arg39)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %99 = "arith.constant"() <{value = false}> : () -> i1
    %100 = "arith.constant"() <{value = true}> : () -> i1
    "cf.br"(%99, %100)[^bb3] : (i1, i1) -> ()
  ^bb2:  // pred: ^bb0
    %101 = "arith.constant"() <{value = false}> : () -> i1
    %102 = "arith.constant"() <{value = true}> : () -> i1
    "cf.br"(%102, %101)[^bb3] : (i1, i1) -> ()
  ^bb3(%103: i1, %104: i1):  // 2 preds: ^bb1, ^bb2
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    "func.return"(%103, %104) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> index, sym_name = "nested_if_yield"}> ({
  ^bb0(%arg38: i1):
    "cf.cond_br"(%arg38)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %91 = "arith.constant"() <{value = true}> : () -> i1
    "cf.br"(%91)[^bb3] : (i1) -> ()
  ^bb2:  // pred: ^bb0
    %92 = "arith.constant"() <{value = false}> : () -> i1
    "cf.br"(%92)[^bb3] : (i1) -> ()
  ^bb3(%93: i1):  // 2 preds: ^bb1, ^bb2
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    "cf.cond_br"(%93)[^bb5, ^bb10] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb5:  // pred: ^bb4
    "cf.cond_br"(%arg38)[^bb6, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb6:  // pred: ^bb5
    %94 = "arith.constant"() <{value = 40 : index}> : () -> index
    "cf.br"(%94)[^bb8] : (index) -> ()
  ^bb7:  // pred: ^bb5
    %95 = "arith.constant"() <{value = 41 : index}> : () -> index
    "cf.br"(%95)[^bb8] : (index) -> ()
  ^bb8(%96: index):  // 2 preds: ^bb6, ^bb7
    "cf.br"()[^bb9] : () -> ()
  ^bb9:  // pred: ^bb8
    "cf.br"(%96)[^bb11] : (index) -> ()
  ^bb10:  // pred: ^bb4
    %97 = "arith.constant"() <{value = 42 : index}> : () -> index
    "cf.br"(%97)[^bb11] : (index) -> ()
  ^bb11(%98: index):  // 2 preds: ^bb9, ^bb10
    "cf.br"()[^bb12] : () -> ()
  ^bb12:  // pred: ^bb11
    "func.return"(%98) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, index, index) -> (), sym_name = "parallel_loop"}> ({
  ^bb0(%arg33: index, %arg34: index, %arg35: index, %arg36: index, %arg37: index):
    %83 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"(%arg33)[^bb1] : (index) -> ()
  ^bb1(%84: index):  // 2 preds: ^bb0, ^bb5
    %85 = "arith.cmpi"(%84, %arg35) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%85)[^bb2, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"(%arg34)[^bb3] : (index) -> ()
  ^bb3(%86: index):  // 2 preds: ^bb2, ^bb4
    %87 = "arith.cmpi"(%86, %arg36) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%87)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %88 = "arith.constant"() <{value = 1 : index}> : () -> index
    %89 = "arith.addi"(%86, %83) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%89)[^bb3] : (index) -> ()
  ^bb5:  // pred: ^bb3
    %90 = "arith.addi"(%84, %arg37) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%90)[^bb1] : (index) -> ()
  ^bb6:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (f32, f32), sym_name = "for_yield"}> ({
  ^bb0(%arg30: index, %arg31: index, %arg32: index):
    %75 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %76 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "cf.br"(%arg30, %75, %76)[^bb1] : (index, f32, f32) -> ()
  ^bb1(%77: index, %78: f32, %79: f32):  // 2 preds: ^bb0, ^bb2
    %80 = "arith.cmpi"(%77, %arg31) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%80)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %81 = "arith.addf"(%78, %79) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %82 = "arith.addi"(%77, %arg32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%82, %81, %81)[^bb1] : (index, f32, f32) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"(%78, %79) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> f32, sym_name = "nested_for_yield"}> ({
  ^bb0(%arg27: index, %arg28: index, %arg29: index):
    %65 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "cf.br"(%arg27, %65)[^bb1] : (index, f32) -> ()
  ^bb1(%66: index, %67: f32):  // 2 preds: ^bb0, ^bb5
    %68 = "arith.cmpi"(%66, %arg28) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%68)[^bb2, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"(%arg27, %67)[^bb3] : (index, f32) -> ()
  ^bb3(%69: index, %70: f32):  // 2 preds: ^bb2, ^bb4
    %71 = "arith.cmpi"(%69, %arg28) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%71)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %72 = "arith.addf"(%70, %70) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %73 = "arith.addi"(%69, %arg29) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%73, %72)[^bb3] : (index, f32) -> ()
  ^bb5:  // pred: ^bb3
    %74 = "arith.addi"(%66, %arg29) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%74, %70)[^bb1] : (index, f32) -> ()
  ^bb6:  // pred: ^bb1
    "func.return"(%67) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "generate", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, f32) -> f32, sym_name = "simple_parallel_reduce_loop"}> ({
  ^bb0(%arg23: index, %arg24: index, %arg25: index, %arg26: f32):
    "cf.br"(%arg23, %arg26)[^bb1] : (index, f32) -> ()
  ^bb1(%59: index, %60: f32):  // 2 preds: ^bb0, ^bb2
    %61 = "arith.cmpi"(%59, %arg24) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%61)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %62 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %63 = "arith.mulf"(%60, %62) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %64 = "arith.addi"(%59, %arg25) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%64, %63)[^bb1] : (index, f32) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"(%60) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, index, index, f32) -> (f32, i64), sym_name = "parallel_reduce_loop"}> ({
  ^bb0(%arg17: index, %arg18: index, %arg19: index, %arg20: index, %arg21: index, %arg22: f32):
    %43 = "arith.constant"() <{value = 1 : index}> : () -> index
    %44 = "arith.constant"() <{value = 42 : i64}> : () -> i64
    "cf.br"(%arg17, %arg22, %44)[^bb1] : (index, f32, i64) -> ()
  ^bb1(%45: index, %46: f32, %47: i64):  // 2 preds: ^bb0, ^bb5
    %48 = "arith.cmpi"(%45, %arg19) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%48)[^bb2, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"(%arg18, %46, %47)[^bb3] : (index, f32, i64) -> ()
  ^bb3(%49: index, %50: f32, %51: i64):  // 2 preds: ^bb2, ^bb4
    %52 = "arith.cmpi"(%49, %arg20) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%52)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %53 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %54 = "func.call"() <{callee = @generate}> : () -> i64
    %55 = "arith.addf"(%50, %53) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %56 = "arith.ori"(%51, %54) : (i64, i64) -> i64
    %57 = "arith.addi"(%49, %43) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%57, %55, %56)[^bb3] : (index, f32, i64) -> ()
  ^bb5:  // pred: ^bb3
    %58 = "arith.addi"(%45, %arg21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%58, %50, %51)[^bb1] : (index, f32, i64) -> ()
  ^bb6:  // pred: ^bb1
    "func.return"(%46, %47) : (f32, i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "unknown_op_inside_loop"}> ({
  ^bb0(%arg14: index, %arg15: index, %arg16: index):
    "cf.br"(%arg14)[^bb1] : (index) -> ()
  ^bb1(%40: index):  // 2 preds: ^bb0, ^bb2
    %41 = "arith.cmpi"(%40, %arg15) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%41)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "unknown.op"() : () -> ()
    %42 = "arith.addi"(%40, %arg16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%42)[^bb1] : (index) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "minimal_while"}> ({
    %39 = "test.make_condition"() : () -> i1
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    "cf.cond_br"(%39)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "test.some_payload"() : () -> ()
    "cf.br"()[^bb1] : () -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "do_while"}> ({
  ^bb0(%arg13: f32):
    "cf.br"(%arg13)[^bb1] : (f32) -> ()
  ^bb1(%37: f32):  // 2 preds: ^bb0, ^bb1
    %38 = "test.make_condition"() : () -> i1
    "cf.cond_br"(%38, %37)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, f32) -> ()
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, f32) -> (), sym_name = "while_values"}> ({
  ^bb0(%arg11: i32, %arg12: f32):
    %28 = "test.make_condition"() : () -> i1
    %29 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %30 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "cf.br"(%arg11, %arg12)[^bb1] : (i32, f32) -> ()
  ^bb1(%31: i32, %32: f32):  // 2 preds: ^bb0, ^bb2
    %33 = "arith.extui"(%arg11) : (i32) -> i64
    %34 = "arith.extf"(%32) : (f32) -> f64
    "cf.cond_br"(%28, %33, %34)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (i1, i64, f64) -> ()
  ^bb2(%35: i64, %36: f64):  // pred: ^bb1
    "cf.br"(%29, %30)[^bb1] : (i32, f32) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> i64, sym_name = "nested_while_ops"}> ({
  ^bb0(%arg10: f32):
    "cf.br"(%arg10)[^bb1] : (f32) -> ()
  ^bb1(%17: f32):  // 2 preds: ^bb0, ^bb8
    %18 = "test.outer_before_pre"() : () -> i1
    "cf.br"(%17)[^bb2] : (f32) -> ()
  ^bb2(%19: f32):  // 2 preds: ^bb1, ^bb3
    %20:2 = "test.inner_before"(%19) : (f32) -> (i1, i64)
    "cf.cond_br"(%20#0, %20#1)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i64) -> ()
  ^bb3(%21: i64):  // pred: ^bb2
    %22 = "test.inner_after"(%21) : (i64) -> f32
    "cf.br"(%22)[^bb2] : (f32) -> ()
  ^bb4:  // pred: ^bb2
    "test.outer_before_post"() : () -> ()
    "cf.cond_br"(%18, %20#1)[^bb5, ^bb9] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i64) -> ()
  ^bb5(%23: i64):  // pred: ^bb4
    "test.outer_after_pre"(%23) : (i64) -> ()
    "cf.br"(%23)[^bb6] : (i64) -> ()
  ^bb6(%24: i64):  // 2 preds: ^bb5, ^bb7
    %25:2 = "test.inner2_before"(%24) : (i64) -> (i1, f32)
    "cf.cond_br"(%25#0, %25#1)[^bb7, ^bb8] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, f32) -> ()
  ^bb7(%26: f32):  // pred: ^bb6
    %27 = "test.inner2_after"(%26) : (f32) -> i64
    "cf.br"(%27)[^bb6] : (i64) -> ()
  ^bb8:  // pred: ^bb6
    "test.outer_after_post"() : () -> ()
    "cf.br"(%25#1)[^bb1] : (f32) -> ()
  ^bb9:  // pred: ^bb4
    "func.return"(%20#1) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, i1, i1) -> (), sym_name = "ifs_in_parallel"}> ({
  ^bb0(%arg5: index, %arg6: index, %arg7: index, %arg8: i1, %arg9: i1):
    "cf.br"(%arg5)[^bb1] : (index) -> ()
  ^bb1(%11: index):  // 2 preds: ^bb0, ^bb8
    %12 = "arith.cmpi"(%11, %arg6) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%12)[^bb2, ^bb9] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "cf.cond_br"(%arg8)[^bb3, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "cf.cond_br"(%arg9)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %13 = "test.if2"() : () -> index
    "cf.br"(%13)[^bb6] : (index) -> ()
  ^bb5:  // pred: ^bb3
    %14 = "test.else2"() : () -> index
    "cf.br"(%14)[^bb6] : (index) -> ()
  ^bb6(%15: index):  // 2 preds: ^bb4, ^bb5
    "cf.br"()[^bb7] : () -> ()
  ^bb7:  // pred: ^bb6
    "cf.br"()[^bb8] : () -> ()
  ^bb8:  // 2 preds: ^bb2, ^bb7
    %16 = "arith.addi"(%11, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%16)[^bb1] : (index) -> ()
  ^bb9:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "func_execute_region_elim_multi_yield"}> ({
    "test.foo"() : () -> ()
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %7 = "test.cmp"() : () -> i1
    "cf.cond_br"(%7)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %8 = "test.val1"() : () -> i64
    "cf.br"(%8)[^bb4] : (i64) -> ()
  ^bb3:  // pred: ^bb1
    %9 = "test.val2"() : () -> i64
    "cf.br"(%9)[^bb4] : (i64) -> ()
  ^bb4(%10: i64):  // 2 preds: ^bb2, ^bb3
    "test.bar"(%10) : (i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, i32, i32, i32) -> i32, sym_name = "index_switch"}> ({
  ^bb0(%arg1: index, %arg2: i32, %arg3: i32, %arg4: i32):
    %5 = "arith.index_cast"(%arg1) : (index) -> i32
    "cf.switch"(%5)[^bb3, ^bb1, ^bb2] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%arg2)[^bb4] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "cf.br"(%arg3)[^bb4] : (i32) -> ()
  ^bb3:  // pred: ^bb0
    "cf.br"(%arg4)[^bb4] : (i32) -> ()
  ^bb4(%6: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    "func.return"(%6) : (i32) -> ()
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


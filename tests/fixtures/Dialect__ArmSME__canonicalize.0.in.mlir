"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xi32>) -> (), sym_name = "unused_ssa_tile_is_removed_from_blocks"}> ({
  ^bb0(%arg0: memref<?x?xi32>):
    %0 = "arith.constant"() <{value = 10 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arm_sme.get_tile"() : () -> vector<[4]x[4]xf32>
    "cf.br"(%1, %3)[^bb1] : (index, vector<[4]x[4]xf32>) -> ()
  ^bb1(%4: index, %5: vector<[4]x[4]xf32>):  // 2 preds: ^bb0, ^bb2
    %6 = "arith.cmpi"(%4, %0) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%6)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %7 = "arith.addi"(%4, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%7, %3)[^bb1] : (index, vector<[4]x[4]xf32>) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()


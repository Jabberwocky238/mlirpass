"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xi32>) -> (), sym_name = "unused_ssa_tile_is_removed_from_blocks"}> ({
  ^bb0(%arg0: memref<?x?xi32>):
    %0 = "arith.constant"() <{value = 10 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"(%1)[^bb1] : (index) -> ()
  ^bb1(%3: index):  // 2 preds: ^bb0, ^bb2
    %4 = "arith.cmpi"(%3, %0) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%4)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %5 = "arith.addi"(%3, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%5)[^bb1] : (index) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()


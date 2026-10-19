"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> (), sym_name = "func"}> ({
  ^bb0(%arg0: i64):
    %0 = "arith.index_cast"(%arg0) : (i64) -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    "scf.parallel"(%0, %0, %0) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg1: index):
      %2 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      "memref.store"(%2, %1, %arg1) : (f32, memref<16xf32>, index) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()


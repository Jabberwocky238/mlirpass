"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, index) -> (), sym_name = "vector_scalable_memcopy"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "vector.vscale"() : () -> index
    %3 = "arith.muli"(%1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "scf.for"(%0, %arg2, %3) ({
    ^bb0(%arg3: index):
      %4 = "vector.load"(%arg0, %arg3) : (memref<?xf32>, index) -> vector<[4]xf32>
      "vector.store"(%4, %arg1, %arg3) : (vector<[4]xf32>, memref<?xf32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()


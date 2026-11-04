"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, tensor<?x?x?xf32>, index, index, index) -> (index, index, index), sym_name = "insert_slice"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%arg1, %2) : (tensor<?x?x?xf32>, index) -> index
    %4 = "tensor.dim"(%arg1, %1) : (tensor<?x?x?xf32>, index) -> index
    %5 = "tensor.dim"(%arg1, %0) : (tensor<?x?x?xf32>, index) -> index
    "func.return"(%3, %4, %5) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index, index) -> (index, index, index), sym_name = "extract_slice"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index):
    "func.return"(%arg1, %arg2, %arg3) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index) -> index, sym_name = "extract_slice_rank_reduced_1"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index):
    "func.return"(%arg1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index) -> index, sym_name = "extract_slice_rank_reduced_2"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index):
    "func.return"(%arg1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index) -> index, sym_name = "extract_slice_rank_reduced_3"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index):
    "func.return"(%arg1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index) -> index, sym_name = "extract_slice_rank_reduced_4"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index):
    "func.return"(%arg1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index) -> (index, index), sym_name = "extract_slice_rank_reduced_5"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index):
    "func.return"(%arg1, %arg2) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index) -> (index, index), sym_name = "extract_slice_rank_reduced_6"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index):
    "func.return"(%arg1, %arg2) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "collapse_shape"}> ({
    %0 = "arith.constant"() <{value = 154 : index}> : () -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()


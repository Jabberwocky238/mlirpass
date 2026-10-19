"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) : (memref<200x100xf32>, index, index) -> vector<8xf32>
    "func.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load_with_alignment_attribute"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) <{alignment = 8 : i64}> : (memref<200x100xf32>, index, index) -> vector<8xf32>
    "func.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<1.100000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    "vector.store"(%0, %arg0, %arg1, %arg2) : (vector<4xf32>, memref<200x100xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_with_alignment_attribute"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<1.100000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    "vector.store"(%0, %arg0, %arg1, %arg2) <{alignment = 8 : i64}> : (vector<4xf32>, memref<200x100xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>, sym_name = "masked_load"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.maskedload"(%arg0, %0, %arg1, %arg2) : (memref<?xf32>, index, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%1) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>, sym_name = "masked_load_with_alignment_attribute"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.maskedload"(%arg0, %0, %arg1, %arg2) <{alignment = 8 : i64}> : (memref<?xf32>, index, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%1) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> (), sym_name = "masked_store"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.maskedstore"(%arg0, %0, %arg1, %arg2) : (memref<?xf32>, index, vector<16xi1>, vector<16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> (), sym_name = "masked_store_with_alignment_attribute"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.maskedstore"(%arg0, %0, %arg1, %arg2) <{alignment = 8 : i64}> : (memref<?xf32>, index, vector<16xi1>, vector<16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> (), sym_name = "scatter"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.scatter"(%arg0, %0, %arg1, %arg2, %arg3) : (memref<?xf32>, index, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> (), sym_name = "scatter_with_alignment_attribute"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.scatter"(%arg0, %0, %arg1, %arg2, %arg3) <{alignment = 8 : i64}> : (memref<?xf32>, index, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>, sym_name = "gather"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.gather"(%arg0, %0, %arg1, %arg2, %arg3) : (memref<?xf32>, index, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    "func.return"(%1) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>, sym_name = "gather_with_alignment_attribute"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.gather"(%arg0, %0, %arg1, %arg2, %arg3) <{alignment = 8 : i64}> : (memref<?xf32>, index, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    "func.return"(%1) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()


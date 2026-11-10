"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) : (memref<200x100xf32>, index, index) -> vector<8xf32>
    "func.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<[8]xf32>, sym_name = "load_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) : (memref<200x100xf32>, index, index) -> vector<[8]xf32>
    "func.return"(%0) : (vector<[8]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load_nontemporal"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) <{nontemporal = true}> : (memref<200x100xf32>, index, index) -> vector<8xf32>
    "func.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<[8]xf32>, sym_name = "load_nontemporal_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) <{nontemporal = true}> : (memref<200x100xf32>, index, index) -> vector<[8]xf32>
    "func.return"(%0) : (vector<[8]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> vector<8xindex>, sym_name = "load_index"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) : (memref<200x100xindex>, index, index) -> vector<8xindex>
    "func.return"(%0) : (vector<8xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> vector<[8]xindex>, sym_name = "load_index_scalable"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) : (memref<200x100xindex>, index, index) -> vector<[8]xindex>
    "func.return"(%0) : (vector<[8]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<f32>, sym_name = "load_0d"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) : (memref<200x100xf32>, index, index) -> vector<f32>
    "func.return"(%0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load_with_alignment"}> ({
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
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<1.100000e+01> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    "vector.store"(%0, %arg0, %arg1, %arg2) : (vector<[4]xf32>, memref<200x100xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_nontemporal"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<1.100000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    "vector.store"(%0, %arg0, %arg1, %arg2) <{nontemporal = true}> : (vector<4xf32>, memref<200x100xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_nontemporal_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<1.100000e+01> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    "vector.store"(%0, %arg0, %arg1, %arg2) <{nontemporal = true}> : (vector<[4]xf32>, memref<200x100xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> (), sym_name = "store_index"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<11> : vector<4xindex>}> : () -> vector<4xindex>
    "vector.store"(%0, %arg0, %arg1, %arg2) : (vector<4xindex>, memref<200x100xindex>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> (), sym_name = "store_index_scalable"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<11> : vector<[4]xindex>}> : () -> vector<[4]xindex>
    "vector.store"(%0, %arg0, %arg1, %arg2) : (vector<[4]xindex>, memref<200x100xindex>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_0d"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<1.100000e+01> : vector<f32>}> : () -> vector<f32>
    "vector.store"(%0, %arg0, %arg1, %arg2) : (vector<f32>, memref<200x100xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index, vector<4xf32>) -> (), sym_name = "store_with_alignment"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index, %arg3: vector<4xf32>):
    "vector.store"(%arg3, %arg0, %arg1, %arg2) <{alignment = 8 : i64}> : (vector<4xf32>, memref<200x100xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()


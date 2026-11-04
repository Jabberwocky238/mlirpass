"builtin.module"() ({
  "memref.global"() <{initial_value = dense<0> : tensor<i64>, sym_name = "global", sym_visibility = "private", type = memref<i64>}> : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "global_load_store"}> ({
    %0 = "arith.constant"() <{value = 127 : i64}> : () -> i64
    %1 = "memref.get_global"() <{name = @global}> : () -> memref<i64>
    %2 = "memref.load"(%1) <{nontemporal = false}> : (memref<i64>) -> i64
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %4 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.copy"(%1, %4) : (memref<i64>, memref<i64>) -> ()
    "memref.store"(%3, %4) <{nontemporal = false}> : (i64, memref<i64>) -> ()
    %5 = "memref.get_global"() <{name = @global}> : () -> memref<i64>
    "memref.copy"(%4, %5) : (memref<i64>, memref<i64>) -> ()
    "func.return"(%3) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{initial_value = dense<0> : tensor<i64>, sym_name = "global", sym_visibility = "private", type = memref<i64>}> : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "raw_hazard"}> ({
    %0 = "arith.constant"() <{value = 127 : i64}> : () -> i64
    %1 = "memref.get_global"() <{name = @global}> : () -> memref<i64>
    %2 = "memref.get_global"() <{name = @global}> : () -> memref<i64>
    %3 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.copy"(%1, %3) : (memref<i64>, memref<i64>) -> ()
    "memref.store"(%0, %3) <{nontemporal = false}> : (i64, memref<i64>) -> ()
    %4 = "memref.load"(%2) <{nontemporal = false}> : (memref<i64>) -> i64
    %5 = "memref.get_global"() <{name = @global}> : () -> memref<i64>
    "memref.copy"(%3, %5) : (memref<i64>, memref<i64>) -> ()
    "func.return"(%4) : (i64) -> ()
  }) : () -> ()
}) : () -> ()


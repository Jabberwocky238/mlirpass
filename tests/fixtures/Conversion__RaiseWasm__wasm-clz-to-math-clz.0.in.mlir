"builtin.module"() ({
  "wasmssa.func"() <{exported, functionType = (i32) -> i32, sym_name = "clz_i32"}> ({
  ^bb0(%arg1: !wasmssa<local ref to i32>):
    %2 = "wasmssa.local_get"(%arg1) : (!wasmssa<local ref to i32>) -> i32
    %3 = "wasmssa.clz"(%2) : (i32) -> i32
    "wasmssa.return"(%3) : (i32) -> ()
  }) : () -> ()
  "wasmssa.func"() <{exported, functionType = (i64) -> i64, sym_name = "clz_i64"}> ({
  ^bb0(%arg0: !wasmssa<local ref to i64>):
    %0 = "wasmssa.local_get"(%arg0) : (!wasmssa<local ref to i64>) -> i64
    %1 = "wasmssa.clz"(%0) : (i64) -> i64
    "wasmssa.return"(%1) : (i64) -> ()
  }) : () -> ()
}) : () -> ()


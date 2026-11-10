"builtin.module"() ({
  "wasmssa.func"() <{exported, functionType = (i32, i32) -> i32, sym_name = "shl_i32"}> ({
  ^bb0(%arg2: !wasmssa<local ref to i32>, %arg3: !wasmssa<local ref to i32>):
    %3 = "wasmssa.local_get"(%arg2) : (!wasmssa<local ref to i32>) -> i32
    %4 = "wasmssa.local_get"(%arg3) : (!wasmssa<local ref to i32>) -> i32
    %5 = "wasmssa.shl"(%3, %4) : (i32, i32) -> i32
    "wasmssa.return"(%5) : (i32) -> ()
  }) : () -> ()
  "wasmssa.func"() <{exported, functionType = (i64, i64) -> i64, sym_name = "shl_i64"}> ({
  ^bb0(%arg0: !wasmssa<local ref to i64>, %arg1: !wasmssa<local ref to i64>):
    %0 = "wasmssa.local_get"(%arg0) : (!wasmssa<local ref to i64>) -> i64
    %1 = "wasmssa.local_get"(%arg1) : (!wasmssa<local ref to i64>) -> i64
    %2 = "wasmssa.shl"(%0, %1) : (i64, i64) -> i64
    "wasmssa.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()


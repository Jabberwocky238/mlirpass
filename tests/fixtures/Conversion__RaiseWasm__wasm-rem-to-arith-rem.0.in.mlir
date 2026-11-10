"builtin.module"() ({
  "wasmssa.func"() <{exported, functionType = (i32, i32) -> i32, sym_name = "rem_ui_32"}> ({
  ^bb0(%arg6: !wasmssa<local ref to i32>, %arg7: !wasmssa<local ref to i32>):
    %9 = "wasmssa.local_get"(%arg6) : (!wasmssa<local ref to i32>) -> i32
    %10 = "wasmssa.local_get"(%arg7) : (!wasmssa<local ref to i32>) -> i32
    %11 = "wasmssa.rem_ui"(%9, %10) : (i32, i32) -> i32
    "wasmssa.return"(%11) : (i32) -> ()
  }) : () -> ()
  "wasmssa.func"() <{exported, functionType = (i32, i32) -> i32, sym_name = "rem_si_32"}> ({
  ^bb0(%arg4: !wasmssa<local ref to i32>, %arg5: !wasmssa<local ref to i32>):
    %6 = "wasmssa.local_get"(%arg4) : (!wasmssa<local ref to i32>) -> i32
    %7 = "wasmssa.local_get"(%arg5) : (!wasmssa<local ref to i32>) -> i32
    %8 = "wasmssa.rem_si"(%6, %7) : (i32, i32) -> i32
    "wasmssa.return"(%8) : (i32) -> ()
  }) : () -> ()
  "wasmssa.func"() <{exported, functionType = (i64, i64) -> i64, sym_name = "rem_ui_64"}> ({
  ^bb0(%arg2: !wasmssa<local ref to i64>, %arg3: !wasmssa<local ref to i64>):
    %3 = "wasmssa.local_get"(%arg2) : (!wasmssa<local ref to i64>) -> i64
    %4 = "wasmssa.local_get"(%arg3) : (!wasmssa<local ref to i64>) -> i64
    %5 = "wasmssa.rem_ui"(%3, %4) : (i64, i64) -> i64
    "wasmssa.return"(%5) : (i64) -> ()
  }) : () -> ()
  "wasmssa.func"() <{exported, functionType = (i64, i64) -> i64, sym_name = "rem_si_64"}> ({
  ^bb0(%arg0: !wasmssa<local ref to i64>, %arg1: !wasmssa<local ref to i64>):
    %0 = "wasmssa.local_get"(%arg0) : (!wasmssa<local ref to i64>) -> i64
    %1 = "wasmssa.local_get"(%arg1) : (!wasmssa<local ref to i64>) -> i64
    %2 = "wasmssa.rem_si"(%0, %1) : (i64, i64) -> i64
    "wasmssa.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()


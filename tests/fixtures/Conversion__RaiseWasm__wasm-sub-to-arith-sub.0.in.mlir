"builtin.module"() ({
  "wasmssa.func"() <{functionType = (i32, i32) -> i32, sym_name = "func_1"}> ({
  ^bb0(%arg0: !wasmssa<local ref to i32>, %arg1: !wasmssa<local ref to i32>):
    %0 = "wasmssa.local_get"(%arg0) : (!wasmssa<local ref to i32>) -> i32
    %1 = "wasmssa.local_get"(%arg1) : (!wasmssa<local ref to i32>) -> i32
    %2 = "wasmssa.sub"(%0, %1) : (i32, i32) -> i32
    "wasmssa.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "wasmssa.func"() <{functionType = (i64, i64) -> i64, sym_name = "func_2"}> ({
  ^bb0(%arg0: !wasmssa<local ref to i64>, %arg1: !wasmssa<local ref to i64>):
    %0 = "wasmssa.local_get"(%arg0) : (!wasmssa<local ref to i64>) -> i64
    %1 = "wasmssa.local_get"(%arg1) : (!wasmssa<local ref to i64>) -> i64
    %2 = "wasmssa.sub"(%0, %1) : (i64, i64) -> i64
    "wasmssa.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "wasmssa.func"() <{functionType = (f32, f32) -> f32, sym_name = "func_3"}> ({
  ^bb0(%arg0: !wasmssa<local ref to f32>, %arg1: !wasmssa<local ref to f32>):
    %0 = "wasmssa.local_get"(%arg0) : (!wasmssa<local ref to f32>) -> f32
    %1 = "wasmssa.local_get"(%arg1) : (!wasmssa<local ref to f32>) -> f32
    %2 = "wasmssa.sub"(%0, %1) : (f32, f32) -> f32
    "wasmssa.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "wasmssa.func"() <{functionType = (f64, f64) -> f64, sym_name = "func_4"}> ({
  ^bb0(%arg0: !wasmssa<local ref to f64>, %arg1: !wasmssa<local ref to f64>):
    %0 = "wasmssa.local_get"(%arg0) : (!wasmssa<local ref to f64>) -> f64
    %1 = "wasmssa.local_get"(%arg1) : (!wasmssa<local ref to f64>) -> f64
    %2 = "wasmssa.sub"(%0, %1) : (f64, f64) -> f64
    "wasmssa.return"(%2) : (f64) -> ()
  }) : () -> ()
}) : () -> ()


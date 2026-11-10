"builtin.module"() ({
  "wasmssa.func"() <{exported, functionType = () -> (i32, i64, f32, f64), sym_name = "get_some_const"}> ({
    %0 = "wasmssa.const"() <{value = 17 : i32}> : () -> i32
    %1 = "wasmssa.const"() <{value = -163 : i64}> : () -> i64
    %2 = "wasmssa.const"() <{value = 3.140000e+00 : f32}> : () -> f32
    %3 = "wasmssa.const"() <{value = -1.575000e+02 : f64}> : () -> f64
    "wasmssa.return"(%0, %1, %2, %3) : (i32, i64, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()


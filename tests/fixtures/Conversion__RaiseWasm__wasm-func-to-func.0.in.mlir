"builtin.module"() ({
  "wasmssa.func"() <{exported, functionType = (i32) -> i32, sym_name = "callee"}> ({
  ^bb0(%arg1: !wasmssa<local ref to i32>):
    %3 = "wasmssa.local_get"(%arg1) : (!wasmssa<local ref to i32>) -> i32
    "wasmssa.return"(%3) : (i32) -> ()
  }) : () -> ()
  "wasmssa.func"() <{exported, functionType = (i32) -> i32, sym_name = "caller"}> ({
  ^bb0(%arg0: !wasmssa<local ref to i32>):
    %1 = "wasmssa.local_get"(%arg0) : (!wasmssa<local ref to i32>) -> i32
    %2 = "wasmssa.call"(%1) <{callee = @callee}> : (i32) -> i32
    "wasmssa.return"(%2) : (i32) -> ()
  }) : () -> ()
  "wasmssa.import_func"() <{importName = "foo", moduleName = "my_module", sym_name = "func_0", type = () -> i32}> {sym_visibility = "nested"} : () -> ()
  "wasmssa.func"() <{exported, functionType = () -> i32, sym_name = "user_of_func0"}> ({
    %0 = "wasmssa.call"() <{callee = @func_0}> : () -> i32
    "wasmssa.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()


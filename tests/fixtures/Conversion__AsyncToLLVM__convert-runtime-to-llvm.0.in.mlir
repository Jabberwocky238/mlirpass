"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "create_token"}> ({
    %33 = "async.runtime.create"() : () -> !async.token
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "create_value"}> ({
    %32 = "async.runtime.create"() : () -> !async.value<f32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "create_group"}> ({
    %30 = "arith.constant"() <{value = 1 : index}> : () -> index
    %31 = "async.runtime.create_group"(%30) : (index) -> !async.group
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "set_token_available"}> ({
    %29 = "async.runtime.create"() : () -> !async.token
    "async.runtime.set_available"(%29) : (!async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "set_value_available"}> ({
    %28 = "async.runtime.create"() : () -> !async.value<f32>
    "async.runtime.set_available"(%28) : (!async.value<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "is_token_error"}> ({
    %26 = "async.runtime.create"() : () -> !async.token
    %27 = "async.runtime.is_error"(%26) : (!async.token) -> i1
    "func.return"(%27) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "is_value_error"}> ({
    %24 = "async.runtime.create"() : () -> !async.value<f32>
    %25 = "async.runtime.is_error"(%24) : (!async.value<f32>) -> i1
    "func.return"(%25) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "await_token"}> ({
    %23 = "async.runtime.create"() : () -> !async.token
    "async.runtime.await"(%23) : (!async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "await_value"}> ({
    %22 = "async.runtime.create"() : () -> !async.value<f32>
    "async.runtime.await"(%22) : (!async.value<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "await_group"}> ({
    %20 = "arith.constant"() <{value = 1 : index}> : () -> index
    %21 = "async.runtime.create_group"(%20) : (index) -> !async.group
    "async.runtime.await"(%21) : (!async.group) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "await_and_resume_token"}> ({
    %17 = "async.coro.id"() : () -> !async.coro.id
    %18 = "async.coro.begin"(%17) : (!async.coro.id) -> !async.coro.handle
    %19 = "async.runtime.create"() : () -> !async.token
    "async.runtime.await_and_resume"(%19, %18) : (!async.token, !async.coro.handle) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "await_and_resume_value"}> ({
    %14 = "async.coro.id"() : () -> !async.coro.id
    %15 = "async.coro.begin"(%14) : (!async.coro.id) -> !async.coro.handle
    %16 = "async.runtime.create"() : () -> !async.value<f32>
    "async.runtime.await_and_resume"(%16, %15) : (!async.value<f32>, !async.coro.handle) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "await_and_resume_group"}> ({
    %10 = "arith.constant"() <{value = 1 : index}> : () -> index
    %11 = "async.coro.id"() : () -> !async.coro.id
    %12 = "async.coro.begin"(%11) : (!async.coro.id) -> !async.coro.handle
    %13 = "async.runtime.create_group"(%10) : (index) -> !async.group
    "async.runtime.await_and_resume"(%13, %12) : (!async.group, !async.coro.handle) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "resume"}> ({
    %8 = "async.coro.id"() : () -> !async.coro.id
    %9 = "async.coro.begin"(%8) : (!async.coro.id) -> !async.coro.handle
    "async.runtime.resume"(%9) : (!async.coro.handle) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "store"}> ({
    %6 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %7 = "async.runtime.create"() : () -> !async.value<f32>
    "async.runtime.store"(%6, %7) : (f32, !async.value<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "load"}> ({
    %4 = "async.runtime.create"() : () -> !async.value<f32>
    %5 = "async.runtime.load"(%4) : (!async.value<f32>) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "add_token_to_group"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "async.runtime.create"() : () -> !async.token
    %2 = "async.runtime.create_group"(%0) : (index) -> !async.group
    %3 = "async.runtime.add_to_group"(%1, %2) : (!async.token, !async.group) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()


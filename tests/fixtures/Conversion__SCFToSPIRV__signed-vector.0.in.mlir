"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "spirv.Constant"() <{value = -5 : si32}> : () -> si32
    %1 = "vector.from_elements"(%0) : (si32) -> vector<1xsi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()


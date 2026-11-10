"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_kernel", targets = [#xevm.target<chip = "pvc">]}> ({
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "arith.constant"() <{value = dense<0> : vector<4xi16>}> : () -> vector<4xi16>
      %1 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
      %2 = "xegpu.dpas"(%0, %0, %1) : (vector<4xi16>, vector<4xi16>, vector<4xi32>) -> vector<4xi32>
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()


"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_kernel", targets = [#xevm.target<chip = "pvc">]}> ({
    "func.func"() <{function_type = (vector<8xf16>, vector<16xf16>, vector<8xf32>) -> vector<8xf32>, sym_name = "dpas"}> ({
    ^bb0(%arg0: vector<8xf16>, %arg1: vector<16xf16>, %arg2: vector<8xf32>):
      %0 = "xegpu.dpas"(%arg0, %arg1, %arg2) : (vector<8xf16>, vector<16xf16>, vector<8xf32>) -> vector<8xf32>
      "func.return"(%0) : (vector<8xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()


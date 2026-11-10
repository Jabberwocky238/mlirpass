"builtin.module"() ({
  "gpu.module"() <{sym_name = "extf_e2m1_bf16", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xf4E2M1FN>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xf4E2M1FN>):
      %0 = "arith.extf"(%arg0) : (vector<16xf4E2M1FN>) -> vector<16xbf16>
      "gpu.return"() : () -> ()
    }) {sym_name = "extf_e2m1_bf16"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "extf_e2m1_f16", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xf4E2M1FN>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xf4E2M1FN>):
      %0 = "arith.extf"(%arg0) : (vector<16xf4E2M1FN>) -> vector<16xf16>
      "gpu.return"() : () -> ()
    }) {sym_name = "extf_e2m1_f16"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "extf_bf8_f16", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xf8E5M2>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xf8E5M2>):
      %0 = "arith.extf"(%arg0) : (vector<16xf8E5M2>) -> vector<16xf16>
      "gpu.return"() : () -> ()
    }) {sym_name = "extf_bf8_f16"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "extf_f8_bf16", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xf8E4M3FN>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xf8E4M3FN>):
      %0 = "arith.extf"(%arg0) : (vector<16xf8E4M3FN>) -> vector<16xbf16>
      "gpu.return"() : () -> ()
    }) {sym_name = "extf_f8_bf16"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "truncf_f16_e2m1", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xf16>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xf16>):
      %0 = "arith.truncf"(%arg0) : (vector<16xf16>) -> vector<16xf4E2M1FN>
      "gpu.return"() : () -> ()
    }) {sym_name = "truncf_f16_e2m1"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "truncf_bf16_f8", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xbf16>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xbf16>):
      %0 = "arith.truncf"(%arg0) : (vector<16xbf16>) -> vector<16xf8E4M3FN>
      "gpu.return"() : () -> ()
    }) {sym_name = "truncf_bf16_f8"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "extf_passthrough", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xf16>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xf16>):
      %0 = "arith.extf"(%arg0) : (vector<16xf16>) -> vector<16xf32>
      "gpu.return"() : () -> ()
    }) {sym_name = "extf_passthrough"} : () -> ()
  }) : () -> ()
}) : () -> ()


"builtin.module"() ({
  "gpu.module"() <{sym_name = "extf_e2m1_bf16", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xf4E2M1FN>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xf4E2M1FN>):
      %0 = "vector.bitcast"(%arg0) : (vector<16xf4E2M1FN>) -> vector<16xi4>
      %1 = "vector.bitcast"(%0) : (vector<16xi4>) -> vector<8xi8>
      %2 = "xevm.extf"(%1) <{dst_etype = #xevm<ext_dst_etype dst_etype = bf16>, src_etype = #xevm<ext_src_etype src_etype = e2m1>}> : (vector<8xi8>) -> vector<16xbf16>
      "gpu.return"() : () -> ()
    }) {sym_name = "extf_e2m1_bf16"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "extf_e2m1_f16", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xf4E2M1FN>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xf4E2M1FN>):
      %0 = "vector.bitcast"(%arg0) : (vector<16xf4E2M1FN>) -> vector<16xi4>
      %1 = "vector.bitcast"(%0) : (vector<16xi4>) -> vector<8xi8>
      %2 = "xevm.extf"(%1) <{dst_etype = #xevm<ext_dst_etype dst_etype = f16>, src_etype = #xevm<ext_src_etype src_etype = e2m1>}> : (vector<8xi8>) -> vector<16xf16>
      "gpu.return"() : () -> ()
    }) {sym_name = "extf_e2m1_f16"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "extf_bf8_f16", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xf8E5M2>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xf8E5M2>):
      %0 = "vector.bitcast"(%arg0) : (vector<16xf8E5M2>) -> vector<16xi8>
      %1 = "xevm.extf"(%0) <{dst_etype = #xevm<ext_dst_etype dst_etype = f16>, src_etype = #xevm<ext_src_etype src_etype = bf8>}> : (vector<16xi8>) -> vector<16xf16>
      "gpu.return"() : () -> ()
    }) {sym_name = "extf_bf8_f16"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "extf_f8_bf16", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xf8E4M3FN>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xf8E4M3FN>):
      %0 = "vector.bitcast"(%arg0) : (vector<16xf8E4M3FN>) -> vector<16xi8>
      %1 = "xevm.extf"(%0) <{dst_etype = #xevm<ext_dst_etype dst_etype = bf16>, src_etype = #xevm<ext_src_etype src_etype = f8>}> : (vector<16xi8>) -> vector<16xbf16>
      "gpu.return"() : () -> ()
    }) {sym_name = "extf_f8_bf16"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "truncf_f16_e2m1", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xf16>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xf16>):
      %0 = "xevm.truncf"(%arg0) <{dst_etype = #xevm<dst_etype dst_etype = e2m1>, src_etype = #xevm<src_etype src_etype = f16>}> : (vector<16xf16>) -> vector<8xi8>
      %1 = "vector.bitcast"(%0) : (vector<8xi8>) -> vector<16xi4>
      "gpu.return"() : () -> ()
    }) {sym_name = "truncf_f16_e2m1"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "truncf_bf16_f8", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xbf16>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xbf16>):
      %0 = "xevm.truncf"(%arg0) <{dst_etype = #xevm<dst_etype dst_etype = f8>, src_etype = #xevm<src_etype src_etype = bf16>}> : (vector<16xbf16>) -> vector<16xi8>
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


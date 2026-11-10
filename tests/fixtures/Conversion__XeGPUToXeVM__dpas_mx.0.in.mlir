"builtin.module"() ({
  "gpu.module"() <{sym_name = "dpas_mx_bf8", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xf8E5M2>, vector<32xf8E5M2>, vector<8xf32>, vector<1xf8E8M0FNU>, vector<1xf8E8M0FNU>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xf8E5M2>, %arg1: vector<32xf8E5M2>, %arg2: vector<8xf32>, %arg3: vector<1xf8E8M0FNU>, %arg4: vector<1xf8E8M0FNU>):
      %0 = "xegpu.dpas_mx"(%arg0, %arg1, %arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1>}> : (vector<16xf8E5M2>, vector<32xf8E5M2>, vector<8xf32>, vector<1xf8E8M0FNU>, vector<1xf8E8M0FNU>) -> vector<8xf32>
      "gpu.return"() : () -> ()
    }) {sym_name = "dpas_mx_bf8"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "dpas_mx_f8", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<16xf8E4M3FN>, vector<32xf8E4M3FN>, vector<8xf32>, vector<1xf8E8M0FNU>, vector<1xf8E8M0FNU>) -> (), kernel}> ({
    ^bb0(%arg0: vector<16xf8E4M3FN>, %arg1: vector<32xf8E4M3FN>, %arg2: vector<8xf32>, %arg3: vector<1xf8E8M0FNU>, %arg4: vector<1xf8E8M0FNU>):
      %0 = "xegpu.dpas_mx"(%arg0, %arg1, %arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1>}> : (vector<16xf8E4M3FN>, vector<32xf8E4M3FN>, vector<8xf32>, vector<1xf8E8M0FNU>, vector<1xf8E8M0FNU>) -> vector<8xf32>
      "gpu.return"() : () -> ()
    }) {sym_name = "dpas_mx_f8"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "dpas_mx_e2m1", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<32xf4E2M1FN>, vector<64xf4E2M1FN>, vector<8xf32>, vector<2xf8E8M0FNU>, vector<2xf8E8M0FNU>) -> (), kernel}> ({
    ^bb0(%arg0: vector<32xf4E2M1FN>, %arg1: vector<64xf4E2M1FN>, %arg2: vector<8xf32>, %arg3: vector<2xf8E8M0FNU>, %arg4: vector<2xf8E8M0FNU>):
      %0 = "xegpu.dpas_mx"(%arg0, %arg1, %arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1>}> : (vector<32xf4E2M1FN>, vector<64xf4E2M1FN>, vector<8xf32>, vector<2xf8E8M0FNU>, vector<2xf8E8M0FNU>) -> vector<8xf32>
      "gpu.return"() : () -> ()
    }) {sym_name = "dpas_mx_e2m1"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "dpas_mx_no_acc", targets = [#xevm.target<chip = "cri">]}> ({
    "gpu.func"() <{function_type = (vector<32xf4E2M1FN>, vector<64xf4E2M1FN>, vector<2xf8E8M0FNU>, vector<2xf8E8M0FNU>) -> (), kernel}> ({
    ^bb0(%arg0: vector<32xf4E2M1FN>, %arg1: vector<64xf4E2M1FN>, %arg2: vector<2xf8E8M0FNU>, %arg3: vector<2xf8E8M0FNU>):
      %0 = "xegpu.dpas_mx"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 1>}> : (vector<32xf4E2M1FN>, vector<64xf4E2M1FN>, vector<2xf8E8M0FNU>, vector<2xf8E8M0FNU>) -> vector<8xf32>
      "gpu.return"() : () -> ()
    }) {sym_name = "dpas_mx_no_acc"} : () -> ()
  }) : () -> ()
}) : () -> ()


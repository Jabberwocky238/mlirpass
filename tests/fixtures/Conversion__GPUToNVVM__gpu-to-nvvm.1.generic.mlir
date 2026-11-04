"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_0"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_ops", visibility_ = 0 : i64}> ({
      %1053 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %1054 = "llvm.sext"(%1053) : (i32) -> i64
      %1055 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %1056 = "llvm.sext"(%1055) : (i32) -> i64
      %1057 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %1058 = "llvm.sext"(%1057) : (i32) -> i64
      %1059 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %1060 = "llvm.sext"(%1059) : (i32) -> i64
      %1061 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %1062 = "llvm.sext"(%1061) : (i32) -> i64
      %1063 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %1064 = "llvm.sext"(%1063) : (i32) -> i64
      %1065 = "nvvm.read.ptx.sreg.ctaid.x"() : () -> i32
      %1066 = "llvm.sext"(%1065) : (i32) -> i64
      %1067 = "nvvm.read.ptx.sreg.ctaid.y"() : () -> i32
      %1068 = "llvm.sext"(%1067) : (i32) -> i64
      %1069 = "nvvm.read.ptx.sreg.ctaid.z"() : () -> i32
      %1070 = "llvm.sext"(%1069) : (i32) -> i64
      %1071 = "nvvm.read.ptx.sreg.nctaid.x"() : () -> i32
      %1072 = "llvm.sext"(%1071) : (i32) -> i64
      %1073 = "nvvm.read.ptx.sreg.nctaid.y"() : () -> i32
      %1074 = "llvm.sext"(%1073) : (i32) -> i64
      %1075 = "nvvm.read.ptx.sreg.nctaid.z"() : () -> i32
      %1076 = "llvm.sext"(%1075) : (i32) -> i64
      %1077 = "nvvm.read.ptx.sreg.laneid"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %1078 = "llvm.sext"(%1077) : (i32) -> i64
      %1079 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1080 = "llvm.insertvalue"(%1079, %1054) <{position = array<i64: 0>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1081 = "llvm.insertvalue"(%1080, %1056) <{position = array<i64: 1>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1082 = "llvm.insertvalue"(%1081, %1058) <{position = array<i64: 2>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1083 = "llvm.insertvalue"(%1082, %1060) <{position = array<i64: 3>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1084 = "llvm.insertvalue"(%1083, %1062) <{position = array<i64: 4>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1085 = "llvm.insertvalue"(%1084, %1064) <{position = array<i64: 5>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1086 = "llvm.insertvalue"(%1085, %1066) <{position = array<i64: 6>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1087 = "llvm.insertvalue"(%1086, %1068) <{position = array<i64: 7>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1088 = "llvm.insertvalue"(%1087, %1070) <{position = array<i64: 8>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1089 = "llvm.insertvalue"(%1088, %1072) <{position = array<i64: 9>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1090 = "llvm.insertvalue"(%1089, %1074) <{position = array<i64: 10>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1091 = "llvm.insertvalue"(%1090, %1076) <{position = array<i64: 11>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1092 = "llvm.insertvalue"(%1091, %1078) <{position = array<i64: 12>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      "llvm.return"(%1092) : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_index_ops", visibility_ = 0 : i64}> ({
    ^bb0(%arg254: !llvm.ptr):
      %1052 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_index_ops, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      "llvm.store"(%1052, %arg254) <{ordering = 0 : i64}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_comp", visibility_ = 0 : i64}> ({
    ^bb0(%arg253: i64):
      %1051 = "llvm.add"(%arg253, %arg253) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.return"(%1051) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_index_comp", visibility_ = 0 : i64}> ({
    ^bb0(%arg252: i64):
      %1050 = "llvm.call"(%arg252) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_index_comp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> i64
      "llvm.return"(%1050) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_2"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<32 x f32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_gpu_all_reduce_op_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_all_reduce_op", visibility_ = 0 : i64}> ({
      %794 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_op_0}> : () -> !llvm.ptr<3>
      %795 = "llvm.getelementptr"(%794) <{elem_type = !llvm.array<32 x f32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %796 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %797 = "llvm.insertvalue"(%796, %795) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %798 = "llvm.insertvalue"(%797, %795) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %799 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %800 = "llvm.insertvalue"(%798, %799) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %801 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %802 = "llvm.insertvalue"(%800, %801) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %803 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %804 = "llvm.insertvalue"(%802, %803) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %805 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %806 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %807 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %808 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %809 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %810 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %811 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %812 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %813 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %814 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %815 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %816 = "llvm.sext"(%815) : (i32) -> i64
      %817 = "llvm.trunc"(%816) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %818 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %819 = "llvm.sext"(%818) : (i32) -> i64
      %820 = "llvm.trunc"(%819) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %821 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %822 = "llvm.sext"(%821) : (i32) -> i64
      %823 = "llvm.trunc"(%822) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %824 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %825 = "llvm.sext"(%824) : (i32) -> i64
      %826 = "llvm.trunc"(%825) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %827 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %828 = "llvm.sext"(%827) : (i32) -> i64
      %829 = "llvm.trunc"(%828) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %830 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %831 = "llvm.sext"(%830) : (i32) -> i64
      %832 = "llvm.trunc"(%831) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %833 = "llvm.mul"(%832, %820) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %834 = "llvm.add"(%833, %829) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %835 = "llvm.mul"(%834, %817) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %836 = "llvm.mul"(%817, %820) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %837 = "llvm.add"(%835, %826) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %838 = "llvm.mul"(%836, %823) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %839 = "llvm.and"(%837, %813) : (i32, i32) -> i32
      %840 = "llvm.icmp"(%839, %812) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %841 = "llvm.sub"(%837, %839) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %842 = "llvm.sub"(%838, %841) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %843 = "llvm.icmp"(%842, %811) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%843)[^bb1, ^bb17] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %844 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %845 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %846 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %847 = "llvm.sub"(%846, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %848 = "llvm.lshr"(%845, %847) : (i32, i32) -> i32
      %849 = "llvm.sub"(%842, %844) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %850 = "nvvm.shfl.sync"(%848, %814, %810, %849) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %851 = "llvm.extractvalue"(%850) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %852 = "llvm.extractvalue"(%850) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%852)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %853 = "llvm.fadd"(%851, %814) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%853)[^bb4] : (f32) -> ()
    ^bb3:  // pred: ^bb1
      "llvm.br"(%814)[^bb4] : (f32) -> ()
    ^bb4(%854: f32):  // 2 preds: ^bb2, ^bb3
      %855 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %856 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %857 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %858 = "llvm.sub"(%857, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %859 = "llvm.lshr"(%856, %858) : (i32, i32) -> i32
      %860 = "llvm.sub"(%842, %855) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %861 = "nvvm.shfl.sync"(%859, %854, %809, %860) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %862 = "llvm.extractvalue"(%861) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %863 = "llvm.extractvalue"(%861) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%863)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb5:  // pred: ^bb4
      %864 = "llvm.fadd"(%854, %862) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%864)[^bb7] : (f32) -> ()
    ^bb6:  // pred: ^bb4
      "llvm.br"(%854)[^bb7] : (f32) -> ()
    ^bb7(%865: f32):  // 2 preds: ^bb5, ^bb6
      %866 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %867 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %868 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %869 = "llvm.sub"(%868, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %870 = "llvm.lshr"(%867, %869) : (i32, i32) -> i32
      %871 = "llvm.sub"(%842, %866) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %872 = "nvvm.shfl.sync"(%870, %865, %808, %871) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %873 = "llvm.extractvalue"(%872) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %874 = "llvm.extractvalue"(%872) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%874)[^bb8, ^bb9] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb8:  // pred: ^bb7
      %875 = "llvm.fadd"(%865, %873) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%875)[^bb10] : (f32) -> ()
    ^bb9:  // pred: ^bb7
      "llvm.br"(%865)[^bb10] : (f32) -> ()
    ^bb10(%876: f32):  // 2 preds: ^bb8, ^bb9
      %877 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %878 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %879 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %880 = "llvm.sub"(%879, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %881 = "llvm.lshr"(%878, %880) : (i32, i32) -> i32
      %882 = "llvm.sub"(%842, %877) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %883 = "nvvm.shfl.sync"(%881, %876, %807, %882) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %884 = "llvm.extractvalue"(%883) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %885 = "llvm.extractvalue"(%883) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%885)[^bb11, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb11:  // pred: ^bb10
      %886 = "llvm.fadd"(%876, %884) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%886)[^bb13] : (f32) -> ()
    ^bb12:  // pred: ^bb10
      "llvm.br"(%876)[^bb13] : (f32) -> ()
    ^bb13(%887: f32):  // 2 preds: ^bb11, ^bb12
      %888 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %889 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %890 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %891 = "llvm.sub"(%890, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %892 = "llvm.lshr"(%889, %891) : (i32, i32) -> i32
      %893 = "llvm.sub"(%842, %888) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %894 = "nvvm.shfl.sync"(%892, %887, %806, %893) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %895 = "llvm.extractvalue"(%894) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %896 = "llvm.extractvalue"(%894) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%896)[^bb14, ^bb15] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb14:  // pred: ^bb13
      %897 = "llvm.fadd"(%887, %895) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%897)[^bb16] : (f32) -> ()
    ^bb15:  // pred: ^bb13
      "llvm.br"(%887)[^bb16] : (f32) -> ()
    ^bb16(%898: f32):  // 2 preds: ^bb14, ^bb15
      "llvm.br"(%898)[^bb18] : (f32) -> ()
    ^bb17:  // pred: ^bb0
      %899 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %900 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %901 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %902 = "llvm.sub"(%901, %811) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %903 = "llvm.lshr"(%900, %902) : (i32, i32) -> i32
      %904 = "llvm.sub"(%811, %899) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %905 = "nvvm.shfl.sync"(%903, %814, %810, %904) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %906 = "llvm.fadd"(%905, %814) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %907 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %908 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %909 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %910 = "llvm.sub"(%909, %811) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %911 = "llvm.lshr"(%908, %910) : (i32, i32) -> i32
      %912 = "llvm.sub"(%811, %907) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %913 = "nvvm.shfl.sync"(%911, %906, %809, %912) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %914 = "llvm.fadd"(%906, %913) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %915 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %916 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %917 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %918 = "llvm.sub"(%917, %811) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %919 = "llvm.lshr"(%916, %918) : (i32, i32) -> i32
      %920 = "llvm.sub"(%811, %915) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %921 = "nvvm.shfl.sync"(%919, %914, %808, %920) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %922 = "llvm.fadd"(%914, %921) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %923 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %924 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %925 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %926 = "llvm.sub"(%925, %811) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %927 = "llvm.lshr"(%924, %926) : (i32, i32) -> i32
      %928 = "llvm.sub"(%811, %923) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %929 = "nvvm.shfl.sync"(%927, %922, %807, %928) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %930 = "llvm.fadd"(%922, %929) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %931 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %932 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %933 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %934 = "llvm.sub"(%933, %811) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %935 = "llvm.lshr"(%932, %934) : (i32, i32) -> i32
      %936 = "llvm.sub"(%811, %931) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %937 = "nvvm.shfl.sync"(%935, %930, %806, %936) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %938 = "llvm.fadd"(%930, %937) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%938)[^bb18] : (f32) -> ()
    ^bb18(%939: f32):  // 2 preds: ^bb16, ^bb17
      "llvm.cond_br"(%840)[^bb19, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb19:  // pred: ^bb18
      %940 = "llvm.sdiv"(%837, %811) : (i32, i32) -> i32
      %941 = "llvm.sext"(%940) : (i32) -> i64
      %942 = "llvm.extractvalue"(%804) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %943 = "llvm.getelementptr"(%942, %941) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%939, %943) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb21] : () -> ()
    ^bb20:  // pred: ^bb18
      "llvm.br"()[^bb21] : () -> ()
    ^bb21:  // 2 preds: ^bb19, ^bb20
      "nvvm.barrier0"() : () -> ()
      %944 = "llvm.add"(%838, %813) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %945 = "llvm.sdiv"(%944, %811) : (i32, i32) -> i32
      %946 = "llvm.icmp"(%837, %945) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%946)[^bb22, ^bb41] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb22:  // pred: ^bb21
      %947 = "llvm.sext"(%837) : (i32) -> i64
      %948 = "llvm.extractvalue"(%804) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %949 = "llvm.getelementptr"(%948, %947) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      %950 = "llvm.load"(%949) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f32
      %951 = "llvm.icmp"(%945, %811) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%951)[^bb23, ^bb39] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb23:  // pred: ^bb22
      %952 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %953 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %954 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %955 = "llvm.sub"(%954, %945) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %956 = "llvm.lshr"(%953, %955) : (i32, i32) -> i32
      %957 = "llvm.sub"(%945, %952) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %958 = "nvvm.shfl.sync"(%956, %950, %810, %957) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %959 = "llvm.extractvalue"(%958) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %960 = "llvm.extractvalue"(%958) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%960)[^bb24, ^bb25] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb24:  // pred: ^bb23
      %961 = "llvm.fadd"(%950, %959) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%961)[^bb26] : (f32) -> ()
    ^bb25:  // pred: ^bb23
      "llvm.br"(%950)[^bb26] : (f32) -> ()
    ^bb26(%962: f32):  // 2 preds: ^bb24, ^bb25
      %963 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %964 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %965 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %966 = "llvm.sub"(%965, %945) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %967 = "llvm.lshr"(%964, %966) : (i32, i32) -> i32
      %968 = "llvm.sub"(%945, %963) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %969 = "nvvm.shfl.sync"(%967, %962, %809, %968) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %970 = "llvm.extractvalue"(%969) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %971 = "llvm.extractvalue"(%969) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%971)[^bb27, ^bb28] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb27:  // pred: ^bb26
      %972 = "llvm.fadd"(%962, %970) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%972)[^bb29] : (f32) -> ()
    ^bb28:  // pred: ^bb26
      "llvm.br"(%962)[^bb29] : (f32) -> ()
    ^bb29(%973: f32):  // 2 preds: ^bb27, ^bb28
      %974 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %975 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %976 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %977 = "llvm.sub"(%976, %945) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %978 = "llvm.lshr"(%975, %977) : (i32, i32) -> i32
      %979 = "llvm.sub"(%945, %974) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %980 = "nvvm.shfl.sync"(%978, %973, %808, %979) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %981 = "llvm.extractvalue"(%980) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %982 = "llvm.extractvalue"(%980) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%982)[^bb30, ^bb31] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb30:  // pred: ^bb29
      %983 = "llvm.fadd"(%973, %981) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%983)[^bb32] : (f32) -> ()
    ^bb31:  // pred: ^bb29
      "llvm.br"(%973)[^bb32] : (f32) -> ()
    ^bb32(%984: f32):  // 2 preds: ^bb30, ^bb31
      %985 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %986 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %987 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %988 = "llvm.sub"(%987, %945) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %989 = "llvm.lshr"(%986, %988) : (i32, i32) -> i32
      %990 = "llvm.sub"(%945, %985) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %991 = "nvvm.shfl.sync"(%989, %984, %807, %990) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %992 = "llvm.extractvalue"(%991) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %993 = "llvm.extractvalue"(%991) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%993)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %994 = "llvm.fadd"(%984, %992) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%994)[^bb35] : (f32) -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"(%984)[^bb35] : (f32) -> ()
    ^bb35(%995: f32):  // 2 preds: ^bb33, ^bb34
      %996 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %997 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %998 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %999 = "llvm.sub"(%998, %945) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1000 = "llvm.lshr"(%997, %999) : (i32, i32) -> i32
      %1001 = "llvm.sub"(%945, %996) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1002 = "nvvm.shfl.sync"(%1000, %995, %806, %1001) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %1003 = "llvm.extractvalue"(%1002) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %1004 = "llvm.extractvalue"(%1002) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%1004)[^bb36, ^bb37] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %1005 = "llvm.fadd"(%995, %1003) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1005)[^bb38] : (f32) -> ()
    ^bb37:  // pred: ^bb35
      "llvm.br"(%995)[^bb38] : (f32) -> ()
    ^bb38(%1006: f32):  // 2 preds: ^bb36, ^bb37
      "llvm.br"(%1006)[^bb40] : (f32) -> ()
    ^bb39:  // pred: ^bb22
      %1007 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1008 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1009 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1010 = "llvm.sub"(%1009, %811) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1011 = "llvm.lshr"(%1008, %1010) : (i32, i32) -> i32
      %1012 = "llvm.sub"(%811, %1007) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1013 = "nvvm.shfl.sync"(%1011, %950, %810, %1012) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1014 = "llvm.fadd"(%950, %1013) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1015 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1016 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1017 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1018 = "llvm.sub"(%1017, %811) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1019 = "llvm.lshr"(%1016, %1018) : (i32, i32) -> i32
      %1020 = "llvm.sub"(%811, %1015) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1021 = "nvvm.shfl.sync"(%1019, %1014, %809, %1020) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1022 = "llvm.fadd"(%1014, %1021) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1023 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1024 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1025 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1026 = "llvm.sub"(%1025, %811) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1027 = "llvm.lshr"(%1024, %1026) : (i32, i32) -> i32
      %1028 = "llvm.sub"(%811, %1023) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1029 = "nvvm.shfl.sync"(%1027, %1022, %808, %1028) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1030 = "llvm.fadd"(%1022, %1029) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1031 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1032 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1033 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1034 = "llvm.sub"(%1033, %811) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1035 = "llvm.lshr"(%1032, %1034) : (i32, i32) -> i32
      %1036 = "llvm.sub"(%811, %1031) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1037 = "nvvm.shfl.sync"(%1035, %1030, %807, %1036) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1038 = "llvm.fadd"(%1030, %1037) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1039 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1040 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1041 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1042 = "llvm.sub"(%1041, %811) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1043 = "llvm.lshr"(%1040, %1042) : (i32, i32) -> i32
      %1044 = "llvm.sub"(%811, %1039) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1045 = "nvvm.shfl.sync"(%1043, %1038, %806, %1044) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1046 = "llvm.fadd"(%1038, %1045) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1046)[^bb40] : (f32) -> ()
    ^bb40(%1047: f32):  // 2 preds: ^bb38, ^bb39
      %1048 = "llvm.extractvalue"(%804) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %1049 = "llvm.getelementptr"(%1048, %805) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%1047, %1049) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb42] : () -> ()
    ^bb41:  // pred: ^bb21
      "llvm.br"()[^bb42] : () -> ()
    ^bb42:  // 2 preds: ^bb40, ^bb41
      "nvvm.barrier0"() : () -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_3"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<32 x i32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_gpu_all_reduce_region_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_all_reduce_region", visibility_ = 0 : i64}> ({
      %539 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_region_0}> : () -> !llvm.ptr<3>
      %540 = "llvm.getelementptr"(%539) <{elem_type = !llvm.array<32 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %541 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %542 = "llvm.insertvalue"(%541, %540) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %543 = "llvm.insertvalue"(%542, %540) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %544 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %545 = "llvm.insertvalue"(%543, %544) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %546 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %547 = "llvm.insertvalue"(%545, %546) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %548 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %549 = "llvm.insertvalue"(%547, %548) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %550 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %551 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %552 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %553 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %554 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %555 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %556 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %557 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %558 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %559 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %560 = "llvm.sext"(%559) : (i32) -> i64
      %561 = "llvm.trunc"(%560) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %562 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %563 = "llvm.sext"(%562) : (i32) -> i64
      %564 = "llvm.trunc"(%563) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %565 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %566 = "llvm.sext"(%565) : (i32) -> i64
      %567 = "llvm.trunc"(%566) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %568 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %569 = "llvm.sext"(%568) : (i32) -> i64
      %570 = "llvm.trunc"(%569) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %571 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %572 = "llvm.sext"(%571) : (i32) -> i64
      %573 = "llvm.trunc"(%572) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %574 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %575 = "llvm.sext"(%574) : (i32) -> i64
      %576 = "llvm.trunc"(%575) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %577 = "llvm.mul"(%576, %564) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %578 = "llvm.add"(%577, %573) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %579 = "llvm.mul"(%578, %561) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %580 = "llvm.mul"(%561, %564) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %581 = "llvm.add"(%579, %570) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %582 = "llvm.mul"(%580, %567) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %583 = "llvm.and"(%581, %557) : (i32, i32) -> i32
      %584 = "llvm.icmp"(%583, %556) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %585 = "llvm.sub"(%581, %583) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %586 = "llvm.sub"(%582, %585) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %587 = "llvm.icmp"(%586, %555) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%587)[^bb1, ^bb22] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %588 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %589 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %590 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %591 = "llvm.sub"(%590, %586) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %592 = "llvm.lshr"(%589, %591) : (i32, i32) -> i32
      %593 = "llvm.sub"(%586, %588) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %594 = "nvvm.shfl.sync"(%592, %558, %558, %593) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %595 = "llvm.extractvalue"(%594) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %596 = "llvm.extractvalue"(%594) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%596, %558)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb2:  // pred: ^bb1
      "llvm.br"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      %597 = "llvm.xor"(%595, %558) : (i32, i32) -> i32
      "llvm.br"(%597)[^bb4] : (i32) -> ()
    ^bb4(%598: i32):  // 2 preds: ^bb1, ^bb3
      "llvm.br"()[^bb5] : () -> ()
    ^bb5:  // pred: ^bb4
      %599 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %600 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %601 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %602 = "llvm.sub"(%601, %586) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %603 = "llvm.lshr"(%600, %602) : (i32, i32) -> i32
      %604 = "llvm.sub"(%586, %599) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %605 = "nvvm.shfl.sync"(%603, %598, %554, %604) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %606 = "llvm.extractvalue"(%605) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %607 = "llvm.extractvalue"(%605) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%607, %598)[^bb6, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb6:  // pred: ^bb5
      "llvm.br"()[^bb7] : () -> ()
    ^bb7:  // pred: ^bb6
      %608 = "llvm.xor"(%598, %606) : (i32, i32) -> i32
      "llvm.br"(%608)[^bb8] : (i32) -> ()
    ^bb8(%609: i32):  // 2 preds: ^bb5, ^bb7
      "llvm.br"()[^bb9] : () -> ()
    ^bb9:  // pred: ^bb8
      %610 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %611 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %612 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %613 = "llvm.sub"(%612, %586) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %614 = "llvm.lshr"(%611, %613) : (i32, i32) -> i32
      %615 = "llvm.sub"(%586, %610) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %616 = "nvvm.shfl.sync"(%614, %609, %553, %615) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %617 = "llvm.extractvalue"(%616) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %618 = "llvm.extractvalue"(%616) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%618, %609)[^bb10, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb10:  // pred: ^bb9
      "llvm.br"()[^bb11] : () -> ()
    ^bb11:  // pred: ^bb10
      %619 = "llvm.xor"(%609, %617) : (i32, i32) -> i32
      "llvm.br"(%619)[^bb12] : (i32) -> ()
    ^bb12(%620: i32):  // 2 preds: ^bb9, ^bb11
      "llvm.br"()[^bb13] : () -> ()
    ^bb13:  // pred: ^bb12
      %621 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %622 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %623 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %624 = "llvm.sub"(%623, %586) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %625 = "llvm.lshr"(%622, %624) : (i32, i32) -> i32
      %626 = "llvm.sub"(%586, %621) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %627 = "nvvm.shfl.sync"(%625, %620, %552, %626) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %628 = "llvm.extractvalue"(%627) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %629 = "llvm.extractvalue"(%627) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%629, %620)[^bb14, ^bb16] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb14:  // pred: ^bb13
      "llvm.br"()[^bb15] : () -> ()
    ^bb15:  // pred: ^bb14
      %630 = "llvm.xor"(%620, %628) : (i32, i32) -> i32
      "llvm.br"(%630)[^bb16] : (i32) -> ()
    ^bb16(%631: i32):  // 2 preds: ^bb13, ^bb15
      "llvm.br"()[^bb17] : () -> ()
    ^bb17:  // pred: ^bb16
      %632 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %633 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %634 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %635 = "llvm.sub"(%634, %586) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %636 = "llvm.lshr"(%633, %635) : (i32, i32) -> i32
      %637 = "llvm.sub"(%586, %632) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %638 = "nvvm.shfl.sync"(%636, %631, %551, %637) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %639 = "llvm.extractvalue"(%638) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %640 = "llvm.extractvalue"(%638) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%640, %631)[^bb18, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb18:  // pred: ^bb17
      "llvm.br"()[^bb19] : () -> ()
    ^bb19:  // pred: ^bb18
      %641 = "llvm.xor"(%631, %639) : (i32, i32) -> i32
      "llvm.br"(%641)[^bb20] : (i32) -> ()
    ^bb20(%642: i32):  // 2 preds: ^bb17, ^bb19
      "llvm.br"(%642)[^bb21] : (i32) -> ()
    ^bb21(%643: i32):  // 2 preds: ^bb20, ^bb31
      "llvm.br"()[^bb32] : () -> ()
    ^bb22:  // pred: ^bb0
      %644 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %645 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %646 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %647 = "llvm.sub"(%646, %555) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %648 = "llvm.lshr"(%645, %647) : (i32, i32) -> i32
      %649 = "llvm.sub"(%555, %644) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %650 = "nvvm.shfl.sync"(%648, %558, %558, %649) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb23] : () -> ()
    ^bb23:  // pred: ^bb22
      %651 = "llvm.xor"(%650, %558) : (i32, i32) -> i32
      "llvm.br"()[^bb24] : () -> ()
    ^bb24:  // pred: ^bb23
      %652 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %653 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %654 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %655 = "llvm.sub"(%654, %555) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %656 = "llvm.lshr"(%653, %655) : (i32, i32) -> i32
      %657 = "llvm.sub"(%555, %652) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %658 = "nvvm.shfl.sync"(%656, %651, %554, %657) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb25] : () -> ()
    ^bb25:  // pred: ^bb24
      %659 = "llvm.xor"(%651, %658) : (i32, i32) -> i32
      "llvm.br"()[^bb26] : () -> ()
    ^bb26:  // pred: ^bb25
      %660 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %661 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %662 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %663 = "llvm.sub"(%662, %555) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %664 = "llvm.lshr"(%661, %663) : (i32, i32) -> i32
      %665 = "llvm.sub"(%555, %660) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %666 = "nvvm.shfl.sync"(%664, %659, %553, %665) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb27] : () -> ()
    ^bb27:  // pred: ^bb26
      %667 = "llvm.xor"(%659, %666) : (i32, i32) -> i32
      "llvm.br"()[^bb28] : () -> ()
    ^bb28:  // pred: ^bb27
      %668 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %669 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %670 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %671 = "llvm.sub"(%670, %555) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %672 = "llvm.lshr"(%669, %671) : (i32, i32) -> i32
      %673 = "llvm.sub"(%555, %668) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %674 = "nvvm.shfl.sync"(%672, %667, %552, %673) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb29] : () -> ()
    ^bb29:  // pred: ^bb28
      %675 = "llvm.xor"(%667, %674) : (i32, i32) -> i32
      "llvm.br"()[^bb30] : () -> ()
    ^bb30:  // pred: ^bb29
      %676 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %677 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %678 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %679 = "llvm.sub"(%678, %555) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %680 = "llvm.lshr"(%677, %679) : (i32, i32) -> i32
      %681 = "llvm.sub"(%555, %676) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %682 = "nvvm.shfl.sync"(%680, %675, %551, %681) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb31] : () -> ()
    ^bb31:  // pred: ^bb30
      %683 = "llvm.xor"(%675, %682) : (i32, i32) -> i32
      "llvm.br"(%683)[^bb21] : (i32) -> ()
    ^bb32:  // pred: ^bb21
      "llvm.cond_br"(%584)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %684 = "llvm.sdiv"(%581, %555) : (i32, i32) -> i32
      %685 = "llvm.sext"(%684) : (i32) -> i64
      %686 = "llvm.extractvalue"(%549) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %687 = "llvm.getelementptr"(%686, %685) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%643, %687) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb35] : () -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"()[^bb35] : () -> ()
    ^bb35:  // 2 preds: ^bb33, ^bb34
      "nvvm.barrier0"() : () -> ()
      %688 = "llvm.add"(%582, %557) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %689 = "llvm.sdiv"(%688, %555) : (i32, i32) -> i32
      %690 = "llvm.icmp"(%581, %689) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%690)[^bb36, ^bb69] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %691 = "llvm.sext"(%581) : (i32) -> i64
      %692 = "llvm.extractvalue"(%549) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %693 = "llvm.getelementptr"(%692, %691) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      %694 = "llvm.load"(%693) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> i32
      %695 = "llvm.icmp"(%689, %555) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%695)[^bb37, ^bb58] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb37:  // pred: ^bb36
      %696 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %697 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %698 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %699 = "llvm.sub"(%698, %689) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %700 = "llvm.lshr"(%697, %699) : (i32, i32) -> i32
      %701 = "llvm.sub"(%689, %696) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %702 = "nvvm.shfl.sync"(%700, %694, %558, %701) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %703 = "llvm.extractvalue"(%702) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %704 = "llvm.extractvalue"(%702) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%704, %694)[^bb38, ^bb40] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb38:  // pred: ^bb37
      "llvm.br"()[^bb39] : () -> ()
    ^bb39:  // pred: ^bb38
      %705 = "llvm.xor"(%694, %703) : (i32, i32) -> i32
      "llvm.br"(%705)[^bb40] : (i32) -> ()
    ^bb40(%706: i32):  // 2 preds: ^bb37, ^bb39
      "llvm.br"()[^bb41] : () -> ()
    ^bb41:  // pred: ^bb40
      %707 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %708 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %709 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %710 = "llvm.sub"(%709, %689) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %711 = "llvm.lshr"(%708, %710) : (i32, i32) -> i32
      %712 = "llvm.sub"(%689, %707) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %713 = "nvvm.shfl.sync"(%711, %706, %554, %712) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %714 = "llvm.extractvalue"(%713) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %715 = "llvm.extractvalue"(%713) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%715, %706)[^bb42, ^bb44] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb42:  // pred: ^bb41
      "llvm.br"()[^bb43] : () -> ()
    ^bb43:  // pred: ^bb42
      %716 = "llvm.xor"(%706, %714) : (i32, i32) -> i32
      "llvm.br"(%716)[^bb44] : (i32) -> ()
    ^bb44(%717: i32):  // 2 preds: ^bb41, ^bb43
      "llvm.br"()[^bb45] : () -> ()
    ^bb45:  // pred: ^bb44
      %718 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %719 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %720 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %721 = "llvm.sub"(%720, %689) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %722 = "llvm.lshr"(%719, %721) : (i32, i32) -> i32
      %723 = "llvm.sub"(%689, %718) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %724 = "nvvm.shfl.sync"(%722, %717, %553, %723) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %725 = "llvm.extractvalue"(%724) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %726 = "llvm.extractvalue"(%724) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%726, %717)[^bb46, ^bb48] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb46:  // pred: ^bb45
      "llvm.br"()[^bb47] : () -> ()
    ^bb47:  // pred: ^bb46
      %727 = "llvm.xor"(%717, %725) : (i32, i32) -> i32
      "llvm.br"(%727)[^bb48] : (i32) -> ()
    ^bb48(%728: i32):  // 2 preds: ^bb45, ^bb47
      "llvm.br"()[^bb49] : () -> ()
    ^bb49:  // pred: ^bb48
      %729 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %730 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %731 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %732 = "llvm.sub"(%731, %689) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %733 = "llvm.lshr"(%730, %732) : (i32, i32) -> i32
      %734 = "llvm.sub"(%689, %729) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %735 = "nvvm.shfl.sync"(%733, %728, %552, %734) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %736 = "llvm.extractvalue"(%735) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %737 = "llvm.extractvalue"(%735) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%737, %728)[^bb50, ^bb52] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb50:  // pred: ^bb49
      "llvm.br"()[^bb51] : () -> ()
    ^bb51:  // pred: ^bb50
      %738 = "llvm.xor"(%728, %736) : (i32, i32) -> i32
      "llvm.br"(%738)[^bb52] : (i32) -> ()
    ^bb52(%739: i32):  // 2 preds: ^bb49, ^bb51
      "llvm.br"()[^bb53] : () -> ()
    ^bb53:  // pred: ^bb52
      %740 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %741 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %742 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %743 = "llvm.sub"(%742, %689) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %744 = "llvm.lshr"(%741, %743) : (i32, i32) -> i32
      %745 = "llvm.sub"(%689, %740) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %746 = "nvvm.shfl.sync"(%744, %739, %551, %745) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %747 = "llvm.extractvalue"(%746) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %748 = "llvm.extractvalue"(%746) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%748, %739)[^bb54, ^bb56] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb54:  // pred: ^bb53
      "llvm.br"()[^bb55] : () -> ()
    ^bb55:  // pred: ^bb54
      %749 = "llvm.xor"(%739, %747) : (i32, i32) -> i32
      "llvm.br"(%749)[^bb56] : (i32) -> ()
    ^bb56(%750: i32):  // 2 preds: ^bb53, ^bb55
      "llvm.br"(%750)[^bb57] : (i32) -> ()
    ^bb57(%751: i32):  // 2 preds: ^bb56, ^bb67
      "llvm.br"()[^bb68] : () -> ()
    ^bb58:  // pred: ^bb36
      %752 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %753 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %754 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %755 = "llvm.sub"(%754, %555) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %756 = "llvm.lshr"(%753, %755) : (i32, i32) -> i32
      %757 = "llvm.sub"(%555, %752) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %758 = "nvvm.shfl.sync"(%756, %694, %558, %757) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb59] : () -> ()
    ^bb59:  // pred: ^bb58
      %759 = "llvm.xor"(%694, %758) : (i32, i32) -> i32
      "llvm.br"()[^bb60] : () -> ()
    ^bb60:  // pred: ^bb59
      %760 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %761 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %762 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %763 = "llvm.sub"(%762, %555) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %764 = "llvm.lshr"(%761, %763) : (i32, i32) -> i32
      %765 = "llvm.sub"(%555, %760) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %766 = "nvvm.shfl.sync"(%764, %759, %554, %765) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb61] : () -> ()
    ^bb61:  // pred: ^bb60
      %767 = "llvm.xor"(%759, %766) : (i32, i32) -> i32
      "llvm.br"()[^bb62] : () -> ()
    ^bb62:  // pred: ^bb61
      %768 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %769 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %770 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %771 = "llvm.sub"(%770, %555) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %772 = "llvm.lshr"(%769, %771) : (i32, i32) -> i32
      %773 = "llvm.sub"(%555, %768) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %774 = "nvvm.shfl.sync"(%772, %767, %553, %773) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb63] : () -> ()
    ^bb63:  // pred: ^bb62
      %775 = "llvm.xor"(%767, %774) : (i32, i32) -> i32
      "llvm.br"()[^bb64] : () -> ()
    ^bb64:  // pred: ^bb63
      %776 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %777 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %778 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %779 = "llvm.sub"(%778, %555) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %780 = "llvm.lshr"(%777, %779) : (i32, i32) -> i32
      %781 = "llvm.sub"(%555, %776) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %782 = "nvvm.shfl.sync"(%780, %775, %552, %781) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb65] : () -> ()
    ^bb65:  // pred: ^bb64
      %783 = "llvm.xor"(%775, %782) : (i32, i32) -> i32
      "llvm.br"()[^bb66] : () -> ()
    ^bb66:  // pred: ^bb65
      %784 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %785 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %786 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %787 = "llvm.sub"(%786, %555) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %788 = "llvm.lshr"(%785, %787) : (i32, i32) -> i32
      %789 = "llvm.sub"(%555, %784) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %790 = "nvvm.shfl.sync"(%788, %783, %551, %789) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb67] : () -> ()
    ^bb67:  // pred: ^bb66
      %791 = "llvm.xor"(%783, %790) : (i32, i32) -> i32
      "llvm.br"(%791)[^bb57] : (i32) -> ()
    ^bb68:  // pred: ^bb57
      %792 = "llvm.extractvalue"(%549) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %793 = "llvm.getelementptr"(%792, %550) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%751, %793) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb70] : () -> ()
    ^bb69:  // pred: ^bb35
      "llvm.br"()[^bb70] : () -> ()
    ^bb70:  // 2 preds: ^bb68, ^bb69
      "nvvm.barrier0"() : () -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_4"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f32, f32, i1, i1, i1, i1)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffle", visibility_ = 0 : i64}> ({
      %492 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %493 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %494 = "llvm.mlir.constant"() <{value = 23 : i32}> : () -> i32
      %495 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %496 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %497 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %498 = "llvm.sub"(%497, %494) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %499 = "llvm.lshr"(%496, %498) : (i32, i32) -> i32
      %500 = "llvm.sub"(%494, %495) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %501 = "nvvm.shfl.sync"(%499, %492, %493, %500) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %502 = "llvm.extractvalue"(%501) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %503 = "llvm.extractvalue"(%501) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %504 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %505 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %506 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %507 = "llvm.sub"(%506, %494) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %508 = "llvm.lshr"(%505, %507) : (i32, i32) -> i32
      %509 = "nvvm.shfl.sync"(%508, %492, %493, %507) <{kind = #nvvm<shfl_kind up>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %510 = "llvm.extractvalue"(%509) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %511 = "llvm.extractvalue"(%509) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %512 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %513 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %514 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %515 = "llvm.sub"(%514, %494) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %516 = "llvm.lshr"(%513, %515) : (i32, i32) -> i32
      %517 = "llvm.sub"(%494, %512) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %518 = "nvvm.shfl.sync"(%516, %492, %493, %517) <{kind = #nvvm<shfl_kind down>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %519 = "llvm.extractvalue"(%518) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %520 = "llvm.extractvalue"(%518) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %521 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %522 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %523 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %524 = "llvm.sub"(%523, %494) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %525 = "llvm.lshr"(%522, %524) : (i32, i32) -> i32
      %526 = "llvm.sub"(%494, %521) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %527 = "nvvm.shfl.sync"(%525, %492, %493, %526) <{kind = #nvvm<shfl_kind idx>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %528 = "llvm.extractvalue"(%527) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %529 = "llvm.extractvalue"(%527) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %530 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %531 = "llvm.insertvalue"(%530, %502) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %532 = "llvm.insertvalue"(%531, %510) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %533 = "llvm.insertvalue"(%532, %519) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %534 = "llvm.insertvalue"(%533, %528) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %535 = "llvm.insertvalue"(%534, %503) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %536 = "llvm.insertvalue"(%535, %511) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %537 = "llvm.insertvalue"(%536, %520) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %538 = "llvm.insertvalue"(%537, %529) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      "llvm.return"(%538) : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_shuffle", visibility_ = 0 : i64}> ({
    ^bb0(%arg251: !llvm.ptr):
      %491 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_shuffle, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      "llvm.store"(%491, %arg251) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f32, f32)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffle_unused_pred", visibility_ = 0 : i64}> ({
      %456 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %457 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %458 = "llvm.mlir.constant"() <{value = 23 : i32}> : () -> i32
      %459 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %460 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %461 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %462 = "llvm.sub"(%461, %458) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %463 = "llvm.lshr"(%460, %462) : (i32, i32) -> i32
      %464 = "llvm.sub"(%458, %459) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %465 = "nvvm.shfl.sync"(%463, %456, %457, %464) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %466 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %467 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %468 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %469 = "llvm.sub"(%468, %458) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %470 = "llvm.lshr"(%467, %469) : (i32, i32) -> i32
      %471 = "nvvm.shfl.sync"(%470, %456, %457, %469) <{kind = #nvvm<shfl_kind up>}> : (i32, f32, i32, i32) -> f32
      %472 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %473 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %474 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %475 = "llvm.sub"(%474, %458) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %476 = "llvm.lshr"(%473, %475) : (i32, i32) -> i32
      %477 = "llvm.sub"(%458, %472) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %478 = "nvvm.shfl.sync"(%476, %456, %457, %477) <{kind = #nvvm<shfl_kind down>}> : (i32, f32, i32, i32) -> f32
      %479 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %480 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %481 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %482 = "llvm.sub"(%481, %458) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %483 = "llvm.lshr"(%480, %482) : (i32, i32) -> i32
      %484 = "llvm.sub"(%458, %479) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %485 = "nvvm.shfl.sync"(%483, %456, %457, %484) <{kind = #nvvm<shfl_kind idx>}> : (i32, f32, i32, i32) -> f32
      %486 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32, f32)>
      %487 = "llvm.insertvalue"(%486, %465) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %488 = "llvm.insertvalue"(%487, %471) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %489 = "llvm.insertvalue"(%488, %478) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %490 = "llvm.insertvalue"(%489, %485) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      "llvm.return"(%490) : (!llvm.struct<(f32, f32, f32, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_shuffle_unused_pred", visibility_ = 0 : i64}> ({
    ^bb0(%arg250: !llvm.ptr):
      %455 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_shuffle_unused_pred, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(f32, f32, f32, f32)>
      "llvm.store"(%455, %arg250) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f32, f32, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_5"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_sync", visibility_ = 0 : i64}> ({
      "nvvm.barrier0"() : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_sync", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_sync, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_6"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fabsf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fabs", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_fabs", visibility_ = 0 : i64}> ({
    ^bb0(%arg248: f32, %arg249: f64):
      %450 = "llvm.call"(%arg248) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fabsf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %451 = "llvm.call"(%arg249) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fabs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %452 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %453 = "llvm.insertvalue"(%452, %450) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %454 = "llvm.insertvalue"(%453, %451) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%454) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_fabs", visibility_ = 0 : i64}> ({
    ^bb0(%arg245: !llvm.ptr, %arg246: f32, %arg247: f64):
      %449 = "llvm.call"(%arg246, %arg247) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_fabs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%449, %arg245) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_7"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cbrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cbrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cbrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg243: f32, %arg244: f64):
      %444 = "llvm.call"(%arg243) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cbrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %445 = "llvm.call"(%arg244) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cbrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %446 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %447 = "llvm.insertvalue"(%446, %444) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %448 = "llvm.insertvalue"(%447, %445) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%448) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_cbrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg240: !llvm.ptr, %arg241: f32, %arg242: f64):
      %443 = "llvm.call"(%arg241, %arg242) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_cbrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%443, %arg240) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_8"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_ceilf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_ceil", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_ceil", visibility_ = 0 : i64}> ({
    ^bb0(%arg238: f32, %arg239: f64):
      %438 = "llvm.call"(%arg238) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_ceilf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %439 = "llvm.call"(%arg239) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_ceil, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %440 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %441 = "llvm.insertvalue"(%440, %438) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %442 = "llvm.insertvalue"(%441, %439) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%442) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_ceil", visibility_ = 0 : i64}> ({
    ^bb0(%arg235: !llvm.ptr, %arg236: f32, %arg237: f64):
      %437 = "llvm.call"(%arg236, %arg237) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_ceil, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%437, %arg235) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_9"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_floorf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_floor", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_floor", visibility_ = 0 : i64}> ({
    ^bb0(%arg233: f32, %arg234: f64):
      %432 = "llvm.call"(%arg233) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_floorf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %433 = "llvm.call"(%arg234) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_floor, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %434 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %435 = "llvm.insertvalue"(%434, %432) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %436 = "llvm.insertvalue"(%435, %433) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%436) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_floor", visibility_ = 0 : i64}> ({
    ^bb0(%arg230: !llvm.ptr, %arg231: f32, %arg232: f64):
      %431 = "llvm.call"(%arg231, %arg232) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_floor, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%431, %arg230) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_10"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cos", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_cosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cos", visibility_ = 0 : i64}> ({
    ^bb0(%arg228: f32, %arg229: f64):
      %424 = "llvm.call"(%arg228) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %425 = "llvm.call"(%arg229) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %426 = "llvm.call"(%arg228) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_cosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %427 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %428 = "llvm.insertvalue"(%427, %424) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %429 = "llvm.insertvalue"(%428, %425) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %430 = "llvm.insertvalue"(%429, %426) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%430) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_cos", visibility_ = 0 : i64}> ({
    ^bb0(%arg225: !llvm.ptr, %arg226: f32, %arg227: f64):
      %423 = "llvm.call"(%arg226, %arg227) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_cos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%423, %arg225) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_11"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_exp", visibility_ = 0 : i64}> ({
    ^bb0(%arg223: f32, %arg224: f64):
      %416 = "llvm.call"(%arg223) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %417 = "llvm.call"(%arg224) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %418 = "llvm.call"(%arg223) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %419 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %420 = "llvm.insertvalue"(%419, %416) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %421 = "llvm.insertvalue"(%420, %417) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %422 = "llvm.insertvalue"(%421, %418) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%422) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_exp", visibility_ = 0 : i64}> ({
    ^bb0(%arg220: !llvm.ptr, %arg221: f32, %arg222: f64):
      %415 = "llvm.call"(%arg221, %arg222) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%415, %arg220) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_12"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_exp2", visibility_ = 0 : i64}> ({
    ^bb0(%arg218: f32, %arg219: f64):
      %410 = "llvm.call"(%arg218) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %411 = "llvm.call"(%arg219) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %412 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %413 = "llvm.insertvalue"(%412, %410) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %414 = "llvm.insertvalue"(%413, %411) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%414) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_exp2", visibility_ = 0 : i64}> ({
    ^bb0(%arg215: !llvm.ptr, %arg216: f32, %arg217: f64):
      %409 = "llvm.call"(%arg216, %arg217) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_exp2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%409, %arg215) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_13"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_logf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_logf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log", visibility_ = 0 : i64}> ({
    ^bb0(%arg213: f32, %arg214: f64):
      %402 = "llvm.call"(%arg213) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_logf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %403 = "llvm.call"(%arg214) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %404 = "llvm.call"(%arg213) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_logf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %405 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %406 = "llvm.insertvalue"(%405, %402) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %407 = "llvm.insertvalue"(%406, %403) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %408 = "llvm.insertvalue"(%407, %404) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%408) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_log", visibility_ = 0 : i64}> ({
    ^bb0(%arg210: !llvm.ptr, %arg211: f32, %arg212: f64):
      %401 = "llvm.call"(%arg211, %arg212) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_log, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%401, %arg210) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_14"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log10f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log10", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_log10f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log10", visibility_ = 0 : i64}> ({
    ^bb0(%arg208: f32, %arg209: f64):
      %394 = "llvm.call"(%arg208) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log10f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %395 = "llvm.call"(%arg209) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log10, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %396 = "llvm.call"(%arg208) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_log10f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %397 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %398 = "llvm.insertvalue"(%397, %394) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %399 = "llvm.insertvalue"(%398, %395) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %400 = "llvm.insertvalue"(%399, %396) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%400) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_log10", visibility_ = 0 : i64}> ({
    ^bb0(%arg205: !llvm.ptr, %arg206: f32, %arg207: f64):
      %393 = "llvm.call"(%arg206, %arg207) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_log10, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%393, %arg205) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_15"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log1pf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log1p", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log1p", visibility_ = 0 : i64}> ({
    ^bb0(%arg203: f32, %arg204: f64):
      %388 = "llvm.call"(%arg203) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log1pf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %389 = "llvm.call"(%arg204) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log1p, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %390 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %391 = "llvm.insertvalue"(%390, %388) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %392 = "llvm.insertvalue"(%391, %389) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%392) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_log1p", visibility_ = 0 : i64}> ({
    ^bb0(%arg200: !llvm.ptr, %arg201: f32, %arg202: f64):
      %387 = "llvm.call"(%arg201, %arg202) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_log1p, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%387, %arg200) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_16"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_log2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log2", visibility_ = 0 : i64}> ({
    ^bb0(%arg198: f32, %arg199: f64):
      %380 = "llvm.call"(%arg198) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %381 = "llvm.call"(%arg199) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %382 = "llvm.call"(%arg198) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_log2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %383 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %384 = "llvm.insertvalue"(%383, %380) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %385 = "llvm.insertvalue"(%384, %381) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %386 = "llvm.insertvalue"(%385, %382) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%386) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_log2", visibility_ = 0 : i64}> ({
    ^bb0(%arg195: !llvm.ptr, %arg196: f32, %arg197: f64):
      %379 = "llvm.call"(%arg196, %arg197) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_log2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%379, %arg195) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_17"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sin", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_sinf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sin", visibility_ = 0 : i64}> ({
    ^bb0(%arg193: f32, %arg194: f64):
      %372 = "llvm.call"(%arg193) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %373 = "llvm.call"(%arg194) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %374 = "llvm.call"(%arg193) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %375 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %376 = "llvm.insertvalue"(%375, %372) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %377 = "llvm.insertvalue"(%376, %373) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %378 = "llvm.insertvalue"(%377, %374) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%378) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_sin", visibility_ = 0 : i64}> ({
    ^bb0(%arg190: !llvm.ptr, %arg191: f32, %arg192: f64):
      %371 = "llvm.call"(%arg191, %arg192) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_sin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%371, %arg190) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_18"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tan", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_tanf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64, f32)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_tan", visibility_ = 0 : i64}> ({
    ^bb0(%arg187: f16, %arg188: f32, %arg189: f64):
      %360 = "llvm.fpext"(%arg187) : (f16) -> f32
      %361 = "llvm.call"(%360) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %362 = "llvm.fptrunc"(%361) : (f32) -> f16
      %363 = "llvm.call"(%arg188) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %364 = "llvm.call"(%arg189) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %365 = "llvm.call"(%arg188) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %366 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64, f32)>
      %367 = "llvm.insertvalue"(%366, %362) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64, f32)>, f16) -> !llvm.struct<(f16, f32, f64, f32)>
      %368 = "llvm.insertvalue"(%367, %363) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64, f32)>, f32) -> !llvm.struct<(f16, f32, f64, f32)>
      %369 = "llvm.insertvalue"(%368, %364) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64, f32)>, f64) -> !llvm.struct<(f16, f32, f64, f32)>
      %370 = "llvm.insertvalue"(%369, %365) <{position = array<i64: 3>}> : (!llvm.struct<(f16, f32, f64, f32)>, f32) -> !llvm.struct<(f16, f32, f64, f32)>
      "llvm.return"(%370) : (!llvm.struct<(f16, f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_tan", visibility_ = 0 : i64}> ({
    ^bb0(%arg183: !llvm.ptr, %arg184: f16, %arg185: f32, %arg186: f64):
      %359 = "llvm.call"(%arg184, %arg185, %arg186) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_tan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64, f32)>
      "llvm.store"(%359, %arg183) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_19"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_tanh", visibility_ = 0 : i64}> ({
    ^bb0(%arg180: f16, %arg181: f32, %arg182: f64):
      %350 = "llvm.fpext"(%arg180) : (f16) -> f32
      %351 = "llvm.call"(%350) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %352 = "llvm.fptrunc"(%351) : (f32) -> f16
      %353 = "llvm.call"(%arg181) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %354 = "llvm.call"(%arg182) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %355 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %356 = "llvm.insertvalue"(%355, %352) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %357 = "llvm.insertvalue"(%356, %353) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %358 = "llvm.insertvalue"(%357, %354) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%358) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_tanh", visibility_ = 0 : i64}> ({
    ^bb0(%arg176: !llvm.ptr, %arg177: f16, %arg178: f32, %arg179: f64):
      %349 = "llvm.call"(%arg177, %arg178, %arg179) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_tanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%349, %arg176) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_20"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rsqrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rsqrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_rsqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg173: f16, %arg174: f32, %arg175: f64):
      %340 = "llvm.fpext"(%arg173) : (f16) -> f32
      %341 = "llvm.call"(%340) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %342 = "llvm.fptrunc"(%341) : (f32) -> f16
      %343 = "llvm.call"(%arg174) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %344 = "llvm.call"(%arg175) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %345 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %346 = "llvm.insertvalue"(%345, %342) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %347 = "llvm.insertvalue"(%346, %343) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %348 = "llvm.insertvalue"(%347, %344) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%348) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_rsqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg169: !llvm.ptr, %arg170: f16, %arg171: f32, %arg172: f64):
      %339 = "llvm.call"(%arg170, %arg171, %arg172) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_rsqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%339, %arg169) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_21"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sqrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sqrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg166: f16, %arg167: f32, %arg168: f64):
      %330 = "llvm.fpext"(%arg166) : (f16) -> f32
      %331 = "llvm.call"(%330) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %332 = "llvm.fptrunc"(%331) : (f32) -> f16
      %333 = "llvm.call"(%arg167) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %334 = "llvm.call"(%arg168) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %335 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %336 = "llvm.insertvalue"(%335, %332) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %337 = "llvm.insertvalue"(%336, %333) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %338 = "llvm.insertvalue"(%337, %334) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%338) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_sqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg162: !llvm.ptr, %arg163: f16, %arg164: f32, %arg165: f64):
      %329 = "llvm.call"(%arg163, %arg164, %arg165) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_sqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%329, %arg162) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_22"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atan", visibility_ = 0 : i64}> ({
    ^bb0(%arg159: f16, %arg160: f32, %arg161: f64):
      %320 = "llvm.fpext"(%arg159) : (f16) -> f32
      %321 = "llvm.call"(%320) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %322 = "llvm.fptrunc"(%321) : (f32) -> f16
      %323 = "llvm.call"(%arg160) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %324 = "llvm.call"(%arg161) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %325 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %326 = "llvm.insertvalue"(%325, %322) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %327 = "llvm.insertvalue"(%326, %323) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %328 = "llvm.insertvalue"(%327, %324) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%328) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_atan", visibility_ = 0 : i64}> ({
    ^bb0(%arg155: !llvm.ptr, %arg156: f16, %arg157: f32, %arg158: f64):
      %319 = "llvm.call"(%arg156, %arg157, %arg158) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_atan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%319, %arg155) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_23"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atan2", visibility_ = 0 : i64}> ({
    ^bb0(%arg152: f16, %arg153: f32, %arg154: f64):
      %309 = "llvm.fpext"(%arg152) : (f16) -> f32
      %310 = "llvm.fpext"(%arg152) : (f16) -> f32
      %311 = "llvm.call"(%309, %310) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %312 = "llvm.fptrunc"(%311) : (f32) -> f16
      %313 = "llvm.call"(%arg153, %arg153) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %314 = "llvm.call"(%arg154, %arg154) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %315 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %316 = "llvm.insertvalue"(%315, %312) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %317 = "llvm.insertvalue"(%316, %313) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %318 = "llvm.insertvalue"(%317, %314) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%318) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_atan2", visibility_ = 0 : i64}> ({
    ^bb0(%arg148: !llvm.ptr, %arg149: f16, %arg150: f32, %arg151: f64):
      %308 = "llvm.call"(%arg149, %arg150, %arg151) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_atan2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%308, %arg148) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_24"}> ({
    "test.symbol_scope"() ({
      "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
      }) : () -> ()
      "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp", visibility_ = 0 : i64}> ({
      }) : () -> ()
      "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_expf", visibility_ = 0 : i64}> ({
      }) : () -> ()
      "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_exp", visibility_ = 0 : i64}> ({
      ^bb0(%arg146: f32, %arg147: f64):
        %301 = "llvm.call"(%arg146) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
        %302 = "llvm.call"(%arg147) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
        %303 = "llvm.call"(%arg146) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
        %304 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
        %305 = "llvm.insertvalue"(%304, %301) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
        %306 = "llvm.insertvalue"(%305, %302) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
        %307 = "llvm.insertvalue"(%306, %303) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
        "llvm.return"(%307) : (!llvm.struct<(f32, f64, f32)>) -> ()
      }) : () -> ()
      "test.finish"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_25"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expm1f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expm1", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_expm1", visibility_ = 0 : i64}> ({
    ^bb0(%arg144: f32, %arg145: f64):
      %296 = "llvm.call"(%arg144) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expm1f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %297 = "llvm.call"(%arg145) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expm1, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %298 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %299 = "llvm.insertvalue"(%298, %296) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %300 = "llvm.insertvalue"(%299, %297) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%300) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_expm1", visibility_ = 0 : i64}> ({
    ^bb0(%arg141: !llvm.ptr, %arg142: f32, %arg143: f64):
      %295 = "llvm.call"(%arg142, %arg143) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_expm1, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%295, %arg141) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_26"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_powf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_pow", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_powf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_pow", visibility_ = 0 : i64}> ({
    ^bb0(%arg139: f32, %arg140: f64):
      %288 = "llvm.call"(%arg139, %arg139) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %289 = "llvm.call"(%arg140, %arg140) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_pow, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %290 = "llvm.call"(%arg139, %arg139) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_powf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %291 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %292 = "llvm.insertvalue"(%291, %288) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %293 = "llvm.insertvalue"(%292, %289) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %294 = "llvm.insertvalue"(%293, %290) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%294) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_pow", visibility_ = 0 : i64}> ({
    ^bb0(%arg136: !llvm.ptr, %arg137: f32, %arg138: f64):
      %287 = "llvm.call"(%arg137, %arg138) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_pow, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%287, %arg136) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_27"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xf32> (vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "gpu_unroll", visibility_ = 0 : i64}> ({
    ^bb0(%arg135: vector<4xf32>):
      %270 = "llvm.mlir.poison"() : () -> vector<4xf32>
      %271 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
      %272 = "llvm.extractelement"(%arg135, %271) : (vector<4xf32>, i64) -> f32
      %273 = "llvm.call"(%272) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %274 = "llvm.insertelement"(%270, %273, %271) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %275 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
      %276 = "llvm.extractelement"(%arg135, %275) : (vector<4xf32>, i64) -> f32
      %277 = "llvm.call"(%276) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %278 = "llvm.insertelement"(%274, %277, %275) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %279 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
      %280 = "llvm.extractelement"(%arg135, %279) : (vector<4xf32>, i64) -> f32
      %281 = "llvm.call"(%280) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %282 = "llvm.insertelement"(%278, %281, %279) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %283 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
      %284 = "llvm.extractelement"(%arg135, %283) : (vector<4xf32>, i64) -> f32
      %285 = "llvm.call"(%284) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %286 = "llvm.insertelement"(%282, %285, %283) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      "llvm.return"(%286) : (vector<4xf32>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xf32> (vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_unroll", visibility_ = 0 : i64}> ({
    ^bb0(%arg134: vector<4xf32>):
      %269 = "llvm.call"(%arg134) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_unroll, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (vector<4xf32>) -> vector<4xf32>
      "llvm.return"(%269) : (vector<4xf32>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_28"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "kernel_func", visibility_ = 0 : i64}> ({
      "llvm.return"() : () -> ()
    }) {gpu.kernel, nvvm.kernel} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_29"}> ({
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<11 x i8>, linkage = #llvm.linkage<internal>, sym_name = "printfFormat_1", value = "Hello: %d\0A\00", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<14 x i8>, linkage = #llvm.linkage<internal>, sym_name = "printfFormat_0", value = "Hello, world\0A\00", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "vprintf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "test_const_printf", visibility_ = 0 : i64}> ({
      %259 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
      %260 = "llvm.getelementptr"(%259) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %261 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %262 = "llvm.alloca"(%261) <{elem_type = !llvm.struct<()>}> : (i64) -> !llvm.ptr
      %263 = "llvm.call"(%260, %262) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      %264 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
      %265 = "llvm.getelementptr"(%264) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %266 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %267 = "llvm.alloca"(%266) <{elem_type = !llvm.struct<()>}> : (i64) -> !llvm.ptr
      %268 = "llvm.call"(%265, %267) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, f32)>, linkage = #llvm.linkage<external>, sym_name = "test_printf", visibility_ = 0 : i64}> ({
    ^bb0(%arg132: i32, %arg133: f32):
      %251 = "llvm.mlir.addressof"() <{global_name = @printfFormat_1}> : () -> !llvm.ptr
      %252 = "llvm.getelementptr"(%251) <{elem_type = !llvm.array<11 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %253 = "llvm.fpext"(%arg133) : (f32) -> f64
      %254 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %255 = "llvm.alloca"(%254) <{elem_type = !llvm.struct<(i32, f64)>}> : (i64) -> !llvm.ptr
      %256 = "llvm.getelementptr"(%255) <{elem_type = !llvm.struct<(i32, f64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      "llvm.store"(%arg132, %256) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      %257 = "llvm.getelementptr"(%255) <{elem_type = !llvm.struct<(i32, f64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
      "llvm.store"(%253, %257) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
      %258 = "llvm.call"(%252, %255) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_30"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_add", visibility_ = 0 : i64}> ({
    ^bb0(%arg131: i32):
      %249 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %250 = "nvvm.redux.sync"(%arg131, %249) <{abs = false, kind = #nvvm<redux_kind add>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_minsi", visibility_ = 0 : i64}> ({
    ^bb0(%arg130: i32):
      %247 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %248 = "nvvm.redux.sync"(%arg130, %247) <{abs = false, kind = #nvvm<redux_kind min>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_maxsi", visibility_ = 0 : i64}> ({
    ^bb0(%arg129: i32):
      %245 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %246 = "nvvm.redux.sync"(%arg129, %245) <{abs = false, kind = #nvvm<redux_kind max>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_and", visibility_ = 0 : i64}> ({
    ^bb0(%arg128: i32):
      %243 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %244 = "nvvm.redux.sync"(%arg128, %243) <{abs = false, kind = #nvvm<redux_kind and>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_or", visibility_ = 0 : i64}> ({
    ^bb0(%arg127: i32):
      %241 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %242 = "nvvm.redux.sync"(%arg127, %241) <{abs = false, kind = #nvvm<redux_kind or>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_xor", visibility_ = 0 : i64}> ({
    ^bb0(%arg126: i32):
      %239 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %240 = "nvvm.redux.sync"(%arg126, %239) <{abs = false, kind = #nvvm<redux_kind xor>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_31"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmodf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmod", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_fmod", visibility_ = 0 : i64}> ({
    ^bb0(%arg124: f32, %arg125: f64):
      %234 = "llvm.call"(%arg124, %arg124) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmodf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %235 = "llvm.call"(%arg125, %arg125) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmod, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %236 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %237 = "llvm.insertvalue"(%236, %234) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %238 = "llvm.insertvalue"(%237, %235) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%238) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_fmod", visibility_ = 0 : i64}> ({
    ^bb0(%arg121: !llvm.ptr, %arg122: f32, %arg123: f64):
      %233 = "llvm.call"(%arg122, %arg123) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_fmod, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%233, %arg121) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_32"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erff", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_erf", visibility_ = 0 : i64}> ({
    ^bb0(%arg119: f32, %arg120: f64):
      %228 = "llvm.call"(%arg119) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erff, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %229 = "llvm.call"(%arg120) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %230 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %231 = "llvm.insertvalue"(%230, %228) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %232 = "llvm.insertvalue"(%231, %229) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%232) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_erf", visibility_ = 0 : i64}> ({
    ^bb0(%arg116: !llvm.ptr, %arg117: f32, %arg118: f64):
      %227 = "llvm.call"(%arg117, %arg118) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_erf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%227, %arg116) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_33"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_block_size", visibility_ = 0 : i64}> ({
    ^bb0(%arg115: !llvm.ptr):
      %219 = "nvvm.read.ptx.sreg.tid.x"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %220 = "llvm.sext"(%219) : (i32) -> i64
      %221 = "nvvm.read.ptx.sreg.tid.y"() <{range = #llvm.constant_range<i32, 0, 4>}> : () -> i32
      %222 = "llvm.sext"(%221) : (i32) -> i64
      %223 = "nvvm.read.ptx.sreg.tid.z"() <{range = #llvm.constant_range<i32, 0, 2>}> : () -> i32
      %224 = "llvm.sext"(%223) : (i32) -> i64
      %225 = "llvm.add"(%220, %222) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %226 = "llvm.add"(%225, %224) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.store"(%226, %arg115) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_block_size = array<i32: 32, 4, 2>, nvvm.kernel, nvvm.maxntid = array<i32: 32, 4, 2>} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_34"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)> (ptr, ptr, i64, i64, i64, f32)>, linkage = #llvm.linkage<external>, sym_name = "memref_signature", visibility_ = 0 : i64}> ({
    ^bb0(%arg109: !llvm.ptr, %arg110: !llvm.ptr, %arg111: i64, %arg112: i64, %arg113: i64, %arg114: f32):
      %210 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %211 = "llvm.insertvalue"(%210, %arg109) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %212 = "llvm.insertvalue"(%211, %arg110) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %213 = "llvm.insertvalue"(%212, %arg111) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %214 = "llvm.insertvalue"(%213, %arg112) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %215 = "llvm.insertvalue"(%214, %arg113) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %216 = "llvm.mlir.poison"() : () -> !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>
      %217 = "llvm.insertvalue"(%216, %215) <{position = array<i64: 0>}> : (!llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>
      %218 = "llvm.insertvalue"(%217, %arg114) <{position = array<i64: 1>}> : (!llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>, f32) -> !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>
      "llvm.return"(%218) : (!llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_35"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acos", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_acos", visibility_ = 0 : i64}> ({
    ^bb0(%arg107: f32, %arg108: f64):
      %205 = "llvm.call"(%arg107) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %206 = "llvm.call"(%arg108) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %207 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %208 = "llvm.insertvalue"(%207, %205) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %209 = "llvm.insertvalue"(%208, %206) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%209) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_acos", visibility_ = 0 : i64}> ({
    ^bb0(%arg104: !llvm.ptr, %arg105: f32, %arg106: f64):
      %204 = "llvm.call"(%arg105, %arg106) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_acos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%204, %arg104) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_36"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acoshf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acosh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_acosh", visibility_ = 0 : i64}> ({
    ^bb0(%arg102: f32, %arg103: f64):
      %199 = "llvm.call"(%arg102) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acoshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %200 = "llvm.call"(%arg103) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %201 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %202 = "llvm.insertvalue"(%201, %199) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %203 = "llvm.insertvalue"(%202, %200) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%203) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_acosh", visibility_ = 0 : i64}> ({
    ^bb0(%arg99: !llvm.ptr, %arg100: f32, %arg101: f64):
      %198 = "llvm.call"(%arg100, %arg101) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_acosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%198, %arg99) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_37"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asinf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asin", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_asin", visibility_ = 0 : i64}> ({
    ^bb0(%arg97: f32, %arg98: f64):
      %193 = "llvm.call"(%arg97) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %194 = "llvm.call"(%arg98) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %195 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %196 = "llvm.insertvalue"(%195, %193) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %197 = "llvm.insertvalue"(%196, %194) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%197) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_asin", visibility_ = 0 : i64}> ({
    ^bb0(%arg94: !llvm.ptr, %arg95: f32, %arg96: f64):
      %192 = "llvm.call"(%arg95, %arg96) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_asin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%192, %arg94) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_38"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asinhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asinh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_asinh", visibility_ = 0 : i64}> ({
    ^bb0(%arg92: f32, %arg93: f64):
      %187 = "llvm.call"(%arg92) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %188 = "llvm.call"(%arg93) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %189 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %190 = "llvm.insertvalue"(%189, %187) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %191 = "llvm.insertvalue"(%190, %188) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%191) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_asinh", visibility_ = 0 : i64}> ({
    ^bb0(%arg89: !llvm.ptr, %arg90: f32, %arg91: f64):
      %186 = "llvm.call"(%arg90, %arg91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_asinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%186, %arg89) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_39"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atanh", visibility_ = 0 : i64}> ({
    ^bb0(%arg86: f16, %arg87: f32, %arg88: f64):
      %177 = "llvm.fpext"(%arg86) : (f16) -> f32
      %178 = "llvm.call"(%177) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %179 = "llvm.fptrunc"(%178) : (f32) -> f16
      %180 = "llvm.call"(%arg87) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %181 = "llvm.call"(%arg88) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %182 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %183 = "llvm.insertvalue"(%182, %179) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %184 = "llvm.insertvalue"(%183, %180) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %185 = "llvm.insertvalue"(%184, %181) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%185) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_atanh", visibility_ = 0 : i64}> ({
    ^bb0(%arg82: !llvm.ptr, %arg83: f16, %arg84: f32, %arg85: f64):
      %176 = "llvm.call"(%arg83, %arg84, %arg85) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_atanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%176, %arg82) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_40"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_copysignf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_copysign", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_copysign", visibility_ = 0 : i64}> ({
    ^bb0(%arg80: f32, %arg81: f64):
      %171 = "llvm.call"(%arg80, %arg80) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_copysignf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %172 = "llvm.call"(%arg81, %arg81) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_copysign, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %173 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %174 = "llvm.insertvalue"(%173, %171) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %175 = "llvm.insertvalue"(%174, %172) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%175) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_copysign", visibility_ = 0 : i64}> ({
    ^bb0(%arg77: !llvm.ptr, %arg78: f32, %arg79: f64):
      %170 = "llvm.call"(%arg78, %arg79) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_copysign, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%170, %arg77) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_41"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_coshf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cosh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cosh", visibility_ = 0 : i64}> ({
    ^bb0(%arg75: f32, %arg76: f64):
      %165 = "llvm.call"(%arg75) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_coshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %166 = "llvm.call"(%arg76) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %167 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %168 = "llvm.insertvalue"(%167, %165) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %169 = "llvm.insertvalue"(%168, %166) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%169) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_cosh", visibility_ = 0 : i64}> ({
    ^bb0(%arg72: !llvm.ptr, %arg73: f32, %arg74: f64):
      %164 = "llvm.call"(%arg73, %arg74) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_cosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%164, %arg72) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_42"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmaf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fma", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_fma", visibility_ = 0 : i64}> ({
    ^bb0(%arg70: f32, %arg71: f64):
      %159 = "llvm.call"(%arg70, %arg70, %arg70) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmaf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, f32, f32) -> f32
      %160 = "llvm.call"(%arg71, %arg71, %arg71) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fma, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f64, f64, f64) -> f64
      %161 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %162 = "llvm.insertvalue"(%161, %159) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %163 = "llvm.insertvalue"(%162, %160) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%163) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_fma", visibility_ = 0 : i64}> ({
    ^bb0(%arg67: !llvm.ptr, %arg68: f32, %arg69: f64):
      %158 = "llvm.call"(%arg68, %arg69) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_fma, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%158, %arg67) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_43"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_roundf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_round", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_round", visibility_ = 0 : i64}> ({
    ^bb0(%arg65: f32, %arg66: f64):
      %153 = "llvm.call"(%arg65) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_roundf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %154 = "llvm.call"(%arg66) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_round, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %155 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %156 = "llvm.insertvalue"(%155, %153) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %157 = "llvm.insertvalue"(%156, %154) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%157) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_round", visibility_ = 0 : i64}> ({
    ^bb0(%arg62: !llvm.ptr, %arg63: f32, %arg64: f64):
      %152 = "llvm.call"(%arg63, %arg64) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_round, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%152, %arg62) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_44"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rintf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rint", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_roundeven", visibility_ = 0 : i64}> ({
    ^bb0(%arg60: f32, %arg61: f64):
      %147 = "llvm.call"(%arg60) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %148 = "llvm.call"(%arg61) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rint, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %149 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %150 = "llvm.insertvalue"(%149, %147) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %151 = "llvm.insertvalue"(%150, %148) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%151) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_roundeven", visibility_ = 0 : i64}> ({
    ^bb0(%arg57: !llvm.ptr, %arg58: f32, %arg59: f64):
      %146 = "llvm.call"(%arg58, %arg59) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_roundeven, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%146, %arg57) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_45"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sinh", visibility_ = 0 : i64}> ({
    ^bb0(%arg55: f32, %arg56: f64):
      %141 = "llvm.call"(%arg55) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %142 = "llvm.call"(%arg56) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %143 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %144 = "llvm.insertvalue"(%143, %141) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %145 = "llvm.insertvalue"(%144, %142) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%145) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_sinh", visibility_ = 0 : i64}> ({
    ^bb0(%arg52: !llvm.ptr, %arg53: f32, %arg54: f64):
      %140 = "llvm.call"(%arg53, %arg54) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_sinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%140, %arg52) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_46"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_coshf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cosh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cosh_with_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg50: f32, %arg51: f64):
      %135 = "llvm.call"(%arg50) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_coshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %136 = "llvm.call"(%arg51) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %137 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %138 = "llvm.insertvalue"(%137, %135) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %139 = "llvm.insertvalue"(%138, %136) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%139) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_cosh_with_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg47: !llvm.ptr, %arg48: f32, %arg49: f64):
      %134 = "llvm.call"(%arg48, %arg49) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_cosh_with_fastmath, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%134, %arg47) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_47"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sinh_with_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg45: f32, %arg46: f64):
      %129 = "llvm.call"(%arg45) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %130 = "llvm.call"(%arg46) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %131 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %132 = "llvm.insertvalue"(%131, %129) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %133 = "llvm.insertvalue"(%132, %130) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%133) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_sinh_with_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg42: !llvm.ptr, %arg43: f32, %arg44: f64):
      %128 = "llvm.call"(%arg43, %arg44) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_sinh_with_fastmath, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%128, %arg42) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_48"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_exp_with_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg40: f32, %arg41: f64):
      %121 = "llvm.call"(%arg40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %122 = "llvm.call"(%arg41) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %123 = "llvm.call"(%arg40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %124 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %125 = "llvm.insertvalue"(%124, %121) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %126 = "llvm.insertvalue"(%125, %122) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %127 = "llvm.insertvalue"(%126, %123) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%127) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_exp_with_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg37: !llvm.ptr, %arg38: f32, %arg39: f64):
      %120 = "llvm.call"(%arg38, %arg39) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_exp_with_fastmath, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%120, %arg37) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_49"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, i64, i64)> ()>, linkage = #llvm.linkage<external>, sym_name = "explicit_id_bounds", visibility_ = 0 : i64}> ({
      %110 = "nvvm.read.ptx.sreg.tid.x"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %111 = "llvm.sext"(%110) : (i32) -> i64
      %112 = "nvvm.read.ptx.sreg.ntid.x"() <{range = #llvm.constant_range<i32, 1, 33>}> : () -> i32
      %113 = "llvm.sext"(%112) : (i32) -> i64
      %114 = "nvvm.read.ptx.sreg.laneid"() <{range = #llvm.constant_range<i32, 0, 16>}> : () -> i32
      %115 = "llvm.sext"(%114) : (i32) -> i64
      %116 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, i64, i64)>
      %117 = "llvm.insertvalue"(%116, %111) <{position = array<i64: 0>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
      %118 = "llvm.insertvalue"(%117, %113) <{position = array<i64: 1>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
      %119 = "llvm.insertvalue"(%118, %115) <{position = array<i64: 2>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
      "llvm.return"(%119) : (!llvm.struct<(i64, i64, i64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_explicit_id_bounds", visibility_ = 0 : i64}> ({
    ^bb0(%arg36: !llvm.ptr):
      %109 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @explicit_id_bounds, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(i64, i64, i64)>
      "llvm.store"(%109, %arg36) <{ordering = 0 : i64}> : (!llvm.struct<(i64, i64, i64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_50"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_grid_size", visibility_ = 0 : i64}> ({
    ^bb0(%arg35: !llvm.ptr):
      %101 = "nvvm.read.ptx.sreg.ctaid.x"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %102 = "llvm.sext"(%101) : (i32) -> i64
      %103 = "nvvm.read.ptx.sreg.ctaid.y"() <{range = #llvm.constant_range<i32, 0, 4>}> : () -> i32
      %104 = "llvm.sext"(%103) : (i32) -> i64
      %105 = "nvvm.read.ptx.sreg.ctaid.z"() <{range = #llvm.constant_range<i32, 0, 2>}> : () -> i32
      %106 = "llvm.sext"(%105) : (i32) -> i64
      %107 = "llvm.add"(%102, %104) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %108 = "llvm.add"(%107, %106) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.store"(%108, %arg35) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_grid_size = array<i32: 32, 4, 2>, nvvm.kernel} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_51"}> ({
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<10 x i8>, linkage = #llvm.linkage<internal>, sym_name = "assert_func_0", value = "(unknown)\00", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<77 x i8>, linkage = #llvm.linkage<internal>, sym_name = "assert_file_0", value = "/home/zq/coding/llvm-project/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm.mlir\00", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<15 x i8>, linkage = #llvm.linkage<internal>, sym_name = "assert_message_0", value = "assert message\00", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i32, ptr, i64)>, linkage = #llvm.linkage<external>, passthrough = ["noreturn"], sym_name = "__assertfail", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1)>, linkage = #llvm.linkage<external>, sym_name = "test_assert", visibility_ = 0 : i64}> ({
    ^bb0(%arg34: i1):
      "llvm.cond_br"(%arg34)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %93 = "llvm.mlir.addressof"() <{global_name = @assert_message_0}> : () -> !llvm.ptr
      %94 = "llvm.getelementptr"(%93) <{elem_type = !llvm.array<15 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %95 = "llvm.mlir.addressof"() <{global_name = @assert_file_0}> : () -> !llvm.ptr
      %96 = "llvm.getelementptr"(%95) <{elem_type = !llvm.array<77 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %97 = "llvm.mlir.addressof"() <{global_name = @assert_func_0}> : () -> !llvm.ptr
      %98 = "llvm.getelementptr"(%97) <{elem_type = !llvm.array<10 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %99 = "llvm.mlir.constant"() <{value = 998 : i32}> : () -> i32
      %100 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
      "llvm.call"(%94, %96, %99, %98, %100) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__assertfail, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (!llvm.ptr, !llvm.ptr, i32, !llvm.ptr, i64) -> ()
      "llvm.br"()[^bb2] : () -> ()
    ^bb2:  // 2 preds: ^bb0, ^bb1
      "llvm.return"() : () -> ()
    }) {gpu.kernel, nvvm.kernel} : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg33: !transform.any_op):
      %92 = "transform.structured.match"(%arg33) <{ops = ["gpu.module"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%92) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.gpu_rewrite_patterns"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.apply_conversion_patterns"(%92) <{illegal_dialects = ["gpu"], illegal_ops = ["llvm.copysign", "llvm.cos", "llvm.exp", "llvm.exp2", "llvm.fabs", "llvm.fceil", "llvm.ffloor", "llvm.frem", "llvm.log", "llvm.log10", "llvm.log2", "llvm.pow", "llvm.roundeven", "llvm.round", "llvm.sin", "llvm.sqrt"], legal_dialects = ["llvm", "memref", "nvvm", "test"], legal_ops = ["func.func", "gpu.module", "gpu.yield"], partial_conversion}> ({
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "arith"}> : () -> ()
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "cf"}> : () -> ()
        "transform.apply_conversion_patterns.vector.vector_to_llvm"() <{force_32bit_vector_indices = true, reassociate_fp_reductions = false, use_vector_alignment = false}> : () -> ()
        "transform.apply_conversion_patterns.func.func_to_llvm"() : () -> ()
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "memref"}> : () -> ()
        "transform.apply_conversion_patterns.gpu.gpu_to_nvvm"() <{benefit = 10 : i16}> : () -> ()
        "transform.apply_conversion_patterns.gpu.gpu_wmma_to_nvvm"() : () -> ()
        "transform.apply_conversion_patterns.gpu.gpu_subgroup_reduce_to_nvvm"() : () -> ()
        "transform.apply_conversion_patterns.nvgpu.nvgpu_to_nvvm"() : () -> ()
      }, {
        "transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter"() <{index_bitwidth = 64 : i64, use_bare_ptr_call_conv = false}> : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
  "gpu.module"() <{sym_name = "test_module_52"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_abs", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "gpu_abs", visibility_ = 0 : i64}> ({
    ^bb0(%arg32: i32):
      %91 = "llvm.call"(%arg32) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_abs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i32
      "llvm.return"(%91) : (i32) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_abs", visibility_ = 0 : i64}> ({
    ^bb0(%arg31: i32):
      %90 = "llvm.call"(%arg31) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_abs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i32
      "llvm.return"(%90) : (i32) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_53"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, i32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_powif", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, i32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_powi", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64, i32)>, linkage = #llvm.linkage<external>, sym_name = "gpu_powi", visibility_ = 0 : i64}> ({
    ^bb0(%arg28: f32, %arg29: f64, %arg30: i32):
      %85 = "llvm.call"(%arg28, %arg30) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powif, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, i32) -> f32
      %86 = "llvm.call"(%arg29, %arg30) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powi, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, i32) -> f64
      %87 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %88 = "llvm.insertvalue"(%87, %85) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %89 = "llvm.insertvalue"(%88, %86) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%89) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64, i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_powi", visibility_ = 0 : i64}> ({
    ^bb0(%arg24: !llvm.ptr, %arg25: f32, %arg26: f64, %arg27: i32):
      %84 = "llvm.call"(%arg25, %arg26, %arg27) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_powi, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, f64, i32) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%84, %arg24) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_54"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_isinff", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_isinfd", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_isnanf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_isnand", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_finitef", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_isfinited", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i1, i1, i1, i1, i1, i1)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "fpclassify", visibility_ = 0 : i64}> ({
    ^bb0(%arg22: f32, %arg23: f64):
      %59 = "llvm.call"(%arg22) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isinff, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> i32
      %60 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %61 = "llvm.icmp"(%59, %60) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %62 = "llvm.call"(%arg23) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isinfd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> i32
      %63 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %64 = "llvm.icmp"(%62, %63) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %65 = "llvm.call"(%arg22) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isnanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> i32
      %66 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %67 = "llvm.icmp"(%65, %66) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %68 = "llvm.call"(%arg23) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isnand, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> i32
      %69 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %70 = "llvm.icmp"(%68, %69) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %71 = "llvm.call"(%arg22) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_finitef, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> i32
      %72 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %73 = "llvm.icmp"(%71, %72) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %74 = "llvm.call"(%arg23) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isfinited, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> i32
      %75 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %76 = "llvm.icmp"(%74, %75) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %77 = "llvm.mlir.poison"() : () -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %78 = "llvm.insertvalue"(%77, %61) <{position = array<i64: 0>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %79 = "llvm.insertvalue"(%78, %64) <{position = array<i64: 1>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %80 = "llvm.insertvalue"(%79, %67) <{position = array<i64: 2>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %81 = "llvm.insertvalue"(%80, %70) <{position = array<i64: 3>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %82 = "llvm.insertvalue"(%81, %73) <{position = array<i64: 4>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %83 = "llvm.insertvalue"(%82, %76) <{position = array<i64: 5>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      "llvm.return"(%83) : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_fpclassify", visibility_ = 0 : i64}> ({
    ^bb0(%arg19: !llvm.ptr, %arg20: f32, %arg21: f64):
      %58 = "llvm.call"(%arg20, %arg21) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @fpclassify, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      "llvm.store"(%58, %arg19) <{ordering = 0 : i64}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_55"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erfcf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erfc", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_erfc", visibility_ = 0 : i64}> ({
    ^bb0(%arg17: f32, %arg18: f64):
      %53 = "llvm.call"(%arg17) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erfcf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %54 = "llvm.call"(%arg18) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erfc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %55 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %56 = "llvm.insertvalue"(%55, %53) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %57 = "llvm.insertvalue"(%56, %54) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%57) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_erfc", visibility_ = 0 : i64}> ({
    ^bb0(%arg14: !llvm.ptr, %arg15: f32, %arg16: f64):
      %52 = "llvm.call"(%arg15, %arg16) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_erfc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%52, %arg14) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_56"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sincosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f64, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sincos", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f16, f32, f32, f64, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sincos", visibility_ = 0 : i64}> ({
    ^bb0(%arg11: f16, %arg12: f32, %arg13: f64):
      %27 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %28 = "llvm.alloca"(%27) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %29 = "llvm.alloca"(%27) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %30 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %31 = "llvm.alloca"(%30) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %32 = "llvm.alloca"(%30) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %33 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %34 = "llvm.alloca"(%33) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %35 = "llvm.alloca"(%33) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %36 = "llvm.fpext"(%arg11) : (f16) -> f32
      "llvm.call"(%36, %34, %35) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %37 = "llvm.load"(%34) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %38 = "llvm.load"(%35) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %39 = "llvm.fptrunc"(%37) : (f32) -> f16
      %40 = "llvm.fptrunc"(%38) : (f32) -> f16
      "llvm.call"(%arg12, %31, %32) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %41 = "llvm.load"(%31) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %42 = "llvm.load"(%32) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      "llvm.call"(%arg13, %28, %29) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f64, !llvm.ptr, !llvm.ptr) -> ()
      %43 = "llvm.load"(%28) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %44 = "llvm.load"(%29) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %45 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %46 = "llvm.insertvalue"(%45, %39) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %47 = "llvm.insertvalue"(%46, %40) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %48 = "llvm.insertvalue"(%47, %41) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %49 = "llvm.insertvalue"(%48, %42) <{position = array<i64: 3>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %50 = "llvm.insertvalue"(%49, %43) <{position = array<i64: 4>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %51 = "llvm.insertvalue"(%50, %44) <{position = array<i64: 5>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      "llvm.return"(%51) : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_sincos", visibility_ = 0 : i64}> ({
    ^bb0(%arg7: !llvm.ptr, %arg8: f16, %arg9: f32, %arg10: f64):
      %26 = "llvm.call"(%arg8, %arg9, %arg10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_sincos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      "llvm.store"(%26, %arg7) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_sincosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f16, f32, f32, f64, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sincos_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %2 = "llvm.alloca"(%1) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %3 = "llvm.alloca"(%1) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %4 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %5 = "llvm.alloca"(%4) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %6 = "llvm.alloca"(%4) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %7 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %8 = "llvm.alloca"(%7) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %9 = "llvm.alloca"(%7) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %10 = "llvm.fpext"(%arg4) : (f16) -> f32
      "llvm.call"(%10, %8, %9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %11 = "llvm.load"(%8) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %12 = "llvm.load"(%9) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %13 = "llvm.fptrunc"(%11) : (f32) -> f16
      %14 = "llvm.fptrunc"(%12) : (f32) -> f16
      "llvm.call"(%arg5, %5, %6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %15 = "llvm.load"(%5) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %16 = "llvm.load"(%6) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      "llvm.call"(%arg6, %2, %3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f64, !llvm.ptr, !llvm.ptr) -> ()
      %17 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %18 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %19 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %20 = "llvm.insertvalue"(%19, %13) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %21 = "llvm.insertvalue"(%20, %14) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %22 = "llvm.insertvalue"(%21, %15) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %23 = "llvm.insertvalue"(%22, %16) <{position = array<i64: 3>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %24 = "llvm.insertvalue"(%23, %17) <{position = array<i64: 4>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %25 = "llvm.insertvalue"(%24, %18) <{position = array<i64: 5>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      "llvm.return"(%25) : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_sincos_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_sincos_fastmath, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_cluster_size"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_cluster_size", visibility_ = 0 : i64}> ({
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_cluster_size = array<i32: 8, 2, 4>, nvvm.cluster_dim = array<i32: 8, 2, 4>, nvvm.kernel} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_cluster_block_ops"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_cluster_size", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr):
      %0 = "nvvm.read.ptx.sreg.cluster.ctaid.x"() <{range = #llvm.constant_range<i32, 0, 8>}> : () -> i32
      %1 = "llvm.sext"(%0) : (i32) -> i64
      %2 = "nvvm.read.ptx.sreg.cluster.ctaid.y"() <{range = #llvm.constant_range<i32, 0, 4>}> : () -> i32
      %3 = "llvm.sext"(%2) : (i32) -> i64
      %4 = "nvvm.read.ptx.sreg.cluster.ctaid.z"() <{range = #llvm.constant_range<i32, 0, 2>}> : () -> i32
      %5 = "llvm.sext"(%4) : (i32) -> i64
      %6 = "nvvm.read.ptx.sreg.cluster.nctaid.x"() <{range = #llvm.constant_range<i32, 1, 9>}> : () -> i32
      %7 = "llvm.sext"(%6) : (i32) -> i64
      %8 = "nvvm.read.ptx.sreg.cluster.nctaid.y"() <{range = #llvm.constant_range<i32, 1, 5>}> : () -> i32
      %9 = "llvm.sext"(%8) : (i32) -> i64
      %10 = "nvvm.read.ptx.sreg.cluster.nctaid.z"() <{range = #llvm.constant_range<i32, 1, 3>}> : () -> i32
      %11 = "llvm.sext"(%10) : (i32) -> i64
      %12 = "llvm.add"(%1, %3) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %13 = "llvm.add"(%12, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %14 = "llvm.add"(%13, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %15 = "llvm.add"(%14, %9) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %16 = "llvm.add"(%15, %11) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.store"(%16, %arg0) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_cluster_size = array<i32: 8, 4, 2>, nvvm.cluster_dim = array<i32: 8, 4, 2>, nvvm.kernel} : () -> ()
  }) : () -> ()
}) : () -> ()


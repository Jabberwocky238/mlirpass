"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_0"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_ops", visibility_ = 0 : i64}> ({
      %1067 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %1068 = "llvm.sext"(%1067) : (i32) -> i64
      %1069 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %1070 = "llvm.sext"(%1069) : (i32) -> i64
      %1071 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %1072 = "llvm.sext"(%1071) : (i32) -> i64
      %1073 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %1074 = "llvm.sext"(%1073) : (i32) -> i64
      %1075 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %1076 = "llvm.sext"(%1075) : (i32) -> i64
      %1077 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %1078 = "llvm.sext"(%1077) : (i32) -> i64
      %1079 = "nvvm.read.ptx.sreg.ctaid.x"() : () -> i32
      %1080 = "llvm.sext"(%1079) : (i32) -> i64
      %1081 = "nvvm.read.ptx.sreg.ctaid.y"() : () -> i32
      %1082 = "llvm.sext"(%1081) : (i32) -> i64
      %1083 = "nvvm.read.ptx.sreg.ctaid.z"() : () -> i32
      %1084 = "llvm.sext"(%1083) : (i32) -> i64
      %1085 = "nvvm.read.ptx.sreg.nctaid.x"() : () -> i32
      %1086 = "llvm.sext"(%1085) : (i32) -> i64
      %1087 = "nvvm.read.ptx.sreg.nctaid.y"() : () -> i32
      %1088 = "llvm.sext"(%1087) : (i32) -> i64
      %1089 = "nvvm.read.ptx.sreg.nctaid.z"() : () -> i32
      %1090 = "llvm.sext"(%1089) : (i32) -> i64
      %1091 = "nvvm.read.ptx.sreg.laneid"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %1092 = "llvm.sext"(%1091) : (i32) -> i64
      %1093 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1094 = "llvm.insertvalue"(%1093, %1068) <{position = array<i64: 0>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1095 = "llvm.insertvalue"(%1094, %1070) <{position = array<i64: 1>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1096 = "llvm.insertvalue"(%1095, %1072) <{position = array<i64: 2>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1097 = "llvm.insertvalue"(%1096, %1074) <{position = array<i64: 3>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1098 = "llvm.insertvalue"(%1097, %1076) <{position = array<i64: 4>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1099 = "llvm.insertvalue"(%1098, %1078) <{position = array<i64: 5>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1100 = "llvm.insertvalue"(%1099, %1080) <{position = array<i64: 6>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1101 = "llvm.insertvalue"(%1100, %1082) <{position = array<i64: 7>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1102 = "llvm.insertvalue"(%1101, %1084) <{position = array<i64: 8>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1103 = "llvm.insertvalue"(%1102, %1086) <{position = array<i64: 9>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1104 = "llvm.insertvalue"(%1103, %1088) <{position = array<i64: 10>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1105 = "llvm.insertvalue"(%1104, %1090) <{position = array<i64: 11>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1106 = "llvm.insertvalue"(%1105, %1092) <{position = array<i64: 12>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      "llvm.return"(%1106) : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_comp", visibility_ = 0 : i64}> ({
    ^bb0(%arg118: i64):
      %1066 = "llvm.add"(%arg118, %arg118) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.return"(%1066) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_2"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<32 x f32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_gpu_all_reduce_op_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_all_reduce_op", visibility_ = 0 : i64}> ({
      %810 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_op_0}> : () -> !llvm.ptr<3>
      %811 = "llvm.getelementptr"(%810) <{elem_type = !llvm.array<32 x f32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %812 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %813 = "llvm.insertvalue"(%812, %811) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %814 = "llvm.insertvalue"(%813, %811) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %815 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %816 = "llvm.insertvalue"(%814, %815) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %817 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %818 = "llvm.insertvalue"(%816, %817) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %819 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %820 = "llvm.insertvalue"(%818, %819) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %821 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %822 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %823 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %824 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %825 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %826 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %827 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %828 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %829 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %830 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %831 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %832 = "llvm.sext"(%831) : (i32) -> i64
      %833 = "llvm.trunc"(%832) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %834 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %835 = "llvm.sext"(%834) : (i32) -> i64
      %836 = "llvm.trunc"(%835) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %837 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %838 = "llvm.sext"(%837) : (i32) -> i64
      %839 = "llvm.trunc"(%838) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %840 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %841 = "llvm.sext"(%840) : (i32) -> i64
      %842 = "llvm.trunc"(%841) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %843 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %844 = "llvm.sext"(%843) : (i32) -> i64
      %845 = "llvm.trunc"(%844) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %846 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %847 = "llvm.sext"(%846) : (i32) -> i64
      %848 = "llvm.trunc"(%847) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %849 = "llvm.mul"(%848, %836) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %850 = "llvm.add"(%849, %845) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %851 = "llvm.mul"(%850, %833) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %852 = "llvm.mul"(%833, %836) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %853 = "llvm.add"(%851, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %854 = "llvm.mul"(%852, %839) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %855 = "llvm.and"(%853, %829) : (i32, i32) -> i32
      %856 = "llvm.icmp"(%855, %828) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %857 = "llvm.sub"(%853, %855) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %858 = "llvm.sub"(%854, %857) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %859 = "llvm.icmp"(%858, %827) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%859)[^bb1, ^bb17] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %860 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %861 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %862 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %863 = "llvm.sub"(%862, %858) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %864 = "llvm.lshr"(%861, %863) : (i32, i32) -> i32
      %865 = "llvm.sub"(%858, %860) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %866 = "nvvm.shfl.sync"(%864, %830, %826, %865) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %867 = "llvm.extractvalue"(%866) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %868 = "llvm.extractvalue"(%866) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%868)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %869 = "llvm.fadd"(%867, %830) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%869)[^bb4] : (f32) -> ()
    ^bb3:  // pred: ^bb1
      "llvm.br"(%830)[^bb4] : (f32) -> ()
    ^bb4(%870: f32):  // 2 preds: ^bb2, ^bb3
      %871 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %872 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %873 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %874 = "llvm.sub"(%873, %858) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %875 = "llvm.lshr"(%872, %874) : (i32, i32) -> i32
      %876 = "llvm.sub"(%858, %871) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %877 = "nvvm.shfl.sync"(%875, %870, %825, %876) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %878 = "llvm.extractvalue"(%877) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %879 = "llvm.extractvalue"(%877) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%879)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb5:  // pred: ^bb4
      %880 = "llvm.fadd"(%870, %878) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%880)[^bb7] : (f32) -> ()
    ^bb6:  // pred: ^bb4
      "llvm.br"(%870)[^bb7] : (f32) -> ()
    ^bb7(%881: f32):  // 2 preds: ^bb5, ^bb6
      %882 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %883 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %884 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %885 = "llvm.sub"(%884, %858) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %886 = "llvm.lshr"(%883, %885) : (i32, i32) -> i32
      %887 = "llvm.sub"(%858, %882) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %888 = "nvvm.shfl.sync"(%886, %881, %824, %887) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %889 = "llvm.extractvalue"(%888) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %890 = "llvm.extractvalue"(%888) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%890)[^bb8, ^bb9] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb8:  // pred: ^bb7
      %891 = "llvm.fadd"(%881, %889) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%891)[^bb10] : (f32) -> ()
    ^bb9:  // pred: ^bb7
      "llvm.br"(%881)[^bb10] : (f32) -> ()
    ^bb10(%892: f32):  // 2 preds: ^bb8, ^bb9
      %893 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %894 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %895 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %896 = "llvm.sub"(%895, %858) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %897 = "llvm.lshr"(%894, %896) : (i32, i32) -> i32
      %898 = "llvm.sub"(%858, %893) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %899 = "nvvm.shfl.sync"(%897, %892, %823, %898) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %900 = "llvm.extractvalue"(%899) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %901 = "llvm.extractvalue"(%899) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%901)[^bb11, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb11:  // pred: ^bb10
      %902 = "llvm.fadd"(%892, %900) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%902)[^bb13] : (f32) -> ()
    ^bb12:  // pred: ^bb10
      "llvm.br"(%892)[^bb13] : (f32) -> ()
    ^bb13(%903: f32):  // 2 preds: ^bb11, ^bb12
      %904 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %905 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %906 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %907 = "llvm.sub"(%906, %858) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %908 = "llvm.lshr"(%905, %907) : (i32, i32) -> i32
      %909 = "llvm.sub"(%858, %904) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %910 = "nvvm.shfl.sync"(%908, %903, %822, %909) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %911 = "llvm.extractvalue"(%910) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %912 = "llvm.extractvalue"(%910) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%912)[^bb14, ^bb15] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb14:  // pred: ^bb13
      %913 = "llvm.fadd"(%903, %911) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%913)[^bb16] : (f32) -> ()
    ^bb15:  // pred: ^bb13
      "llvm.br"(%903)[^bb16] : (f32) -> ()
    ^bb16(%914: f32):  // 2 preds: ^bb14, ^bb15
      "llvm.br"(%914)[^bb18] : (f32) -> ()
    ^bb17:  // pred: ^bb0
      %915 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %916 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %917 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %918 = "llvm.sub"(%917, %827) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %919 = "llvm.lshr"(%916, %918) : (i32, i32) -> i32
      %920 = "llvm.sub"(%827, %915) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %921 = "nvvm.shfl.sync"(%919, %830, %826, %920) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %922 = "llvm.fadd"(%921, %830) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %923 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %924 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %925 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %926 = "llvm.sub"(%925, %827) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %927 = "llvm.lshr"(%924, %926) : (i32, i32) -> i32
      %928 = "llvm.sub"(%827, %923) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %929 = "nvvm.shfl.sync"(%927, %922, %825, %928) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %930 = "llvm.fadd"(%922, %929) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %931 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %932 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %933 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %934 = "llvm.sub"(%933, %827) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %935 = "llvm.lshr"(%932, %934) : (i32, i32) -> i32
      %936 = "llvm.sub"(%827, %931) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %937 = "nvvm.shfl.sync"(%935, %930, %824, %936) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %938 = "llvm.fadd"(%930, %937) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %939 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %940 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %941 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %942 = "llvm.sub"(%941, %827) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %943 = "llvm.lshr"(%940, %942) : (i32, i32) -> i32
      %944 = "llvm.sub"(%827, %939) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %945 = "nvvm.shfl.sync"(%943, %938, %823, %944) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %946 = "llvm.fadd"(%938, %945) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %947 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %948 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %949 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %950 = "llvm.sub"(%949, %827) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %951 = "llvm.lshr"(%948, %950) : (i32, i32) -> i32
      %952 = "llvm.sub"(%827, %947) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %953 = "nvvm.shfl.sync"(%951, %946, %822, %952) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %954 = "llvm.fadd"(%946, %953) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%954)[^bb18] : (f32) -> ()
    ^bb18(%955: f32):  // 2 preds: ^bb16, ^bb17
      "llvm.cond_br"(%856)[^bb19, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb19:  // pred: ^bb18
      %956 = "llvm.sdiv"(%853, %827) : (i32, i32) -> i32
      %957 = "llvm.sext"(%956) : (i32) -> i64
      %958 = "llvm.extractvalue"(%820) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %959 = "llvm.getelementptr"(%958, %957) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%955, %959) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb21] : () -> ()
    ^bb20:  // pred: ^bb18
      "llvm.br"()[^bb21] : () -> ()
    ^bb21:  // 2 preds: ^bb19, ^bb20
      "nvvm.barrier"() <{aligned = true, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      %960 = "llvm.add"(%854, %829) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %961 = "llvm.sdiv"(%960, %827) : (i32, i32) -> i32
      %962 = "llvm.icmp"(%853, %961) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%962)[^bb22, ^bb41] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb22:  // pred: ^bb21
      %963 = "llvm.sext"(%853) : (i32) -> i64
      %964 = "llvm.extractvalue"(%820) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %965 = "llvm.getelementptr"(%964, %963) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      %966 = "llvm.load"(%965) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f32
      %967 = "llvm.icmp"(%961, %827) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%967)[^bb23, ^bb39] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb23:  // pred: ^bb22
      %968 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %969 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %970 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %971 = "llvm.sub"(%970, %961) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %972 = "llvm.lshr"(%969, %971) : (i32, i32) -> i32
      %973 = "llvm.sub"(%961, %968) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %974 = "nvvm.shfl.sync"(%972, %966, %826, %973) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %975 = "llvm.extractvalue"(%974) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %976 = "llvm.extractvalue"(%974) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%976)[^bb24, ^bb25] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb24:  // pred: ^bb23
      %977 = "llvm.fadd"(%966, %975) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%977)[^bb26] : (f32) -> ()
    ^bb25:  // pred: ^bb23
      "llvm.br"(%966)[^bb26] : (f32) -> ()
    ^bb26(%978: f32):  // 2 preds: ^bb24, ^bb25
      %979 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %980 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %981 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %982 = "llvm.sub"(%981, %961) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %983 = "llvm.lshr"(%980, %982) : (i32, i32) -> i32
      %984 = "llvm.sub"(%961, %979) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %985 = "nvvm.shfl.sync"(%983, %978, %825, %984) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %986 = "llvm.extractvalue"(%985) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %987 = "llvm.extractvalue"(%985) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%987)[^bb27, ^bb28] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb27:  // pred: ^bb26
      %988 = "llvm.fadd"(%978, %986) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%988)[^bb29] : (f32) -> ()
    ^bb28:  // pred: ^bb26
      "llvm.br"(%978)[^bb29] : (f32) -> ()
    ^bb29(%989: f32):  // 2 preds: ^bb27, ^bb28
      %990 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %991 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %992 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %993 = "llvm.sub"(%992, %961) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %994 = "llvm.lshr"(%991, %993) : (i32, i32) -> i32
      %995 = "llvm.sub"(%961, %990) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %996 = "nvvm.shfl.sync"(%994, %989, %824, %995) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %997 = "llvm.extractvalue"(%996) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %998 = "llvm.extractvalue"(%996) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%998)[^bb30, ^bb31] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb30:  // pred: ^bb29
      %999 = "llvm.fadd"(%989, %997) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%999)[^bb32] : (f32) -> ()
    ^bb31:  // pred: ^bb29
      "llvm.br"(%989)[^bb32] : (f32) -> ()
    ^bb32(%1000: f32):  // 2 preds: ^bb30, ^bb31
      %1001 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1002 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1003 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1004 = "llvm.sub"(%1003, %961) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1005 = "llvm.lshr"(%1002, %1004) : (i32, i32) -> i32
      %1006 = "llvm.sub"(%961, %1001) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1007 = "nvvm.shfl.sync"(%1005, %1000, %823, %1006) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %1008 = "llvm.extractvalue"(%1007) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %1009 = "llvm.extractvalue"(%1007) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%1009)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %1010 = "llvm.fadd"(%1000, %1008) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1010)[^bb35] : (f32) -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"(%1000)[^bb35] : (f32) -> ()
    ^bb35(%1011: f32):  // 2 preds: ^bb33, ^bb34
      %1012 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1013 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1014 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1015 = "llvm.sub"(%1014, %961) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1016 = "llvm.lshr"(%1013, %1015) : (i32, i32) -> i32
      %1017 = "llvm.sub"(%961, %1012) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1018 = "nvvm.shfl.sync"(%1016, %1011, %822, %1017) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %1019 = "llvm.extractvalue"(%1018) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %1020 = "llvm.extractvalue"(%1018) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%1020)[^bb36, ^bb37] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %1021 = "llvm.fadd"(%1011, %1019) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1021)[^bb38] : (f32) -> ()
    ^bb37:  // pred: ^bb35
      "llvm.br"(%1011)[^bb38] : (f32) -> ()
    ^bb38(%1022: f32):  // 2 preds: ^bb36, ^bb37
      "llvm.br"(%1022)[^bb40] : (f32) -> ()
    ^bb39:  // pred: ^bb22
      %1023 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1024 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1025 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1026 = "llvm.sub"(%1025, %827) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1027 = "llvm.lshr"(%1024, %1026) : (i32, i32) -> i32
      %1028 = "llvm.sub"(%827, %1023) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1029 = "nvvm.shfl.sync"(%1027, %966, %826, %1028) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1030 = "llvm.fadd"(%966, %1029) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1031 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1032 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1033 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1034 = "llvm.sub"(%1033, %827) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1035 = "llvm.lshr"(%1032, %1034) : (i32, i32) -> i32
      %1036 = "llvm.sub"(%827, %1031) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1037 = "nvvm.shfl.sync"(%1035, %1030, %825, %1036) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1038 = "llvm.fadd"(%1030, %1037) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1039 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1040 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1041 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1042 = "llvm.sub"(%1041, %827) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1043 = "llvm.lshr"(%1040, %1042) : (i32, i32) -> i32
      %1044 = "llvm.sub"(%827, %1039) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1045 = "nvvm.shfl.sync"(%1043, %1038, %824, %1044) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1046 = "llvm.fadd"(%1038, %1045) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1047 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1048 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1049 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1050 = "llvm.sub"(%1049, %827) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1051 = "llvm.lshr"(%1048, %1050) : (i32, i32) -> i32
      %1052 = "llvm.sub"(%827, %1047) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1053 = "nvvm.shfl.sync"(%1051, %1046, %823, %1052) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1054 = "llvm.fadd"(%1046, %1053) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1055 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1056 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1057 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1058 = "llvm.sub"(%1057, %827) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1059 = "llvm.lshr"(%1056, %1058) : (i32, i32) -> i32
      %1060 = "llvm.sub"(%827, %1055) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1061 = "nvvm.shfl.sync"(%1059, %1054, %822, %1060) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1062 = "llvm.fadd"(%1054, %1061) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1062)[^bb40] : (f32) -> ()
    ^bb40(%1063: f32):  // 2 preds: ^bb38, ^bb39
      %1064 = "llvm.extractvalue"(%820) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %1065 = "llvm.getelementptr"(%1064, %821) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%1063, %1065) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb42] : () -> ()
    ^bb41:  // pred: ^bb21
      "llvm.br"()[^bb42] : () -> ()
    ^bb42:  // 2 preds: ^bb40, ^bb41
      "nvvm.barrier"() <{aligned = true, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_3"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<32 x i32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_gpu_all_reduce_region_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_all_reduce_region", visibility_ = 0 : i64}> ({
      %555 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_region_0}> : () -> !llvm.ptr<3>
      %556 = "llvm.getelementptr"(%555) <{elem_type = !llvm.array<32 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %557 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %558 = "llvm.insertvalue"(%557, %556) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %559 = "llvm.insertvalue"(%558, %556) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %560 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %561 = "llvm.insertvalue"(%559, %560) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %562 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %563 = "llvm.insertvalue"(%561, %562) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %564 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %565 = "llvm.insertvalue"(%563, %564) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %566 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %567 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %568 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %569 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %570 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %571 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %572 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %573 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %574 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %575 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %576 = "llvm.sext"(%575) : (i32) -> i64
      %577 = "llvm.trunc"(%576) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %578 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %579 = "llvm.sext"(%578) : (i32) -> i64
      %580 = "llvm.trunc"(%579) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %581 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %582 = "llvm.sext"(%581) : (i32) -> i64
      %583 = "llvm.trunc"(%582) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %584 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %585 = "llvm.sext"(%584) : (i32) -> i64
      %586 = "llvm.trunc"(%585) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %587 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %588 = "llvm.sext"(%587) : (i32) -> i64
      %589 = "llvm.trunc"(%588) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %590 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %591 = "llvm.sext"(%590) : (i32) -> i64
      %592 = "llvm.trunc"(%591) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %593 = "llvm.mul"(%592, %580) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %594 = "llvm.add"(%593, %589) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %595 = "llvm.mul"(%594, %577) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %596 = "llvm.mul"(%577, %580) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %597 = "llvm.add"(%595, %586) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %598 = "llvm.mul"(%596, %583) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %599 = "llvm.and"(%597, %573) : (i32, i32) -> i32
      %600 = "llvm.icmp"(%599, %572) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %601 = "llvm.sub"(%597, %599) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %602 = "llvm.sub"(%598, %601) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %603 = "llvm.icmp"(%602, %571) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%603)[^bb1, ^bb22] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %604 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %605 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %606 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %607 = "llvm.sub"(%606, %602) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %608 = "llvm.lshr"(%605, %607) : (i32, i32) -> i32
      %609 = "llvm.sub"(%602, %604) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %610 = "nvvm.shfl.sync"(%608, %574, %574, %609) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %611 = "llvm.extractvalue"(%610) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %612 = "llvm.extractvalue"(%610) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%612, %574)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb2:  // pred: ^bb1
      "llvm.br"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      %613 = "llvm.xor"(%611, %574) : (i32, i32) -> i32
      "llvm.br"(%613)[^bb4] : (i32) -> ()
    ^bb4(%614: i32):  // 2 preds: ^bb1, ^bb3
      "llvm.br"()[^bb5] : () -> ()
    ^bb5:  // pred: ^bb4
      %615 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %616 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %617 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %618 = "llvm.sub"(%617, %602) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %619 = "llvm.lshr"(%616, %618) : (i32, i32) -> i32
      %620 = "llvm.sub"(%602, %615) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %621 = "nvvm.shfl.sync"(%619, %614, %570, %620) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %622 = "llvm.extractvalue"(%621) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %623 = "llvm.extractvalue"(%621) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%623, %614)[^bb6, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb6:  // pred: ^bb5
      "llvm.br"()[^bb7] : () -> ()
    ^bb7:  // pred: ^bb6
      %624 = "llvm.xor"(%614, %622) : (i32, i32) -> i32
      "llvm.br"(%624)[^bb8] : (i32) -> ()
    ^bb8(%625: i32):  // 2 preds: ^bb5, ^bb7
      "llvm.br"()[^bb9] : () -> ()
    ^bb9:  // pred: ^bb8
      %626 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %627 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %628 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %629 = "llvm.sub"(%628, %602) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %630 = "llvm.lshr"(%627, %629) : (i32, i32) -> i32
      %631 = "llvm.sub"(%602, %626) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %632 = "nvvm.shfl.sync"(%630, %625, %569, %631) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %633 = "llvm.extractvalue"(%632) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %634 = "llvm.extractvalue"(%632) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%634, %625)[^bb10, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb10:  // pred: ^bb9
      "llvm.br"()[^bb11] : () -> ()
    ^bb11:  // pred: ^bb10
      %635 = "llvm.xor"(%625, %633) : (i32, i32) -> i32
      "llvm.br"(%635)[^bb12] : (i32) -> ()
    ^bb12(%636: i32):  // 2 preds: ^bb9, ^bb11
      "llvm.br"()[^bb13] : () -> ()
    ^bb13:  // pred: ^bb12
      %637 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %638 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %639 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %640 = "llvm.sub"(%639, %602) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %641 = "llvm.lshr"(%638, %640) : (i32, i32) -> i32
      %642 = "llvm.sub"(%602, %637) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %643 = "nvvm.shfl.sync"(%641, %636, %568, %642) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %644 = "llvm.extractvalue"(%643) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %645 = "llvm.extractvalue"(%643) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%645, %636)[^bb14, ^bb16] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb14:  // pred: ^bb13
      "llvm.br"()[^bb15] : () -> ()
    ^bb15:  // pred: ^bb14
      %646 = "llvm.xor"(%636, %644) : (i32, i32) -> i32
      "llvm.br"(%646)[^bb16] : (i32) -> ()
    ^bb16(%647: i32):  // 2 preds: ^bb13, ^bb15
      "llvm.br"()[^bb17] : () -> ()
    ^bb17:  // pred: ^bb16
      %648 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %649 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %650 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %651 = "llvm.sub"(%650, %602) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %652 = "llvm.lshr"(%649, %651) : (i32, i32) -> i32
      %653 = "llvm.sub"(%602, %648) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %654 = "nvvm.shfl.sync"(%652, %647, %567, %653) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %655 = "llvm.extractvalue"(%654) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %656 = "llvm.extractvalue"(%654) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%656, %647)[^bb18, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb18:  // pred: ^bb17
      "llvm.br"()[^bb19] : () -> ()
    ^bb19:  // pred: ^bb18
      %657 = "llvm.xor"(%647, %655) : (i32, i32) -> i32
      "llvm.br"(%657)[^bb20] : (i32) -> ()
    ^bb20(%658: i32):  // 2 preds: ^bb17, ^bb19
      "llvm.br"(%658)[^bb21] : (i32) -> ()
    ^bb21(%659: i32):  // 2 preds: ^bb20, ^bb31
      "llvm.br"()[^bb32] : () -> ()
    ^bb22:  // pred: ^bb0
      %660 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %661 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %662 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %663 = "llvm.sub"(%662, %571) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %664 = "llvm.lshr"(%661, %663) : (i32, i32) -> i32
      %665 = "llvm.sub"(%571, %660) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %666 = "nvvm.shfl.sync"(%664, %574, %574, %665) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb23] : () -> ()
    ^bb23:  // pred: ^bb22
      %667 = "llvm.xor"(%666, %574) : (i32, i32) -> i32
      "llvm.br"()[^bb24] : () -> ()
    ^bb24:  // pred: ^bb23
      %668 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %669 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %670 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %671 = "llvm.sub"(%670, %571) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %672 = "llvm.lshr"(%669, %671) : (i32, i32) -> i32
      %673 = "llvm.sub"(%571, %668) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %674 = "nvvm.shfl.sync"(%672, %667, %570, %673) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb25] : () -> ()
    ^bb25:  // pred: ^bb24
      %675 = "llvm.xor"(%667, %674) : (i32, i32) -> i32
      "llvm.br"()[^bb26] : () -> ()
    ^bb26:  // pred: ^bb25
      %676 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %677 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %678 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %679 = "llvm.sub"(%678, %571) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %680 = "llvm.lshr"(%677, %679) : (i32, i32) -> i32
      %681 = "llvm.sub"(%571, %676) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %682 = "nvvm.shfl.sync"(%680, %675, %569, %681) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb27] : () -> ()
    ^bb27:  // pred: ^bb26
      %683 = "llvm.xor"(%675, %682) : (i32, i32) -> i32
      "llvm.br"()[^bb28] : () -> ()
    ^bb28:  // pred: ^bb27
      %684 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %685 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %686 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %687 = "llvm.sub"(%686, %571) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %688 = "llvm.lshr"(%685, %687) : (i32, i32) -> i32
      %689 = "llvm.sub"(%571, %684) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %690 = "nvvm.shfl.sync"(%688, %683, %568, %689) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb29] : () -> ()
    ^bb29:  // pred: ^bb28
      %691 = "llvm.xor"(%683, %690) : (i32, i32) -> i32
      "llvm.br"()[^bb30] : () -> ()
    ^bb30:  // pred: ^bb29
      %692 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %693 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %694 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %695 = "llvm.sub"(%694, %571) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %696 = "llvm.lshr"(%693, %695) : (i32, i32) -> i32
      %697 = "llvm.sub"(%571, %692) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %698 = "nvvm.shfl.sync"(%696, %691, %567, %697) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb31] : () -> ()
    ^bb31:  // pred: ^bb30
      %699 = "llvm.xor"(%691, %698) : (i32, i32) -> i32
      "llvm.br"(%699)[^bb21] : (i32) -> ()
    ^bb32:  // pred: ^bb21
      "llvm.cond_br"(%600)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %700 = "llvm.sdiv"(%597, %571) : (i32, i32) -> i32
      %701 = "llvm.sext"(%700) : (i32) -> i64
      %702 = "llvm.extractvalue"(%565) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %703 = "llvm.getelementptr"(%702, %701) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%659, %703) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb35] : () -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"()[^bb35] : () -> ()
    ^bb35:  // 2 preds: ^bb33, ^bb34
      "nvvm.barrier"() <{aligned = true, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      %704 = "llvm.add"(%598, %573) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %705 = "llvm.sdiv"(%704, %571) : (i32, i32) -> i32
      %706 = "llvm.icmp"(%597, %705) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%706)[^bb36, ^bb69] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %707 = "llvm.sext"(%597) : (i32) -> i64
      %708 = "llvm.extractvalue"(%565) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %709 = "llvm.getelementptr"(%708, %707) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      %710 = "llvm.load"(%709) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> i32
      %711 = "llvm.icmp"(%705, %571) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%711)[^bb37, ^bb58] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb37:  // pred: ^bb36
      %712 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %713 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %714 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %715 = "llvm.sub"(%714, %705) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %716 = "llvm.lshr"(%713, %715) : (i32, i32) -> i32
      %717 = "llvm.sub"(%705, %712) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %718 = "nvvm.shfl.sync"(%716, %710, %574, %717) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %719 = "llvm.extractvalue"(%718) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %720 = "llvm.extractvalue"(%718) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%720, %710)[^bb38, ^bb40] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb38:  // pred: ^bb37
      "llvm.br"()[^bb39] : () -> ()
    ^bb39:  // pred: ^bb38
      %721 = "llvm.xor"(%710, %719) : (i32, i32) -> i32
      "llvm.br"(%721)[^bb40] : (i32) -> ()
    ^bb40(%722: i32):  // 2 preds: ^bb37, ^bb39
      "llvm.br"()[^bb41] : () -> ()
    ^bb41:  // pred: ^bb40
      %723 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %724 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %725 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %726 = "llvm.sub"(%725, %705) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %727 = "llvm.lshr"(%724, %726) : (i32, i32) -> i32
      %728 = "llvm.sub"(%705, %723) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %729 = "nvvm.shfl.sync"(%727, %722, %570, %728) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %730 = "llvm.extractvalue"(%729) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %731 = "llvm.extractvalue"(%729) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%731, %722)[^bb42, ^bb44] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb42:  // pred: ^bb41
      "llvm.br"()[^bb43] : () -> ()
    ^bb43:  // pred: ^bb42
      %732 = "llvm.xor"(%722, %730) : (i32, i32) -> i32
      "llvm.br"(%732)[^bb44] : (i32) -> ()
    ^bb44(%733: i32):  // 2 preds: ^bb41, ^bb43
      "llvm.br"()[^bb45] : () -> ()
    ^bb45:  // pred: ^bb44
      %734 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %735 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %736 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %737 = "llvm.sub"(%736, %705) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %738 = "llvm.lshr"(%735, %737) : (i32, i32) -> i32
      %739 = "llvm.sub"(%705, %734) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %740 = "nvvm.shfl.sync"(%738, %733, %569, %739) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %741 = "llvm.extractvalue"(%740) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %742 = "llvm.extractvalue"(%740) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%742, %733)[^bb46, ^bb48] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb46:  // pred: ^bb45
      "llvm.br"()[^bb47] : () -> ()
    ^bb47:  // pred: ^bb46
      %743 = "llvm.xor"(%733, %741) : (i32, i32) -> i32
      "llvm.br"(%743)[^bb48] : (i32) -> ()
    ^bb48(%744: i32):  // 2 preds: ^bb45, ^bb47
      "llvm.br"()[^bb49] : () -> ()
    ^bb49:  // pred: ^bb48
      %745 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %746 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %747 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %748 = "llvm.sub"(%747, %705) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %749 = "llvm.lshr"(%746, %748) : (i32, i32) -> i32
      %750 = "llvm.sub"(%705, %745) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %751 = "nvvm.shfl.sync"(%749, %744, %568, %750) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %752 = "llvm.extractvalue"(%751) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %753 = "llvm.extractvalue"(%751) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%753, %744)[^bb50, ^bb52] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb50:  // pred: ^bb49
      "llvm.br"()[^bb51] : () -> ()
    ^bb51:  // pred: ^bb50
      %754 = "llvm.xor"(%744, %752) : (i32, i32) -> i32
      "llvm.br"(%754)[^bb52] : (i32) -> ()
    ^bb52(%755: i32):  // 2 preds: ^bb49, ^bb51
      "llvm.br"()[^bb53] : () -> ()
    ^bb53:  // pred: ^bb52
      %756 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %757 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %758 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %759 = "llvm.sub"(%758, %705) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %760 = "llvm.lshr"(%757, %759) : (i32, i32) -> i32
      %761 = "llvm.sub"(%705, %756) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %762 = "nvvm.shfl.sync"(%760, %755, %567, %761) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %763 = "llvm.extractvalue"(%762) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %764 = "llvm.extractvalue"(%762) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%764, %755)[^bb54, ^bb56] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb54:  // pred: ^bb53
      "llvm.br"()[^bb55] : () -> ()
    ^bb55:  // pred: ^bb54
      %765 = "llvm.xor"(%755, %763) : (i32, i32) -> i32
      "llvm.br"(%765)[^bb56] : (i32) -> ()
    ^bb56(%766: i32):  // 2 preds: ^bb53, ^bb55
      "llvm.br"(%766)[^bb57] : (i32) -> ()
    ^bb57(%767: i32):  // 2 preds: ^bb56, ^bb67
      "llvm.br"()[^bb68] : () -> ()
    ^bb58:  // pred: ^bb36
      %768 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %769 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %770 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %771 = "llvm.sub"(%770, %571) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %772 = "llvm.lshr"(%769, %771) : (i32, i32) -> i32
      %773 = "llvm.sub"(%571, %768) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %774 = "nvvm.shfl.sync"(%772, %710, %574, %773) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb59] : () -> ()
    ^bb59:  // pred: ^bb58
      %775 = "llvm.xor"(%710, %774) : (i32, i32) -> i32
      "llvm.br"()[^bb60] : () -> ()
    ^bb60:  // pred: ^bb59
      %776 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %777 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %778 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %779 = "llvm.sub"(%778, %571) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %780 = "llvm.lshr"(%777, %779) : (i32, i32) -> i32
      %781 = "llvm.sub"(%571, %776) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %782 = "nvvm.shfl.sync"(%780, %775, %570, %781) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb61] : () -> ()
    ^bb61:  // pred: ^bb60
      %783 = "llvm.xor"(%775, %782) : (i32, i32) -> i32
      "llvm.br"()[^bb62] : () -> ()
    ^bb62:  // pred: ^bb61
      %784 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %785 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %786 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %787 = "llvm.sub"(%786, %571) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %788 = "llvm.lshr"(%785, %787) : (i32, i32) -> i32
      %789 = "llvm.sub"(%571, %784) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %790 = "nvvm.shfl.sync"(%788, %783, %569, %789) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb63] : () -> ()
    ^bb63:  // pred: ^bb62
      %791 = "llvm.xor"(%783, %790) : (i32, i32) -> i32
      "llvm.br"()[^bb64] : () -> ()
    ^bb64:  // pred: ^bb63
      %792 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %793 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %794 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %795 = "llvm.sub"(%794, %571) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %796 = "llvm.lshr"(%793, %795) : (i32, i32) -> i32
      %797 = "llvm.sub"(%571, %792) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %798 = "nvvm.shfl.sync"(%796, %791, %568, %797) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb65] : () -> ()
    ^bb65:  // pred: ^bb64
      %799 = "llvm.xor"(%791, %798) : (i32, i32) -> i32
      "llvm.br"()[^bb66] : () -> ()
    ^bb66:  // pred: ^bb65
      %800 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %801 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %802 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %803 = "llvm.sub"(%802, %571) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %804 = "llvm.lshr"(%801, %803) : (i32, i32) -> i32
      %805 = "llvm.sub"(%571, %800) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %806 = "nvvm.shfl.sync"(%804, %799, %567, %805) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb67] : () -> ()
    ^bb67:  // pred: ^bb66
      %807 = "llvm.xor"(%799, %806) : (i32, i32) -> i32
      "llvm.br"(%807)[^bb57] : (i32) -> ()
    ^bb68:  // pred: ^bb57
      %808 = "llvm.extractvalue"(%565) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %809 = "llvm.getelementptr"(%808, %566) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%767, %809) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb70] : () -> ()
    ^bb69:  // pred: ^bb35
      "llvm.br"()[^bb70] : () -> ()
    ^bb70:  // 2 preds: ^bb68, ^bb69
      "nvvm.barrier"() <{aligned = true, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_4"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f32, f32, i1, i1, i1, i1)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffle", visibility_ = 0 : i64}> ({
      %508 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %509 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %510 = "llvm.mlir.constant"() <{value = 23 : i32}> : () -> i32
      %511 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %512 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %513 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %514 = "llvm.sub"(%513, %510) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %515 = "llvm.lshr"(%512, %514) : (i32, i32) -> i32
      %516 = "llvm.sub"(%510, %511) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %517 = "nvvm.shfl.sync"(%515, %508, %509, %516) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %518 = "llvm.extractvalue"(%517) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %519 = "llvm.extractvalue"(%517) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %520 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %521 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %522 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %523 = "llvm.sub"(%522, %510) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %524 = "llvm.lshr"(%521, %523) : (i32, i32) -> i32
      %525 = "nvvm.shfl.sync"(%524, %508, %509, %523) <{kind = #nvvm<shfl_kind up>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %526 = "llvm.extractvalue"(%525) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %527 = "llvm.extractvalue"(%525) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %528 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %529 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %530 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %531 = "llvm.sub"(%530, %510) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %532 = "llvm.lshr"(%529, %531) : (i32, i32) -> i32
      %533 = "llvm.sub"(%510, %528) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %534 = "nvvm.shfl.sync"(%532, %508, %509, %533) <{kind = #nvvm<shfl_kind down>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %535 = "llvm.extractvalue"(%534) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %536 = "llvm.extractvalue"(%534) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %537 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %538 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %539 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %540 = "llvm.sub"(%539, %510) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %541 = "llvm.lshr"(%538, %540) : (i32, i32) -> i32
      %542 = "llvm.sub"(%510, %537) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %543 = "nvvm.shfl.sync"(%541, %508, %509, %542) <{kind = #nvvm<shfl_kind idx>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %544 = "llvm.extractvalue"(%543) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %545 = "llvm.extractvalue"(%543) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %546 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %547 = "llvm.insertvalue"(%546, %518) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %548 = "llvm.insertvalue"(%547, %526) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %549 = "llvm.insertvalue"(%548, %535) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %550 = "llvm.insertvalue"(%549, %544) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %551 = "llvm.insertvalue"(%550, %519) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %552 = "llvm.insertvalue"(%551, %527) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %553 = "llvm.insertvalue"(%552, %536) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %554 = "llvm.insertvalue"(%553, %545) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      "llvm.return"(%554) : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f32, f32)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffle_unused_pred", visibility_ = 0 : i64}> ({
      %473 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %474 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %475 = "llvm.mlir.constant"() <{value = 23 : i32}> : () -> i32
      %476 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %477 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %478 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %479 = "llvm.sub"(%478, %475) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %480 = "llvm.lshr"(%477, %479) : (i32, i32) -> i32
      %481 = "llvm.sub"(%475, %476) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %482 = "nvvm.shfl.sync"(%480, %473, %474, %481) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %483 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %484 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %485 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %486 = "llvm.sub"(%485, %475) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %487 = "llvm.lshr"(%484, %486) : (i32, i32) -> i32
      %488 = "nvvm.shfl.sync"(%487, %473, %474, %486) <{kind = #nvvm<shfl_kind up>}> : (i32, f32, i32, i32) -> f32
      %489 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %490 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %491 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %492 = "llvm.sub"(%491, %475) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %493 = "llvm.lshr"(%490, %492) : (i32, i32) -> i32
      %494 = "llvm.sub"(%475, %489) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %495 = "nvvm.shfl.sync"(%493, %473, %474, %494) <{kind = #nvvm<shfl_kind down>}> : (i32, f32, i32, i32) -> f32
      %496 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %497 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %498 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %499 = "llvm.sub"(%498, %475) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %500 = "llvm.lshr"(%497, %499) : (i32, i32) -> i32
      %501 = "llvm.sub"(%475, %496) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %502 = "nvvm.shfl.sync"(%500, %473, %474, %501) <{kind = #nvvm<shfl_kind idx>}> : (i32, f32, i32, i32) -> f32
      %503 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32, f32)>
      %504 = "llvm.insertvalue"(%503, %482) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %505 = "llvm.insertvalue"(%504, %488) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %506 = "llvm.insertvalue"(%505, %495) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %507 = "llvm.insertvalue"(%506, %502) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      "llvm.return"(%507) : (!llvm.struct<(f32, f32, f32, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_5"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_sync", visibility_ = 0 : i64}> ({
      "nvvm.barrier"() <{aligned = true, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_sync_subgroup", visibility_ = 0 : i64}> ({
      %472 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      "nvvm.bar.warp.sync"(%472) : (i32) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "gpu_named_barriers", visibility_ = 0 : i64}> ({
    ^bb0(%arg117: i32):
      %453 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %454 = "llvm.mlir.addressof"() <{global_name = @__named_barrier_id}> : () -> !llvm.ptr
      %455 = "llvm.load"(%454) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
      %456 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %457 = "llvm.mul"(%arg117, %456) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %458 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, i32)>
      %459 = "llvm.insertvalue"(%458, %455) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %460 = "llvm.insertvalue"(%459, %457) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %461 = "llvm.mlir.addressof"() <{global_name = @__named_barrier_id_0}> : () -> !llvm.ptr
      %462 = "llvm.load"(%461) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
      %463 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %464 = "llvm.mul"(%453, %463) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %465 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, i32)>
      %466 = "llvm.insertvalue"(%465, %462) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %467 = "llvm.insertvalue"(%466, %464) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %468 = "llvm.extractvalue"(%460) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
      %469 = "llvm.extractvalue"(%460) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
      "nvvm.barrier"(%468, %469) <{aligned = true, operandSegmentSizes = array<i32: 1, 1>}> : (i32, i32) -> ()
      %470 = "llvm.extractvalue"(%467) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
      %471 = "llvm.extractvalue"(%467) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
      "nvvm.barrier"(%470, %471) <{aligned = true, operandSegmentSizes = array<i32: 1, 1>}> : (i32, i32) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<(i32, i32)>)>, linkage = #llvm.linkage<external>, sym_name = "gpu_named_barrier_arg", visibility_ = 0 : i64}> ({
    ^bb0(%arg116: !llvm.struct<(i32, i32)>):
      %451 = "llvm.extractvalue"(%arg116) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
      %452 = "llvm.extractvalue"(%arg116) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
      "nvvm.barrier"(%451, %452) <{aligned = true, operandSegmentSizes = array<i32: 1, 1>}> : (i32, i32) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = i32, linkage = #llvm.linkage<internal>, sym_name = "__named_barrier_id", value = 1 : i32, visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = i32, linkage = #llvm.linkage<internal>, sym_name = "__named_barrier_id_0", value = 2 : i32, visibility_ = 0 : i64}> ({
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_6"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fabsf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fabs", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_fabs", visibility_ = 0 : i64}> ({
    ^bb0(%arg114: f32, %arg115: f64):
      %446 = "llvm.call"(%arg114) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fabsf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %447 = "llvm.call"(%arg115) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fabs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %448 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %449 = "llvm.insertvalue"(%448, %446) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %450 = "llvm.insertvalue"(%449, %447) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%450) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_7"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cbrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cbrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cbrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg112: f32, %arg113: f64):
      %441 = "llvm.call"(%arg112) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cbrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %442 = "llvm.call"(%arg113) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cbrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %443 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %444 = "llvm.insertvalue"(%443, %441) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %445 = "llvm.insertvalue"(%444, %442) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%445) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_8"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_ceilf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_ceil", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_ceil", visibility_ = 0 : i64}> ({
    ^bb0(%arg110: f32, %arg111: f64):
      %436 = "llvm.call"(%arg110) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_ceilf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %437 = "llvm.call"(%arg111) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_ceil, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %438 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %439 = "llvm.insertvalue"(%438, %436) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %440 = "llvm.insertvalue"(%439, %437) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%440) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_9"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_floorf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_floor", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_floor", visibility_ = 0 : i64}> ({
    ^bb0(%arg108: f32, %arg109: f64):
      %431 = "llvm.call"(%arg108) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_floorf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %432 = "llvm.call"(%arg109) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_floor, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %433 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %434 = "llvm.insertvalue"(%433, %431) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %435 = "llvm.insertvalue"(%434, %432) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%435) : (!llvm.struct<(f32, f64)>) -> ()
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
    ^bb0(%arg106: f32, %arg107: f64):
      %424 = "llvm.call"(%arg106) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %425 = "llvm.call"(%arg107) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %426 = "llvm.call"(%arg106) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_cosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %427 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %428 = "llvm.insertvalue"(%427, %424) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %429 = "llvm.insertvalue"(%428, %425) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %430 = "llvm.insertvalue"(%429, %426) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%430) : (!llvm.struct<(f32, f64, f32)>) -> ()
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
    ^bb0(%arg104: f32, %arg105: f64):
      %417 = "llvm.call"(%arg104) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %418 = "llvm.call"(%arg105) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %419 = "llvm.call"(%arg104) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %420 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %421 = "llvm.insertvalue"(%420, %417) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %422 = "llvm.insertvalue"(%421, %418) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %423 = "llvm.insertvalue"(%422, %419) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%423) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_12"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_exp2", visibility_ = 0 : i64}> ({
    ^bb0(%arg102: f32, %arg103: f64):
      %412 = "llvm.call"(%arg102) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %413 = "llvm.call"(%arg103) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %414 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %415 = "llvm.insertvalue"(%414, %412) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %416 = "llvm.insertvalue"(%415, %413) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%416) : (!llvm.struct<(f32, f64)>) -> ()
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
    ^bb0(%arg100: f32, %arg101: f64):
      %405 = "llvm.call"(%arg100) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_logf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %406 = "llvm.call"(%arg101) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %407 = "llvm.call"(%arg100) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_logf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %408 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %409 = "llvm.insertvalue"(%408, %405) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %410 = "llvm.insertvalue"(%409, %406) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %411 = "llvm.insertvalue"(%410, %407) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%411) : (!llvm.struct<(f32, f64, f32)>) -> ()
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
    ^bb0(%arg98: f32, %arg99: f64):
      %398 = "llvm.call"(%arg98) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log10f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %399 = "llvm.call"(%arg99) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log10, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %400 = "llvm.call"(%arg98) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_log10f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %401 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %402 = "llvm.insertvalue"(%401, %398) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %403 = "llvm.insertvalue"(%402, %399) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %404 = "llvm.insertvalue"(%403, %400) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%404) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_15"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log1pf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log1p", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log1p", visibility_ = 0 : i64}> ({
    ^bb0(%arg96: f32, %arg97: f64):
      %393 = "llvm.call"(%arg96) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log1pf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %394 = "llvm.call"(%arg97) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log1p, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %395 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %396 = "llvm.insertvalue"(%395, %393) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %397 = "llvm.insertvalue"(%396, %394) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%397) : (!llvm.struct<(f32, f64)>) -> ()
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
    ^bb0(%arg94: f32, %arg95: f64):
      %386 = "llvm.call"(%arg94) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %387 = "llvm.call"(%arg95) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %388 = "llvm.call"(%arg94) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_log2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %389 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %390 = "llvm.insertvalue"(%389, %386) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %391 = "llvm.insertvalue"(%390, %387) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %392 = "llvm.insertvalue"(%391, %388) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%392) : (!llvm.struct<(f32, f64, f32)>) -> ()
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
    ^bb0(%arg92: f32, %arg93: f64):
      %379 = "llvm.call"(%arg92) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %380 = "llvm.call"(%arg93) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %381 = "llvm.call"(%arg92) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %382 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %383 = "llvm.insertvalue"(%382, %379) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %384 = "llvm.insertvalue"(%383, %380) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %385 = "llvm.insertvalue"(%384, %381) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%385) : (!llvm.struct<(f32, f64, f32)>) -> ()
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
    ^bb0(%arg89: f16, %arg90: f32, %arg91: f64):
      %368 = "llvm.fpext"(%arg89) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %369 = "llvm.call"(%368) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %370 = "llvm.fptrunc"(%369) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %371 = "llvm.call"(%arg90) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %372 = "llvm.call"(%arg91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %373 = "llvm.call"(%arg90) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %374 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64, f32)>
      %375 = "llvm.insertvalue"(%374, %370) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64, f32)>, f16) -> !llvm.struct<(f16, f32, f64, f32)>
      %376 = "llvm.insertvalue"(%375, %371) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64, f32)>, f32) -> !llvm.struct<(f16, f32, f64, f32)>
      %377 = "llvm.insertvalue"(%376, %372) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64, f32)>, f64) -> !llvm.struct<(f16, f32, f64, f32)>
      %378 = "llvm.insertvalue"(%377, %373) <{position = array<i64: 3>}> : (!llvm.struct<(f16, f32, f64, f32)>, f32) -> !llvm.struct<(f16, f32, f64, f32)>
      "llvm.return"(%378) : (!llvm.struct<(f16, f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_19"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_tanh", visibility_ = 0 : i64}> ({
    ^bb0(%arg86: f16, %arg87: f32, %arg88: f64):
      %359 = "llvm.fpext"(%arg86) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %360 = "llvm.call"(%359) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %361 = "llvm.fptrunc"(%360) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %362 = "llvm.call"(%arg87) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %363 = "llvm.call"(%arg88) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %364 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %365 = "llvm.insertvalue"(%364, %361) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %366 = "llvm.insertvalue"(%365, %362) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %367 = "llvm.insertvalue"(%366, %363) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%367) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_20"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rsqrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rsqrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_rsqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg83: f16, %arg84: f32, %arg85: f64):
      %350 = "llvm.fpext"(%arg83) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %351 = "llvm.call"(%350) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %352 = "llvm.fptrunc"(%351) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %353 = "llvm.call"(%arg84) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %354 = "llvm.call"(%arg85) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %355 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %356 = "llvm.insertvalue"(%355, %352) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %357 = "llvm.insertvalue"(%356, %353) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %358 = "llvm.insertvalue"(%357, %354) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%358) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_21"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sqrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sqrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg80: f16, %arg81: f32, %arg82: f64):
      %341 = "llvm.fpext"(%arg80) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %342 = "llvm.call"(%341) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %343 = "llvm.fptrunc"(%342) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %344 = "llvm.call"(%arg81) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %345 = "llvm.call"(%arg82) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %346 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %347 = "llvm.insertvalue"(%346, %343) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %348 = "llvm.insertvalue"(%347, %344) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %349 = "llvm.insertvalue"(%348, %345) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%349) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_22"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atan", visibility_ = 0 : i64}> ({
    ^bb0(%arg77: f16, %arg78: f32, %arg79: f64):
      %332 = "llvm.fpext"(%arg77) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %333 = "llvm.call"(%332) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %334 = "llvm.fptrunc"(%333) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %335 = "llvm.call"(%arg78) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %336 = "llvm.call"(%arg79) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %337 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %338 = "llvm.insertvalue"(%337, %334) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %339 = "llvm.insertvalue"(%338, %335) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %340 = "llvm.insertvalue"(%339, %336) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%340) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_23"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atan2", visibility_ = 0 : i64}> ({
    ^bb0(%arg74: f16, %arg75: f32, %arg76: f64):
      %322 = "llvm.fpext"(%arg74) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %323 = "llvm.fpext"(%arg74) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %324 = "llvm.call"(%322, %323) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %325 = "llvm.fptrunc"(%324) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %326 = "llvm.call"(%arg75, %arg75) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %327 = "llvm.call"(%arg76, %arg76) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %328 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %329 = "llvm.insertvalue"(%328, %325) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %330 = "llvm.insertvalue"(%329, %326) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %331 = "llvm.insertvalue"(%330, %327) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%331) : (!llvm.struct<(f16, f32, f64)>) -> ()
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
      ^bb0(%arg72: f32, %arg73: f64):
        %315 = "llvm.call"(%arg72) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
        %316 = "llvm.call"(%arg73) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
        %317 = "llvm.call"(%arg72) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
        %318 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
        %319 = "llvm.insertvalue"(%318, %315) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
        %320 = "llvm.insertvalue"(%319, %316) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
        %321 = "llvm.insertvalue"(%320, %317) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
        "llvm.return"(%321) : (!llvm.struct<(f32, f64, f32)>) -> ()
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
    ^bb0(%arg70: f32, %arg71: f64):
      %310 = "llvm.call"(%arg70) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expm1f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %311 = "llvm.call"(%arg71) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expm1, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %312 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %313 = "llvm.insertvalue"(%312, %310) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %314 = "llvm.insertvalue"(%313, %311) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%314) : (!llvm.struct<(f32, f64)>) -> ()
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
    ^bb0(%arg68: f32, %arg69: f64):
      %303 = "llvm.call"(%arg68, %arg68) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %304 = "llvm.call"(%arg69, %arg69) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_pow, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %305 = "llvm.call"(%arg68, %arg68) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_powf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %306 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %307 = "llvm.insertvalue"(%306, %303) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %308 = "llvm.insertvalue"(%307, %304) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %309 = "llvm.insertvalue"(%308, %305) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%309) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_27"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xf32> (vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "gpu_unroll", visibility_ = 0 : i64}> ({
    ^bb0(%arg67: vector<4xf32>):
      %286 = "llvm.mlir.poison"() : () -> vector<4xf32>
      %287 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
      %288 = "llvm.extractelement"(%arg67, %287) : (vector<4xf32>, i64) -> f32
      %289 = "llvm.call"(%288) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %290 = "llvm.insertelement"(%286, %289, %287) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %291 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
      %292 = "llvm.extractelement"(%arg67, %291) : (vector<4xf32>, i64) -> f32
      %293 = "llvm.call"(%292) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %294 = "llvm.insertelement"(%290, %293, %291) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %295 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
      %296 = "llvm.extractelement"(%arg67, %295) : (vector<4xf32>, i64) -> f32
      %297 = "llvm.call"(%296) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %298 = "llvm.insertelement"(%294, %297, %295) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %299 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
      %300 = "llvm.extractelement"(%arg67, %299) : (vector<4xf32>, i64) -> f32
      %301 = "llvm.call"(%300) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %302 = "llvm.insertelement"(%298, %301, %299) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      "llvm.return"(%302) : (vector<4xf32>) -> ()
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
      %276 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
      %277 = "llvm.getelementptr"(%276) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %278 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %279 = "llvm.alloca"(%278) <{elem_type = !llvm.struct<()>}> : (i64) -> !llvm.ptr
      %280 = "llvm.call"(%277, %279) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      %281 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
      %282 = "llvm.getelementptr"(%281) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %283 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %284 = "llvm.alloca"(%283) <{elem_type = !llvm.struct<()>}> : (i64) -> !llvm.ptr
      %285 = "llvm.call"(%282, %284) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, f32)>, linkage = #llvm.linkage<external>, sym_name = "test_printf", visibility_ = 0 : i64}> ({
    ^bb0(%arg65: i32, %arg66: f32):
      %268 = "llvm.mlir.addressof"() <{global_name = @printfFormat_1}> : () -> !llvm.ptr
      %269 = "llvm.getelementptr"(%268) <{elem_type = !llvm.array<11 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %270 = "llvm.fpext"(%arg66) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f64
      %271 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %272 = "llvm.alloca"(%271) <{elem_type = !llvm.struct<(i32, f64)>}> : (i64) -> !llvm.ptr
      %273 = "llvm.getelementptr"(%272) <{elem_type = !llvm.struct<(i32, f64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      "llvm.store"(%arg65, %273) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      %274 = "llvm.getelementptr"(%272) <{elem_type = !llvm.struct<(i32, f64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
      "llvm.store"(%270, %274) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
      %275 = "llvm.call"(%269, %272) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_30"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_add", visibility_ = 0 : i64}> ({
    ^bb0(%arg63: i32, %arg64: !llvm.ptr):
      %260 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %261 = "llvm.insertvalue"(%260, %arg64) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %262 = "llvm.insertvalue"(%261, %arg64) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %263 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %264 = "llvm.insertvalue"(%262, %263) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %265 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %266 = "nvvm.redux.sync"(%arg63, %265) <{abs = false, kind = #nvvm<reduction_kind add>, nan = false}> : (i32, i32) -> i32
      %267 = "llvm.extractvalue"(%264) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
      "llvm.store"(%266, %267) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_minsi", visibility_ = 0 : i64}> ({
    ^bb0(%arg61: i32, %arg62: !llvm.ptr):
      %252 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %253 = "llvm.insertvalue"(%252, %arg62) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %254 = "llvm.insertvalue"(%253, %arg62) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %255 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %256 = "llvm.insertvalue"(%254, %255) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %257 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %258 = "nvvm.redux.sync"(%arg61, %257) <{abs = false, kind = #nvvm<reduction_kind min>, nan = false}> : (i32, i32) -> i32
      %259 = "llvm.extractvalue"(%256) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
      "llvm.store"(%258, %259) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_maxsi", visibility_ = 0 : i64}> ({
    ^bb0(%arg59: i32, %arg60: !llvm.ptr):
      %244 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %245 = "llvm.insertvalue"(%244, %arg60) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %246 = "llvm.insertvalue"(%245, %arg60) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %247 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %248 = "llvm.insertvalue"(%246, %247) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %249 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %250 = "nvvm.redux.sync"(%arg59, %249) <{abs = false, kind = #nvvm<reduction_kind max>, nan = false}> : (i32, i32) -> i32
      %251 = "llvm.extractvalue"(%248) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
      "llvm.store"(%250, %251) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_and", visibility_ = 0 : i64}> ({
    ^bb0(%arg57: i32, %arg58: !llvm.ptr):
      %236 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %237 = "llvm.insertvalue"(%236, %arg58) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %238 = "llvm.insertvalue"(%237, %arg58) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %239 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %240 = "llvm.insertvalue"(%238, %239) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %241 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %242 = "nvvm.redux.sync"(%arg57, %241) <{abs = false, kind = #nvvm<reduction_kind and>, nan = false}> : (i32, i32) -> i32
      %243 = "llvm.extractvalue"(%240) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
      "llvm.store"(%242, %243) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_or", visibility_ = 0 : i64}> ({
    ^bb0(%arg55: i32, %arg56: !llvm.ptr):
      %228 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %229 = "llvm.insertvalue"(%228, %arg56) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %230 = "llvm.insertvalue"(%229, %arg56) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %231 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %232 = "llvm.insertvalue"(%230, %231) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %233 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %234 = "nvvm.redux.sync"(%arg55, %233) <{abs = false, kind = #nvvm<reduction_kind or>, nan = false}> : (i32, i32) -> i32
      %235 = "llvm.extractvalue"(%232) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
      "llvm.store"(%234, %235) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_xor", visibility_ = 0 : i64}> ({
    ^bb0(%arg53: i32, %arg54: !llvm.ptr):
      %220 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %221 = "llvm.insertvalue"(%220, %arg54) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %222 = "llvm.insertvalue"(%221, %arg54) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %223 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %224 = "llvm.insertvalue"(%222, %223) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %225 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %226 = "nvvm.redux.sync"(%arg53, %225) <{abs = false, kind = #nvvm<reduction_kind xor>, nan = false}> : (i32, i32) -> i32
      %227 = "llvm.extractvalue"(%224) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
      "llvm.store"(%226, %227) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_31"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmodf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmod", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_fmod", visibility_ = 0 : i64}> ({
    ^bb0(%arg51: f32, %arg52: f64):
      %215 = "llvm.call"(%arg51, %arg51) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmodf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %216 = "llvm.call"(%arg52, %arg52) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmod, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %217 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %218 = "llvm.insertvalue"(%217, %215) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %219 = "llvm.insertvalue"(%218, %216) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%219) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_32"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erff", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_erf", visibility_ = 0 : i64}> ({
    ^bb0(%arg49: f32, %arg50: f64):
      %210 = "llvm.call"(%arg49) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erff, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %211 = "llvm.call"(%arg50) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %212 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %213 = "llvm.insertvalue"(%212, %210) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %214 = "llvm.insertvalue"(%213, %211) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%214) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_33"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_block_size", visibility_ = 0 : i64}> ({
    ^bb0(%arg48: !llvm.ptr):
      %202 = "nvvm.read.ptx.sreg.tid.x"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %203 = "llvm.sext"(%202) : (i32) -> i64
      %204 = "nvvm.read.ptx.sreg.tid.y"() <{range = #llvm.constant_range<i32, 0, 4>}> : () -> i32
      %205 = "llvm.sext"(%204) : (i32) -> i64
      %206 = "nvvm.read.ptx.sreg.tid.z"() <{range = #llvm.constant_range<i32, 0, 2>}> : () -> i32
      %207 = "llvm.sext"(%206) : (i32) -> i64
      %208 = "llvm.add"(%203, %205) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %209 = "llvm.add"(%208, %207) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.store"(%209, %arg48) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_block_size = array<i32: 32, 4, 2>, nvvm.kernel, nvvm.maxntid = array<i32: 32, 4, 2>} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_34"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, f32)> (ptr, f32)>, linkage = #llvm.linkage<external>, sym_name = "memref_signature", visibility_ = 0 : i64}> ({
    ^bb0(%arg46: !llvm.ptr, %arg47: f32):
      %189 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %190 = "llvm.insertvalue"(%189, %arg46) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %191 = "llvm.insertvalue"(%190, %arg46) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %192 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %193 = "llvm.insertvalue"(%191, %192) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %194 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
      %195 = "llvm.insertvalue"(%193, %194) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %196 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %197 = "llvm.insertvalue"(%195, %196) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %198 = "llvm.extractvalue"(%197) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
      %199 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, f32)>
      %200 = "llvm.insertvalue"(%199, %198) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, f32)>, !llvm.ptr) -> !llvm.struct<(ptr, f32)>
      %201 = "llvm.insertvalue"(%200, %arg47) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, f32)>, f32) -> !llvm.struct<(ptr, f32)>
      "llvm.return"(%201) : (!llvm.struct<(ptr, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_35"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acos", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_acos", visibility_ = 0 : i64}> ({
    ^bb0(%arg44: f32, %arg45: f64):
      %184 = "llvm.call"(%arg44) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %185 = "llvm.call"(%arg45) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %186 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %187 = "llvm.insertvalue"(%186, %184) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %188 = "llvm.insertvalue"(%187, %185) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%188) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_36"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acoshf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acosh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_acosh", visibility_ = 0 : i64}> ({
    ^bb0(%arg42: f32, %arg43: f64):
      %179 = "llvm.call"(%arg42) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acoshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %180 = "llvm.call"(%arg43) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %181 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %182 = "llvm.insertvalue"(%181, %179) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %183 = "llvm.insertvalue"(%182, %180) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%183) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_37"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asinf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asin", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_asin", visibility_ = 0 : i64}> ({
    ^bb0(%arg40: f32, %arg41: f64):
      %174 = "llvm.call"(%arg40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %175 = "llvm.call"(%arg41) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %176 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %177 = "llvm.insertvalue"(%176, %174) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %178 = "llvm.insertvalue"(%177, %175) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%178) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_38"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asinhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asinh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_asinh", visibility_ = 0 : i64}> ({
    ^bb0(%arg38: f32, %arg39: f64):
      %169 = "llvm.call"(%arg38) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %170 = "llvm.call"(%arg39) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %171 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %172 = "llvm.insertvalue"(%171, %169) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %173 = "llvm.insertvalue"(%172, %170) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%173) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_39"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atanh", visibility_ = 0 : i64}> ({
    ^bb0(%arg35: f16, %arg36: f32, %arg37: f64):
      %160 = "llvm.fpext"(%arg35) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %161 = "llvm.call"(%160) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %162 = "llvm.fptrunc"(%161) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %163 = "llvm.call"(%arg36) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %164 = "llvm.call"(%arg37) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %165 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %166 = "llvm.insertvalue"(%165, %162) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %167 = "llvm.insertvalue"(%166, %163) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %168 = "llvm.insertvalue"(%167, %164) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%168) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_40"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_copysignf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_copysign", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_copysign", visibility_ = 0 : i64}> ({
    ^bb0(%arg33: f32, %arg34: f64):
      %155 = "llvm.call"(%arg33, %arg33) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_copysignf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %156 = "llvm.call"(%arg34, %arg34) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_copysign, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %157 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %158 = "llvm.insertvalue"(%157, %155) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %159 = "llvm.insertvalue"(%158, %156) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%159) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_41"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_coshf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cosh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cosh", visibility_ = 0 : i64}> ({
    ^bb0(%arg31: f32, %arg32: f64):
      %150 = "llvm.call"(%arg31) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_coshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %151 = "llvm.call"(%arg32) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %152 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %153 = "llvm.insertvalue"(%152, %150) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %154 = "llvm.insertvalue"(%153, %151) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%154) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_42"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmaf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fma", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_fma", visibility_ = 0 : i64}> ({
    ^bb0(%arg29: f32, %arg30: f64):
      %145 = "llvm.call"(%arg29, %arg29, %arg29) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmaf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, f32, f32) -> f32
      %146 = "llvm.call"(%arg30, %arg30, %arg30) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fma, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f64, f64, f64) -> f64
      %147 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %148 = "llvm.insertvalue"(%147, %145) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %149 = "llvm.insertvalue"(%148, %146) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%149) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_43"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_roundf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_round", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_round", visibility_ = 0 : i64}> ({
    ^bb0(%arg27: f32, %arg28: f64):
      %140 = "llvm.call"(%arg27) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_roundf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %141 = "llvm.call"(%arg28) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_round, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %142 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %143 = "llvm.insertvalue"(%142, %140) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %144 = "llvm.insertvalue"(%143, %141) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%144) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_44"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rintf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rint", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_roundeven", visibility_ = 0 : i64}> ({
    ^bb0(%arg25: f32, %arg26: f64):
      %135 = "llvm.call"(%arg25) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %136 = "llvm.call"(%arg26) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rint, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %137 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %138 = "llvm.insertvalue"(%137, %135) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %139 = "llvm.insertvalue"(%138, %136) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%139) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_45"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sinh", visibility_ = 0 : i64}> ({
    ^bb0(%arg23: f32, %arg24: f64):
      %130 = "llvm.call"(%arg23) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %131 = "llvm.call"(%arg24) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %132 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %133 = "llvm.insertvalue"(%132, %130) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %134 = "llvm.insertvalue"(%133, %131) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%134) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_46"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_coshf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cosh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cosh_with_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg21: f32, %arg22: f64):
      %125 = "llvm.call"(%arg21) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_coshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %126 = "llvm.call"(%arg22) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %127 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %128 = "llvm.insertvalue"(%127, %125) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %129 = "llvm.insertvalue"(%128, %126) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%129) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_47"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sinh_with_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg19: f32, %arg20: f64):
      %120 = "llvm.call"(%arg19) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %121 = "llvm.call"(%arg20) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %122 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %123 = "llvm.insertvalue"(%122, %120) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %124 = "llvm.insertvalue"(%123, %121) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%124) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_48"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_exp_with_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg17: f32, %arg18: f64):
      %113 = "llvm.call"(%arg17) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %114 = "llvm.call"(%arg18) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %115 = "llvm.call"(%arg17) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %116 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %117 = "llvm.insertvalue"(%116, %113) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %118 = "llvm.insertvalue"(%117, %114) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %119 = "llvm.insertvalue"(%118, %115) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%119) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_49"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, i64, i64)> ()>, linkage = #llvm.linkage<external>, sym_name = "explicit_id_bounds", visibility_ = 0 : i64}> ({
      %103 = "nvvm.read.ptx.sreg.tid.x"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %104 = "llvm.sext"(%103) : (i32) -> i64
      %105 = "nvvm.read.ptx.sreg.ntid.x"() <{range = #llvm.constant_range<i32, 1, 33>}> : () -> i32
      %106 = "llvm.sext"(%105) : (i32) -> i64
      %107 = "nvvm.read.ptx.sreg.laneid"() <{range = #llvm.constant_range<i32, 0, 16>}> : () -> i32
      %108 = "llvm.sext"(%107) : (i32) -> i64
      %109 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, i64, i64)>
      %110 = "llvm.insertvalue"(%109, %104) <{position = array<i64: 0>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
      %111 = "llvm.insertvalue"(%110, %106) <{position = array<i64: 1>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
      %112 = "llvm.insertvalue"(%111, %108) <{position = array<i64: 2>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
      "llvm.return"(%112) : (!llvm.struct<(i64, i64, i64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_50"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_grid_size", visibility_ = 0 : i64}> ({
    ^bb0(%arg16: !llvm.ptr):
      %95 = "nvvm.read.ptx.sreg.ctaid.x"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %96 = "llvm.sext"(%95) : (i32) -> i64
      %97 = "nvvm.read.ptx.sreg.ctaid.y"() <{range = #llvm.constant_range<i32, 0, 4>}> : () -> i32
      %98 = "llvm.sext"(%97) : (i32) -> i64
      %99 = "nvvm.read.ptx.sreg.ctaid.z"() <{range = #llvm.constant_range<i32, 0, 2>}> : () -> i32
      %100 = "llvm.sext"(%99) : (i32) -> i64
      %101 = "llvm.add"(%96, %98) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %102 = "llvm.add"(%101, %100) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.store"(%102, %arg16) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_grid_size = array<i32: 32, 4, 2>, nvvm.kernel} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_51"}> ({
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<10 x i8>, linkage = #llvm.linkage<internal>, sym_name = "assert_func_0", value = "(unknown)\00", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<90 x i8>, linkage = #llvm.linkage<internal>, sym_name = "assert_file_0", value = "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm.mlir\00", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<15 x i8>, linkage = #llvm.linkage<internal>, sym_name = "assert_message_0", value = "assert message\00", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i32, ptr, i64)>, linkage = #llvm.linkage<external>, passthrough = ["noreturn"], sym_name = "__assertfail", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1)>, linkage = #llvm.linkage<external>, sym_name = "test_assert", visibility_ = 0 : i64}> ({
    ^bb0(%arg15: i1):
      "llvm.cond_br"(%arg15)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %87 = "llvm.mlir.addressof"() <{global_name = @assert_message_0}> : () -> !llvm.ptr
      %88 = "llvm.getelementptr"(%87) <{elem_type = !llvm.array<15 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %89 = "llvm.mlir.addressof"() <{global_name = @assert_file_0}> : () -> !llvm.ptr
      %90 = "llvm.getelementptr"(%89) <{elem_type = !llvm.array<90 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %91 = "llvm.mlir.addressof"() <{global_name = @assert_func_0}> : () -> !llvm.ptr
      %92 = "llvm.getelementptr"(%91) <{elem_type = !llvm.array<10 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %93 = "llvm.mlir.constant"() <{value = 1056 : i32}> : () -> i32
      %94 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
      "llvm.call"(%88, %90, %93, %92, %94) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__assertfail, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (!llvm.ptr, !llvm.ptr, i32, !llvm.ptr, i64) -> ()
      "llvm.br"()[^bb2] : () -> ()
    ^bb2:  // 2 preds: ^bb0, ^bb1
      "llvm.return"() : () -> ()
    }) {gpu.kernel, nvvm.kernel} : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg14: !transform.any_op):
      %86 = "transform.structured.match"(%arg14) <{ops = ["gpu.module"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%86) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.gpu_rewrite_patterns"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.apply_conversion_patterns"(%86) <{illegal_dialects = ["gpu"], illegal_ops = ["llvm.copysign", "llvm.cos", "llvm.exp", "llvm.exp2", "llvm.fabs", "llvm.fceil", "llvm.ffloor", "llvm.frem", "llvm.log", "llvm.log10", "llvm.log2", "llvm.pow", "llvm.roundeven", "llvm.round", "llvm.sin", "llvm.sqrt"], legal_dialects = ["llvm", "memref", "nvvm", "test"], legal_ops = ["gpu.module", "gpu.yield"], partial_conversion}> ({
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
    ^bb0(%arg13: i32):
      %85 = "llvm.call"(%arg13) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_abs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i32
      "llvm.return"(%85) : (i32) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_53"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, i32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_powif", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, i32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_powi", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64, i32)>, linkage = #llvm.linkage<external>, sym_name = "gpu_powi", visibility_ = 0 : i64}> ({
    ^bb0(%arg10: f32, %arg11: f64, %arg12: i32):
      %80 = "llvm.call"(%arg10, %arg12) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powif, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, i32) -> f32
      %81 = "llvm.call"(%arg11, %arg12) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powi, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, i32) -> f64
      %82 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %83 = "llvm.insertvalue"(%82, %80) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %84 = "llvm.insertvalue"(%83, %81) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%84) : (!llvm.struct<(f32, f64)>) -> ()
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
    ^bb0(%arg8: f32, %arg9: f64):
      %55 = "llvm.call"(%arg8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isinff, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> i32
      %56 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %57 = "llvm.icmp"(%55, %56) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %58 = "llvm.call"(%arg9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isinfd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> i32
      %59 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %60 = "llvm.icmp"(%58, %59) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %61 = "llvm.call"(%arg8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isnanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> i32
      %62 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %63 = "llvm.icmp"(%61, %62) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %64 = "llvm.call"(%arg9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isnand, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> i32
      %65 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %66 = "llvm.icmp"(%64, %65) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %67 = "llvm.call"(%arg8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_finitef, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> i32
      %68 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %69 = "llvm.icmp"(%67, %68) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %70 = "llvm.call"(%arg9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isfinited, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> i32
      %71 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %72 = "llvm.icmp"(%70, %71) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %73 = "llvm.mlir.poison"() : () -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %74 = "llvm.insertvalue"(%73, %57) <{position = array<i64: 0>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %75 = "llvm.insertvalue"(%74, %60) <{position = array<i64: 1>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %76 = "llvm.insertvalue"(%75, %63) <{position = array<i64: 2>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %77 = "llvm.insertvalue"(%76, %66) <{position = array<i64: 3>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %78 = "llvm.insertvalue"(%77, %69) <{position = array<i64: 4>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %79 = "llvm.insertvalue"(%78, %72) <{position = array<i64: 5>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      "llvm.return"(%79) : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_55"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erfcf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erfc", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_erfc", visibility_ = 0 : i64}> ({
    ^bb0(%arg6: f32, %arg7: f64):
      %50 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erfcf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %51 = "llvm.call"(%arg7) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erfc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %52 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %53 = "llvm.insertvalue"(%52, %50) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %54 = "llvm.insertvalue"(%53, %51) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%54) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_56"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sincosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f64, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sincos", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f16, f32, f32, f64, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sincos", visibility_ = 0 : i64}> ({
    ^bb0(%arg3: f16, %arg4: f32, %arg5: f64):
      %25 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %26 = "llvm.alloca"(%25) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %27 = "llvm.alloca"(%25) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %28 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %29 = "llvm.alloca"(%28) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %30 = "llvm.alloca"(%28) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %31 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %32 = "llvm.alloca"(%31) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %33 = "llvm.alloca"(%31) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %34 = "llvm.fpext"(%arg3) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      "llvm.call"(%34, %32, %33) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %35 = "llvm.load"(%32) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %36 = "llvm.load"(%33) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %37 = "llvm.fptrunc"(%35) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %38 = "llvm.fptrunc"(%36) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      "llvm.call"(%arg4, %29, %30) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %39 = "llvm.load"(%29) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %40 = "llvm.load"(%30) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      "llvm.call"(%arg5, %26, %27) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f64, !llvm.ptr, !llvm.ptr) -> ()
      %41 = "llvm.load"(%26) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %42 = "llvm.load"(%27) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %43 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %44 = "llvm.insertvalue"(%43, %37) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %45 = "llvm.insertvalue"(%44, %38) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %46 = "llvm.insertvalue"(%45, %39) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %47 = "llvm.insertvalue"(%46, %40) <{position = array<i64: 3>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %48 = "llvm.insertvalue"(%47, %41) <{position = array<i64: 4>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %49 = "llvm.insertvalue"(%48, %42) <{position = array<i64: 5>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      "llvm.return"(%49) : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_sincosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f16, f32, f32, f64, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sincos_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1 = "llvm.alloca"(%0) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %2 = "llvm.alloca"(%0) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %4 = "llvm.alloca"(%3) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %5 = "llvm.alloca"(%3) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %6 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %7 = "llvm.alloca"(%6) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %8 = "llvm.alloca"(%6) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %9 = "llvm.fpext"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      "llvm.call"(%9, %7, %8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %10 = "llvm.load"(%7) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %11 = "llvm.load"(%8) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %12 = "llvm.fptrunc"(%10) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %13 = "llvm.fptrunc"(%11) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      "llvm.call"(%arg1, %4, %5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %14 = "llvm.load"(%4) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %15 = "llvm.load"(%5) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      "llvm.call"(%arg2, %1, %2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f64, !llvm.ptr, !llvm.ptr) -> ()
      %16 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %17 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %18 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %19 = "llvm.insertvalue"(%18, %12) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %20 = "llvm.insertvalue"(%19, %13) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %21 = "llvm.insertvalue"(%20, %14) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %22 = "llvm.insertvalue"(%21, %15) <{position = array<i64: 3>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %23 = "llvm.insertvalue"(%22, %16) <{position = array<i64: 4>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %24 = "llvm.insertvalue"(%23, %17) <{position = array<i64: 5>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      "llvm.return"(%24) : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>) -> ()
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
      %6 = "nvvm.read.ptx.sreg.cluster.nctaid.x"() <{range = #llvm.constant_range<i32, 8, 9>}> : () -> i32
      %7 = "llvm.sext"(%6) : (i32) -> i64
      %8 = "nvvm.read.ptx.sreg.cluster.nctaid.y"() <{range = #llvm.constant_range<i32, 4, 5>}> : () -> i32
      %9 = "llvm.sext"(%8) : (i32) -> i64
      %10 = "nvvm.read.ptx.sreg.cluster.nctaid.z"() <{range = #llvm.constant_range<i32, 2, 3>}> : () -> i32
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

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i32, i64)> (i1)>, linkage = #llvm.linkage<external>, sym_name = "gpu_ballot", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i1):
      %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1 = "nvvm.vote.sync"(%0, %arg0) <{kind = #nvvm<vote_sync_kind ballot>}> : (i32, i1) -> i32
      %2 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %3 = "nvvm.vote.sync"(%2, %arg0) <{kind = #nvvm<vote_sync_kind ballot>}> : (i32, i1) -> i32
      %4 = "llvm.zext"(%3) : (i32) -> i64
      %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, i64)>
      %6 = "llvm.insertvalue"(%5, %1) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i64)>, i32) -> !llvm.struct<(i32, i64)>
      %7 = "llvm.insertvalue"(%6, %4) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i64)>, i64) -> !llvm.struct<(i32, i64)>
      "llvm.return"(%7) : (!llvm.struct<(i32, i64)>) -> ()
    }) : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()


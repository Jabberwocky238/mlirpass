"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_0"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_ops", visibility_ = 0 : i64}> ({
      %1078 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %1079 = "llvm.sext"(%1078) : (i32) -> i64
      %1080 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %1081 = "llvm.sext"(%1080) : (i32) -> i64
      %1082 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %1083 = "llvm.sext"(%1082) : (i32) -> i64
      %1084 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %1085 = "llvm.sext"(%1084) : (i32) -> i64
      %1086 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %1087 = "llvm.sext"(%1086) : (i32) -> i64
      %1088 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %1089 = "llvm.sext"(%1088) : (i32) -> i64
      %1090 = "nvvm.read.ptx.sreg.ctaid.x"() : () -> i32
      %1091 = "llvm.sext"(%1090) : (i32) -> i64
      %1092 = "nvvm.read.ptx.sreg.ctaid.y"() : () -> i32
      %1093 = "llvm.sext"(%1092) : (i32) -> i64
      %1094 = "nvvm.read.ptx.sreg.ctaid.z"() : () -> i32
      %1095 = "llvm.sext"(%1094) : (i32) -> i64
      %1096 = "nvvm.read.ptx.sreg.nctaid.x"() : () -> i32
      %1097 = "llvm.sext"(%1096) : (i32) -> i64
      %1098 = "nvvm.read.ptx.sreg.nctaid.y"() : () -> i32
      %1099 = "llvm.sext"(%1098) : (i32) -> i64
      %1100 = "nvvm.read.ptx.sreg.nctaid.z"() : () -> i32
      %1101 = "llvm.sext"(%1100) : (i32) -> i64
      %1102 = "nvvm.read.ptx.sreg.laneid"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %1103 = "llvm.sext"(%1102) : (i32) -> i64
      %1104 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1105 = "llvm.insertvalue"(%1104, %1079) <{position = array<i64: 0>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1106 = "llvm.insertvalue"(%1105, %1081) <{position = array<i64: 1>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1107 = "llvm.insertvalue"(%1106, %1083) <{position = array<i64: 2>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1108 = "llvm.insertvalue"(%1107, %1085) <{position = array<i64: 3>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1109 = "llvm.insertvalue"(%1108, %1087) <{position = array<i64: 4>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1110 = "llvm.insertvalue"(%1109, %1089) <{position = array<i64: 5>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1111 = "llvm.insertvalue"(%1110, %1091) <{position = array<i64: 6>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1112 = "llvm.insertvalue"(%1111, %1093) <{position = array<i64: 7>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1113 = "llvm.insertvalue"(%1112, %1095) <{position = array<i64: 8>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1114 = "llvm.insertvalue"(%1113, %1097) <{position = array<i64: 9>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1115 = "llvm.insertvalue"(%1114, %1099) <{position = array<i64: 10>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1116 = "llvm.insertvalue"(%1115, %1101) <{position = array<i64: 11>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1117 = "llvm.insertvalue"(%1116, %1103) <{position = array<i64: 12>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      "llvm.return"(%1117) : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_comp", visibility_ = 0 : i64}> ({
    ^bb0(%arg136: i64):
      %1077 = "llvm.add"(%arg136, %arg136) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.return"(%1077) : (i64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_2"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<32 x f32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_gpu_all_reduce_op_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_all_reduce_op", visibility_ = 0 : i64}> ({
      %823 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_op_0}> : () -> !llvm.ptr<3>
      %824 = "llvm.getelementptr"(%823) <{elem_type = !llvm.array<32 x f32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %825 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %826 = "llvm.insertvalue"(%825, %824) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %827 = "llvm.insertvalue"(%826, %824) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %828 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %829 = "llvm.insertvalue"(%827, %828) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %830 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %831 = "llvm.insertvalue"(%829, %830) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %832 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %833 = "llvm.insertvalue"(%831, %832) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %834 = "builtin.unrealized_conversion_cast"(%833) : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<32xf32, #gpu.address_space<workgroup>>
      %835 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %836 = "builtin.unrealized_conversion_cast"(%835) : (i64) -> index
      %837 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %838 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %839 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %840 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %841 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %842 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %843 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %844 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %845 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %846 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %847 = "llvm.sext"(%846) : (i32) -> i64
      %848 = "llvm.trunc"(%847) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %849 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %850 = "llvm.sext"(%849) : (i32) -> i64
      %851 = "llvm.trunc"(%850) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %852 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %853 = "llvm.sext"(%852) : (i32) -> i64
      %854 = "llvm.trunc"(%853) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %855 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %856 = "llvm.sext"(%855) : (i32) -> i64
      %857 = "llvm.trunc"(%856) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %858 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %859 = "llvm.sext"(%858) : (i32) -> i64
      %860 = "llvm.trunc"(%859) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %861 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %862 = "llvm.sext"(%861) : (i32) -> i64
      %863 = "llvm.trunc"(%862) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %864 = "llvm.mul"(%863, %851) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %865 = "llvm.add"(%864, %860) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %866 = "llvm.mul"(%865, %848) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %867 = "llvm.mul"(%848, %851) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %868 = "llvm.add"(%866, %857) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %869 = "llvm.mul"(%867, %854) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %870 = "llvm.and"(%868, %844) : (i32, i32) -> i32
      %871 = "llvm.icmp"(%870, %843) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %872 = "llvm.sub"(%868, %870) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %873 = "llvm.sub"(%869, %872) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %874 = "llvm.icmp"(%873, %842) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%874)[^bb1, ^bb17] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %875 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %876 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %877 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %878 = "llvm.sub"(%877, %873) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %879 = "llvm.lshr"(%876, %878) : (i32, i32) -> i32
      %880 = "llvm.sub"(%873, %875) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %881 = "nvvm.shfl.sync"(%879, %845, %841, %880) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %882 = "llvm.extractvalue"(%881) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %883 = "llvm.extractvalue"(%881) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%883)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %884 = "llvm.fadd"(%882, %845) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%884)[^bb4] : (f32) -> ()
    ^bb3:  // pred: ^bb1
      "llvm.br"(%845)[^bb4] : (f32) -> ()
    ^bb4(%885: f32):  // 2 preds: ^bb2, ^bb3
      %886 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %887 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %888 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %889 = "llvm.sub"(%888, %873) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %890 = "llvm.lshr"(%887, %889) : (i32, i32) -> i32
      %891 = "llvm.sub"(%873, %886) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %892 = "nvvm.shfl.sync"(%890, %885, %840, %891) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %893 = "llvm.extractvalue"(%892) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %894 = "llvm.extractvalue"(%892) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%894)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb5:  // pred: ^bb4
      %895 = "llvm.fadd"(%885, %893) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%895)[^bb7] : (f32) -> ()
    ^bb6:  // pred: ^bb4
      "llvm.br"(%885)[^bb7] : (f32) -> ()
    ^bb7(%896: f32):  // 2 preds: ^bb5, ^bb6
      %897 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %898 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %899 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %900 = "llvm.sub"(%899, %873) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %901 = "llvm.lshr"(%898, %900) : (i32, i32) -> i32
      %902 = "llvm.sub"(%873, %897) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %903 = "nvvm.shfl.sync"(%901, %896, %839, %902) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %904 = "llvm.extractvalue"(%903) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %905 = "llvm.extractvalue"(%903) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%905)[^bb8, ^bb9] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb8:  // pred: ^bb7
      %906 = "llvm.fadd"(%896, %904) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%906)[^bb10] : (f32) -> ()
    ^bb9:  // pred: ^bb7
      "llvm.br"(%896)[^bb10] : (f32) -> ()
    ^bb10(%907: f32):  // 2 preds: ^bb8, ^bb9
      %908 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %909 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %910 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %911 = "llvm.sub"(%910, %873) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %912 = "llvm.lshr"(%909, %911) : (i32, i32) -> i32
      %913 = "llvm.sub"(%873, %908) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %914 = "nvvm.shfl.sync"(%912, %907, %838, %913) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %915 = "llvm.extractvalue"(%914) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %916 = "llvm.extractvalue"(%914) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%916)[^bb11, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb11:  // pred: ^bb10
      %917 = "llvm.fadd"(%907, %915) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%917)[^bb13] : (f32) -> ()
    ^bb12:  // pred: ^bb10
      "llvm.br"(%907)[^bb13] : (f32) -> ()
    ^bb13(%918: f32):  // 2 preds: ^bb11, ^bb12
      %919 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %920 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %921 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %922 = "llvm.sub"(%921, %873) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %923 = "llvm.lshr"(%920, %922) : (i32, i32) -> i32
      %924 = "llvm.sub"(%873, %919) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %925 = "nvvm.shfl.sync"(%923, %918, %837, %924) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %926 = "llvm.extractvalue"(%925) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %927 = "llvm.extractvalue"(%925) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%927)[^bb14, ^bb15] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb14:  // pred: ^bb13
      %928 = "llvm.fadd"(%918, %926) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%928)[^bb16] : (f32) -> ()
    ^bb15:  // pred: ^bb13
      "llvm.br"(%918)[^bb16] : (f32) -> ()
    ^bb16(%929: f32):  // 2 preds: ^bb14, ^bb15
      "llvm.br"(%929)[^bb18] : (f32) -> ()
    ^bb17:  // pred: ^bb0
      %930 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %931 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %932 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %933 = "llvm.sub"(%932, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %934 = "llvm.lshr"(%931, %933) : (i32, i32) -> i32
      %935 = "llvm.sub"(%842, %930) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %936 = "nvvm.shfl.sync"(%934, %845, %841, %935) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %937 = "llvm.fadd"(%936, %845) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %938 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %939 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %940 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %941 = "llvm.sub"(%940, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %942 = "llvm.lshr"(%939, %941) : (i32, i32) -> i32
      %943 = "llvm.sub"(%842, %938) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %944 = "nvvm.shfl.sync"(%942, %937, %840, %943) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %945 = "llvm.fadd"(%937, %944) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %946 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %947 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %948 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %949 = "llvm.sub"(%948, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %950 = "llvm.lshr"(%947, %949) : (i32, i32) -> i32
      %951 = "llvm.sub"(%842, %946) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %952 = "nvvm.shfl.sync"(%950, %945, %839, %951) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %953 = "llvm.fadd"(%945, %952) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %954 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %955 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %956 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %957 = "llvm.sub"(%956, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %958 = "llvm.lshr"(%955, %957) : (i32, i32) -> i32
      %959 = "llvm.sub"(%842, %954) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %960 = "nvvm.shfl.sync"(%958, %953, %838, %959) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %961 = "llvm.fadd"(%953, %960) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %962 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %963 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %964 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %965 = "llvm.sub"(%964, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %966 = "llvm.lshr"(%963, %965) : (i32, i32) -> i32
      %967 = "llvm.sub"(%842, %962) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %968 = "nvvm.shfl.sync"(%966, %961, %837, %967) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %969 = "llvm.fadd"(%961, %968) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%969)[^bb18] : (f32) -> ()
    ^bb18(%970: f32):  // 2 preds: ^bb16, ^bb17
      "llvm.cond_br"(%871)[^bb19, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb19:  // pred: ^bb18
      %971 = "llvm.sdiv"(%868, %842) : (i32, i32) -> i32
      %972 = "llvm.sext"(%971) : (i32) -> i64
      %973 = "builtin.unrealized_conversion_cast"(%972) : (i64) -> index
      "memref.store"(%970, %834, %973) <{nontemporal = false}> : (f32, memref<32xf32, #gpu.address_space<workgroup>>, index) -> ()
      "llvm.br"()[^bb21] : () -> ()
    ^bb20:  // pred: ^bb18
      "llvm.br"()[^bb21] : () -> ()
    ^bb21:  // 2 preds: ^bb19, ^bb20
      "nvvm.barrier"() <{aligned = true, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      %974 = "llvm.add"(%869, %844) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %975 = "llvm.sdiv"(%974, %842) : (i32, i32) -> i32
      %976 = "llvm.icmp"(%868, %975) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%976)[^bb22, ^bb41] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb22:  // pred: ^bb21
      %977 = "llvm.sext"(%868) : (i32) -> i64
      %978 = "builtin.unrealized_conversion_cast"(%977) : (i64) -> index
      %979 = "memref.load"(%834, %978) <{invariant = false, nontemporal = false}> : (memref<32xf32, #gpu.address_space<workgroup>>, index) -> f32
      %980 = "llvm.icmp"(%975, %842) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%980)[^bb23, ^bb39] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb23:  // pred: ^bb22
      %981 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %982 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %983 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %984 = "llvm.sub"(%983, %975) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %985 = "llvm.lshr"(%982, %984) : (i32, i32) -> i32
      %986 = "llvm.sub"(%975, %981) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %987 = "nvvm.shfl.sync"(%985, %979, %841, %986) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %988 = "llvm.extractvalue"(%987) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %989 = "llvm.extractvalue"(%987) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%989)[^bb24, ^bb25] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb24:  // pred: ^bb23
      %990 = "llvm.fadd"(%979, %988) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%990)[^bb26] : (f32) -> ()
    ^bb25:  // pred: ^bb23
      "llvm.br"(%979)[^bb26] : (f32) -> ()
    ^bb26(%991: f32):  // 2 preds: ^bb24, ^bb25
      %992 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %993 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %994 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %995 = "llvm.sub"(%994, %975) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %996 = "llvm.lshr"(%993, %995) : (i32, i32) -> i32
      %997 = "llvm.sub"(%975, %992) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %998 = "nvvm.shfl.sync"(%996, %991, %840, %997) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %999 = "llvm.extractvalue"(%998) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %1000 = "llvm.extractvalue"(%998) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%1000)[^bb27, ^bb28] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb27:  // pred: ^bb26
      %1001 = "llvm.fadd"(%991, %999) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1001)[^bb29] : (f32) -> ()
    ^bb28:  // pred: ^bb26
      "llvm.br"(%991)[^bb29] : (f32) -> ()
    ^bb29(%1002: f32):  // 2 preds: ^bb27, ^bb28
      %1003 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1004 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1005 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1006 = "llvm.sub"(%1005, %975) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1007 = "llvm.lshr"(%1004, %1006) : (i32, i32) -> i32
      %1008 = "llvm.sub"(%975, %1003) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1009 = "nvvm.shfl.sync"(%1007, %1002, %839, %1008) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %1010 = "llvm.extractvalue"(%1009) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %1011 = "llvm.extractvalue"(%1009) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%1011)[^bb30, ^bb31] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb30:  // pred: ^bb29
      %1012 = "llvm.fadd"(%1002, %1010) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1012)[^bb32] : (f32) -> ()
    ^bb31:  // pred: ^bb29
      "llvm.br"(%1002)[^bb32] : (f32) -> ()
    ^bb32(%1013: f32):  // 2 preds: ^bb30, ^bb31
      %1014 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1015 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1016 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1017 = "llvm.sub"(%1016, %975) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1018 = "llvm.lshr"(%1015, %1017) : (i32, i32) -> i32
      %1019 = "llvm.sub"(%975, %1014) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1020 = "nvvm.shfl.sync"(%1018, %1013, %838, %1019) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %1021 = "llvm.extractvalue"(%1020) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %1022 = "llvm.extractvalue"(%1020) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%1022)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %1023 = "llvm.fadd"(%1013, %1021) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1023)[^bb35] : (f32) -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"(%1013)[^bb35] : (f32) -> ()
    ^bb35(%1024: f32):  // 2 preds: ^bb33, ^bb34
      %1025 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1026 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1027 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1028 = "llvm.sub"(%1027, %975) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1029 = "llvm.lshr"(%1026, %1028) : (i32, i32) -> i32
      %1030 = "llvm.sub"(%975, %1025) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1031 = "nvvm.shfl.sync"(%1029, %1024, %837, %1030) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %1032 = "llvm.extractvalue"(%1031) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %1033 = "llvm.extractvalue"(%1031) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%1033)[^bb36, ^bb37] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %1034 = "llvm.fadd"(%1024, %1032) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1034)[^bb38] : (f32) -> ()
    ^bb37:  // pred: ^bb35
      "llvm.br"(%1024)[^bb38] : (f32) -> ()
    ^bb38(%1035: f32):  // 2 preds: ^bb36, ^bb37
      "llvm.br"(%1035)[^bb40] : (f32) -> ()
    ^bb39:  // pred: ^bb22
      %1036 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1037 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1038 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1039 = "llvm.sub"(%1038, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1040 = "llvm.lshr"(%1037, %1039) : (i32, i32) -> i32
      %1041 = "llvm.sub"(%842, %1036) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1042 = "nvvm.shfl.sync"(%1040, %979, %841, %1041) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1043 = "llvm.fadd"(%979, %1042) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1044 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1045 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1046 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1047 = "llvm.sub"(%1046, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1048 = "llvm.lshr"(%1045, %1047) : (i32, i32) -> i32
      %1049 = "llvm.sub"(%842, %1044) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1050 = "nvvm.shfl.sync"(%1048, %1043, %840, %1049) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1051 = "llvm.fadd"(%1043, %1050) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1052 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1053 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1054 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1055 = "llvm.sub"(%1054, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1056 = "llvm.lshr"(%1053, %1055) : (i32, i32) -> i32
      %1057 = "llvm.sub"(%842, %1052) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1058 = "nvvm.shfl.sync"(%1056, %1051, %839, %1057) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1059 = "llvm.fadd"(%1051, %1058) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1060 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1061 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1062 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1063 = "llvm.sub"(%1062, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1064 = "llvm.lshr"(%1061, %1063) : (i32, i32) -> i32
      %1065 = "llvm.sub"(%842, %1060) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1066 = "nvvm.shfl.sync"(%1064, %1059, %838, %1065) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1067 = "llvm.fadd"(%1059, %1066) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1068 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1069 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1070 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1071 = "llvm.sub"(%1070, %842) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1072 = "llvm.lshr"(%1069, %1071) : (i32, i32) -> i32
      %1073 = "llvm.sub"(%842, %1068) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1074 = "nvvm.shfl.sync"(%1072, %1067, %837, %1073) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1075 = "llvm.fadd"(%1067, %1074) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1075)[^bb40] : (f32) -> ()
    ^bb40(%1076: f32):  // 2 preds: ^bb38, ^bb39
      "memref.store"(%1076, %834, %836) <{nontemporal = false}> : (f32, memref<32xf32, #gpu.address_space<workgroup>>, index) -> ()
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
      %570 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_region_0}> : () -> !llvm.ptr<3>
      %571 = "llvm.getelementptr"(%570) <{elem_type = !llvm.array<32 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %572 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %573 = "llvm.insertvalue"(%572, %571) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %574 = "llvm.insertvalue"(%573, %571) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %575 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %576 = "llvm.insertvalue"(%574, %575) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %577 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %578 = "llvm.insertvalue"(%576, %577) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %579 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %580 = "llvm.insertvalue"(%578, %579) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %581 = "builtin.unrealized_conversion_cast"(%580) : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<32xi32, #gpu.address_space<workgroup>>
      %582 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %583 = "builtin.unrealized_conversion_cast"(%582) : (i64) -> index
      %584 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %585 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %586 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %587 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %588 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %589 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %590 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %591 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %592 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %593 = "llvm.sext"(%592) : (i32) -> i64
      %594 = "llvm.trunc"(%593) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %595 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %596 = "llvm.sext"(%595) : (i32) -> i64
      %597 = "llvm.trunc"(%596) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %598 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %599 = "llvm.sext"(%598) : (i32) -> i64
      %600 = "llvm.trunc"(%599) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %601 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %602 = "llvm.sext"(%601) : (i32) -> i64
      %603 = "llvm.trunc"(%602) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %604 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %605 = "llvm.sext"(%604) : (i32) -> i64
      %606 = "llvm.trunc"(%605) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %607 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %608 = "llvm.sext"(%607) : (i32) -> i64
      %609 = "llvm.trunc"(%608) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %610 = "llvm.mul"(%609, %597) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %611 = "llvm.add"(%610, %606) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %612 = "llvm.mul"(%611, %594) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %613 = "llvm.mul"(%594, %597) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %614 = "llvm.add"(%612, %603) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %615 = "llvm.mul"(%613, %600) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %616 = "llvm.and"(%614, %590) : (i32, i32) -> i32
      %617 = "llvm.icmp"(%616, %589) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %618 = "llvm.sub"(%614, %616) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %619 = "llvm.sub"(%615, %618) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %620 = "llvm.icmp"(%619, %588) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%620)[^bb1, ^bb22] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %621 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %622 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %623 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %624 = "llvm.sub"(%623, %619) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %625 = "llvm.lshr"(%622, %624) : (i32, i32) -> i32
      %626 = "llvm.sub"(%619, %621) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %627 = "nvvm.shfl.sync"(%625, %591, %591, %626) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %628 = "llvm.extractvalue"(%627) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %629 = "llvm.extractvalue"(%627) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%629, %591)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb2:  // pred: ^bb1
      "llvm.br"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      %630 = "llvm.xor"(%628, %591) : (i32, i32) -> i32
      "llvm.br"(%630)[^bb4] : (i32) -> ()
    ^bb4(%631: i32):  // 2 preds: ^bb1, ^bb3
      "llvm.br"()[^bb5] : () -> ()
    ^bb5:  // pred: ^bb4
      %632 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %633 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %634 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %635 = "llvm.sub"(%634, %619) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %636 = "llvm.lshr"(%633, %635) : (i32, i32) -> i32
      %637 = "llvm.sub"(%619, %632) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %638 = "nvvm.shfl.sync"(%636, %631, %587, %637) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %639 = "llvm.extractvalue"(%638) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %640 = "llvm.extractvalue"(%638) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%640, %631)[^bb6, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb6:  // pred: ^bb5
      "llvm.br"()[^bb7] : () -> ()
    ^bb7:  // pred: ^bb6
      %641 = "llvm.xor"(%631, %639) : (i32, i32) -> i32
      "llvm.br"(%641)[^bb8] : (i32) -> ()
    ^bb8(%642: i32):  // 2 preds: ^bb5, ^bb7
      "llvm.br"()[^bb9] : () -> ()
    ^bb9:  // pred: ^bb8
      %643 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %644 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %645 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %646 = "llvm.sub"(%645, %619) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %647 = "llvm.lshr"(%644, %646) : (i32, i32) -> i32
      %648 = "llvm.sub"(%619, %643) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %649 = "nvvm.shfl.sync"(%647, %642, %586, %648) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %650 = "llvm.extractvalue"(%649) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %651 = "llvm.extractvalue"(%649) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%651, %642)[^bb10, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb10:  // pred: ^bb9
      "llvm.br"()[^bb11] : () -> ()
    ^bb11:  // pred: ^bb10
      %652 = "llvm.xor"(%642, %650) : (i32, i32) -> i32
      "llvm.br"(%652)[^bb12] : (i32) -> ()
    ^bb12(%653: i32):  // 2 preds: ^bb9, ^bb11
      "llvm.br"()[^bb13] : () -> ()
    ^bb13:  // pred: ^bb12
      %654 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %655 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %656 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %657 = "llvm.sub"(%656, %619) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %658 = "llvm.lshr"(%655, %657) : (i32, i32) -> i32
      %659 = "llvm.sub"(%619, %654) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %660 = "nvvm.shfl.sync"(%658, %653, %585, %659) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %661 = "llvm.extractvalue"(%660) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %662 = "llvm.extractvalue"(%660) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%662, %653)[^bb14, ^bb16] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb14:  // pred: ^bb13
      "llvm.br"()[^bb15] : () -> ()
    ^bb15:  // pred: ^bb14
      %663 = "llvm.xor"(%653, %661) : (i32, i32) -> i32
      "llvm.br"(%663)[^bb16] : (i32) -> ()
    ^bb16(%664: i32):  // 2 preds: ^bb13, ^bb15
      "llvm.br"()[^bb17] : () -> ()
    ^bb17:  // pred: ^bb16
      %665 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %666 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %667 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %668 = "llvm.sub"(%667, %619) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %669 = "llvm.lshr"(%666, %668) : (i32, i32) -> i32
      %670 = "llvm.sub"(%619, %665) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %671 = "nvvm.shfl.sync"(%669, %664, %584, %670) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %672 = "llvm.extractvalue"(%671) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %673 = "llvm.extractvalue"(%671) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%673, %664)[^bb18, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb18:  // pred: ^bb17
      "llvm.br"()[^bb19] : () -> ()
    ^bb19:  // pred: ^bb18
      %674 = "llvm.xor"(%664, %672) : (i32, i32) -> i32
      "llvm.br"(%674)[^bb20] : (i32) -> ()
    ^bb20(%675: i32):  // 2 preds: ^bb17, ^bb19
      "llvm.br"(%675)[^bb21] : (i32) -> ()
    ^bb21(%676: i32):  // 2 preds: ^bb20, ^bb31
      "llvm.br"()[^bb32] : () -> ()
    ^bb22:  // pred: ^bb0
      %677 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %678 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %679 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %680 = "llvm.sub"(%679, %588) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %681 = "llvm.lshr"(%678, %680) : (i32, i32) -> i32
      %682 = "llvm.sub"(%588, %677) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %683 = "nvvm.shfl.sync"(%681, %591, %591, %682) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb23] : () -> ()
    ^bb23:  // pred: ^bb22
      %684 = "llvm.xor"(%683, %591) : (i32, i32) -> i32
      "llvm.br"()[^bb24] : () -> ()
    ^bb24:  // pred: ^bb23
      %685 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %686 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %687 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %688 = "llvm.sub"(%687, %588) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %689 = "llvm.lshr"(%686, %688) : (i32, i32) -> i32
      %690 = "llvm.sub"(%588, %685) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %691 = "nvvm.shfl.sync"(%689, %684, %587, %690) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb25] : () -> ()
    ^bb25:  // pred: ^bb24
      %692 = "llvm.xor"(%684, %691) : (i32, i32) -> i32
      "llvm.br"()[^bb26] : () -> ()
    ^bb26:  // pred: ^bb25
      %693 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %694 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %695 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %696 = "llvm.sub"(%695, %588) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %697 = "llvm.lshr"(%694, %696) : (i32, i32) -> i32
      %698 = "llvm.sub"(%588, %693) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %699 = "nvvm.shfl.sync"(%697, %692, %586, %698) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb27] : () -> ()
    ^bb27:  // pred: ^bb26
      %700 = "llvm.xor"(%692, %699) : (i32, i32) -> i32
      "llvm.br"()[^bb28] : () -> ()
    ^bb28:  // pred: ^bb27
      %701 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %702 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %703 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %704 = "llvm.sub"(%703, %588) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %705 = "llvm.lshr"(%702, %704) : (i32, i32) -> i32
      %706 = "llvm.sub"(%588, %701) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %707 = "nvvm.shfl.sync"(%705, %700, %585, %706) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb29] : () -> ()
    ^bb29:  // pred: ^bb28
      %708 = "llvm.xor"(%700, %707) : (i32, i32) -> i32
      "llvm.br"()[^bb30] : () -> ()
    ^bb30:  // pred: ^bb29
      %709 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %710 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %711 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %712 = "llvm.sub"(%711, %588) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %713 = "llvm.lshr"(%710, %712) : (i32, i32) -> i32
      %714 = "llvm.sub"(%588, %709) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %715 = "nvvm.shfl.sync"(%713, %708, %584, %714) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb31] : () -> ()
    ^bb31:  // pred: ^bb30
      %716 = "llvm.xor"(%708, %715) : (i32, i32) -> i32
      "llvm.br"(%716)[^bb21] : (i32) -> ()
    ^bb32:  // pred: ^bb21
      "llvm.cond_br"(%617)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %717 = "llvm.sdiv"(%614, %588) : (i32, i32) -> i32
      %718 = "llvm.sext"(%717) : (i32) -> i64
      %719 = "builtin.unrealized_conversion_cast"(%718) : (i64) -> index
      "memref.store"(%676, %581, %719) <{nontemporal = false}> : (i32, memref<32xi32, #gpu.address_space<workgroup>>, index) -> ()
      "llvm.br"()[^bb35] : () -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"()[^bb35] : () -> ()
    ^bb35:  // 2 preds: ^bb33, ^bb34
      "nvvm.barrier"() <{aligned = true, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      %720 = "llvm.add"(%615, %590) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %721 = "llvm.sdiv"(%720, %588) : (i32, i32) -> i32
      %722 = "llvm.icmp"(%614, %721) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%722)[^bb36, ^bb69] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %723 = "llvm.sext"(%614) : (i32) -> i64
      %724 = "builtin.unrealized_conversion_cast"(%723) : (i64) -> index
      %725 = "memref.load"(%581, %724) <{invariant = false, nontemporal = false}> : (memref<32xi32, #gpu.address_space<workgroup>>, index) -> i32
      %726 = "llvm.icmp"(%721, %588) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%726)[^bb37, ^bb58] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb37:  // pred: ^bb36
      %727 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %728 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %729 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %730 = "llvm.sub"(%729, %721) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %731 = "llvm.lshr"(%728, %730) : (i32, i32) -> i32
      %732 = "llvm.sub"(%721, %727) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %733 = "nvvm.shfl.sync"(%731, %725, %591, %732) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %734 = "llvm.extractvalue"(%733) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %735 = "llvm.extractvalue"(%733) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%735, %725)[^bb38, ^bb40] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb38:  // pred: ^bb37
      "llvm.br"()[^bb39] : () -> ()
    ^bb39:  // pred: ^bb38
      %736 = "llvm.xor"(%725, %734) : (i32, i32) -> i32
      "llvm.br"(%736)[^bb40] : (i32) -> ()
    ^bb40(%737: i32):  // 2 preds: ^bb37, ^bb39
      "llvm.br"()[^bb41] : () -> ()
    ^bb41:  // pred: ^bb40
      %738 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %739 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %740 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %741 = "llvm.sub"(%740, %721) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %742 = "llvm.lshr"(%739, %741) : (i32, i32) -> i32
      %743 = "llvm.sub"(%721, %738) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %744 = "nvvm.shfl.sync"(%742, %737, %587, %743) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %745 = "llvm.extractvalue"(%744) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %746 = "llvm.extractvalue"(%744) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%746, %737)[^bb42, ^bb44] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb42:  // pred: ^bb41
      "llvm.br"()[^bb43] : () -> ()
    ^bb43:  // pred: ^bb42
      %747 = "llvm.xor"(%737, %745) : (i32, i32) -> i32
      "llvm.br"(%747)[^bb44] : (i32) -> ()
    ^bb44(%748: i32):  // 2 preds: ^bb41, ^bb43
      "llvm.br"()[^bb45] : () -> ()
    ^bb45:  // pred: ^bb44
      %749 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %750 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %751 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %752 = "llvm.sub"(%751, %721) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %753 = "llvm.lshr"(%750, %752) : (i32, i32) -> i32
      %754 = "llvm.sub"(%721, %749) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %755 = "nvvm.shfl.sync"(%753, %748, %586, %754) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %756 = "llvm.extractvalue"(%755) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %757 = "llvm.extractvalue"(%755) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%757, %748)[^bb46, ^bb48] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb46:  // pred: ^bb45
      "llvm.br"()[^bb47] : () -> ()
    ^bb47:  // pred: ^bb46
      %758 = "llvm.xor"(%748, %756) : (i32, i32) -> i32
      "llvm.br"(%758)[^bb48] : (i32) -> ()
    ^bb48(%759: i32):  // 2 preds: ^bb45, ^bb47
      "llvm.br"()[^bb49] : () -> ()
    ^bb49:  // pred: ^bb48
      %760 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %761 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %762 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %763 = "llvm.sub"(%762, %721) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %764 = "llvm.lshr"(%761, %763) : (i32, i32) -> i32
      %765 = "llvm.sub"(%721, %760) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %766 = "nvvm.shfl.sync"(%764, %759, %585, %765) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %767 = "llvm.extractvalue"(%766) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %768 = "llvm.extractvalue"(%766) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%768, %759)[^bb50, ^bb52] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb50:  // pred: ^bb49
      "llvm.br"()[^bb51] : () -> ()
    ^bb51:  // pred: ^bb50
      %769 = "llvm.xor"(%759, %767) : (i32, i32) -> i32
      "llvm.br"(%769)[^bb52] : (i32) -> ()
    ^bb52(%770: i32):  // 2 preds: ^bb49, ^bb51
      "llvm.br"()[^bb53] : () -> ()
    ^bb53:  // pred: ^bb52
      %771 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %772 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %773 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %774 = "llvm.sub"(%773, %721) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %775 = "llvm.lshr"(%772, %774) : (i32, i32) -> i32
      %776 = "llvm.sub"(%721, %771) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %777 = "nvvm.shfl.sync"(%775, %770, %584, %776) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %778 = "llvm.extractvalue"(%777) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %779 = "llvm.extractvalue"(%777) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%779, %770)[^bb54, ^bb56] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb54:  // pred: ^bb53
      "llvm.br"()[^bb55] : () -> ()
    ^bb55:  // pred: ^bb54
      %780 = "llvm.xor"(%770, %778) : (i32, i32) -> i32
      "llvm.br"(%780)[^bb56] : (i32) -> ()
    ^bb56(%781: i32):  // 2 preds: ^bb53, ^bb55
      "llvm.br"(%781)[^bb57] : (i32) -> ()
    ^bb57(%782: i32):  // 2 preds: ^bb56, ^bb67
      "llvm.br"()[^bb68] : () -> ()
    ^bb58:  // pred: ^bb36
      %783 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %784 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %785 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %786 = "llvm.sub"(%785, %588) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %787 = "llvm.lshr"(%784, %786) : (i32, i32) -> i32
      %788 = "llvm.sub"(%588, %783) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %789 = "nvvm.shfl.sync"(%787, %725, %591, %788) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb59] : () -> ()
    ^bb59:  // pred: ^bb58
      %790 = "llvm.xor"(%725, %789) : (i32, i32) -> i32
      "llvm.br"()[^bb60] : () -> ()
    ^bb60:  // pred: ^bb59
      %791 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %792 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %793 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %794 = "llvm.sub"(%793, %588) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %795 = "llvm.lshr"(%792, %794) : (i32, i32) -> i32
      %796 = "llvm.sub"(%588, %791) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %797 = "nvvm.shfl.sync"(%795, %790, %587, %796) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb61] : () -> ()
    ^bb61:  // pred: ^bb60
      %798 = "llvm.xor"(%790, %797) : (i32, i32) -> i32
      "llvm.br"()[^bb62] : () -> ()
    ^bb62:  // pred: ^bb61
      %799 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %800 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %801 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %802 = "llvm.sub"(%801, %588) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %803 = "llvm.lshr"(%800, %802) : (i32, i32) -> i32
      %804 = "llvm.sub"(%588, %799) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %805 = "nvvm.shfl.sync"(%803, %798, %586, %804) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb63] : () -> ()
    ^bb63:  // pred: ^bb62
      %806 = "llvm.xor"(%798, %805) : (i32, i32) -> i32
      "llvm.br"()[^bb64] : () -> ()
    ^bb64:  // pred: ^bb63
      %807 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %808 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %809 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %810 = "llvm.sub"(%809, %588) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %811 = "llvm.lshr"(%808, %810) : (i32, i32) -> i32
      %812 = "llvm.sub"(%588, %807) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %813 = "nvvm.shfl.sync"(%811, %806, %585, %812) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb65] : () -> ()
    ^bb65:  // pred: ^bb64
      %814 = "llvm.xor"(%806, %813) : (i32, i32) -> i32
      "llvm.br"()[^bb66] : () -> ()
    ^bb66:  // pred: ^bb65
      %815 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %816 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %817 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %818 = "llvm.sub"(%817, %588) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %819 = "llvm.lshr"(%816, %818) : (i32, i32) -> i32
      %820 = "llvm.sub"(%588, %815) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %821 = "nvvm.shfl.sync"(%819, %814, %584, %820) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb67] : () -> ()
    ^bb67:  // pred: ^bb66
      %822 = "llvm.xor"(%814, %821) : (i32, i32) -> i32
      "llvm.br"(%822)[^bb57] : (i32) -> ()
    ^bb68:  // pred: ^bb57
      "memref.store"(%782, %581, %583) <{nontemporal = false}> : (i32, memref<32xi32, #gpu.address_space<workgroup>>, index) -> ()
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
      %523 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %524 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %525 = "llvm.mlir.constant"() <{value = 23 : i32}> : () -> i32
      %526 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %527 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %528 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %529 = "llvm.sub"(%528, %525) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %530 = "llvm.lshr"(%527, %529) : (i32, i32) -> i32
      %531 = "llvm.sub"(%525, %526) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %532 = "nvvm.shfl.sync"(%530, %523, %524, %531) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %533 = "llvm.extractvalue"(%532) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %534 = "llvm.extractvalue"(%532) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %535 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %536 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %537 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %538 = "llvm.sub"(%537, %525) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %539 = "llvm.lshr"(%536, %538) : (i32, i32) -> i32
      %540 = "nvvm.shfl.sync"(%539, %523, %524, %538) <{kind = #nvvm<shfl_kind up>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %541 = "llvm.extractvalue"(%540) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %542 = "llvm.extractvalue"(%540) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %543 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %544 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %545 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %546 = "llvm.sub"(%545, %525) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %547 = "llvm.lshr"(%544, %546) : (i32, i32) -> i32
      %548 = "llvm.sub"(%525, %543) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %549 = "nvvm.shfl.sync"(%547, %523, %524, %548) <{kind = #nvvm<shfl_kind down>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %550 = "llvm.extractvalue"(%549) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %551 = "llvm.extractvalue"(%549) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %552 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %553 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %554 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %555 = "llvm.sub"(%554, %525) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %556 = "llvm.lshr"(%553, %555) : (i32, i32) -> i32
      %557 = "llvm.sub"(%525, %552) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %558 = "nvvm.shfl.sync"(%556, %523, %524, %557) <{kind = #nvvm<shfl_kind idx>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %559 = "llvm.extractvalue"(%558) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %560 = "llvm.extractvalue"(%558) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %561 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %562 = "llvm.insertvalue"(%561, %533) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %563 = "llvm.insertvalue"(%562, %541) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %564 = "llvm.insertvalue"(%563, %550) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %565 = "llvm.insertvalue"(%564, %559) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %566 = "llvm.insertvalue"(%565, %534) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %567 = "llvm.insertvalue"(%566, %542) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %568 = "llvm.insertvalue"(%567, %551) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %569 = "llvm.insertvalue"(%568, %560) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      "llvm.return"(%569) : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>) -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f32, f32)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffle_unused_pred", visibility_ = 0 : i64}> ({
      %488 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %489 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %490 = "llvm.mlir.constant"() <{value = 23 : i32}> : () -> i32
      %491 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %492 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %493 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %494 = "llvm.sub"(%493, %490) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %495 = "llvm.lshr"(%492, %494) : (i32, i32) -> i32
      %496 = "llvm.sub"(%490, %491) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %497 = "nvvm.shfl.sync"(%495, %488, %489, %496) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %498 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %499 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %500 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %501 = "llvm.sub"(%500, %490) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %502 = "llvm.lshr"(%499, %501) : (i32, i32) -> i32
      %503 = "nvvm.shfl.sync"(%502, %488, %489, %501) <{kind = #nvvm<shfl_kind up>}> : (i32, f32, i32, i32) -> f32
      %504 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %505 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %506 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %507 = "llvm.sub"(%506, %490) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %508 = "llvm.lshr"(%505, %507) : (i32, i32) -> i32
      %509 = "llvm.sub"(%490, %504) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %510 = "nvvm.shfl.sync"(%508, %488, %489, %509) <{kind = #nvvm<shfl_kind down>}> : (i32, f32, i32, i32) -> f32
      %511 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %512 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %513 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %514 = "llvm.sub"(%513, %490) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %515 = "llvm.lshr"(%512, %514) : (i32, i32) -> i32
      %516 = "llvm.sub"(%490, %511) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %517 = "nvvm.shfl.sync"(%515, %488, %489, %516) <{kind = #nvvm<shfl_kind idx>}> : (i32, f32, i32, i32) -> f32
      %518 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32, f32)>
      %519 = "llvm.insertvalue"(%518, %497) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %520 = "llvm.insertvalue"(%519, %503) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %521 = "llvm.insertvalue"(%520, %510) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %522 = "llvm.insertvalue"(%521, %517) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      "llvm.return"(%522) : (!llvm.struct<(f32, f32, f32, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_5"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_sync", visibility_ = 0 : i64}> ({
      "nvvm.barrier"() <{aligned = true, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_sync_subgroup", visibility_ = 0 : i64}> ({
      %487 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      "nvvm.bar.warp.sync"(%487) : (i32) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "gpu_named_barriers", visibility_ = 0 : i64}> ({
    ^bb0(%arg135: i32):
      %468 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %469 = "llvm.mlir.addressof"() <{global_name = @__named_barrier_id}> : () -> !llvm.ptr
      %470 = "llvm.load"(%469) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
      %471 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %472 = "llvm.mul"(%arg135, %471) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %473 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, i32)>
      %474 = "llvm.insertvalue"(%473, %470) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %475 = "llvm.insertvalue"(%474, %472) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %476 = "llvm.mlir.addressof"() <{global_name = @__named_barrier_id_0}> : () -> !llvm.ptr
      %477 = "llvm.load"(%476) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
      %478 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %479 = "llvm.mul"(%468, %478) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %480 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, i32)>
      %481 = "llvm.insertvalue"(%480, %477) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %482 = "llvm.insertvalue"(%481, %479) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %483 = "llvm.extractvalue"(%475) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
      %484 = "llvm.extractvalue"(%475) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
      "nvvm.barrier"(%483, %484) <{aligned = true, operandSegmentSizes = array<i32: 1, 1>}> : (i32, i32) -> ()
      %485 = "llvm.extractvalue"(%482) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
      %486 = "llvm.extractvalue"(%482) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
      "nvvm.barrier"(%485, %486) <{aligned = true, operandSegmentSizes = array<i32: 1, 1>}> : (i32, i32) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<(i32, i32)>)>, linkage = #llvm.linkage<external>, sym_name = "gpu_named_barrier_arg", visibility_ = 0 : i64}> ({
    ^bb0(%arg134: !llvm.struct<(i32, i32)>):
      %466 = "llvm.extractvalue"(%arg134) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
      %467 = "llvm.extractvalue"(%arg134) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
      "nvvm.barrier"(%466, %467) <{aligned = true, operandSegmentSizes = array<i32: 1, 1>}> : (i32, i32) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
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
    ^bb0(%arg132: f32, %arg133: f64):
      %461 = "llvm.call"(%arg132) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fabsf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %462 = "llvm.call"(%arg133) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fabs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %463 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %464 = "llvm.insertvalue"(%463, %461) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %465 = "llvm.insertvalue"(%464, %462) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%465) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_7"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cbrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cbrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cbrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg130: f32, %arg131: f64):
      %456 = "llvm.call"(%arg130) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cbrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %457 = "llvm.call"(%arg131) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cbrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %458 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %459 = "llvm.insertvalue"(%458, %456) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %460 = "llvm.insertvalue"(%459, %457) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%460) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_8"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_ceilf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_ceil", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_ceil", visibility_ = 0 : i64}> ({
    ^bb0(%arg128: f32, %arg129: f64):
      %451 = "llvm.call"(%arg128) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_ceilf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %452 = "llvm.call"(%arg129) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_ceil, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %453 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %454 = "llvm.insertvalue"(%453, %451) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %455 = "llvm.insertvalue"(%454, %452) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%455) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_9"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_floorf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_floor", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_floor", visibility_ = 0 : i64}> ({
    ^bb0(%arg126: f32, %arg127: f64):
      %446 = "llvm.call"(%arg126) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_floorf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %447 = "llvm.call"(%arg127) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_floor, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %448 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %449 = "llvm.insertvalue"(%448, %446) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %450 = "llvm.insertvalue"(%449, %447) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%450) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_10"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cos", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_cosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cos", visibility_ = 0 : i64}> ({
    ^bb0(%arg124: f32, %arg125: f64):
      %439 = "llvm.call"(%arg124) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %440 = "llvm.call"(%arg125) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %441 = "llvm.call"(%arg124) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_cosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %442 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %443 = "llvm.insertvalue"(%442, %439) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %444 = "llvm.insertvalue"(%443, %440) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %445 = "llvm.insertvalue"(%444, %441) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%445) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_11"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_exp", visibility_ = 0 : i64}> ({
    ^bb0(%arg122: f32, %arg123: f64):
      %432 = "llvm.call"(%arg122) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %433 = "llvm.call"(%arg123) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %434 = "llvm.call"(%arg122) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %435 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %436 = "llvm.insertvalue"(%435, %432) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %437 = "llvm.insertvalue"(%436, %433) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %438 = "llvm.insertvalue"(%437, %434) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%438) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_12"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_exp2", visibility_ = 0 : i64}> ({
    ^bb0(%arg120: f32, %arg121: f64):
      %427 = "llvm.call"(%arg120) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %428 = "llvm.call"(%arg121) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %429 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %430 = "llvm.insertvalue"(%429, %427) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %431 = "llvm.insertvalue"(%430, %428) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%431) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_13"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_logf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_logf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log", visibility_ = 0 : i64}> ({
    ^bb0(%arg118: f32, %arg119: f64):
      %420 = "llvm.call"(%arg118) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_logf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %421 = "llvm.call"(%arg119) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %422 = "llvm.call"(%arg118) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_logf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %423 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %424 = "llvm.insertvalue"(%423, %420) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %425 = "llvm.insertvalue"(%424, %421) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %426 = "llvm.insertvalue"(%425, %422) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%426) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_14"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log10f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log10", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_log10f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log10", visibility_ = 0 : i64}> ({
    ^bb0(%arg116: f32, %arg117: f64):
      %413 = "llvm.call"(%arg116) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log10f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %414 = "llvm.call"(%arg117) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log10, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %415 = "llvm.call"(%arg116) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_log10f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %416 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %417 = "llvm.insertvalue"(%416, %413) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %418 = "llvm.insertvalue"(%417, %414) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %419 = "llvm.insertvalue"(%418, %415) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%419) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_15"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log1pf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log1p", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log1p", visibility_ = 0 : i64}> ({
    ^bb0(%arg114: f32, %arg115: f64):
      %408 = "llvm.call"(%arg114) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log1pf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %409 = "llvm.call"(%arg115) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log1p, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %410 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %411 = "llvm.insertvalue"(%410, %408) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %412 = "llvm.insertvalue"(%411, %409) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%412) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_16"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_log2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log2", visibility_ = 0 : i64}> ({
    ^bb0(%arg112: f32, %arg113: f64):
      %401 = "llvm.call"(%arg112) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %402 = "llvm.call"(%arg113) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %403 = "llvm.call"(%arg112) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_log2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %404 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %405 = "llvm.insertvalue"(%404, %401) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %406 = "llvm.insertvalue"(%405, %402) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %407 = "llvm.insertvalue"(%406, %403) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%407) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_17"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sin", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_sinf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sin", visibility_ = 0 : i64}> ({
    ^bb0(%arg110: f32, %arg111: f64):
      %394 = "llvm.call"(%arg110) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %395 = "llvm.call"(%arg111) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %396 = "llvm.call"(%arg110) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %397 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %398 = "llvm.insertvalue"(%397, %394) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %399 = "llvm.insertvalue"(%398, %395) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %400 = "llvm.insertvalue"(%399, %396) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%400) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_18"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tan", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_tanf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64, f32)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_tan", visibility_ = 0 : i64}> ({
    ^bb0(%arg107: f16, %arg108: f32, %arg109: f64):
      %383 = "llvm.fpext"(%arg107) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %384 = "llvm.call"(%383) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %385 = "llvm.fptrunc"(%384) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %386 = "llvm.call"(%arg108) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %387 = "llvm.call"(%arg109) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %388 = "llvm.call"(%arg108) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %389 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64, f32)>
      %390 = "llvm.insertvalue"(%389, %385) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64, f32)>, f16) -> !llvm.struct<(f16, f32, f64, f32)>
      %391 = "llvm.insertvalue"(%390, %386) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64, f32)>, f32) -> !llvm.struct<(f16, f32, f64, f32)>
      %392 = "llvm.insertvalue"(%391, %387) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64, f32)>, f64) -> !llvm.struct<(f16, f32, f64, f32)>
      %393 = "llvm.insertvalue"(%392, %388) <{position = array<i64: 3>}> : (!llvm.struct<(f16, f32, f64, f32)>, f32) -> !llvm.struct<(f16, f32, f64, f32)>
      "llvm.return"(%393) : (!llvm.struct<(f16, f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_19"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_tanh", visibility_ = 0 : i64}> ({
    ^bb0(%arg104: f16, %arg105: f32, %arg106: f64):
      %374 = "llvm.fpext"(%arg104) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %375 = "llvm.call"(%374) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %376 = "llvm.fptrunc"(%375) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %377 = "llvm.call"(%arg105) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %378 = "llvm.call"(%arg106) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %379 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %380 = "llvm.insertvalue"(%379, %376) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %381 = "llvm.insertvalue"(%380, %377) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %382 = "llvm.insertvalue"(%381, %378) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%382) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_20"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rsqrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rsqrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_rsqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg101: f16, %arg102: f32, %arg103: f64):
      %365 = "llvm.fpext"(%arg101) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %366 = "llvm.call"(%365) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %367 = "llvm.fptrunc"(%366) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %368 = "llvm.call"(%arg102) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %369 = "llvm.call"(%arg103) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %370 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %371 = "llvm.insertvalue"(%370, %367) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %372 = "llvm.insertvalue"(%371, %368) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %373 = "llvm.insertvalue"(%372, %369) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%373) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_21"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sqrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sqrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg98: f16, %arg99: f32, %arg100: f64):
      %356 = "llvm.fpext"(%arg98) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %357 = "llvm.call"(%356) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %358 = "llvm.fptrunc"(%357) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %359 = "llvm.call"(%arg99) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %360 = "llvm.call"(%arg100) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %361 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %362 = "llvm.insertvalue"(%361, %358) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %363 = "llvm.insertvalue"(%362, %359) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %364 = "llvm.insertvalue"(%363, %360) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%364) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_22"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atan", visibility_ = 0 : i64}> ({
    ^bb0(%arg95: f16, %arg96: f32, %arg97: f64):
      %347 = "llvm.fpext"(%arg95) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %348 = "llvm.call"(%347) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %349 = "llvm.fptrunc"(%348) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %350 = "llvm.call"(%arg96) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %351 = "llvm.call"(%arg97) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %352 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %353 = "llvm.insertvalue"(%352, %349) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %354 = "llvm.insertvalue"(%353, %350) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %355 = "llvm.insertvalue"(%354, %351) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%355) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_23"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atan2", visibility_ = 0 : i64}> ({
    ^bb0(%arg92: f16, %arg93: f32, %arg94: f64):
      %337 = "llvm.fpext"(%arg92) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %338 = "llvm.fpext"(%arg92) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %339 = "llvm.call"(%337, %338) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %340 = "llvm.fptrunc"(%339) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %341 = "llvm.call"(%arg93, %arg93) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %342 = "llvm.call"(%arg94, %arg94) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %343 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %344 = "llvm.insertvalue"(%343, %340) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %345 = "llvm.insertvalue"(%344, %341) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %346 = "llvm.insertvalue"(%345, %342) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%346) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) : () -> ()
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
      ^bb0(%arg90: f32, %arg91: f64):
        %330 = "llvm.call"(%arg90) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
        %331 = "llvm.call"(%arg91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
        %332 = "llvm.call"(%arg90) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
        %333 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
        %334 = "llvm.insertvalue"(%333, %330) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
        %335 = "llvm.insertvalue"(%334, %331) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
        %336 = "llvm.insertvalue"(%335, %332) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
        "llvm.return"(%336) : (!llvm.struct<(f32, f64, f32)>) -> ()
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
    ^bb0(%arg88: f32, %arg89: f64):
      %325 = "llvm.call"(%arg88) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expm1f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %326 = "llvm.call"(%arg89) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expm1, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %327 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %328 = "llvm.insertvalue"(%327, %325) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %329 = "llvm.insertvalue"(%328, %326) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%329) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_26"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_powf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_pow", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_powf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_pow", visibility_ = 0 : i64}> ({
    ^bb0(%arg86: f32, %arg87: f64):
      %318 = "llvm.call"(%arg86, %arg86) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %319 = "llvm.call"(%arg87, %arg87) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_pow, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %320 = "llvm.call"(%arg86, %arg86) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_powf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %321 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %322 = "llvm.insertvalue"(%321, %318) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %323 = "llvm.insertvalue"(%322, %319) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %324 = "llvm.insertvalue"(%323, %320) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%324) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_27"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xf32> (vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "gpu_unroll", visibility_ = 0 : i64}> ({
    ^bb0(%arg85: vector<4xf32>):
      %301 = "llvm.mlir.poison"() : () -> vector<4xf32>
      %302 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
      %303 = "llvm.extractelement"(%arg85, %302) : (vector<4xf32>, i64) -> f32
      %304 = "llvm.call"(%303) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %305 = "llvm.insertelement"(%301, %304, %302) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %306 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
      %307 = "llvm.extractelement"(%arg85, %306) : (vector<4xf32>, i64) -> f32
      %308 = "llvm.call"(%307) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %309 = "llvm.insertelement"(%305, %308, %306) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %310 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
      %311 = "llvm.extractelement"(%arg85, %310) : (vector<4xf32>, i64) -> f32
      %312 = "llvm.call"(%311) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %313 = "llvm.insertelement"(%309, %312, %310) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %314 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
      %315 = "llvm.extractelement"(%arg85, %314) : (vector<4xf32>, i64) -> f32
      %316 = "llvm.call"(%315) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %317 = "llvm.insertelement"(%313, %316, %314) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      "llvm.return"(%317) : (vector<4xf32>) -> ()
    }) : () -> ()
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
      %291 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
      %292 = "llvm.getelementptr"(%291) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %293 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %294 = "llvm.alloca"(%293) <{elem_type = !llvm.struct<()>}> : (i64) -> !llvm.ptr
      %295 = "llvm.call"(%292, %294) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      %296 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
      %297 = "llvm.getelementptr"(%296) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %298 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %299 = "llvm.alloca"(%298) <{elem_type = !llvm.struct<()>}> : (i64) -> !llvm.ptr
      %300 = "llvm.call"(%297, %299) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, f32)>, linkage = #llvm.linkage<external>, sym_name = "test_printf", visibility_ = 0 : i64}> ({
    ^bb0(%arg83: i32, %arg84: f32):
      %283 = "llvm.mlir.addressof"() <{global_name = @printfFormat_1}> : () -> !llvm.ptr
      %284 = "llvm.getelementptr"(%283) <{elem_type = !llvm.array<11 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %285 = "llvm.fpext"(%arg84) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f64
      %286 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %287 = "llvm.alloca"(%286) <{elem_type = !llvm.struct<(i32, f64)>}> : (i64) -> !llvm.ptr
      %288 = "llvm.getelementptr"(%287) <{elem_type = !llvm.struct<(i32, f64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      "llvm.store"(%arg83, %288) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      %289 = "llvm.getelementptr"(%287) <{elem_type = !llvm.struct<(i32, f64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
      "llvm.store"(%285, %289) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
      %290 = "llvm.call"(%284, %287) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_30"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_add", visibility_ = 0 : i64}> ({
    ^bb0(%arg79: i32, %arg80: !llvm.ptr, %arg81: !llvm.ptr, %arg82: i64):
      %276 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %277 = "llvm.insertvalue"(%276, %arg80) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %278 = "llvm.insertvalue"(%277, %arg81) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %279 = "llvm.insertvalue"(%278, %arg82) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %280 = "builtin.unrealized_conversion_cast"(%279) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<i32>
      %281 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %282 = "nvvm.redux.sync"(%arg79, %281) <{abs = false, kind = #nvvm<reduction_kind add>, nan = false}> : (i32, i32) -> i32
      "memref.store"(%282, %280) : (i32, memref<i32>) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_minsi", visibility_ = 0 : i64}> ({
    ^bb0(%arg75: i32, %arg76: !llvm.ptr, %arg77: !llvm.ptr, %arg78: i64):
      %269 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %270 = "llvm.insertvalue"(%269, %arg76) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %271 = "llvm.insertvalue"(%270, %arg77) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %272 = "llvm.insertvalue"(%271, %arg78) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %273 = "builtin.unrealized_conversion_cast"(%272) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<i32>
      %274 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %275 = "nvvm.redux.sync"(%arg75, %274) <{abs = false, kind = #nvvm<reduction_kind min>, nan = false}> : (i32, i32) -> i32
      "memref.store"(%275, %273) : (i32, memref<i32>) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_maxsi", visibility_ = 0 : i64}> ({
    ^bb0(%arg71: i32, %arg72: !llvm.ptr, %arg73: !llvm.ptr, %arg74: i64):
      %262 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %263 = "llvm.insertvalue"(%262, %arg72) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %264 = "llvm.insertvalue"(%263, %arg73) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %265 = "llvm.insertvalue"(%264, %arg74) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %266 = "builtin.unrealized_conversion_cast"(%265) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<i32>
      %267 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %268 = "nvvm.redux.sync"(%arg71, %267) <{abs = false, kind = #nvvm<reduction_kind max>, nan = false}> : (i32, i32) -> i32
      "memref.store"(%268, %266) : (i32, memref<i32>) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_and", visibility_ = 0 : i64}> ({
    ^bb0(%arg67: i32, %arg68: !llvm.ptr, %arg69: !llvm.ptr, %arg70: i64):
      %255 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %256 = "llvm.insertvalue"(%255, %arg68) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %257 = "llvm.insertvalue"(%256, %arg69) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %258 = "llvm.insertvalue"(%257, %arg70) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %259 = "builtin.unrealized_conversion_cast"(%258) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<i32>
      %260 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %261 = "nvvm.redux.sync"(%arg67, %260) <{abs = false, kind = #nvvm<reduction_kind and>, nan = false}> : (i32, i32) -> i32
      "memref.store"(%261, %259) : (i32, memref<i32>) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_or", visibility_ = 0 : i64}> ({
    ^bb0(%arg63: i32, %arg64: !llvm.ptr, %arg65: !llvm.ptr, %arg66: i64):
      %248 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %249 = "llvm.insertvalue"(%248, %arg64) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %250 = "llvm.insertvalue"(%249, %arg65) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %251 = "llvm.insertvalue"(%250, %arg66) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %252 = "builtin.unrealized_conversion_cast"(%251) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<i32>
      %253 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %254 = "nvvm.redux.sync"(%arg63, %253) <{abs = false, kind = #nvvm<reduction_kind or>, nan = false}> : (i32, i32) -> i32
      "memref.store"(%254, %252) : (i32, memref<i32>) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_xor", visibility_ = 0 : i64}> ({
    ^bb0(%arg59: i32, %arg60: !llvm.ptr, %arg61: !llvm.ptr, %arg62: i64):
      %241 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %242 = "llvm.insertvalue"(%241, %arg60) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %243 = "llvm.insertvalue"(%242, %arg61) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %244 = "llvm.insertvalue"(%243, %arg62) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %245 = "builtin.unrealized_conversion_cast"(%244) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<i32>
      %246 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %247 = "nvvm.redux.sync"(%arg59, %246) <{abs = false, kind = #nvvm<reduction_kind xor>, nan = false}> : (i32, i32) -> i32
      "memref.store"(%247, %245) : (i32, memref<i32>) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_31"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmodf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmod", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_fmod", visibility_ = 0 : i64}> ({
    ^bb0(%arg57: f32, %arg58: f64):
      %236 = "llvm.call"(%arg57, %arg57) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmodf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %237 = "llvm.call"(%arg58, %arg58) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmod, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %238 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %239 = "llvm.insertvalue"(%238, %236) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %240 = "llvm.insertvalue"(%239, %237) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%240) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_32"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erff", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_erf", visibility_ = 0 : i64}> ({
    ^bb0(%arg55: f32, %arg56: f64):
      %231 = "llvm.call"(%arg55) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erff, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %232 = "llvm.call"(%arg56) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %233 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %234 = "llvm.insertvalue"(%233, %231) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %235 = "llvm.insertvalue"(%234, %232) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%235) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_33"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_block_size", visibility_ = 0 : i64}> ({
    ^bb0(%arg54: !llvm.ptr):
      %223 = "nvvm.read.ptx.sreg.tid.x"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %224 = "llvm.sext"(%223) : (i32) -> i64
      %225 = "nvvm.read.ptx.sreg.tid.y"() <{range = #llvm.constant_range<i32, 0, 4>}> : () -> i32
      %226 = "llvm.sext"(%225) : (i32) -> i64
      %227 = "nvvm.read.ptx.sreg.tid.z"() <{range = #llvm.constant_range<i32, 0, 2>}> : () -> i32
      %228 = "llvm.sext"(%227) : (i32) -> i64
      %229 = "llvm.add"(%224, %226) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %230 = "llvm.add"(%229, %228) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.store"(%230, %arg54) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_block_size = array<i32: 32, 4, 2>, nvvm.kernel, nvvm.maxntid = array<i32: 32, 4, 2>} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_34"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)> (ptr, ptr, i64, i64, i64, f32)>, linkage = #llvm.linkage<external>, sym_name = "memref_signature", visibility_ = 0 : i64}> ({
    ^bb0(%arg48: !llvm.ptr, %arg49: !llvm.ptr, %arg50: i64, %arg51: i64, %arg52: i64, %arg53: f32):
      %214 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %215 = "llvm.insertvalue"(%214, %arg48) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %216 = "llvm.insertvalue"(%215, %arg49) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %217 = "llvm.insertvalue"(%216, %arg50) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %218 = "llvm.insertvalue"(%217, %arg51) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %219 = "llvm.insertvalue"(%218, %arg52) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %220 = "llvm.mlir.poison"() : () -> !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>
      %221 = "llvm.insertvalue"(%220, %219) <{position = array<i64: 0>}> : (!llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>
      %222 = "llvm.insertvalue"(%221, %arg53) <{position = array<i64: 1>}> : (!llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>, f32) -> !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>
      "llvm.return"(%222) : (!llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_35"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acos", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_acos", visibility_ = 0 : i64}> ({
    ^bb0(%arg46: f32, %arg47: f64):
      %209 = "llvm.call"(%arg46) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %210 = "llvm.call"(%arg47) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %211 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %212 = "llvm.insertvalue"(%211, %209) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %213 = "llvm.insertvalue"(%212, %210) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%213) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_36"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acoshf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acosh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_acosh", visibility_ = 0 : i64}> ({
    ^bb0(%arg44: f32, %arg45: f64):
      %204 = "llvm.call"(%arg44) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acoshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %205 = "llvm.call"(%arg45) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %206 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %207 = "llvm.insertvalue"(%206, %204) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %208 = "llvm.insertvalue"(%207, %205) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%208) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_37"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asinf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asin", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_asin", visibility_ = 0 : i64}> ({
    ^bb0(%arg42: f32, %arg43: f64):
      %199 = "llvm.call"(%arg42) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %200 = "llvm.call"(%arg43) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %201 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %202 = "llvm.insertvalue"(%201, %199) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %203 = "llvm.insertvalue"(%202, %200) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%203) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_38"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asinhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asinh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_asinh", visibility_ = 0 : i64}> ({
    ^bb0(%arg40: f32, %arg41: f64):
      %194 = "llvm.call"(%arg40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %195 = "llvm.call"(%arg41) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %196 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %197 = "llvm.insertvalue"(%196, %194) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %198 = "llvm.insertvalue"(%197, %195) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%198) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_39"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atanh", visibility_ = 0 : i64}> ({
    ^bb0(%arg37: f16, %arg38: f32, %arg39: f64):
      %185 = "llvm.fpext"(%arg37) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %186 = "llvm.call"(%185) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %187 = "llvm.fptrunc"(%186) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %188 = "llvm.call"(%arg38) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %189 = "llvm.call"(%arg39) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %190 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %191 = "llvm.insertvalue"(%190, %187) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %192 = "llvm.insertvalue"(%191, %188) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %193 = "llvm.insertvalue"(%192, %189) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%193) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_40"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_copysignf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_copysign", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_copysign", visibility_ = 0 : i64}> ({
    ^bb0(%arg35: f32, %arg36: f64):
      %180 = "llvm.call"(%arg35, %arg35) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_copysignf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %181 = "llvm.call"(%arg36, %arg36) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_copysign, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %182 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %183 = "llvm.insertvalue"(%182, %180) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %184 = "llvm.insertvalue"(%183, %181) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%184) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_41"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_coshf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cosh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cosh", visibility_ = 0 : i64}> ({
    ^bb0(%arg33: f32, %arg34: f64):
      %175 = "llvm.call"(%arg33) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_coshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %176 = "llvm.call"(%arg34) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %177 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %178 = "llvm.insertvalue"(%177, %175) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %179 = "llvm.insertvalue"(%178, %176) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%179) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_42"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmaf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fma", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_fma", visibility_ = 0 : i64}> ({
    ^bb0(%arg31: f32, %arg32: f64):
      %170 = "llvm.call"(%arg31, %arg31, %arg31) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmaf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, f32, f32) -> f32
      %171 = "llvm.call"(%arg32, %arg32, %arg32) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fma, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f64, f64, f64) -> f64
      %172 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %173 = "llvm.insertvalue"(%172, %170) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %174 = "llvm.insertvalue"(%173, %171) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%174) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_43"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_roundf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_round", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_round", visibility_ = 0 : i64}> ({
    ^bb0(%arg29: f32, %arg30: f64):
      %165 = "llvm.call"(%arg29) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_roundf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %166 = "llvm.call"(%arg30) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_round, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %167 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %168 = "llvm.insertvalue"(%167, %165) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %169 = "llvm.insertvalue"(%168, %166) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%169) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_44"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rintf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rint", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_roundeven", visibility_ = 0 : i64}> ({
    ^bb0(%arg27: f32, %arg28: f64):
      %160 = "llvm.call"(%arg27) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %161 = "llvm.call"(%arg28) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rint, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %162 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %163 = "llvm.insertvalue"(%162, %160) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %164 = "llvm.insertvalue"(%163, %161) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%164) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_45"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sinh", visibility_ = 0 : i64}> ({
    ^bb0(%arg25: f32, %arg26: f64):
      %155 = "llvm.call"(%arg25) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %156 = "llvm.call"(%arg26) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %157 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %158 = "llvm.insertvalue"(%157, %155) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %159 = "llvm.insertvalue"(%158, %156) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%159) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_46"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_coshf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cosh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cosh_with_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg23: f32, %arg24: f64):
      %150 = "llvm.call"(%arg23) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_coshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %151 = "llvm.call"(%arg24) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %152 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %153 = "llvm.insertvalue"(%152, %150) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %154 = "llvm.insertvalue"(%153, %151) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%154) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_47"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sinh_with_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg21: f32, %arg22: f64):
      %145 = "llvm.call"(%arg21) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %146 = "llvm.call"(%arg22) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %147 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %148 = "llvm.insertvalue"(%147, %145) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %149 = "llvm.insertvalue"(%148, %146) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%149) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_48"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64, f32)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_exp_with_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg19: f32, %arg20: f64):
      %138 = "llvm.call"(%arg19) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %139 = "llvm.call"(%arg20) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %140 = "llvm.call"(%arg19) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %141 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %142 = "llvm.insertvalue"(%141, %138) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %143 = "llvm.insertvalue"(%142, %139) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %144 = "llvm.insertvalue"(%143, %140) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%144) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_49"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, i64, i64)> ()>, linkage = #llvm.linkage<external>, sym_name = "explicit_id_bounds", visibility_ = 0 : i64}> ({
      %128 = "nvvm.read.ptx.sreg.tid.x"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %129 = "llvm.sext"(%128) : (i32) -> i64
      %130 = "nvvm.read.ptx.sreg.ntid.x"() <{range = #llvm.constant_range<i32, 1, 33>}> : () -> i32
      %131 = "llvm.sext"(%130) : (i32) -> i64
      %132 = "nvvm.read.ptx.sreg.laneid"() <{range = #llvm.constant_range<i32, 0, 16>}> : () -> i32
      %133 = "llvm.sext"(%132) : (i32) -> i64
      %134 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, i64, i64)>
      %135 = "llvm.insertvalue"(%134, %129) <{position = array<i64: 0>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
      %136 = "llvm.insertvalue"(%135, %131) <{position = array<i64: 1>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
      %137 = "llvm.insertvalue"(%136, %133) <{position = array<i64: 2>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
      "llvm.return"(%137) : (!llvm.struct<(i64, i64, i64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_50"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_grid_size", visibility_ = 0 : i64}> ({
    ^bb0(%arg18: !llvm.ptr):
      %120 = "nvvm.read.ptx.sreg.ctaid.x"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %121 = "llvm.sext"(%120) : (i32) -> i64
      %122 = "nvvm.read.ptx.sreg.ctaid.y"() <{range = #llvm.constant_range<i32, 0, 4>}> : () -> i32
      %123 = "llvm.sext"(%122) : (i32) -> i64
      %124 = "nvvm.read.ptx.sreg.ctaid.z"() <{range = #llvm.constant_range<i32, 0, 2>}> : () -> i32
      %125 = "llvm.sext"(%124) : (i32) -> i64
      %126 = "llvm.add"(%121, %123) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %127 = "llvm.add"(%126, %125) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.store"(%127, %arg18) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
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
    ^bb0(%arg17: i1):
      "llvm.cond_br"(%arg17)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %112 = "llvm.mlir.addressof"() <{global_name = @assert_message_0}> : () -> !llvm.ptr
      %113 = "llvm.getelementptr"(%112) <{elem_type = !llvm.array<15 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %114 = "llvm.mlir.addressof"() <{global_name = @assert_file_0}> : () -> !llvm.ptr
      %115 = "llvm.getelementptr"(%114) <{elem_type = !llvm.array<90 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %116 = "llvm.mlir.addressof"() <{global_name = @assert_func_0}> : () -> !llvm.ptr
      %117 = "llvm.getelementptr"(%116) <{elem_type = !llvm.array<10 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %118 = "llvm.mlir.constant"() <{value = 1056 : i32}> : () -> i32
      %119 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
      "llvm.call"(%113, %115, %118, %117, %119) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__assertfail, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (!llvm.ptr, !llvm.ptr, i32, !llvm.ptr, i64) -> ()
      "llvm.br"()[^bb2] : () -> ()
    ^bb2:  // 2 preds: ^bb0, ^bb1
      "llvm.return"() : () -> ()
    }) {gpu.kernel, nvvm.kernel} : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg16: !transform.any_op):
      %111 = "transform.structured.match"(%arg16) <{ops = ["gpu.module"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%111) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.gpu_rewrite_patterns"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.apply_conversion_patterns"(%111) <{illegal_dialects = ["gpu"], illegal_ops = ["llvm.copysign", "llvm.cos", "llvm.exp", "llvm.exp2", "llvm.fabs", "llvm.fceil", "llvm.ffloor", "llvm.frem", "llvm.log", "llvm.log10", "llvm.log2", "llvm.pow", "llvm.roundeven", "llvm.round", "llvm.sin", "llvm.sqrt"], legal_dialects = ["llvm", "memref", "nvvm", "test"], legal_ops = ["gpu.module", "gpu.yield"], partial_conversion}> ({
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
    ^bb0(%arg15: i32):
      %110 = "llvm.call"(%arg15) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_abs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i32
      "llvm.return"(%110) : (i32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_53"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, i32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_powif", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, i32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_powi", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64, i32)>, linkage = #llvm.linkage<external>, sym_name = "gpu_powi", visibility_ = 0 : i64}> ({
    ^bb0(%arg12: f32, %arg13: f64, %arg14: i32):
      %105 = "llvm.call"(%arg12, %arg14) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powif, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, i32) -> f32
      %106 = "llvm.call"(%arg13, %arg14) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powi, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, i32) -> f64
      %107 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %108 = "llvm.insertvalue"(%107, %105) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %109 = "llvm.insertvalue"(%108, %106) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%109) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
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
    ^bb0(%arg10: f32, %arg11: f64):
      %80 = "llvm.call"(%arg10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isinff, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> i32
      %81 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %82 = "llvm.icmp"(%80, %81) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %83 = "llvm.call"(%arg11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isinfd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> i32
      %84 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %85 = "llvm.icmp"(%83, %84) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %86 = "llvm.call"(%arg10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isnanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> i32
      %87 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %88 = "llvm.icmp"(%86, %87) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %89 = "llvm.call"(%arg11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isnand, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> i32
      %90 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %91 = "llvm.icmp"(%89, %90) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %92 = "llvm.call"(%arg10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_finitef, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> i32
      %93 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %94 = "llvm.icmp"(%92, %93) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %95 = "llvm.call"(%arg11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isfinited, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> i32
      %96 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %97 = "llvm.icmp"(%95, %96) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %98 = "llvm.mlir.poison"() : () -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %99 = "llvm.insertvalue"(%98, %82) <{position = array<i64: 0>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %100 = "llvm.insertvalue"(%99, %85) <{position = array<i64: 1>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %101 = "llvm.insertvalue"(%100, %88) <{position = array<i64: 2>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %102 = "llvm.insertvalue"(%101, %91) <{position = array<i64: 3>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %103 = "llvm.insertvalue"(%102, %94) <{position = array<i64: 4>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %104 = "llvm.insertvalue"(%103, %97) <{position = array<i64: 5>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      "llvm.return"(%104) : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_55"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erfcf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erfc", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_erfc", visibility_ = 0 : i64}> ({
    ^bb0(%arg8: f32, %arg9: f64):
      %75 = "llvm.call"(%arg8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erfcf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %76 = "llvm.call"(%arg9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erfc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %77 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %78 = "llvm.insertvalue"(%77, %75) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %79 = "llvm.insertvalue"(%78, %76) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%79) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_56"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sincosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f64, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sincos", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f16, f32, f32, f64, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sincos", visibility_ = 0 : i64}> ({
    ^bb0(%arg5: f16, %arg6: f32, %arg7: f64):
      %50 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %51 = "llvm.alloca"(%50) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %52 = "llvm.alloca"(%50) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %53 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %54 = "llvm.alloca"(%53) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %55 = "llvm.alloca"(%53) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %56 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %57 = "llvm.alloca"(%56) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %58 = "llvm.alloca"(%56) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %59 = "llvm.fpext"(%arg5) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      "llvm.call"(%59, %57, %58) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %60 = "llvm.load"(%57) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %61 = "llvm.load"(%58) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %62 = "llvm.fptrunc"(%60) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %63 = "llvm.fptrunc"(%61) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      "llvm.call"(%arg6, %54, %55) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %64 = "llvm.load"(%54) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %65 = "llvm.load"(%55) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      "llvm.call"(%arg7, %51, %52) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f64, !llvm.ptr, !llvm.ptr) -> ()
      %66 = "llvm.load"(%51) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %67 = "llvm.load"(%52) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %68 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %69 = "llvm.insertvalue"(%68, %62) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %70 = "llvm.insertvalue"(%69, %63) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %71 = "llvm.insertvalue"(%70, %64) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %72 = "llvm.insertvalue"(%71, %65) <{position = array<i64: 3>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %73 = "llvm.insertvalue"(%72, %66) <{position = array<i64: 4>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %74 = "llvm.insertvalue"(%73, %67) <{position = array<i64: 5>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      "llvm.return"(%74) : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>) -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_sincosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f16, f32, f32, f64, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sincos_fastmath", visibility_ = 0 : i64}> ({
    ^bb0(%arg2: f16, %arg3: f32, %arg4: f64):
      %25 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %26 = "llvm.alloca"(%25) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %27 = "llvm.alloca"(%25) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %28 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %29 = "llvm.alloca"(%28) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %30 = "llvm.alloca"(%28) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %31 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %32 = "llvm.alloca"(%31) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %33 = "llvm.alloca"(%31) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %34 = "llvm.fpext"(%arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      "llvm.call"(%34, %32, %33) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %35 = "llvm.load"(%32) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %36 = "llvm.load"(%33) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %37 = "llvm.fptrunc"(%35) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %38 = "llvm.fptrunc"(%36) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      "llvm.call"(%arg3, %29, %30) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %39 = "llvm.load"(%29) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %40 = "llvm.load"(%30) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      "llvm.call"(%arg4, %26, %27) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f64, !llvm.ptr, !llvm.ptr) -> ()
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
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_cluster_size"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_cluster_size", visibility_ = 0 : i64}> ({
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_cluster_size = array<i32: 8, 2, 4>, nvvm.cluster_dim = array<i32: 8, 2, 4>, nvvm.kernel} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_cluster_block_ops"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_cluster_size", visibility_ = 0 : i64}> ({
    ^bb0(%arg1: !llvm.ptr):
      %8 = "nvvm.read.ptx.sreg.cluster.ctaid.x"() <{range = #llvm.constant_range<i32, 0, 8>}> : () -> i32
      %9 = "llvm.sext"(%8) : (i32) -> i64
      %10 = "nvvm.read.ptx.sreg.cluster.ctaid.y"() <{range = #llvm.constant_range<i32, 0, 4>}> : () -> i32
      %11 = "llvm.sext"(%10) : (i32) -> i64
      %12 = "nvvm.read.ptx.sreg.cluster.ctaid.z"() <{range = #llvm.constant_range<i32, 0, 2>}> : () -> i32
      %13 = "llvm.sext"(%12) : (i32) -> i64
      %14 = "nvvm.read.ptx.sreg.cluster.nctaid.x"() <{range = #llvm.constant_range<i32, 8, 9>}> : () -> i32
      %15 = "llvm.sext"(%14) : (i32) -> i64
      %16 = "nvvm.read.ptx.sreg.cluster.nctaid.y"() <{range = #llvm.constant_range<i32, 4, 5>}> : () -> i32
      %17 = "llvm.sext"(%16) : (i32) -> i64
      %18 = "nvvm.read.ptx.sreg.cluster.nctaid.z"() <{range = #llvm.constant_range<i32, 2, 3>}> : () -> i32
      %19 = "llvm.sext"(%18) : (i32) -> i64
      %20 = "llvm.add"(%9, %11) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %21 = "llvm.add"(%20, %13) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %22 = "llvm.add"(%21, %15) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %23 = "llvm.add"(%22, %17) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %24 = "llvm.add"(%23, %19) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.store"(%24, %arg1) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_cluster_size = array<i32: 8, 4, 2>, nvvm.cluster_dim = array<i32: 8, 4, 2>, nvvm.kernel} : () -> ()
  }) : () -> ()
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
}) : () -> ()


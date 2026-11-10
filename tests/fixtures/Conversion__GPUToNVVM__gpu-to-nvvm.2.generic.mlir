"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_0"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_ops", visibility_ = 0 : i64}> ({
      %1101 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %1102 = "llvm.sext"(%1101) : (i32) -> i64
      %1103 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %1104 = "llvm.sext"(%1103) : (i32) -> i64
      %1105 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %1106 = "llvm.sext"(%1105) : (i32) -> i64
      %1107 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %1108 = "llvm.sext"(%1107) : (i32) -> i64
      %1109 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %1110 = "llvm.sext"(%1109) : (i32) -> i64
      %1111 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %1112 = "llvm.sext"(%1111) : (i32) -> i64
      %1113 = "nvvm.read.ptx.sreg.ctaid.x"() : () -> i32
      %1114 = "llvm.sext"(%1113) : (i32) -> i64
      %1115 = "nvvm.read.ptx.sreg.ctaid.y"() : () -> i32
      %1116 = "llvm.sext"(%1115) : (i32) -> i64
      %1117 = "nvvm.read.ptx.sreg.ctaid.z"() : () -> i32
      %1118 = "llvm.sext"(%1117) : (i32) -> i64
      %1119 = "nvvm.read.ptx.sreg.nctaid.x"() : () -> i32
      %1120 = "llvm.sext"(%1119) : (i32) -> i64
      %1121 = "nvvm.read.ptx.sreg.nctaid.y"() : () -> i32
      %1122 = "llvm.sext"(%1121) : (i32) -> i64
      %1123 = "nvvm.read.ptx.sreg.nctaid.z"() : () -> i32
      %1124 = "llvm.sext"(%1123) : (i32) -> i64
      %1125 = "nvvm.read.ptx.sreg.laneid"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %1126 = "llvm.sext"(%1125) : (i32) -> i64
      %1127 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1128 = "llvm.insertvalue"(%1127, %1102) <{position = array<i64: 0>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1129 = "llvm.insertvalue"(%1128, %1104) <{position = array<i64: 1>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1130 = "llvm.insertvalue"(%1129, %1106) <{position = array<i64: 2>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1131 = "llvm.insertvalue"(%1130, %1108) <{position = array<i64: 3>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1132 = "llvm.insertvalue"(%1131, %1110) <{position = array<i64: 4>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1133 = "llvm.insertvalue"(%1132, %1112) <{position = array<i64: 5>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1134 = "llvm.insertvalue"(%1133, %1114) <{position = array<i64: 6>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1135 = "llvm.insertvalue"(%1134, %1116) <{position = array<i64: 7>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1136 = "llvm.insertvalue"(%1135, %1118) <{position = array<i64: 8>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1137 = "llvm.insertvalue"(%1136, %1120) <{position = array<i64: 9>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1138 = "llvm.insertvalue"(%1137, %1122) <{position = array<i64: 10>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1139 = "llvm.insertvalue"(%1138, %1124) <{position = array<i64: 11>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1140 = "llvm.insertvalue"(%1139, %1126) <{position = array<i64: 12>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      "llvm.return"(%1140) : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_index_ops", visibility_ = 0 : i64}> ({
    ^bb0(%arg276: !llvm.ptr):
      %1100 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_index_ops, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      "llvm.store"(%1100, %arg276) <{ordering = 0 : i64}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_comp", visibility_ = 0 : i64}> ({
    ^bb0(%arg275: i64):
      %1099 = "llvm.add"(%arg275, %arg275) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.return"(%1099) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_index_comp", visibility_ = 0 : i64}> ({
    ^bb0(%arg274: i64):
      %1098 = "llvm.call"(%arg274) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_index_comp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> i64
      "llvm.return"(%1098) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_2"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<32 x f32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_gpu_all_reduce_op_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_all_reduce_op", visibility_ = 0 : i64}> ({
      %844 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_op_0}> : () -> !llvm.ptr<3>
      %845 = "llvm.getelementptr"(%844) <{elem_type = !llvm.array<32 x f32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %846 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %847 = "llvm.insertvalue"(%846, %845) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %848 = "llvm.insertvalue"(%847, %845) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %849 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %850 = "llvm.insertvalue"(%848, %849) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %851 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %852 = "llvm.insertvalue"(%850, %851) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %853 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %854 = "llvm.insertvalue"(%852, %853) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %855 = "builtin.unrealized_conversion_cast"(%854) : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<32xf32, #gpu.address_space<workgroup>>
      %856 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %857 = "builtin.unrealized_conversion_cast"(%856) : (i64) -> index
      %858 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %859 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %860 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %861 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %862 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %863 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %864 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %865 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %866 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %867 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %868 = "llvm.sext"(%867) : (i32) -> i64
      %869 = "llvm.trunc"(%868) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %870 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %871 = "llvm.sext"(%870) : (i32) -> i64
      %872 = "llvm.trunc"(%871) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %873 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %874 = "llvm.sext"(%873) : (i32) -> i64
      %875 = "llvm.trunc"(%874) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %876 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %877 = "llvm.sext"(%876) : (i32) -> i64
      %878 = "llvm.trunc"(%877) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %879 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %880 = "llvm.sext"(%879) : (i32) -> i64
      %881 = "llvm.trunc"(%880) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %882 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %883 = "llvm.sext"(%882) : (i32) -> i64
      %884 = "llvm.trunc"(%883) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %885 = "llvm.mul"(%884, %872) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %886 = "llvm.add"(%885, %881) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %887 = "llvm.mul"(%886, %869) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %888 = "llvm.mul"(%869, %872) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %889 = "llvm.add"(%887, %878) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %890 = "llvm.mul"(%888, %875) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %891 = "llvm.and"(%889, %865) : (i32, i32) -> i32
      %892 = "llvm.icmp"(%891, %864) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %893 = "llvm.sub"(%889, %891) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %894 = "llvm.sub"(%890, %893) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %895 = "llvm.icmp"(%894, %863) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%895)[^bb1, ^bb17] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %896 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %897 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %898 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %899 = "llvm.sub"(%898, %894) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %900 = "llvm.lshr"(%897, %899) : (i32, i32) -> i32
      %901 = "llvm.sub"(%894, %896) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %902 = "nvvm.shfl.sync"(%900, %866, %862, %901) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %903 = "llvm.extractvalue"(%902) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %904 = "llvm.extractvalue"(%902) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%904)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %905 = "llvm.fadd"(%903, %866) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%905)[^bb4] : (f32) -> ()
    ^bb3:  // pred: ^bb1
      "llvm.br"(%866)[^bb4] : (f32) -> ()
    ^bb4(%906: f32):  // 2 preds: ^bb2, ^bb3
      %907 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %908 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %909 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %910 = "llvm.sub"(%909, %894) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %911 = "llvm.lshr"(%908, %910) : (i32, i32) -> i32
      %912 = "llvm.sub"(%894, %907) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %913 = "nvvm.shfl.sync"(%911, %906, %861, %912) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %914 = "llvm.extractvalue"(%913) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %915 = "llvm.extractvalue"(%913) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%915)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb5:  // pred: ^bb4
      %916 = "llvm.fadd"(%906, %914) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%916)[^bb7] : (f32) -> ()
    ^bb6:  // pred: ^bb4
      "llvm.br"(%906)[^bb7] : (f32) -> ()
    ^bb7(%917: f32):  // 2 preds: ^bb5, ^bb6
      %918 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %919 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %920 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %921 = "llvm.sub"(%920, %894) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %922 = "llvm.lshr"(%919, %921) : (i32, i32) -> i32
      %923 = "llvm.sub"(%894, %918) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %924 = "nvvm.shfl.sync"(%922, %917, %860, %923) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %925 = "llvm.extractvalue"(%924) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %926 = "llvm.extractvalue"(%924) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%926)[^bb8, ^bb9] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb8:  // pred: ^bb7
      %927 = "llvm.fadd"(%917, %925) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%927)[^bb10] : (f32) -> ()
    ^bb9:  // pred: ^bb7
      "llvm.br"(%917)[^bb10] : (f32) -> ()
    ^bb10(%928: f32):  // 2 preds: ^bb8, ^bb9
      %929 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %930 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %931 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %932 = "llvm.sub"(%931, %894) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %933 = "llvm.lshr"(%930, %932) : (i32, i32) -> i32
      %934 = "llvm.sub"(%894, %929) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %935 = "nvvm.shfl.sync"(%933, %928, %859, %934) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %936 = "llvm.extractvalue"(%935) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %937 = "llvm.extractvalue"(%935) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%937)[^bb11, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb11:  // pred: ^bb10
      %938 = "llvm.fadd"(%928, %936) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%938)[^bb13] : (f32) -> ()
    ^bb12:  // pred: ^bb10
      "llvm.br"(%928)[^bb13] : (f32) -> ()
    ^bb13(%939: f32):  // 2 preds: ^bb11, ^bb12
      %940 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %941 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %942 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %943 = "llvm.sub"(%942, %894) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %944 = "llvm.lshr"(%941, %943) : (i32, i32) -> i32
      %945 = "llvm.sub"(%894, %940) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %946 = "nvvm.shfl.sync"(%944, %939, %858, %945) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %947 = "llvm.extractvalue"(%946) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %948 = "llvm.extractvalue"(%946) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%948)[^bb14, ^bb15] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb14:  // pred: ^bb13
      %949 = "llvm.fadd"(%939, %947) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%949)[^bb16] : (f32) -> ()
    ^bb15:  // pred: ^bb13
      "llvm.br"(%939)[^bb16] : (f32) -> ()
    ^bb16(%950: f32):  // 2 preds: ^bb14, ^bb15
      "llvm.br"(%950)[^bb18] : (f32) -> ()
    ^bb17:  // pred: ^bb0
      %951 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %952 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %953 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %954 = "llvm.sub"(%953, %863) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %955 = "llvm.lshr"(%952, %954) : (i32, i32) -> i32
      %956 = "llvm.sub"(%863, %951) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %957 = "nvvm.shfl.sync"(%955, %866, %862, %956) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %958 = "llvm.fadd"(%957, %866) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %959 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %960 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %961 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %962 = "llvm.sub"(%961, %863) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %963 = "llvm.lshr"(%960, %962) : (i32, i32) -> i32
      %964 = "llvm.sub"(%863, %959) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %965 = "nvvm.shfl.sync"(%963, %958, %861, %964) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %966 = "llvm.fadd"(%958, %965) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %967 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %968 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %969 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %970 = "llvm.sub"(%969, %863) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %971 = "llvm.lshr"(%968, %970) : (i32, i32) -> i32
      %972 = "llvm.sub"(%863, %967) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %973 = "nvvm.shfl.sync"(%971, %966, %860, %972) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %974 = "llvm.fadd"(%966, %973) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %975 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %976 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %977 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %978 = "llvm.sub"(%977, %863) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %979 = "llvm.lshr"(%976, %978) : (i32, i32) -> i32
      %980 = "llvm.sub"(%863, %975) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %981 = "nvvm.shfl.sync"(%979, %974, %859, %980) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %982 = "llvm.fadd"(%974, %981) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %983 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %984 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %985 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %986 = "llvm.sub"(%985, %863) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %987 = "llvm.lshr"(%984, %986) : (i32, i32) -> i32
      %988 = "llvm.sub"(%863, %983) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %989 = "nvvm.shfl.sync"(%987, %982, %858, %988) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %990 = "llvm.fadd"(%982, %989) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%990)[^bb18] : (f32) -> ()
    ^bb18(%991: f32):  // 2 preds: ^bb16, ^bb17
      "llvm.cond_br"(%892)[^bb19, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb19:  // pred: ^bb18
      %992 = "llvm.sdiv"(%889, %863) : (i32, i32) -> i32
      %993 = "llvm.sext"(%992) : (i32) -> i64
      %994 = "builtin.unrealized_conversion_cast"(%993) : (i64) -> index
      "memref.store"(%991, %855, %994) <{nontemporal = false}> : (f32, memref<32xf32, #gpu.address_space<workgroup>>, index) -> ()
      "llvm.br"()[^bb21] : () -> ()
    ^bb20:  // pred: ^bb18
      "llvm.br"()[^bb21] : () -> ()
    ^bb21:  // 2 preds: ^bb19, ^bb20
      "nvvm.barrier"() <{aligned = true, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      %995 = "llvm.add"(%890, %865) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %996 = "llvm.sdiv"(%995, %863) : (i32, i32) -> i32
      %997 = "llvm.icmp"(%889, %996) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%997)[^bb22, ^bb41] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb22:  // pred: ^bb21
      %998 = "llvm.sext"(%889) : (i32) -> i64
      %999 = "builtin.unrealized_conversion_cast"(%998) : (i64) -> index
      %1000 = "memref.load"(%855, %999) <{invariant = false, nontemporal = false}> : (memref<32xf32, #gpu.address_space<workgroup>>, index) -> f32
      %1001 = "llvm.icmp"(%996, %863) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%1001)[^bb23, ^bb39] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb23:  // pred: ^bb22
      %1002 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1003 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1004 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1005 = "llvm.sub"(%1004, %996) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1006 = "llvm.lshr"(%1003, %1005) : (i32, i32) -> i32
      %1007 = "llvm.sub"(%996, %1002) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1008 = "nvvm.shfl.sync"(%1006, %1000, %862, %1007) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %1009 = "llvm.extractvalue"(%1008) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %1010 = "llvm.extractvalue"(%1008) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%1010)[^bb24, ^bb25] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb24:  // pred: ^bb23
      %1011 = "llvm.fadd"(%1000, %1009) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1011)[^bb26] : (f32) -> ()
    ^bb25:  // pred: ^bb23
      "llvm.br"(%1000)[^bb26] : (f32) -> ()
    ^bb26(%1012: f32):  // 2 preds: ^bb24, ^bb25
      %1013 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1014 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1015 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1016 = "llvm.sub"(%1015, %996) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1017 = "llvm.lshr"(%1014, %1016) : (i32, i32) -> i32
      %1018 = "llvm.sub"(%996, %1013) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1019 = "nvvm.shfl.sync"(%1017, %1012, %861, %1018) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %1020 = "llvm.extractvalue"(%1019) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %1021 = "llvm.extractvalue"(%1019) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%1021)[^bb27, ^bb28] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb27:  // pred: ^bb26
      %1022 = "llvm.fadd"(%1012, %1020) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1022)[^bb29] : (f32) -> ()
    ^bb28:  // pred: ^bb26
      "llvm.br"(%1012)[^bb29] : (f32) -> ()
    ^bb29(%1023: f32):  // 2 preds: ^bb27, ^bb28
      %1024 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1025 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1026 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1027 = "llvm.sub"(%1026, %996) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1028 = "llvm.lshr"(%1025, %1027) : (i32, i32) -> i32
      %1029 = "llvm.sub"(%996, %1024) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1030 = "nvvm.shfl.sync"(%1028, %1023, %860, %1029) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %1031 = "llvm.extractvalue"(%1030) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %1032 = "llvm.extractvalue"(%1030) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%1032)[^bb30, ^bb31] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb30:  // pred: ^bb29
      %1033 = "llvm.fadd"(%1023, %1031) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1033)[^bb32] : (f32) -> ()
    ^bb31:  // pred: ^bb29
      "llvm.br"(%1023)[^bb32] : (f32) -> ()
    ^bb32(%1034: f32):  // 2 preds: ^bb30, ^bb31
      %1035 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1036 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1037 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1038 = "llvm.sub"(%1037, %996) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1039 = "llvm.lshr"(%1036, %1038) : (i32, i32) -> i32
      %1040 = "llvm.sub"(%996, %1035) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1041 = "nvvm.shfl.sync"(%1039, %1034, %859, %1040) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %1042 = "llvm.extractvalue"(%1041) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %1043 = "llvm.extractvalue"(%1041) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%1043)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %1044 = "llvm.fadd"(%1034, %1042) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1044)[^bb35] : (f32) -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"(%1034)[^bb35] : (f32) -> ()
    ^bb35(%1045: f32):  // 2 preds: ^bb33, ^bb34
      %1046 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1047 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1048 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1049 = "llvm.sub"(%1048, %996) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1050 = "llvm.lshr"(%1047, %1049) : (i32, i32) -> i32
      %1051 = "llvm.sub"(%996, %1046) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1052 = "nvvm.shfl.sync"(%1050, %1045, %858, %1051) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %1053 = "llvm.extractvalue"(%1052) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %1054 = "llvm.extractvalue"(%1052) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%1054)[^bb36, ^bb37] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %1055 = "llvm.fadd"(%1045, %1053) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1055)[^bb38] : (f32) -> ()
    ^bb37:  // pred: ^bb35
      "llvm.br"(%1045)[^bb38] : (f32) -> ()
    ^bb38(%1056: f32):  // 2 preds: ^bb36, ^bb37
      "llvm.br"(%1056)[^bb40] : (f32) -> ()
    ^bb39:  // pred: ^bb22
      %1057 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1058 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1059 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1060 = "llvm.sub"(%1059, %863) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1061 = "llvm.lshr"(%1058, %1060) : (i32, i32) -> i32
      %1062 = "llvm.sub"(%863, %1057) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1063 = "nvvm.shfl.sync"(%1061, %1000, %862, %1062) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1064 = "llvm.fadd"(%1000, %1063) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1065 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1066 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1067 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1068 = "llvm.sub"(%1067, %863) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1069 = "llvm.lshr"(%1066, %1068) : (i32, i32) -> i32
      %1070 = "llvm.sub"(%863, %1065) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1071 = "nvvm.shfl.sync"(%1069, %1064, %861, %1070) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1072 = "llvm.fadd"(%1064, %1071) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1073 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1074 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1075 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1076 = "llvm.sub"(%1075, %863) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1077 = "llvm.lshr"(%1074, %1076) : (i32, i32) -> i32
      %1078 = "llvm.sub"(%863, %1073) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1079 = "nvvm.shfl.sync"(%1077, %1072, %860, %1078) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1080 = "llvm.fadd"(%1072, %1079) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1081 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1082 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1083 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1084 = "llvm.sub"(%1083, %863) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1085 = "llvm.lshr"(%1082, %1084) : (i32, i32) -> i32
      %1086 = "llvm.sub"(%863, %1081) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1087 = "nvvm.shfl.sync"(%1085, %1080, %859, %1086) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1088 = "llvm.fadd"(%1080, %1087) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1089 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1090 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1091 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1092 = "llvm.sub"(%1091, %863) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1093 = "llvm.lshr"(%1090, %1092) : (i32, i32) -> i32
      %1094 = "llvm.sub"(%863, %1089) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1095 = "nvvm.shfl.sync"(%1093, %1088, %858, %1094) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1096 = "llvm.fadd"(%1088, %1095) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1096)[^bb40] : (f32) -> ()
    ^bb40(%1097: f32):  // 2 preds: ^bb38, ^bb39
      "memref.store"(%1097, %855, %857) <{nontemporal = false}> : (f32, memref<32xf32, #gpu.address_space<workgroup>>, index) -> ()
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
      %591 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_region_0}> : () -> !llvm.ptr<3>
      %592 = "llvm.getelementptr"(%591) <{elem_type = !llvm.array<32 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %593 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %594 = "llvm.insertvalue"(%593, %592) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %595 = "llvm.insertvalue"(%594, %592) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %596 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %597 = "llvm.insertvalue"(%595, %596) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %598 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %599 = "llvm.insertvalue"(%597, %598) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %600 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %601 = "llvm.insertvalue"(%599, %600) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %602 = "builtin.unrealized_conversion_cast"(%601) : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<32xi32, #gpu.address_space<workgroup>>
      %603 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %604 = "builtin.unrealized_conversion_cast"(%603) : (i64) -> index
      %605 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %606 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %607 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %608 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %609 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %610 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %611 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %612 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %613 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %614 = "llvm.sext"(%613) : (i32) -> i64
      %615 = "llvm.trunc"(%614) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %616 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %617 = "llvm.sext"(%616) : (i32) -> i64
      %618 = "llvm.trunc"(%617) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %619 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %620 = "llvm.sext"(%619) : (i32) -> i64
      %621 = "llvm.trunc"(%620) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %622 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %623 = "llvm.sext"(%622) : (i32) -> i64
      %624 = "llvm.trunc"(%623) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %625 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %626 = "llvm.sext"(%625) : (i32) -> i64
      %627 = "llvm.trunc"(%626) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %628 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %629 = "llvm.sext"(%628) : (i32) -> i64
      %630 = "llvm.trunc"(%629) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %631 = "llvm.mul"(%630, %618) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %632 = "llvm.add"(%631, %627) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %633 = "llvm.mul"(%632, %615) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %634 = "llvm.mul"(%615, %618) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %635 = "llvm.add"(%633, %624) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %636 = "llvm.mul"(%634, %621) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %637 = "llvm.and"(%635, %611) : (i32, i32) -> i32
      %638 = "llvm.icmp"(%637, %610) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %639 = "llvm.sub"(%635, %637) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %640 = "llvm.sub"(%636, %639) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %641 = "llvm.icmp"(%640, %609) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%641)[^bb1, ^bb22] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %642 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %643 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %644 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %645 = "llvm.sub"(%644, %640) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %646 = "llvm.lshr"(%643, %645) : (i32, i32) -> i32
      %647 = "llvm.sub"(%640, %642) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %648 = "nvvm.shfl.sync"(%646, %612, %612, %647) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %649 = "llvm.extractvalue"(%648) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %650 = "llvm.extractvalue"(%648) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%650, %612)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb2:  // pred: ^bb1
      "llvm.br"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      %651 = "llvm.xor"(%649, %612) : (i32, i32) -> i32
      "llvm.br"(%651)[^bb4] : (i32) -> ()
    ^bb4(%652: i32):  // 2 preds: ^bb1, ^bb3
      "llvm.br"()[^bb5] : () -> ()
    ^bb5:  // pred: ^bb4
      %653 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %654 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %655 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %656 = "llvm.sub"(%655, %640) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %657 = "llvm.lshr"(%654, %656) : (i32, i32) -> i32
      %658 = "llvm.sub"(%640, %653) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %659 = "nvvm.shfl.sync"(%657, %652, %608, %658) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %660 = "llvm.extractvalue"(%659) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %661 = "llvm.extractvalue"(%659) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%661, %652)[^bb6, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb6:  // pred: ^bb5
      "llvm.br"()[^bb7] : () -> ()
    ^bb7:  // pred: ^bb6
      %662 = "llvm.xor"(%652, %660) : (i32, i32) -> i32
      "llvm.br"(%662)[^bb8] : (i32) -> ()
    ^bb8(%663: i32):  // 2 preds: ^bb5, ^bb7
      "llvm.br"()[^bb9] : () -> ()
    ^bb9:  // pred: ^bb8
      %664 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %665 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %666 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %667 = "llvm.sub"(%666, %640) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %668 = "llvm.lshr"(%665, %667) : (i32, i32) -> i32
      %669 = "llvm.sub"(%640, %664) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %670 = "nvvm.shfl.sync"(%668, %663, %607, %669) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %671 = "llvm.extractvalue"(%670) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %672 = "llvm.extractvalue"(%670) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%672, %663)[^bb10, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb10:  // pred: ^bb9
      "llvm.br"()[^bb11] : () -> ()
    ^bb11:  // pred: ^bb10
      %673 = "llvm.xor"(%663, %671) : (i32, i32) -> i32
      "llvm.br"(%673)[^bb12] : (i32) -> ()
    ^bb12(%674: i32):  // 2 preds: ^bb9, ^bb11
      "llvm.br"()[^bb13] : () -> ()
    ^bb13:  // pred: ^bb12
      %675 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %676 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %677 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %678 = "llvm.sub"(%677, %640) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %679 = "llvm.lshr"(%676, %678) : (i32, i32) -> i32
      %680 = "llvm.sub"(%640, %675) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %681 = "nvvm.shfl.sync"(%679, %674, %606, %680) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %682 = "llvm.extractvalue"(%681) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %683 = "llvm.extractvalue"(%681) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%683, %674)[^bb14, ^bb16] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb14:  // pred: ^bb13
      "llvm.br"()[^bb15] : () -> ()
    ^bb15:  // pred: ^bb14
      %684 = "llvm.xor"(%674, %682) : (i32, i32) -> i32
      "llvm.br"(%684)[^bb16] : (i32) -> ()
    ^bb16(%685: i32):  // 2 preds: ^bb13, ^bb15
      "llvm.br"()[^bb17] : () -> ()
    ^bb17:  // pred: ^bb16
      %686 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %687 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %688 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %689 = "llvm.sub"(%688, %640) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %690 = "llvm.lshr"(%687, %689) : (i32, i32) -> i32
      %691 = "llvm.sub"(%640, %686) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %692 = "nvvm.shfl.sync"(%690, %685, %605, %691) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %693 = "llvm.extractvalue"(%692) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %694 = "llvm.extractvalue"(%692) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%694, %685)[^bb18, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb18:  // pred: ^bb17
      "llvm.br"()[^bb19] : () -> ()
    ^bb19:  // pred: ^bb18
      %695 = "llvm.xor"(%685, %693) : (i32, i32) -> i32
      "llvm.br"(%695)[^bb20] : (i32) -> ()
    ^bb20(%696: i32):  // 2 preds: ^bb17, ^bb19
      "llvm.br"(%696)[^bb21] : (i32) -> ()
    ^bb21(%697: i32):  // 2 preds: ^bb20, ^bb31
      "llvm.br"()[^bb32] : () -> ()
    ^bb22:  // pred: ^bb0
      %698 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %699 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %700 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %701 = "llvm.sub"(%700, %609) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %702 = "llvm.lshr"(%699, %701) : (i32, i32) -> i32
      %703 = "llvm.sub"(%609, %698) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %704 = "nvvm.shfl.sync"(%702, %612, %612, %703) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb23] : () -> ()
    ^bb23:  // pred: ^bb22
      %705 = "llvm.xor"(%704, %612) : (i32, i32) -> i32
      "llvm.br"()[^bb24] : () -> ()
    ^bb24:  // pred: ^bb23
      %706 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %707 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %708 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %709 = "llvm.sub"(%708, %609) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %710 = "llvm.lshr"(%707, %709) : (i32, i32) -> i32
      %711 = "llvm.sub"(%609, %706) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %712 = "nvvm.shfl.sync"(%710, %705, %608, %711) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb25] : () -> ()
    ^bb25:  // pred: ^bb24
      %713 = "llvm.xor"(%705, %712) : (i32, i32) -> i32
      "llvm.br"()[^bb26] : () -> ()
    ^bb26:  // pred: ^bb25
      %714 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %715 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %716 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %717 = "llvm.sub"(%716, %609) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %718 = "llvm.lshr"(%715, %717) : (i32, i32) -> i32
      %719 = "llvm.sub"(%609, %714) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %720 = "nvvm.shfl.sync"(%718, %713, %607, %719) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb27] : () -> ()
    ^bb27:  // pred: ^bb26
      %721 = "llvm.xor"(%713, %720) : (i32, i32) -> i32
      "llvm.br"()[^bb28] : () -> ()
    ^bb28:  // pred: ^bb27
      %722 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %723 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %724 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %725 = "llvm.sub"(%724, %609) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %726 = "llvm.lshr"(%723, %725) : (i32, i32) -> i32
      %727 = "llvm.sub"(%609, %722) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %728 = "nvvm.shfl.sync"(%726, %721, %606, %727) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb29] : () -> ()
    ^bb29:  // pred: ^bb28
      %729 = "llvm.xor"(%721, %728) : (i32, i32) -> i32
      "llvm.br"()[^bb30] : () -> ()
    ^bb30:  // pred: ^bb29
      %730 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %731 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %732 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %733 = "llvm.sub"(%732, %609) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %734 = "llvm.lshr"(%731, %733) : (i32, i32) -> i32
      %735 = "llvm.sub"(%609, %730) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %736 = "nvvm.shfl.sync"(%734, %729, %605, %735) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb31] : () -> ()
    ^bb31:  // pred: ^bb30
      %737 = "llvm.xor"(%729, %736) : (i32, i32) -> i32
      "llvm.br"(%737)[^bb21] : (i32) -> ()
    ^bb32:  // pred: ^bb21
      "llvm.cond_br"(%638)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %738 = "llvm.sdiv"(%635, %609) : (i32, i32) -> i32
      %739 = "llvm.sext"(%738) : (i32) -> i64
      %740 = "builtin.unrealized_conversion_cast"(%739) : (i64) -> index
      "memref.store"(%697, %602, %740) <{nontemporal = false}> : (i32, memref<32xi32, #gpu.address_space<workgroup>>, index) -> ()
      "llvm.br"()[^bb35] : () -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"()[^bb35] : () -> ()
    ^bb35:  // 2 preds: ^bb33, ^bb34
      "nvvm.barrier"() <{aligned = true, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      %741 = "llvm.add"(%636, %611) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %742 = "llvm.sdiv"(%741, %609) : (i32, i32) -> i32
      %743 = "llvm.icmp"(%635, %742) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%743)[^bb36, ^bb69] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %744 = "llvm.sext"(%635) : (i32) -> i64
      %745 = "builtin.unrealized_conversion_cast"(%744) : (i64) -> index
      %746 = "memref.load"(%602, %745) <{invariant = false, nontemporal = false}> : (memref<32xi32, #gpu.address_space<workgroup>>, index) -> i32
      %747 = "llvm.icmp"(%742, %609) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%747)[^bb37, ^bb58] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb37:  // pred: ^bb36
      %748 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %749 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %750 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %751 = "llvm.sub"(%750, %742) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %752 = "llvm.lshr"(%749, %751) : (i32, i32) -> i32
      %753 = "llvm.sub"(%742, %748) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %754 = "nvvm.shfl.sync"(%752, %746, %612, %753) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %755 = "llvm.extractvalue"(%754) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %756 = "llvm.extractvalue"(%754) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%756, %746)[^bb38, ^bb40] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb38:  // pred: ^bb37
      "llvm.br"()[^bb39] : () -> ()
    ^bb39:  // pred: ^bb38
      %757 = "llvm.xor"(%746, %755) : (i32, i32) -> i32
      "llvm.br"(%757)[^bb40] : (i32) -> ()
    ^bb40(%758: i32):  // 2 preds: ^bb37, ^bb39
      "llvm.br"()[^bb41] : () -> ()
    ^bb41:  // pred: ^bb40
      %759 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %760 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %761 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %762 = "llvm.sub"(%761, %742) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %763 = "llvm.lshr"(%760, %762) : (i32, i32) -> i32
      %764 = "llvm.sub"(%742, %759) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %765 = "nvvm.shfl.sync"(%763, %758, %608, %764) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %766 = "llvm.extractvalue"(%765) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %767 = "llvm.extractvalue"(%765) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%767, %758)[^bb42, ^bb44] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb42:  // pred: ^bb41
      "llvm.br"()[^bb43] : () -> ()
    ^bb43:  // pred: ^bb42
      %768 = "llvm.xor"(%758, %766) : (i32, i32) -> i32
      "llvm.br"(%768)[^bb44] : (i32) -> ()
    ^bb44(%769: i32):  // 2 preds: ^bb41, ^bb43
      "llvm.br"()[^bb45] : () -> ()
    ^bb45:  // pred: ^bb44
      %770 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %771 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %772 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %773 = "llvm.sub"(%772, %742) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %774 = "llvm.lshr"(%771, %773) : (i32, i32) -> i32
      %775 = "llvm.sub"(%742, %770) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %776 = "nvvm.shfl.sync"(%774, %769, %607, %775) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %777 = "llvm.extractvalue"(%776) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %778 = "llvm.extractvalue"(%776) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%778, %769)[^bb46, ^bb48] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb46:  // pred: ^bb45
      "llvm.br"()[^bb47] : () -> ()
    ^bb47:  // pred: ^bb46
      %779 = "llvm.xor"(%769, %777) : (i32, i32) -> i32
      "llvm.br"(%779)[^bb48] : (i32) -> ()
    ^bb48(%780: i32):  // 2 preds: ^bb45, ^bb47
      "llvm.br"()[^bb49] : () -> ()
    ^bb49:  // pred: ^bb48
      %781 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %782 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %783 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %784 = "llvm.sub"(%783, %742) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %785 = "llvm.lshr"(%782, %784) : (i32, i32) -> i32
      %786 = "llvm.sub"(%742, %781) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %787 = "nvvm.shfl.sync"(%785, %780, %606, %786) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %788 = "llvm.extractvalue"(%787) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %789 = "llvm.extractvalue"(%787) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%789, %780)[^bb50, ^bb52] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb50:  // pred: ^bb49
      "llvm.br"()[^bb51] : () -> ()
    ^bb51:  // pred: ^bb50
      %790 = "llvm.xor"(%780, %788) : (i32, i32) -> i32
      "llvm.br"(%790)[^bb52] : (i32) -> ()
    ^bb52(%791: i32):  // 2 preds: ^bb49, ^bb51
      "llvm.br"()[^bb53] : () -> ()
    ^bb53:  // pred: ^bb52
      %792 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %793 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %794 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %795 = "llvm.sub"(%794, %742) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %796 = "llvm.lshr"(%793, %795) : (i32, i32) -> i32
      %797 = "llvm.sub"(%742, %792) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %798 = "nvvm.shfl.sync"(%796, %791, %605, %797) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %799 = "llvm.extractvalue"(%798) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %800 = "llvm.extractvalue"(%798) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%800, %791)[^bb54, ^bb56] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb54:  // pred: ^bb53
      "llvm.br"()[^bb55] : () -> ()
    ^bb55:  // pred: ^bb54
      %801 = "llvm.xor"(%791, %799) : (i32, i32) -> i32
      "llvm.br"(%801)[^bb56] : (i32) -> ()
    ^bb56(%802: i32):  // 2 preds: ^bb53, ^bb55
      "llvm.br"(%802)[^bb57] : (i32) -> ()
    ^bb57(%803: i32):  // 2 preds: ^bb56, ^bb67
      "llvm.br"()[^bb68] : () -> ()
    ^bb58:  // pred: ^bb36
      %804 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %805 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %806 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %807 = "llvm.sub"(%806, %609) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %808 = "llvm.lshr"(%805, %807) : (i32, i32) -> i32
      %809 = "llvm.sub"(%609, %804) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %810 = "nvvm.shfl.sync"(%808, %746, %612, %809) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb59] : () -> ()
    ^bb59:  // pred: ^bb58
      %811 = "llvm.xor"(%746, %810) : (i32, i32) -> i32
      "llvm.br"()[^bb60] : () -> ()
    ^bb60:  // pred: ^bb59
      %812 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %813 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %814 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %815 = "llvm.sub"(%814, %609) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %816 = "llvm.lshr"(%813, %815) : (i32, i32) -> i32
      %817 = "llvm.sub"(%609, %812) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %818 = "nvvm.shfl.sync"(%816, %811, %608, %817) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb61] : () -> ()
    ^bb61:  // pred: ^bb60
      %819 = "llvm.xor"(%811, %818) : (i32, i32) -> i32
      "llvm.br"()[^bb62] : () -> ()
    ^bb62:  // pred: ^bb61
      %820 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %821 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %822 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %823 = "llvm.sub"(%822, %609) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %824 = "llvm.lshr"(%821, %823) : (i32, i32) -> i32
      %825 = "llvm.sub"(%609, %820) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %826 = "nvvm.shfl.sync"(%824, %819, %607, %825) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb63] : () -> ()
    ^bb63:  // pred: ^bb62
      %827 = "llvm.xor"(%819, %826) : (i32, i32) -> i32
      "llvm.br"()[^bb64] : () -> ()
    ^bb64:  // pred: ^bb63
      %828 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %829 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %830 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %831 = "llvm.sub"(%830, %609) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %832 = "llvm.lshr"(%829, %831) : (i32, i32) -> i32
      %833 = "llvm.sub"(%609, %828) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %834 = "nvvm.shfl.sync"(%832, %827, %606, %833) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb65] : () -> ()
    ^bb65:  // pred: ^bb64
      %835 = "llvm.xor"(%827, %834) : (i32, i32) -> i32
      "llvm.br"()[^bb66] : () -> ()
    ^bb66:  // pred: ^bb65
      %836 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %837 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %838 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %839 = "llvm.sub"(%838, %609) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %840 = "llvm.lshr"(%837, %839) : (i32, i32) -> i32
      %841 = "llvm.sub"(%609, %836) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %842 = "nvvm.shfl.sync"(%840, %835, %605, %841) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb67] : () -> ()
    ^bb67:  // pred: ^bb66
      %843 = "llvm.xor"(%835, %842) : (i32, i32) -> i32
      "llvm.br"(%843)[^bb57] : (i32) -> ()
    ^bb68:  // pred: ^bb57
      "memref.store"(%803, %602, %604) <{nontemporal = false}> : (i32, memref<32xi32, #gpu.address_space<workgroup>>, index) -> ()
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
      %544 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %545 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %546 = "llvm.mlir.constant"() <{value = 23 : i32}> : () -> i32
      %547 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %548 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %549 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %550 = "llvm.sub"(%549, %546) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %551 = "llvm.lshr"(%548, %550) : (i32, i32) -> i32
      %552 = "llvm.sub"(%546, %547) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %553 = "nvvm.shfl.sync"(%551, %544, %545, %552) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %554 = "llvm.extractvalue"(%553) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %555 = "llvm.extractvalue"(%553) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %556 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %557 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %558 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %559 = "llvm.sub"(%558, %546) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %560 = "llvm.lshr"(%557, %559) : (i32, i32) -> i32
      %561 = "nvvm.shfl.sync"(%560, %544, %545, %559) <{kind = #nvvm<shfl_kind up>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %562 = "llvm.extractvalue"(%561) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %563 = "llvm.extractvalue"(%561) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %564 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %565 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %566 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %567 = "llvm.sub"(%566, %546) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %568 = "llvm.lshr"(%565, %567) : (i32, i32) -> i32
      %569 = "llvm.sub"(%546, %564) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %570 = "nvvm.shfl.sync"(%568, %544, %545, %569) <{kind = #nvvm<shfl_kind down>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %571 = "llvm.extractvalue"(%570) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %572 = "llvm.extractvalue"(%570) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %573 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %574 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %575 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %576 = "llvm.sub"(%575, %546) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %577 = "llvm.lshr"(%574, %576) : (i32, i32) -> i32
      %578 = "llvm.sub"(%546, %573) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %579 = "nvvm.shfl.sync"(%577, %544, %545, %578) <{kind = #nvvm<shfl_kind idx>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %580 = "llvm.extractvalue"(%579) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %581 = "llvm.extractvalue"(%579) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %582 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %583 = "llvm.insertvalue"(%582, %554) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %584 = "llvm.insertvalue"(%583, %562) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %585 = "llvm.insertvalue"(%584, %571) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %586 = "llvm.insertvalue"(%585, %580) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %587 = "llvm.insertvalue"(%586, %555) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %588 = "llvm.insertvalue"(%587, %563) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %589 = "llvm.insertvalue"(%588, %572) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %590 = "llvm.insertvalue"(%589, %581) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      "llvm.return"(%590) : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_shuffle", visibility_ = 0 : i64}> ({
    ^bb0(%arg273: !llvm.ptr):
      %543 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_shuffle, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      "llvm.store"(%543, %arg273) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f32, f32)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffle_unused_pred", visibility_ = 0 : i64}> ({
      %508 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %509 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %510 = "llvm.mlir.constant"() <{value = 23 : i32}> : () -> i32
      %511 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %512 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %513 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %514 = "llvm.sub"(%513, %510) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %515 = "llvm.lshr"(%512, %514) : (i32, i32) -> i32
      %516 = "llvm.sub"(%510, %511) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %517 = "nvvm.shfl.sync"(%515, %508, %509, %516) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %518 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %519 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %520 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %521 = "llvm.sub"(%520, %510) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %522 = "llvm.lshr"(%519, %521) : (i32, i32) -> i32
      %523 = "nvvm.shfl.sync"(%522, %508, %509, %521) <{kind = #nvvm<shfl_kind up>}> : (i32, f32, i32, i32) -> f32
      %524 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %525 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %526 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %527 = "llvm.sub"(%526, %510) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %528 = "llvm.lshr"(%525, %527) : (i32, i32) -> i32
      %529 = "llvm.sub"(%510, %524) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %530 = "nvvm.shfl.sync"(%528, %508, %509, %529) <{kind = #nvvm<shfl_kind down>}> : (i32, f32, i32, i32) -> f32
      %531 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %532 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %533 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %534 = "llvm.sub"(%533, %510) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %535 = "llvm.lshr"(%532, %534) : (i32, i32) -> i32
      %536 = "llvm.sub"(%510, %531) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %537 = "nvvm.shfl.sync"(%535, %508, %509, %536) <{kind = #nvvm<shfl_kind idx>}> : (i32, f32, i32, i32) -> f32
      %538 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32, f32)>
      %539 = "llvm.insertvalue"(%538, %517) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %540 = "llvm.insertvalue"(%539, %523) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %541 = "llvm.insertvalue"(%540, %530) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %542 = "llvm.insertvalue"(%541, %537) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      "llvm.return"(%542) : (!llvm.struct<(f32, f32, f32, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_shuffle_unused_pred", visibility_ = 0 : i64}> ({
    ^bb0(%arg272: !llvm.ptr):
      %507 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_shuffle_unused_pred, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(f32, f32, f32, f32)>
      "llvm.store"(%507, %arg272) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f32, f32, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_5"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_sync", visibility_ = 0 : i64}> ({
      "nvvm.barrier"() <{aligned = true, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_sync", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_sync, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_sync_subgroup", visibility_ = 0 : i64}> ({
      %506 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      "nvvm.bar.warp.sync"(%506) : (i32) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_sync_subgroup", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_sync_subgroup, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "gpu_named_barriers", visibility_ = 0 : i64}> ({
    ^bb0(%arg271: i32):
      %487 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %488 = "llvm.mlir.addressof"() <{global_name = @__named_barrier_id}> : () -> !llvm.ptr
      %489 = "llvm.load"(%488) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
      %490 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %491 = "llvm.mul"(%arg271, %490) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %492 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, i32)>
      %493 = "llvm.insertvalue"(%492, %489) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %494 = "llvm.insertvalue"(%493, %491) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %495 = "llvm.mlir.addressof"() <{global_name = @__named_barrier_id_0}> : () -> !llvm.ptr
      %496 = "llvm.load"(%495) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
      %497 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %498 = "llvm.mul"(%487, %497) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %499 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, i32)>
      %500 = "llvm.insertvalue"(%499, %496) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %501 = "llvm.insertvalue"(%500, %498) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %502 = "llvm.extractvalue"(%494) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
      %503 = "llvm.extractvalue"(%494) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
      "nvvm.barrier"(%502, %503) <{aligned = true, operandSegmentSizes = array<i32: 1, 1>}> : (i32, i32) -> ()
      %504 = "llvm.extractvalue"(%501) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
      %505 = "llvm.extractvalue"(%501) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
      "nvvm.barrier"(%504, %505) <{aligned = true, operandSegmentSizes = array<i32: 1, 1>}> : (i32, i32) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_named_barriers", visibility_ = 0 : i64}> ({
    ^bb0(%arg270: i32):
      "llvm.call"(%arg270) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_named_barriers, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<(i32, i32)>)>, linkage = #llvm.linkage<external>, sym_name = "gpu_named_barrier_arg", visibility_ = 0 : i64}> ({
    ^bb0(%arg269: !llvm.struct<(i32, i32)>):
      %485 = "llvm.extractvalue"(%arg269) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
      %486 = "llvm.extractvalue"(%arg269) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
      "nvvm.barrier"(%485, %486) <{aligned = true, operandSegmentSizes = array<i32: 1, 1>}> : (i32, i32) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<(i32, i32)>)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_named_barrier_arg", visibility_ = 0 : i64}> ({
    ^bb0(%arg268: !llvm.struct<(i32, i32)>):
      "llvm.call"(%arg268) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_named_barrier_arg, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.struct<(i32, i32)>) -> ()
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
    ^bb0(%arg266: f32, %arg267: f64):
      %480 = "llvm.call"(%arg266) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fabsf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %481 = "llvm.call"(%arg267) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fabs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %482 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %483 = "llvm.insertvalue"(%482, %480) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %484 = "llvm.insertvalue"(%483, %481) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%484) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_fabs", visibility_ = 0 : i64}> ({
    ^bb0(%arg263: !llvm.ptr, %arg264: f32, %arg265: f64):
      %479 = "llvm.call"(%arg264, %arg265) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_fabs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%479, %arg263) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_7"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cbrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cbrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cbrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg261: f32, %arg262: f64):
      %474 = "llvm.call"(%arg261) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cbrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %475 = "llvm.call"(%arg262) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cbrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %476 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %477 = "llvm.insertvalue"(%476, %474) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %478 = "llvm.insertvalue"(%477, %475) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%478) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_cbrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg258: !llvm.ptr, %arg259: f32, %arg260: f64):
      %473 = "llvm.call"(%arg259, %arg260) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_cbrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%473, %arg258) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_8"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_ceilf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_ceil", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_ceil", visibility_ = 0 : i64}> ({
    ^bb0(%arg256: f32, %arg257: f64):
      %468 = "llvm.call"(%arg256) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_ceilf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %469 = "llvm.call"(%arg257) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_ceil, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %470 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %471 = "llvm.insertvalue"(%470, %468) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %472 = "llvm.insertvalue"(%471, %469) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%472) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_ceil", visibility_ = 0 : i64}> ({
    ^bb0(%arg253: !llvm.ptr, %arg254: f32, %arg255: f64):
      %467 = "llvm.call"(%arg254, %arg255) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_ceil, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%467, %arg253) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_9"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_floorf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_floor", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_floor", visibility_ = 0 : i64}> ({
    ^bb0(%arg251: f32, %arg252: f64):
      %462 = "llvm.call"(%arg251) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_floorf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %463 = "llvm.call"(%arg252) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_floor, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %464 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %465 = "llvm.insertvalue"(%464, %462) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %466 = "llvm.insertvalue"(%465, %463) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%466) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_floor", visibility_ = 0 : i64}> ({
    ^bb0(%arg248: !llvm.ptr, %arg249: f32, %arg250: f64):
      %461 = "llvm.call"(%arg249, %arg250) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_floor, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%461, %arg248) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
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
    ^bb0(%arg246: f32, %arg247: f64):
      %454 = "llvm.call"(%arg246) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %455 = "llvm.call"(%arg247) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %456 = "llvm.call"(%arg246) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_cosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %457 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %458 = "llvm.insertvalue"(%457, %454) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %459 = "llvm.insertvalue"(%458, %455) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %460 = "llvm.insertvalue"(%459, %456) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%460) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_cos", visibility_ = 0 : i64}> ({
    ^bb0(%arg243: !llvm.ptr, %arg244: f32, %arg245: f64):
      %453 = "llvm.call"(%arg244, %arg245) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_cos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%453, %arg243) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
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
    ^bb0(%arg241: f32, %arg242: f64):
      %446 = "llvm.call"(%arg241) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %447 = "llvm.call"(%arg242) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %448 = "llvm.call"(%arg241) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %449 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %450 = "llvm.insertvalue"(%449, %446) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %451 = "llvm.insertvalue"(%450, %447) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %452 = "llvm.insertvalue"(%451, %448) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%452) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_exp", visibility_ = 0 : i64}> ({
    ^bb0(%arg238: !llvm.ptr, %arg239: f32, %arg240: f64):
      %445 = "llvm.call"(%arg239, %arg240) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%445, %arg238) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_12"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_exp2", visibility_ = 0 : i64}> ({
    ^bb0(%arg236: f32, %arg237: f64):
      %440 = "llvm.call"(%arg236) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %441 = "llvm.call"(%arg237) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %442 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %443 = "llvm.insertvalue"(%442, %440) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %444 = "llvm.insertvalue"(%443, %441) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%444) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_exp2", visibility_ = 0 : i64}> ({
    ^bb0(%arg233: !llvm.ptr, %arg234: f32, %arg235: f64):
      %439 = "llvm.call"(%arg234, %arg235) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_exp2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%439, %arg233) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
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
    ^bb0(%arg231: f32, %arg232: f64):
      %432 = "llvm.call"(%arg231) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_logf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %433 = "llvm.call"(%arg232) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %434 = "llvm.call"(%arg231) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_logf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %435 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %436 = "llvm.insertvalue"(%435, %432) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %437 = "llvm.insertvalue"(%436, %433) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %438 = "llvm.insertvalue"(%437, %434) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%438) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_log", visibility_ = 0 : i64}> ({
    ^bb0(%arg228: !llvm.ptr, %arg229: f32, %arg230: f64):
      %431 = "llvm.call"(%arg229, %arg230) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_log, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%431, %arg228) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
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
    ^bb0(%arg226: f32, %arg227: f64):
      %424 = "llvm.call"(%arg226) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log10f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %425 = "llvm.call"(%arg227) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log10, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %426 = "llvm.call"(%arg226) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_log10f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %427 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %428 = "llvm.insertvalue"(%427, %424) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %429 = "llvm.insertvalue"(%428, %425) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %430 = "llvm.insertvalue"(%429, %426) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%430) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_log10", visibility_ = 0 : i64}> ({
    ^bb0(%arg223: !llvm.ptr, %arg224: f32, %arg225: f64):
      %423 = "llvm.call"(%arg224, %arg225) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_log10, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%423, %arg223) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_15"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log1pf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log1p", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log1p", visibility_ = 0 : i64}> ({
    ^bb0(%arg221: f32, %arg222: f64):
      %418 = "llvm.call"(%arg221) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log1pf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %419 = "llvm.call"(%arg222) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log1p, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %420 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %421 = "llvm.insertvalue"(%420, %418) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %422 = "llvm.insertvalue"(%421, %419) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%422) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_log1p", visibility_ = 0 : i64}> ({
    ^bb0(%arg218: !llvm.ptr, %arg219: f32, %arg220: f64):
      %417 = "llvm.call"(%arg219, %arg220) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_log1p, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%417, %arg218) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
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
    ^bb0(%arg216: f32, %arg217: f64):
      %410 = "llvm.call"(%arg216) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %411 = "llvm.call"(%arg217) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %412 = "llvm.call"(%arg216) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_log2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %413 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %414 = "llvm.insertvalue"(%413, %410) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %415 = "llvm.insertvalue"(%414, %411) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %416 = "llvm.insertvalue"(%415, %412) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%416) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_log2", visibility_ = 0 : i64}> ({
    ^bb0(%arg213: !llvm.ptr, %arg214: f32, %arg215: f64):
      %409 = "llvm.call"(%arg214, %arg215) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_log2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%409, %arg213) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
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
    ^bb0(%arg211: f32, %arg212: f64):
      %402 = "llvm.call"(%arg211) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %403 = "llvm.call"(%arg212) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %404 = "llvm.call"(%arg211) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %405 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %406 = "llvm.insertvalue"(%405, %402) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %407 = "llvm.insertvalue"(%406, %403) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %408 = "llvm.insertvalue"(%407, %404) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%408) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_sin", visibility_ = 0 : i64}> ({
    ^bb0(%arg208: !llvm.ptr, %arg209: f32, %arg210: f64):
      %401 = "llvm.call"(%arg209, %arg210) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_sin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%401, %arg208) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
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
    ^bb0(%arg205: f16, %arg206: f32, %arg207: f64):
      %390 = "llvm.fpext"(%arg205) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %391 = "llvm.call"(%390) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %392 = "llvm.fptrunc"(%391) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %393 = "llvm.call"(%arg206) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %394 = "llvm.call"(%arg207) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %395 = "llvm.call"(%arg206) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %396 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64, f32)>
      %397 = "llvm.insertvalue"(%396, %392) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64, f32)>, f16) -> !llvm.struct<(f16, f32, f64, f32)>
      %398 = "llvm.insertvalue"(%397, %393) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64, f32)>, f32) -> !llvm.struct<(f16, f32, f64, f32)>
      %399 = "llvm.insertvalue"(%398, %394) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64, f32)>, f64) -> !llvm.struct<(f16, f32, f64, f32)>
      %400 = "llvm.insertvalue"(%399, %395) <{position = array<i64: 3>}> : (!llvm.struct<(f16, f32, f64, f32)>, f32) -> !llvm.struct<(f16, f32, f64, f32)>
      "llvm.return"(%400) : (!llvm.struct<(f16, f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_tan", visibility_ = 0 : i64}> ({
    ^bb0(%arg201: !llvm.ptr, %arg202: f16, %arg203: f32, %arg204: f64):
      %389 = "llvm.call"(%arg202, %arg203, %arg204) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_tan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64, f32)>
      "llvm.store"(%389, %arg201) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_19"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_tanh", visibility_ = 0 : i64}> ({
    ^bb0(%arg198: f16, %arg199: f32, %arg200: f64):
      %380 = "llvm.fpext"(%arg198) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %381 = "llvm.call"(%380) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %382 = "llvm.fptrunc"(%381) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %383 = "llvm.call"(%arg199) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %384 = "llvm.call"(%arg200) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %385 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %386 = "llvm.insertvalue"(%385, %382) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %387 = "llvm.insertvalue"(%386, %383) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %388 = "llvm.insertvalue"(%387, %384) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%388) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_tanh", visibility_ = 0 : i64}> ({
    ^bb0(%arg194: !llvm.ptr, %arg195: f16, %arg196: f32, %arg197: f64):
      %379 = "llvm.call"(%arg195, %arg196, %arg197) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_tanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%379, %arg194) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_20"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rsqrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rsqrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_rsqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg191: f16, %arg192: f32, %arg193: f64):
      %370 = "llvm.fpext"(%arg191) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %371 = "llvm.call"(%370) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %372 = "llvm.fptrunc"(%371) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %373 = "llvm.call"(%arg192) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %374 = "llvm.call"(%arg193) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %375 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %376 = "llvm.insertvalue"(%375, %372) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %377 = "llvm.insertvalue"(%376, %373) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %378 = "llvm.insertvalue"(%377, %374) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%378) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_rsqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg187: !llvm.ptr, %arg188: f16, %arg189: f32, %arg190: f64):
      %369 = "llvm.call"(%arg188, %arg189, %arg190) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_rsqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%369, %arg187) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_21"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sqrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sqrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg184: f16, %arg185: f32, %arg186: f64):
      %360 = "llvm.fpext"(%arg184) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %361 = "llvm.call"(%360) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %362 = "llvm.fptrunc"(%361) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %363 = "llvm.call"(%arg185) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %364 = "llvm.call"(%arg186) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %365 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %366 = "llvm.insertvalue"(%365, %362) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %367 = "llvm.insertvalue"(%366, %363) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %368 = "llvm.insertvalue"(%367, %364) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%368) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_sqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg180: !llvm.ptr, %arg181: f16, %arg182: f32, %arg183: f64):
      %359 = "llvm.call"(%arg181, %arg182, %arg183) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_sqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%359, %arg180) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_22"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atan", visibility_ = 0 : i64}> ({
    ^bb0(%arg177: f16, %arg178: f32, %arg179: f64):
      %350 = "llvm.fpext"(%arg177) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %351 = "llvm.call"(%350) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %352 = "llvm.fptrunc"(%351) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %353 = "llvm.call"(%arg178) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %354 = "llvm.call"(%arg179) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %355 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %356 = "llvm.insertvalue"(%355, %352) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %357 = "llvm.insertvalue"(%356, %353) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %358 = "llvm.insertvalue"(%357, %354) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%358) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_atan", visibility_ = 0 : i64}> ({
    ^bb0(%arg173: !llvm.ptr, %arg174: f16, %arg175: f32, %arg176: f64):
      %349 = "llvm.call"(%arg174, %arg175, %arg176) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_atan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%349, %arg173) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_23"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atan2", visibility_ = 0 : i64}> ({
    ^bb0(%arg170: f16, %arg171: f32, %arg172: f64):
      %339 = "llvm.fpext"(%arg170) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %340 = "llvm.fpext"(%arg170) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %341 = "llvm.call"(%339, %340) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %342 = "llvm.fptrunc"(%341) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %343 = "llvm.call"(%arg171, %arg171) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %344 = "llvm.call"(%arg172, %arg172) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %345 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %346 = "llvm.insertvalue"(%345, %342) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %347 = "llvm.insertvalue"(%346, %343) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %348 = "llvm.insertvalue"(%347, %344) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%348) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_atan2", visibility_ = 0 : i64}> ({
    ^bb0(%arg166: !llvm.ptr, %arg167: f16, %arg168: f32, %arg169: f64):
      %338 = "llvm.call"(%arg167, %arg168, %arg169) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_atan2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%338, %arg166) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
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
      ^bb0(%arg164: f32, %arg165: f64):
        %331 = "llvm.call"(%arg164) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
        %332 = "llvm.call"(%arg165) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
        %333 = "llvm.call"(%arg164) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
        %334 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
        %335 = "llvm.insertvalue"(%334, %331) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
        %336 = "llvm.insertvalue"(%335, %332) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
        %337 = "llvm.insertvalue"(%336, %333) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
        "llvm.return"(%337) : (!llvm.struct<(f32, f64, f32)>) -> ()
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
    ^bb0(%arg162: f32, %arg163: f64):
      %326 = "llvm.call"(%arg162) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expm1f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %327 = "llvm.call"(%arg163) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expm1, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %328 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %329 = "llvm.insertvalue"(%328, %326) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %330 = "llvm.insertvalue"(%329, %327) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%330) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_expm1", visibility_ = 0 : i64}> ({
    ^bb0(%arg159: !llvm.ptr, %arg160: f32, %arg161: f64):
      %325 = "llvm.call"(%arg160, %arg161) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_expm1, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64)>
      "llvm.store"(%325, %arg159) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64)>, !llvm.ptr) -> ()
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
    ^bb0(%arg157: f32, %arg158: f64):
      %318 = "llvm.call"(%arg157, %arg157) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %319 = "llvm.call"(%arg158, %arg158) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_pow, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %320 = "llvm.call"(%arg157, %arg157) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_powf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %321 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %322 = "llvm.insertvalue"(%321, %318) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %323 = "llvm.insertvalue"(%322, %319) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %324 = "llvm.insertvalue"(%323, %320) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%324) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_pow", visibility_ = 0 : i64}> ({
    ^bb0(%arg154: !llvm.ptr, %arg155: f32, %arg156: f64):
      %317 = "llvm.call"(%arg155, %arg156) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_pow, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f64) -> !llvm.struct<(f32, f64, f32)>
      "llvm.store"(%317, %arg154) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f64, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_27"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xf32> (vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "gpu_unroll", visibility_ = 0 : i64}> ({
    ^bb0(%arg153: vector<4xf32>):
      %300 = "llvm.mlir.poison"() : () -> vector<4xf32>
      %301 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
      %302 = "llvm.extractelement"(%arg153, %301) : (vector<4xf32>, i64) -> f32
      %303 = "llvm.call"(%302) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %304 = "llvm.insertelement"(%300, %303, %301) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %305 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
      %306 = "llvm.extractelement"(%arg153, %305) : (vector<4xf32>, i64) -> f32
      %307 = "llvm.call"(%306) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %308 = "llvm.insertelement"(%304, %307, %305) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %309 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
      %310 = "llvm.extractelement"(%arg153, %309) : (vector<4xf32>, i64) -> f32
      %311 = "llvm.call"(%310) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %312 = "llvm.insertelement"(%308, %311, %309) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %313 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
      %314 = "llvm.extractelement"(%arg153, %313) : (vector<4xf32>, i64) -> f32
      %315 = "llvm.call"(%314) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %316 = "llvm.insertelement"(%312, %315, %313) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      "llvm.return"(%316) : (vector<4xf32>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xf32> (vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_unroll", visibility_ = 0 : i64}> ({
    ^bb0(%arg152: vector<4xf32>):
      %299 = "llvm.call"(%arg152) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_unroll, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (vector<4xf32>) -> vector<4xf32>
      "llvm.return"(%299) : (vector<4xf32>) -> ()
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
      %289 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
      %290 = "llvm.getelementptr"(%289) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %291 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %292 = "llvm.alloca"(%291) <{elem_type = !llvm.struct<()>}> : (i64) -> !llvm.ptr
      %293 = "llvm.call"(%290, %292) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      %294 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
      %295 = "llvm.getelementptr"(%294) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %296 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %297 = "llvm.alloca"(%296) <{elem_type = !llvm.struct<()>}> : (i64) -> !llvm.ptr
      %298 = "llvm.call"(%295, %297) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, f32)>, linkage = #llvm.linkage<external>, sym_name = "test_printf", visibility_ = 0 : i64}> ({
    ^bb0(%arg150: i32, %arg151: f32):
      %281 = "llvm.mlir.addressof"() <{global_name = @printfFormat_1}> : () -> !llvm.ptr
      %282 = "llvm.getelementptr"(%281) <{elem_type = !llvm.array<11 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %283 = "llvm.fpext"(%arg151) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f64
      %284 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %285 = "llvm.alloca"(%284) <{elem_type = !llvm.struct<(i32, f64)>}> : (i64) -> !llvm.ptr
      %286 = "llvm.getelementptr"(%285) <{elem_type = !llvm.struct<(i32, f64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      "llvm.store"(%arg150, %286) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      %287 = "llvm.getelementptr"(%285) <{elem_type = !llvm.struct<(i32, f64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
      "llvm.store"(%283, %287) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
      %288 = "llvm.call"(%282, %285) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_30"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_add", visibility_ = 0 : i64}> ({
    ^bb0(%arg146: i32, %arg147: !llvm.ptr, %arg148: !llvm.ptr, %arg149: i64):
      %274 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %275 = "llvm.insertvalue"(%274, %arg147) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %276 = "llvm.insertvalue"(%275, %arg148) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %277 = "llvm.insertvalue"(%276, %arg149) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %278 = "builtin.unrealized_conversion_cast"(%277) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<i32>
      %279 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %280 = "nvvm.redux.sync"(%arg146, %279) <{abs = false, kind = #nvvm<reduction_kind add>, nan = false}> : (i32, i32) -> i32
      "memref.store"(%280, %278) : (i32, memref<i32>) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_minsi", visibility_ = 0 : i64}> ({
    ^bb0(%arg142: i32, %arg143: !llvm.ptr, %arg144: !llvm.ptr, %arg145: i64):
      %267 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %268 = "llvm.insertvalue"(%267, %arg143) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %269 = "llvm.insertvalue"(%268, %arg144) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %270 = "llvm.insertvalue"(%269, %arg145) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %271 = "builtin.unrealized_conversion_cast"(%270) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<i32>
      %272 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %273 = "nvvm.redux.sync"(%arg142, %272) <{abs = false, kind = #nvvm<reduction_kind min>, nan = false}> : (i32, i32) -> i32
      "memref.store"(%273, %271) : (i32, memref<i32>) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_maxsi", visibility_ = 0 : i64}> ({
    ^bb0(%arg138: i32, %arg139: !llvm.ptr, %arg140: !llvm.ptr, %arg141: i64):
      %260 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %261 = "llvm.insertvalue"(%260, %arg139) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %262 = "llvm.insertvalue"(%261, %arg140) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %263 = "llvm.insertvalue"(%262, %arg141) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %264 = "builtin.unrealized_conversion_cast"(%263) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<i32>
      %265 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %266 = "nvvm.redux.sync"(%arg138, %265) <{abs = false, kind = #nvvm<reduction_kind max>, nan = false}> : (i32, i32) -> i32
      "memref.store"(%266, %264) : (i32, memref<i32>) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_and", visibility_ = 0 : i64}> ({
    ^bb0(%arg134: i32, %arg135: !llvm.ptr, %arg136: !llvm.ptr, %arg137: i64):
      %253 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %254 = "llvm.insertvalue"(%253, %arg135) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %255 = "llvm.insertvalue"(%254, %arg136) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %256 = "llvm.insertvalue"(%255, %arg137) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %257 = "builtin.unrealized_conversion_cast"(%256) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<i32>
      %258 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %259 = "nvvm.redux.sync"(%arg134, %258) <{abs = false, kind = #nvvm<reduction_kind and>, nan = false}> : (i32, i32) -> i32
      "memref.store"(%259, %257) : (i32, memref<i32>) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_or", visibility_ = 0 : i64}> ({
    ^bb0(%arg130: i32, %arg131: !llvm.ptr, %arg132: !llvm.ptr, %arg133: i64):
      %246 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %247 = "llvm.insertvalue"(%246, %arg131) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %248 = "llvm.insertvalue"(%247, %arg132) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %249 = "llvm.insertvalue"(%248, %arg133) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %250 = "builtin.unrealized_conversion_cast"(%249) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<i32>
      %251 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %252 = "nvvm.redux.sync"(%arg130, %251) <{abs = false, kind = #nvvm<reduction_kind or>, nan = false}> : (i32, i32) -> i32
      "memref.store"(%252, %250) : (i32, memref<i32>) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_xor", visibility_ = 0 : i64}> ({
    ^bb0(%arg126: i32, %arg127: !llvm.ptr, %arg128: !llvm.ptr, %arg129: i64):
      %239 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %240 = "llvm.insertvalue"(%239, %arg127) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %241 = "llvm.insertvalue"(%240, %arg128) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %242 = "llvm.insertvalue"(%241, %arg129) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %243 = "builtin.unrealized_conversion_cast"(%242) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<i32>
      %244 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %245 = "nvvm.redux.sync"(%arg126, %244) <{abs = false, kind = #nvvm<reduction_kind xor>, nan = false}> : (i32, i32) -> i32
      "memref.store"(%245, %243) : (i32, memref<i32>) -> ()
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
      %177 = "llvm.fpext"(%arg86) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      %178 = "llvm.call"(%177) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %179 = "llvm.fptrunc"(%178) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
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
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<90 x i8>, linkage = #llvm.linkage<internal>, sym_name = "assert_file_0", value = "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm.mlir\00", visibility_ = 0 : i64}> ({
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
      %96 = "llvm.getelementptr"(%95) <{elem_type = !llvm.array<90 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %97 = "llvm.mlir.addressof"() <{global_name = @assert_func_0}> : () -> !llvm.ptr
      %98 = "llvm.getelementptr"(%97) <{elem_type = !llvm.array<10 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %99 = "llvm.mlir.constant"() <{value = 1056 : i32}> : () -> i32
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
      "transform.apply_conversion_patterns"(%92) <{illegal_dialects = ["gpu"], illegal_ops = ["llvm.copysign", "llvm.cos", "llvm.exp", "llvm.exp2", "llvm.fabs", "llvm.fceil", "llvm.ffloor", "llvm.frem", "llvm.log", "llvm.log10", "llvm.log2", "llvm.pow", "llvm.roundeven", "llvm.round", "llvm.sin", "llvm.sqrt"], legal_dialects = ["llvm", "memref", "nvvm", "test"], legal_ops = ["gpu.module", "gpu.yield"], partial_conversion}> ({
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
      %36 = "llvm.fpext"(%arg11) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      "llvm.call"(%36, %34, %35) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %37 = "llvm.load"(%34) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %38 = "llvm.load"(%35) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %39 = "llvm.fptrunc"(%37) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %40 = "llvm.fptrunc"(%38) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
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
      %10 = "llvm.fpext"(%arg4) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f32
      "llvm.call"(%10, %8, %9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %11 = "llvm.load"(%8) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %12 = "llvm.load"(%9) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %13 = "llvm.fptrunc"(%11) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
      %14 = "llvm.fptrunc"(%12) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f16
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


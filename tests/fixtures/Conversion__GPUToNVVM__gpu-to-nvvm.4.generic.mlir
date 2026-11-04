"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_0"}> ({
    "func.func"() <{function_type = () -> (index, index, index, index, index, index, index, index, index, index, index, index, index), sym_name = "gpu_index_ops"}> ({
      %1019 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %1020 = "llvm.sext"(%1019) : (i32) -> i64
      %1021 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %1022 = "llvm.sext"(%1021) : (i32) -> i64
      %1023 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %1024 = "llvm.sext"(%1023) : (i32) -> i64
      %1025 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %1026 = "llvm.sext"(%1025) : (i32) -> i64
      %1027 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %1028 = "llvm.sext"(%1027) : (i32) -> i64
      %1029 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %1030 = "llvm.sext"(%1029) : (i32) -> i64
      %1031 = "nvvm.read.ptx.sreg.ctaid.x"() : () -> i32
      %1032 = "llvm.sext"(%1031) : (i32) -> i64
      %1033 = "nvvm.read.ptx.sreg.ctaid.y"() : () -> i32
      %1034 = "llvm.sext"(%1033) : (i32) -> i64
      %1035 = "nvvm.read.ptx.sreg.ctaid.z"() : () -> i32
      %1036 = "llvm.sext"(%1035) : (i32) -> i64
      %1037 = "nvvm.read.ptx.sreg.nctaid.x"() : () -> i32
      %1038 = "llvm.sext"(%1037) : (i32) -> i64
      %1039 = "nvvm.read.ptx.sreg.nctaid.y"() : () -> i32
      %1040 = "llvm.sext"(%1039) : (i32) -> i64
      %1041 = "nvvm.read.ptx.sreg.nctaid.z"() : () -> i32
      %1042 = "llvm.sext"(%1041) : (i32) -> i64
      %1043 = "nvvm.read.ptx.sreg.laneid"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %1044 = "llvm.sext"(%1043) : (i32) -> i64
      %1045 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1046 = "llvm.insertvalue"(%1045, %1020) <{position = array<i64: 0>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1047 = "llvm.insertvalue"(%1046, %1022) <{position = array<i64: 1>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1048 = "llvm.insertvalue"(%1047, %1024) <{position = array<i64: 2>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1049 = "llvm.insertvalue"(%1048, %1026) <{position = array<i64: 3>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1050 = "llvm.insertvalue"(%1049, %1028) <{position = array<i64: 4>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1051 = "llvm.insertvalue"(%1050, %1030) <{position = array<i64: 5>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1052 = "llvm.insertvalue"(%1051, %1032) <{position = array<i64: 6>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1053 = "llvm.insertvalue"(%1052, %1034) <{position = array<i64: 7>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1054 = "llvm.insertvalue"(%1053, %1036) <{position = array<i64: 8>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1055 = "llvm.insertvalue"(%1054, %1038) <{position = array<i64: 9>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1056 = "llvm.insertvalue"(%1055, %1040) <{position = array<i64: 10>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1057 = "llvm.insertvalue"(%1056, %1042) <{position = array<i64: 11>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1058 = "llvm.insertvalue"(%1057, %1044) <{position = array<i64: 12>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      "llvm.return"(%1058) : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "func.func"() <{function_type = (index) -> index, sym_name = "gpu_index_comp"}> ({
    ^bb0(%arg115: index):
      %1017 = "builtin.unrealized_conversion_cast"(%arg115) : (index) -> i64
      %1018 = "llvm.add"(%1017, %1017) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.return"(%1018) : (i64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_2"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<32 x f32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_gpu_all_reduce_op_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_all_reduce_op", visibility_ = 0 : i64}> ({
      %763 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_op_0}> : () -> !llvm.ptr<3>
      %764 = "llvm.getelementptr"(%763) <{elem_type = !llvm.array<32 x f32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %765 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %766 = "llvm.insertvalue"(%765, %764) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %767 = "llvm.insertvalue"(%766, %764) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %768 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %769 = "llvm.insertvalue"(%767, %768) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %770 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %771 = "llvm.insertvalue"(%769, %770) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %772 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %773 = "llvm.insertvalue"(%771, %772) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %774 = "builtin.unrealized_conversion_cast"(%773) : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<32xf32, #gpu.address_space<workgroup>>
      %775 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %776 = "builtin.unrealized_conversion_cast"(%775) : (i64) -> index
      %777 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %778 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %779 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %780 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %781 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %782 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %783 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %784 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %785 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %786 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %787 = "llvm.sext"(%786) : (i32) -> i64
      %788 = "llvm.trunc"(%787) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %789 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %790 = "llvm.sext"(%789) : (i32) -> i64
      %791 = "llvm.trunc"(%790) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %792 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %793 = "llvm.sext"(%792) : (i32) -> i64
      %794 = "llvm.trunc"(%793) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %795 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %796 = "llvm.sext"(%795) : (i32) -> i64
      %797 = "llvm.trunc"(%796) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %798 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %799 = "llvm.sext"(%798) : (i32) -> i64
      %800 = "llvm.trunc"(%799) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %801 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %802 = "llvm.sext"(%801) : (i32) -> i64
      %803 = "llvm.trunc"(%802) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %804 = "llvm.mul"(%803, %791) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %805 = "llvm.add"(%804, %800) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %806 = "llvm.mul"(%805, %788) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %807 = "llvm.mul"(%788, %791) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %808 = "llvm.add"(%806, %797) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %809 = "llvm.mul"(%807, %794) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %810 = "llvm.and"(%808, %784) : (i32, i32) -> i32
      %811 = "llvm.icmp"(%810, %783) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %812 = "llvm.sub"(%808, %810) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %813 = "llvm.sub"(%809, %812) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %814 = "llvm.icmp"(%813, %782) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%814)[^bb1, ^bb17] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %815 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %816 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %817 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %818 = "llvm.sub"(%817, %813) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %819 = "llvm.lshr"(%816, %818) : (i32, i32) -> i32
      %820 = "llvm.sub"(%813, %815) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %821 = "nvvm.shfl.sync"(%819, %785, %781, %820) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %822 = "llvm.extractvalue"(%821) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %823 = "llvm.extractvalue"(%821) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%823)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %824 = "llvm.fadd"(%822, %785) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%824)[^bb4] : (f32) -> ()
    ^bb3:  // pred: ^bb1
      "llvm.br"(%785)[^bb4] : (f32) -> ()
    ^bb4(%825: f32):  // 2 preds: ^bb2, ^bb3
      %826 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %827 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %828 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %829 = "llvm.sub"(%828, %813) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %830 = "llvm.lshr"(%827, %829) : (i32, i32) -> i32
      %831 = "llvm.sub"(%813, %826) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %832 = "nvvm.shfl.sync"(%830, %825, %780, %831) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %833 = "llvm.extractvalue"(%832) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %834 = "llvm.extractvalue"(%832) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%834)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb5:  // pred: ^bb4
      %835 = "llvm.fadd"(%825, %833) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%835)[^bb7] : (f32) -> ()
    ^bb6:  // pred: ^bb4
      "llvm.br"(%825)[^bb7] : (f32) -> ()
    ^bb7(%836: f32):  // 2 preds: ^bb5, ^bb6
      %837 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %838 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %839 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %840 = "llvm.sub"(%839, %813) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %841 = "llvm.lshr"(%838, %840) : (i32, i32) -> i32
      %842 = "llvm.sub"(%813, %837) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %843 = "nvvm.shfl.sync"(%841, %836, %779, %842) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %844 = "llvm.extractvalue"(%843) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %845 = "llvm.extractvalue"(%843) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%845)[^bb8, ^bb9] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb8:  // pred: ^bb7
      %846 = "llvm.fadd"(%836, %844) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%846)[^bb10] : (f32) -> ()
    ^bb9:  // pred: ^bb7
      "llvm.br"(%836)[^bb10] : (f32) -> ()
    ^bb10(%847: f32):  // 2 preds: ^bb8, ^bb9
      %848 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %849 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %850 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %851 = "llvm.sub"(%850, %813) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %852 = "llvm.lshr"(%849, %851) : (i32, i32) -> i32
      %853 = "llvm.sub"(%813, %848) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %854 = "nvvm.shfl.sync"(%852, %847, %778, %853) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %855 = "llvm.extractvalue"(%854) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %856 = "llvm.extractvalue"(%854) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%856)[^bb11, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb11:  // pred: ^bb10
      %857 = "llvm.fadd"(%847, %855) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%857)[^bb13] : (f32) -> ()
    ^bb12:  // pred: ^bb10
      "llvm.br"(%847)[^bb13] : (f32) -> ()
    ^bb13(%858: f32):  // 2 preds: ^bb11, ^bb12
      %859 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %860 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %861 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %862 = "llvm.sub"(%861, %813) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %863 = "llvm.lshr"(%860, %862) : (i32, i32) -> i32
      %864 = "llvm.sub"(%813, %859) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %865 = "nvvm.shfl.sync"(%863, %858, %777, %864) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %866 = "llvm.extractvalue"(%865) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %867 = "llvm.extractvalue"(%865) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%867)[^bb14, ^bb15] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb14:  // pred: ^bb13
      %868 = "llvm.fadd"(%858, %866) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%868)[^bb16] : (f32) -> ()
    ^bb15:  // pred: ^bb13
      "llvm.br"(%858)[^bb16] : (f32) -> ()
    ^bb16(%869: f32):  // 2 preds: ^bb14, ^bb15
      "llvm.br"(%869)[^bb18] : (f32) -> ()
    ^bb17:  // pred: ^bb0
      %870 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %871 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %872 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %873 = "llvm.sub"(%872, %782) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %874 = "llvm.lshr"(%871, %873) : (i32, i32) -> i32
      %875 = "llvm.sub"(%782, %870) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %876 = "nvvm.shfl.sync"(%874, %785, %781, %875) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %877 = "llvm.fadd"(%876, %785) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %878 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %879 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %880 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %881 = "llvm.sub"(%880, %782) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %882 = "llvm.lshr"(%879, %881) : (i32, i32) -> i32
      %883 = "llvm.sub"(%782, %878) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %884 = "nvvm.shfl.sync"(%882, %877, %780, %883) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %885 = "llvm.fadd"(%877, %884) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %886 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %887 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %888 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %889 = "llvm.sub"(%888, %782) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %890 = "llvm.lshr"(%887, %889) : (i32, i32) -> i32
      %891 = "llvm.sub"(%782, %886) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %892 = "nvvm.shfl.sync"(%890, %885, %779, %891) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %893 = "llvm.fadd"(%885, %892) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %894 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %895 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %896 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %897 = "llvm.sub"(%896, %782) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %898 = "llvm.lshr"(%895, %897) : (i32, i32) -> i32
      %899 = "llvm.sub"(%782, %894) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %900 = "nvvm.shfl.sync"(%898, %893, %778, %899) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %901 = "llvm.fadd"(%893, %900) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %902 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %903 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %904 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %905 = "llvm.sub"(%904, %782) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %906 = "llvm.lshr"(%903, %905) : (i32, i32) -> i32
      %907 = "llvm.sub"(%782, %902) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %908 = "nvvm.shfl.sync"(%906, %901, %777, %907) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %909 = "llvm.fadd"(%901, %908) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%909)[^bb18] : (f32) -> ()
    ^bb18(%910: f32):  // 2 preds: ^bb16, ^bb17
      "llvm.cond_br"(%811)[^bb19, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb19:  // pred: ^bb18
      %911 = "llvm.sdiv"(%808, %782) : (i32, i32) -> i32
      %912 = "llvm.sext"(%911) : (i32) -> i64
      %913 = "builtin.unrealized_conversion_cast"(%912) : (i64) -> index
      "memref.store"(%910, %774, %913) <{nontemporal = false}> : (f32, memref<32xf32, #gpu.address_space<workgroup>>, index) -> ()
      "llvm.br"()[^bb21] : () -> ()
    ^bb20:  // pred: ^bb18
      "llvm.br"()[^bb21] : () -> ()
    ^bb21:  // 2 preds: ^bb19, ^bb20
      "nvvm.barrier0"() : () -> ()
      %914 = "llvm.add"(%809, %784) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %915 = "llvm.sdiv"(%914, %782) : (i32, i32) -> i32
      %916 = "llvm.icmp"(%808, %915) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%916)[^bb22, ^bb41] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb22:  // pred: ^bb21
      %917 = "llvm.sext"(%808) : (i32) -> i64
      %918 = "builtin.unrealized_conversion_cast"(%917) : (i64) -> index
      %919 = "memref.load"(%774, %918) <{nontemporal = false}> : (memref<32xf32, #gpu.address_space<workgroup>>, index) -> f32
      %920 = "llvm.icmp"(%915, %782) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%920)[^bb23, ^bb39] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb23:  // pred: ^bb22
      %921 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %922 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %923 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %924 = "llvm.sub"(%923, %915) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %925 = "llvm.lshr"(%922, %924) : (i32, i32) -> i32
      %926 = "llvm.sub"(%915, %921) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %927 = "nvvm.shfl.sync"(%925, %919, %781, %926) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %928 = "llvm.extractvalue"(%927) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %929 = "llvm.extractvalue"(%927) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%929)[^bb24, ^bb25] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb24:  // pred: ^bb23
      %930 = "llvm.fadd"(%919, %928) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%930)[^bb26] : (f32) -> ()
    ^bb25:  // pred: ^bb23
      "llvm.br"(%919)[^bb26] : (f32) -> ()
    ^bb26(%931: f32):  // 2 preds: ^bb24, ^bb25
      %932 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %933 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %934 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %935 = "llvm.sub"(%934, %915) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %936 = "llvm.lshr"(%933, %935) : (i32, i32) -> i32
      %937 = "llvm.sub"(%915, %932) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %938 = "nvvm.shfl.sync"(%936, %931, %780, %937) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %939 = "llvm.extractvalue"(%938) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %940 = "llvm.extractvalue"(%938) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%940)[^bb27, ^bb28] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb27:  // pred: ^bb26
      %941 = "llvm.fadd"(%931, %939) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%941)[^bb29] : (f32) -> ()
    ^bb28:  // pred: ^bb26
      "llvm.br"(%931)[^bb29] : (f32) -> ()
    ^bb29(%942: f32):  // 2 preds: ^bb27, ^bb28
      %943 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %944 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %945 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %946 = "llvm.sub"(%945, %915) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %947 = "llvm.lshr"(%944, %946) : (i32, i32) -> i32
      %948 = "llvm.sub"(%915, %943) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %949 = "nvvm.shfl.sync"(%947, %942, %779, %948) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %950 = "llvm.extractvalue"(%949) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %951 = "llvm.extractvalue"(%949) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%951)[^bb30, ^bb31] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb30:  // pred: ^bb29
      %952 = "llvm.fadd"(%942, %950) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%952)[^bb32] : (f32) -> ()
    ^bb31:  // pred: ^bb29
      "llvm.br"(%942)[^bb32] : (f32) -> ()
    ^bb32(%953: f32):  // 2 preds: ^bb30, ^bb31
      %954 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %955 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %956 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %957 = "llvm.sub"(%956, %915) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %958 = "llvm.lshr"(%955, %957) : (i32, i32) -> i32
      %959 = "llvm.sub"(%915, %954) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %960 = "nvvm.shfl.sync"(%958, %953, %778, %959) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %961 = "llvm.extractvalue"(%960) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %962 = "llvm.extractvalue"(%960) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%962)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %963 = "llvm.fadd"(%953, %961) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%963)[^bb35] : (f32) -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"(%953)[^bb35] : (f32) -> ()
    ^bb35(%964: f32):  // 2 preds: ^bb33, ^bb34
      %965 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %966 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %967 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %968 = "llvm.sub"(%967, %915) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %969 = "llvm.lshr"(%966, %968) : (i32, i32) -> i32
      %970 = "llvm.sub"(%915, %965) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %971 = "nvvm.shfl.sync"(%969, %964, %777, %970) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %972 = "llvm.extractvalue"(%971) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %973 = "llvm.extractvalue"(%971) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%973)[^bb36, ^bb37] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %974 = "llvm.fadd"(%964, %972) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%974)[^bb38] : (f32) -> ()
    ^bb37:  // pred: ^bb35
      "llvm.br"(%964)[^bb38] : (f32) -> ()
    ^bb38(%975: f32):  // 2 preds: ^bb36, ^bb37
      "llvm.br"(%975)[^bb40] : (f32) -> ()
    ^bb39:  // pred: ^bb22
      %976 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %977 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %978 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %979 = "llvm.sub"(%978, %782) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %980 = "llvm.lshr"(%977, %979) : (i32, i32) -> i32
      %981 = "llvm.sub"(%782, %976) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %982 = "nvvm.shfl.sync"(%980, %919, %781, %981) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %983 = "llvm.fadd"(%919, %982) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %984 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %985 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %986 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %987 = "llvm.sub"(%986, %782) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %988 = "llvm.lshr"(%985, %987) : (i32, i32) -> i32
      %989 = "llvm.sub"(%782, %984) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %990 = "nvvm.shfl.sync"(%988, %983, %780, %989) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %991 = "llvm.fadd"(%983, %990) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %992 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %993 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %994 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %995 = "llvm.sub"(%994, %782) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %996 = "llvm.lshr"(%993, %995) : (i32, i32) -> i32
      %997 = "llvm.sub"(%782, %992) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %998 = "nvvm.shfl.sync"(%996, %991, %779, %997) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %999 = "llvm.fadd"(%991, %998) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1000 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1001 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1002 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1003 = "llvm.sub"(%1002, %782) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1004 = "llvm.lshr"(%1001, %1003) : (i32, i32) -> i32
      %1005 = "llvm.sub"(%782, %1000) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1006 = "nvvm.shfl.sync"(%1004, %999, %778, %1005) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1007 = "llvm.fadd"(%999, %1006) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %1008 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %1009 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %1010 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1011 = "llvm.sub"(%1010, %782) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1012 = "llvm.lshr"(%1009, %1011) : (i32, i32) -> i32
      %1013 = "llvm.sub"(%782, %1008) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1014 = "nvvm.shfl.sync"(%1012, %1007, %777, %1013) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1015 = "llvm.fadd"(%1007, %1014) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1015)[^bb40] : (f32) -> ()
    ^bb40(%1016: f32):  // 2 preds: ^bb38, ^bb39
      "memref.store"(%1016, %774, %776) <{nontemporal = false}> : (f32, memref<32xf32, #gpu.address_space<workgroup>>, index) -> ()
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
      %510 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_region_0}> : () -> !llvm.ptr<3>
      %511 = "llvm.getelementptr"(%510) <{elem_type = !llvm.array<32 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %512 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %513 = "llvm.insertvalue"(%512, %511) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %514 = "llvm.insertvalue"(%513, %511) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %515 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %516 = "llvm.insertvalue"(%514, %515) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %517 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %518 = "llvm.insertvalue"(%516, %517) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %519 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %520 = "llvm.insertvalue"(%518, %519) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %521 = "builtin.unrealized_conversion_cast"(%520) : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<32xi32, #gpu.address_space<workgroup>>
      %522 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %523 = "builtin.unrealized_conversion_cast"(%522) : (i64) -> index
      %524 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %525 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %526 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %527 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %528 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %529 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %530 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %531 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %532 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %533 = "llvm.sext"(%532) : (i32) -> i64
      %534 = "llvm.trunc"(%533) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %535 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %536 = "llvm.sext"(%535) : (i32) -> i64
      %537 = "llvm.trunc"(%536) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %538 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %539 = "llvm.sext"(%538) : (i32) -> i64
      %540 = "llvm.trunc"(%539) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %541 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %542 = "llvm.sext"(%541) : (i32) -> i64
      %543 = "llvm.trunc"(%542) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %544 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %545 = "llvm.sext"(%544) : (i32) -> i64
      %546 = "llvm.trunc"(%545) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %547 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %548 = "llvm.sext"(%547) : (i32) -> i64
      %549 = "llvm.trunc"(%548) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %550 = "llvm.mul"(%549, %537) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %551 = "llvm.add"(%550, %546) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %552 = "llvm.mul"(%551, %534) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %553 = "llvm.mul"(%534, %537) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %554 = "llvm.add"(%552, %543) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %555 = "llvm.mul"(%553, %540) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %556 = "llvm.and"(%554, %530) : (i32, i32) -> i32
      %557 = "llvm.icmp"(%556, %529) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %558 = "llvm.sub"(%554, %556) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %559 = "llvm.sub"(%555, %558) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %560 = "llvm.icmp"(%559, %528) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%560)[^bb1, ^bb22] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %561 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %562 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %563 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %564 = "llvm.sub"(%563, %559) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %565 = "llvm.lshr"(%562, %564) : (i32, i32) -> i32
      %566 = "llvm.sub"(%559, %561) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %567 = "nvvm.shfl.sync"(%565, %531, %531, %566) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %568 = "llvm.extractvalue"(%567) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %569 = "llvm.extractvalue"(%567) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%569, %531)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb2:  // pred: ^bb1
      "llvm.br"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      %570 = "llvm.xor"(%568, %531) : (i32, i32) -> i32
      "llvm.br"(%570)[^bb4] : (i32) -> ()
    ^bb4(%571: i32):  // 2 preds: ^bb1, ^bb3
      "llvm.br"()[^bb5] : () -> ()
    ^bb5:  // pred: ^bb4
      %572 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %573 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %574 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %575 = "llvm.sub"(%574, %559) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %576 = "llvm.lshr"(%573, %575) : (i32, i32) -> i32
      %577 = "llvm.sub"(%559, %572) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %578 = "nvvm.shfl.sync"(%576, %571, %527, %577) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %579 = "llvm.extractvalue"(%578) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %580 = "llvm.extractvalue"(%578) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%580, %571)[^bb6, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb6:  // pred: ^bb5
      "llvm.br"()[^bb7] : () -> ()
    ^bb7:  // pred: ^bb6
      %581 = "llvm.xor"(%571, %579) : (i32, i32) -> i32
      "llvm.br"(%581)[^bb8] : (i32) -> ()
    ^bb8(%582: i32):  // 2 preds: ^bb5, ^bb7
      "llvm.br"()[^bb9] : () -> ()
    ^bb9:  // pred: ^bb8
      %583 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %584 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %585 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %586 = "llvm.sub"(%585, %559) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %587 = "llvm.lshr"(%584, %586) : (i32, i32) -> i32
      %588 = "llvm.sub"(%559, %583) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %589 = "nvvm.shfl.sync"(%587, %582, %526, %588) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %590 = "llvm.extractvalue"(%589) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %591 = "llvm.extractvalue"(%589) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%591, %582)[^bb10, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb10:  // pred: ^bb9
      "llvm.br"()[^bb11] : () -> ()
    ^bb11:  // pred: ^bb10
      %592 = "llvm.xor"(%582, %590) : (i32, i32) -> i32
      "llvm.br"(%592)[^bb12] : (i32) -> ()
    ^bb12(%593: i32):  // 2 preds: ^bb9, ^bb11
      "llvm.br"()[^bb13] : () -> ()
    ^bb13:  // pred: ^bb12
      %594 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %595 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %596 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %597 = "llvm.sub"(%596, %559) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %598 = "llvm.lshr"(%595, %597) : (i32, i32) -> i32
      %599 = "llvm.sub"(%559, %594) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %600 = "nvvm.shfl.sync"(%598, %593, %525, %599) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %601 = "llvm.extractvalue"(%600) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %602 = "llvm.extractvalue"(%600) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%602, %593)[^bb14, ^bb16] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb14:  // pred: ^bb13
      "llvm.br"()[^bb15] : () -> ()
    ^bb15:  // pred: ^bb14
      %603 = "llvm.xor"(%593, %601) : (i32, i32) -> i32
      "llvm.br"(%603)[^bb16] : (i32) -> ()
    ^bb16(%604: i32):  // 2 preds: ^bb13, ^bb15
      "llvm.br"()[^bb17] : () -> ()
    ^bb17:  // pred: ^bb16
      %605 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %606 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %607 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %608 = "llvm.sub"(%607, %559) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %609 = "llvm.lshr"(%606, %608) : (i32, i32) -> i32
      %610 = "llvm.sub"(%559, %605) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %611 = "nvvm.shfl.sync"(%609, %604, %524, %610) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %612 = "llvm.extractvalue"(%611) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %613 = "llvm.extractvalue"(%611) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%613, %604)[^bb18, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb18:  // pred: ^bb17
      "llvm.br"()[^bb19] : () -> ()
    ^bb19:  // pred: ^bb18
      %614 = "llvm.xor"(%604, %612) : (i32, i32) -> i32
      "llvm.br"(%614)[^bb20] : (i32) -> ()
    ^bb20(%615: i32):  // 2 preds: ^bb17, ^bb19
      "llvm.br"(%615)[^bb21] : (i32) -> ()
    ^bb21(%616: i32):  // 2 preds: ^bb20, ^bb31
      "llvm.br"()[^bb32] : () -> ()
    ^bb22:  // pred: ^bb0
      %617 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %618 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %619 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %620 = "llvm.sub"(%619, %528) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %621 = "llvm.lshr"(%618, %620) : (i32, i32) -> i32
      %622 = "llvm.sub"(%528, %617) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %623 = "nvvm.shfl.sync"(%621, %531, %531, %622) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb23] : () -> ()
    ^bb23:  // pred: ^bb22
      %624 = "llvm.xor"(%623, %531) : (i32, i32) -> i32
      "llvm.br"()[^bb24] : () -> ()
    ^bb24:  // pred: ^bb23
      %625 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %626 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %627 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %628 = "llvm.sub"(%627, %528) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %629 = "llvm.lshr"(%626, %628) : (i32, i32) -> i32
      %630 = "llvm.sub"(%528, %625) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %631 = "nvvm.shfl.sync"(%629, %624, %527, %630) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb25] : () -> ()
    ^bb25:  // pred: ^bb24
      %632 = "llvm.xor"(%624, %631) : (i32, i32) -> i32
      "llvm.br"()[^bb26] : () -> ()
    ^bb26:  // pred: ^bb25
      %633 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %634 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %635 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %636 = "llvm.sub"(%635, %528) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %637 = "llvm.lshr"(%634, %636) : (i32, i32) -> i32
      %638 = "llvm.sub"(%528, %633) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %639 = "nvvm.shfl.sync"(%637, %632, %526, %638) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb27] : () -> ()
    ^bb27:  // pred: ^bb26
      %640 = "llvm.xor"(%632, %639) : (i32, i32) -> i32
      "llvm.br"()[^bb28] : () -> ()
    ^bb28:  // pred: ^bb27
      %641 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %642 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %643 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %644 = "llvm.sub"(%643, %528) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %645 = "llvm.lshr"(%642, %644) : (i32, i32) -> i32
      %646 = "llvm.sub"(%528, %641) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %647 = "nvvm.shfl.sync"(%645, %640, %525, %646) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb29] : () -> ()
    ^bb29:  // pred: ^bb28
      %648 = "llvm.xor"(%640, %647) : (i32, i32) -> i32
      "llvm.br"()[^bb30] : () -> ()
    ^bb30:  // pred: ^bb29
      %649 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %650 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %651 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %652 = "llvm.sub"(%651, %528) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %653 = "llvm.lshr"(%650, %652) : (i32, i32) -> i32
      %654 = "llvm.sub"(%528, %649) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %655 = "nvvm.shfl.sync"(%653, %648, %524, %654) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb31] : () -> ()
    ^bb31:  // pred: ^bb30
      %656 = "llvm.xor"(%648, %655) : (i32, i32) -> i32
      "llvm.br"(%656)[^bb21] : (i32) -> ()
    ^bb32:  // pred: ^bb21
      "llvm.cond_br"(%557)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %657 = "llvm.sdiv"(%554, %528) : (i32, i32) -> i32
      %658 = "llvm.sext"(%657) : (i32) -> i64
      %659 = "builtin.unrealized_conversion_cast"(%658) : (i64) -> index
      "memref.store"(%616, %521, %659) <{nontemporal = false}> : (i32, memref<32xi32, #gpu.address_space<workgroup>>, index) -> ()
      "llvm.br"()[^bb35] : () -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"()[^bb35] : () -> ()
    ^bb35:  // 2 preds: ^bb33, ^bb34
      "nvvm.barrier0"() : () -> ()
      %660 = "llvm.add"(%555, %530) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %661 = "llvm.sdiv"(%660, %528) : (i32, i32) -> i32
      %662 = "llvm.icmp"(%554, %661) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%662)[^bb36, ^bb69] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %663 = "llvm.sext"(%554) : (i32) -> i64
      %664 = "builtin.unrealized_conversion_cast"(%663) : (i64) -> index
      %665 = "memref.load"(%521, %664) <{nontemporal = false}> : (memref<32xi32, #gpu.address_space<workgroup>>, index) -> i32
      %666 = "llvm.icmp"(%661, %528) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%666)[^bb37, ^bb58] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb37:  // pred: ^bb36
      %667 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %668 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %669 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %670 = "llvm.sub"(%669, %661) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %671 = "llvm.lshr"(%668, %670) : (i32, i32) -> i32
      %672 = "llvm.sub"(%661, %667) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %673 = "nvvm.shfl.sync"(%671, %665, %531, %672) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %674 = "llvm.extractvalue"(%673) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %675 = "llvm.extractvalue"(%673) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%675, %665)[^bb38, ^bb40] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb38:  // pred: ^bb37
      "llvm.br"()[^bb39] : () -> ()
    ^bb39:  // pred: ^bb38
      %676 = "llvm.xor"(%665, %674) : (i32, i32) -> i32
      "llvm.br"(%676)[^bb40] : (i32) -> ()
    ^bb40(%677: i32):  // 2 preds: ^bb37, ^bb39
      "llvm.br"()[^bb41] : () -> ()
    ^bb41:  // pred: ^bb40
      %678 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %679 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %680 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %681 = "llvm.sub"(%680, %661) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %682 = "llvm.lshr"(%679, %681) : (i32, i32) -> i32
      %683 = "llvm.sub"(%661, %678) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %684 = "nvvm.shfl.sync"(%682, %677, %527, %683) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %685 = "llvm.extractvalue"(%684) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %686 = "llvm.extractvalue"(%684) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%686, %677)[^bb42, ^bb44] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb42:  // pred: ^bb41
      "llvm.br"()[^bb43] : () -> ()
    ^bb43:  // pred: ^bb42
      %687 = "llvm.xor"(%677, %685) : (i32, i32) -> i32
      "llvm.br"(%687)[^bb44] : (i32) -> ()
    ^bb44(%688: i32):  // 2 preds: ^bb41, ^bb43
      "llvm.br"()[^bb45] : () -> ()
    ^bb45:  // pred: ^bb44
      %689 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %690 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %691 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %692 = "llvm.sub"(%691, %661) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %693 = "llvm.lshr"(%690, %692) : (i32, i32) -> i32
      %694 = "llvm.sub"(%661, %689) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %695 = "nvvm.shfl.sync"(%693, %688, %526, %694) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %696 = "llvm.extractvalue"(%695) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %697 = "llvm.extractvalue"(%695) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%697, %688)[^bb46, ^bb48] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb46:  // pred: ^bb45
      "llvm.br"()[^bb47] : () -> ()
    ^bb47:  // pred: ^bb46
      %698 = "llvm.xor"(%688, %696) : (i32, i32) -> i32
      "llvm.br"(%698)[^bb48] : (i32) -> ()
    ^bb48(%699: i32):  // 2 preds: ^bb45, ^bb47
      "llvm.br"()[^bb49] : () -> ()
    ^bb49:  // pred: ^bb48
      %700 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %701 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %702 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %703 = "llvm.sub"(%702, %661) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %704 = "llvm.lshr"(%701, %703) : (i32, i32) -> i32
      %705 = "llvm.sub"(%661, %700) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %706 = "nvvm.shfl.sync"(%704, %699, %525, %705) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %707 = "llvm.extractvalue"(%706) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %708 = "llvm.extractvalue"(%706) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%708, %699)[^bb50, ^bb52] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb50:  // pred: ^bb49
      "llvm.br"()[^bb51] : () -> ()
    ^bb51:  // pred: ^bb50
      %709 = "llvm.xor"(%699, %707) : (i32, i32) -> i32
      "llvm.br"(%709)[^bb52] : (i32) -> ()
    ^bb52(%710: i32):  // 2 preds: ^bb49, ^bb51
      "llvm.br"()[^bb53] : () -> ()
    ^bb53:  // pred: ^bb52
      %711 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %712 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %713 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %714 = "llvm.sub"(%713, %661) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %715 = "llvm.lshr"(%712, %714) : (i32, i32) -> i32
      %716 = "llvm.sub"(%661, %711) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %717 = "nvvm.shfl.sync"(%715, %710, %524, %716) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %718 = "llvm.extractvalue"(%717) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %719 = "llvm.extractvalue"(%717) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%719, %710)[^bb54, ^bb56] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb54:  // pred: ^bb53
      "llvm.br"()[^bb55] : () -> ()
    ^bb55:  // pred: ^bb54
      %720 = "llvm.xor"(%710, %718) : (i32, i32) -> i32
      "llvm.br"(%720)[^bb56] : (i32) -> ()
    ^bb56(%721: i32):  // 2 preds: ^bb53, ^bb55
      "llvm.br"(%721)[^bb57] : (i32) -> ()
    ^bb57(%722: i32):  // 2 preds: ^bb56, ^bb67
      "llvm.br"()[^bb68] : () -> ()
    ^bb58:  // pred: ^bb36
      %723 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %724 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %725 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %726 = "llvm.sub"(%725, %528) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %727 = "llvm.lshr"(%724, %726) : (i32, i32) -> i32
      %728 = "llvm.sub"(%528, %723) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %729 = "nvvm.shfl.sync"(%727, %665, %531, %728) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb59] : () -> ()
    ^bb59:  // pred: ^bb58
      %730 = "llvm.xor"(%665, %729) : (i32, i32) -> i32
      "llvm.br"()[^bb60] : () -> ()
    ^bb60:  // pred: ^bb59
      %731 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %732 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %733 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %734 = "llvm.sub"(%733, %528) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %735 = "llvm.lshr"(%732, %734) : (i32, i32) -> i32
      %736 = "llvm.sub"(%528, %731) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %737 = "nvvm.shfl.sync"(%735, %730, %527, %736) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb61] : () -> ()
    ^bb61:  // pred: ^bb60
      %738 = "llvm.xor"(%730, %737) : (i32, i32) -> i32
      "llvm.br"()[^bb62] : () -> ()
    ^bb62:  // pred: ^bb61
      %739 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %740 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %741 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %742 = "llvm.sub"(%741, %528) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %743 = "llvm.lshr"(%740, %742) : (i32, i32) -> i32
      %744 = "llvm.sub"(%528, %739) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %745 = "nvvm.shfl.sync"(%743, %738, %526, %744) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb63] : () -> ()
    ^bb63:  // pred: ^bb62
      %746 = "llvm.xor"(%738, %745) : (i32, i32) -> i32
      "llvm.br"()[^bb64] : () -> ()
    ^bb64:  // pred: ^bb63
      %747 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %748 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %749 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %750 = "llvm.sub"(%749, %528) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %751 = "llvm.lshr"(%748, %750) : (i32, i32) -> i32
      %752 = "llvm.sub"(%528, %747) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %753 = "nvvm.shfl.sync"(%751, %746, %525, %752) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb65] : () -> ()
    ^bb65:  // pred: ^bb64
      %754 = "llvm.xor"(%746, %753) : (i32, i32) -> i32
      "llvm.br"()[^bb66] : () -> ()
    ^bb66:  // pred: ^bb65
      %755 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %756 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %757 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %758 = "llvm.sub"(%757, %528) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %759 = "llvm.lshr"(%756, %758) : (i32, i32) -> i32
      %760 = "llvm.sub"(%528, %755) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %761 = "nvvm.shfl.sync"(%759, %754, %524, %760) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb67] : () -> ()
    ^bb67:  // pred: ^bb66
      %762 = "llvm.xor"(%754, %761) : (i32, i32) -> i32
      "llvm.br"(%762)[^bb57] : (i32) -> ()
    ^bb68:  // pred: ^bb57
      "memref.store"(%722, %521, %523) <{nontemporal = false}> : (i32, memref<32xi32, #gpu.address_space<workgroup>>, index) -> ()
      "llvm.br"()[^bb70] : () -> ()
    ^bb69:  // pred: ^bb35
      "llvm.br"()[^bb70] : () -> ()
    ^bb70:  // 2 preds: ^bb68, ^bb69
      "nvvm.barrier0"() : () -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_4"}> ({
    "func.func"() <{function_type = () -> (f32, f32, f32, f32, i1, i1, i1, i1), sym_name = "gpu_shuffle"}> ({
      %463 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %464 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %465 = "llvm.mlir.constant"() <{value = 23 : i32}> : () -> i32
      %466 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %467 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %468 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %469 = "llvm.sub"(%468, %465) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %470 = "llvm.lshr"(%467, %469) : (i32, i32) -> i32
      %471 = "llvm.sub"(%465, %466) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %472 = "nvvm.shfl.sync"(%470, %463, %464, %471) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %473 = "llvm.extractvalue"(%472) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %474 = "llvm.extractvalue"(%472) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %475 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %476 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %477 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %478 = "llvm.sub"(%477, %465) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %479 = "llvm.lshr"(%476, %478) : (i32, i32) -> i32
      %480 = "nvvm.shfl.sync"(%479, %463, %464, %478) <{kind = #nvvm<shfl_kind up>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %481 = "llvm.extractvalue"(%480) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %482 = "llvm.extractvalue"(%480) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %483 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %484 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %485 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %486 = "llvm.sub"(%485, %465) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %487 = "llvm.lshr"(%484, %486) : (i32, i32) -> i32
      %488 = "llvm.sub"(%465, %483) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %489 = "nvvm.shfl.sync"(%487, %463, %464, %488) <{kind = #nvvm<shfl_kind down>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %490 = "llvm.extractvalue"(%489) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %491 = "llvm.extractvalue"(%489) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %492 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %493 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %494 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %495 = "llvm.sub"(%494, %465) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %496 = "llvm.lshr"(%493, %495) : (i32, i32) -> i32
      %497 = "llvm.sub"(%465, %492) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %498 = "nvvm.shfl.sync"(%496, %463, %464, %497) <{kind = #nvvm<shfl_kind idx>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %499 = "llvm.extractvalue"(%498) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %500 = "llvm.extractvalue"(%498) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %501 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %502 = "llvm.insertvalue"(%501, %473) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %503 = "llvm.insertvalue"(%502, %481) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %504 = "llvm.insertvalue"(%503, %490) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %505 = "llvm.insertvalue"(%504, %499) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %506 = "llvm.insertvalue"(%505, %474) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %507 = "llvm.insertvalue"(%506, %482) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %508 = "llvm.insertvalue"(%507, %491) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %509 = "llvm.insertvalue"(%508, %500) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      "llvm.return"(%509) : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (f32, f32, f32, f32), sym_name = "gpu_shuffle_unused_pred"}> ({
      %428 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %429 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %430 = "llvm.mlir.constant"() <{value = 23 : i32}> : () -> i32
      %431 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %432 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %433 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %434 = "llvm.sub"(%433, %430) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %435 = "llvm.lshr"(%432, %434) : (i32, i32) -> i32
      %436 = "llvm.sub"(%430, %431) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %437 = "nvvm.shfl.sync"(%435, %428, %429, %436) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %438 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %439 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %440 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %441 = "llvm.sub"(%440, %430) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %442 = "llvm.lshr"(%439, %441) : (i32, i32) -> i32
      %443 = "nvvm.shfl.sync"(%442, %428, %429, %441) <{kind = #nvvm<shfl_kind up>}> : (i32, f32, i32, i32) -> f32
      %444 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %445 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %446 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %447 = "llvm.sub"(%446, %430) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %448 = "llvm.lshr"(%445, %447) : (i32, i32) -> i32
      %449 = "llvm.sub"(%430, %444) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %450 = "nvvm.shfl.sync"(%448, %428, %429, %449) <{kind = #nvvm<shfl_kind down>}> : (i32, f32, i32, i32) -> f32
      %451 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %452 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %453 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %454 = "llvm.sub"(%453, %430) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %455 = "llvm.lshr"(%452, %454) : (i32, i32) -> i32
      %456 = "llvm.sub"(%430, %451) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %457 = "nvvm.shfl.sync"(%455, %428, %429, %456) <{kind = #nvvm<shfl_kind idx>}> : (i32, f32, i32, i32) -> f32
      %458 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32, f32)>
      %459 = "llvm.insertvalue"(%458, %437) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %460 = "llvm.insertvalue"(%459, %443) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %461 = "llvm.insertvalue"(%460, %450) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %462 = "llvm.insertvalue"(%461, %457) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      "llvm.return"(%462) : (!llvm.struct<(f32, f32, f32, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_5"}> ({
    "func.func"() <{function_type = () -> (), sym_name = "gpu_sync"}> ({
      "nvvm.barrier0"() : () -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_6"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fabsf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fabs", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_fabs"}> ({
    ^bb0(%arg113: f32, %arg114: f64):
      %423 = "llvm.call"(%arg113) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fabsf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %424 = "llvm.call"(%arg114) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fabs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %425 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %426 = "llvm.insertvalue"(%425, %423) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %427 = "llvm.insertvalue"(%426, %424) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%427) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_7"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cbrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cbrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_cbrt"}> ({
    ^bb0(%arg111: f32, %arg112: f64):
      %418 = "llvm.call"(%arg111) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cbrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %419 = "llvm.call"(%arg112) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cbrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %420 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %421 = "llvm.insertvalue"(%420, %418) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %422 = "llvm.insertvalue"(%421, %419) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%422) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_8"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_ceilf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_ceil", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_ceil"}> ({
    ^bb0(%arg109: f32, %arg110: f64):
      %413 = "llvm.call"(%arg109) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_ceilf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %414 = "llvm.call"(%arg110) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_ceil, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %415 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %416 = "llvm.insertvalue"(%415, %413) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %417 = "llvm.insertvalue"(%416, %414) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%417) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_9"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_floorf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_floor", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_floor"}> ({
    ^bb0(%arg107: f32, %arg108: f64):
      %408 = "llvm.call"(%arg107) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_floorf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %409 = "llvm.call"(%arg108) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_floor, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %410 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %411 = "llvm.insertvalue"(%410, %408) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %412 = "llvm.insertvalue"(%411, %409) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%412) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_10"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cos", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_cosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_cos"}> ({
    ^bb0(%arg105: f32, %arg106: f64):
      %401 = "llvm.call"(%arg105) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %402 = "llvm.call"(%arg106) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %403 = "llvm.call"(%arg105) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_cosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %404 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %405 = "llvm.insertvalue"(%404, %401) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %406 = "llvm.insertvalue"(%405, %402) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %407 = "llvm.insertvalue"(%406, %403) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%407) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_11"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_exp"}> ({
    ^bb0(%arg103: f32, %arg104: f64):
      %394 = "llvm.call"(%arg103) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %395 = "llvm.call"(%arg104) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %396 = "llvm.call"(%arg103) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %397 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %398 = "llvm.insertvalue"(%397, %394) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %399 = "llvm.insertvalue"(%398, %395) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %400 = "llvm.insertvalue"(%399, %396) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%400) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_12"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_exp2"}> ({
    ^bb0(%arg101: f32, %arg102: f64):
      %389 = "llvm.call"(%arg101) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %390 = "llvm.call"(%arg102) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %391 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %392 = "llvm.insertvalue"(%391, %389) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %393 = "llvm.insertvalue"(%392, %390) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%393) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_13"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_logf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_logf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_log"}> ({
    ^bb0(%arg99: f32, %arg100: f64):
      %382 = "llvm.call"(%arg99) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_logf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %383 = "llvm.call"(%arg100) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %384 = "llvm.call"(%arg99) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_logf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %385 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %386 = "llvm.insertvalue"(%385, %382) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %387 = "llvm.insertvalue"(%386, %383) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %388 = "llvm.insertvalue"(%387, %384) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%388) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_14"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log10f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log10", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_log10f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_log10"}> ({
    ^bb0(%arg97: f32, %arg98: f64):
      %375 = "llvm.call"(%arg97) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log10f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %376 = "llvm.call"(%arg98) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log10, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %377 = "llvm.call"(%arg97) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_log10f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %378 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %379 = "llvm.insertvalue"(%378, %375) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %380 = "llvm.insertvalue"(%379, %376) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %381 = "llvm.insertvalue"(%380, %377) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%381) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_15"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log1pf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log1p", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_log1p"}> ({
    ^bb0(%arg95: f32, %arg96: f64):
      %370 = "llvm.call"(%arg95) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log1pf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %371 = "llvm.call"(%arg96) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log1p, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %372 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %373 = "llvm.insertvalue"(%372, %370) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %374 = "llvm.insertvalue"(%373, %371) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%374) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_16"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_log2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_log2"}> ({
    ^bb0(%arg93: f32, %arg94: f64):
      %363 = "llvm.call"(%arg93) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %364 = "llvm.call"(%arg94) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %365 = "llvm.call"(%arg93) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_log2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %366 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %367 = "llvm.insertvalue"(%366, %363) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %368 = "llvm.insertvalue"(%367, %364) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %369 = "llvm.insertvalue"(%368, %365) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%369) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_17"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sin", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_sinf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_sin"}> ({
    ^bb0(%arg91: f32, %arg92: f64):
      %356 = "llvm.call"(%arg91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %357 = "llvm.call"(%arg92) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %358 = "llvm.call"(%arg91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %359 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %360 = "llvm.insertvalue"(%359, %356) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %361 = "llvm.insertvalue"(%360, %357) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %362 = "llvm.insertvalue"(%361, %358) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%362) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_18"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tan", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_tanf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64, f32), sym_name = "gpu_tan"}> ({
    ^bb0(%arg88: f16, %arg89: f32, %arg90: f64):
      %345 = "llvm.fpext"(%arg88) : (f16) -> f32
      %346 = "llvm.call"(%345) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %347 = "llvm.fptrunc"(%346) : (f32) -> f16
      %348 = "llvm.call"(%arg89) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %349 = "llvm.call"(%arg90) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %350 = "llvm.call"(%arg89) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %351 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64, f32)>
      %352 = "llvm.insertvalue"(%351, %347) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64, f32)>, f16) -> !llvm.struct<(f16, f32, f64, f32)>
      %353 = "llvm.insertvalue"(%352, %348) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64, f32)>, f32) -> !llvm.struct<(f16, f32, f64, f32)>
      %354 = "llvm.insertvalue"(%353, %349) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64, f32)>, f64) -> !llvm.struct<(f16, f32, f64, f32)>
      %355 = "llvm.insertvalue"(%354, %350) <{position = array<i64: 3>}> : (!llvm.struct<(f16, f32, f64, f32)>, f32) -> !llvm.struct<(f16, f32, f64, f32)>
      "llvm.return"(%355) : (!llvm.struct<(f16, f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_19"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_tanh"}> ({
    ^bb0(%arg85: f16, %arg86: f32, %arg87: f64):
      %336 = "llvm.fpext"(%arg85) : (f16) -> f32
      %337 = "llvm.call"(%336) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %338 = "llvm.fptrunc"(%337) : (f32) -> f16
      %339 = "llvm.call"(%arg86) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %340 = "llvm.call"(%arg87) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %341 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %342 = "llvm.insertvalue"(%341, %338) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %343 = "llvm.insertvalue"(%342, %339) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %344 = "llvm.insertvalue"(%343, %340) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%344) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_20"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rsqrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rsqrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_rsqrt"}> ({
    ^bb0(%arg82: f16, %arg83: f32, %arg84: f64):
      %327 = "llvm.fpext"(%arg82) : (f16) -> f32
      %328 = "llvm.call"(%327) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %329 = "llvm.fptrunc"(%328) : (f32) -> f16
      %330 = "llvm.call"(%arg83) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %331 = "llvm.call"(%arg84) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %332 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %333 = "llvm.insertvalue"(%332, %329) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %334 = "llvm.insertvalue"(%333, %330) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %335 = "llvm.insertvalue"(%334, %331) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%335) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_21"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sqrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sqrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_sqrt"}> ({
    ^bb0(%arg79: f16, %arg80: f32, %arg81: f64):
      %318 = "llvm.fpext"(%arg79) : (f16) -> f32
      %319 = "llvm.call"(%318) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %320 = "llvm.fptrunc"(%319) : (f32) -> f16
      %321 = "llvm.call"(%arg80) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %322 = "llvm.call"(%arg81) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %323 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %324 = "llvm.insertvalue"(%323, %320) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %325 = "llvm.insertvalue"(%324, %321) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %326 = "llvm.insertvalue"(%325, %322) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%326) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_22"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atan"}> ({
    ^bb0(%arg76: f16, %arg77: f32, %arg78: f64):
      %309 = "llvm.fpext"(%arg76) : (f16) -> f32
      %310 = "llvm.call"(%309) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %311 = "llvm.fptrunc"(%310) : (f32) -> f16
      %312 = "llvm.call"(%arg77) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %313 = "llvm.call"(%arg78) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %314 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %315 = "llvm.insertvalue"(%314, %311) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %316 = "llvm.insertvalue"(%315, %312) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %317 = "llvm.insertvalue"(%316, %313) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%317) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_23"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atan2"}> ({
    ^bb0(%arg73: f16, %arg74: f32, %arg75: f64):
      %299 = "llvm.fpext"(%arg73) : (f16) -> f32
      %300 = "llvm.fpext"(%arg73) : (f16) -> f32
      %301 = "llvm.call"(%299, %300) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %302 = "llvm.fptrunc"(%301) : (f32) -> f16
      %303 = "llvm.call"(%arg74, %arg74) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %304 = "llvm.call"(%arg75, %arg75) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %305 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %306 = "llvm.insertvalue"(%305, %302) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %307 = "llvm.insertvalue"(%306, %303) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %308 = "llvm.insertvalue"(%307, %304) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%308) : (!llvm.struct<(f16, f32, f64)>) -> ()
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
      "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_exp"}> ({
      ^bb0(%arg71: f32, %arg72: f64):
        %292 = "llvm.call"(%arg71) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
        %293 = "llvm.call"(%arg72) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
        %294 = "llvm.call"(%arg71) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
        %295 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
        %296 = "llvm.insertvalue"(%295, %292) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
        %297 = "llvm.insertvalue"(%296, %293) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
        %298 = "llvm.insertvalue"(%297, %294) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
        "llvm.return"(%298) : (!llvm.struct<(f32, f64, f32)>) -> ()
      }) : () -> ()
      "test.finish"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_25"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expm1f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expm1", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_expm1"}> ({
    ^bb0(%arg69: f32, %arg70: f64):
      %287 = "llvm.call"(%arg69) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expm1f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %288 = "llvm.call"(%arg70) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expm1, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %289 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %290 = "llvm.insertvalue"(%289, %287) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %291 = "llvm.insertvalue"(%290, %288) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%291) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_26"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_powf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_pow", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_powf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_pow"}> ({
    ^bb0(%arg67: f32, %arg68: f64):
      %280 = "llvm.call"(%arg67, %arg67) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %281 = "llvm.call"(%arg68, %arg68) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_pow, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %282 = "llvm.call"(%arg67, %arg67) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_powf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %283 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %284 = "llvm.insertvalue"(%283, %280) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %285 = "llvm.insertvalue"(%284, %281) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %286 = "llvm.insertvalue"(%285, %282) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%286) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_27"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "gpu_unroll"}> ({
    ^bb0(%arg66: vector<4xf32>):
      %263 = "llvm.mlir.poison"() : () -> vector<4xf32>
      %264 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
      %265 = "llvm.extractelement"(%arg66, %264) : (vector<4xf32>, i64) -> f32
      %266 = "llvm.call"(%265) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %267 = "llvm.insertelement"(%263, %266, %264) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %268 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
      %269 = "llvm.extractelement"(%arg66, %268) : (vector<4xf32>, i64) -> f32
      %270 = "llvm.call"(%269) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %271 = "llvm.insertelement"(%267, %270, %268) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %272 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
      %273 = "llvm.extractelement"(%arg66, %272) : (vector<4xf32>, i64) -> f32
      %274 = "llvm.call"(%273) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %275 = "llvm.insertelement"(%271, %274, %272) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %276 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
      %277 = "llvm.extractelement"(%arg66, %276) : (vector<4xf32>, i64) -> f32
      %278 = "llvm.call"(%277) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %279 = "llvm.insertelement"(%275, %278, %276) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      "llvm.return"(%279) : (vector<4xf32>) -> ()
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
      %253 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
      %254 = "llvm.getelementptr"(%253) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %255 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %256 = "llvm.alloca"(%255) <{elem_type = !llvm.struct<()>}> : (i64) -> !llvm.ptr
      %257 = "llvm.call"(%254, %256) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      %258 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
      %259 = "llvm.getelementptr"(%258) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %260 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %261 = "llvm.alloca"(%260) <{elem_type = !llvm.struct<()>}> : (i64) -> !llvm.ptr
      %262 = "llvm.call"(%259, %261) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, f32)>, linkage = #llvm.linkage<external>, sym_name = "test_printf", visibility_ = 0 : i64}> ({
    ^bb0(%arg64: i32, %arg65: f32):
      %245 = "llvm.mlir.addressof"() <{global_name = @printfFormat_1}> : () -> !llvm.ptr
      %246 = "llvm.getelementptr"(%245) <{elem_type = !llvm.array<11 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %247 = "llvm.fpext"(%arg65) : (f32) -> f64
      %248 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %249 = "llvm.alloca"(%248) <{elem_type = !llvm.struct<(i32, f64)>}> : (i64) -> !llvm.ptr
      %250 = "llvm.getelementptr"(%249) <{elem_type = !llvm.struct<(i32, f64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      "llvm.store"(%arg64, %250) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      %251 = "llvm.getelementptr"(%249) <{elem_type = !llvm.struct<(i32, f64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
      "llvm.store"(%247, %251) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
      %252 = "llvm.call"(%246, %249) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_30"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_add", visibility_ = 0 : i64}> ({
    ^bb0(%arg63: i32):
      %243 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %244 = "nvvm.redux.sync"(%arg63, %243) <{abs = false, kind = #nvvm<redux_kind add>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_minsi", visibility_ = 0 : i64}> ({
    ^bb0(%arg62: i32):
      %241 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %242 = "nvvm.redux.sync"(%arg62, %241) <{abs = false, kind = #nvvm<redux_kind min>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_maxsi", visibility_ = 0 : i64}> ({
    ^bb0(%arg61: i32):
      %239 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %240 = "nvvm.redux.sync"(%arg61, %239) <{abs = false, kind = #nvvm<redux_kind max>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_and", visibility_ = 0 : i64}> ({
    ^bb0(%arg60: i32):
      %237 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %238 = "nvvm.redux.sync"(%arg60, %237) <{abs = false, kind = #nvvm<redux_kind and>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_or", visibility_ = 0 : i64}> ({
    ^bb0(%arg59: i32):
      %235 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %236 = "nvvm.redux.sync"(%arg59, %235) <{abs = false, kind = #nvvm<redux_kind or>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_xor", visibility_ = 0 : i64}> ({
    ^bb0(%arg58: i32):
      %233 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %234 = "nvvm.redux.sync"(%arg58, %233) <{abs = false, kind = #nvvm<redux_kind xor>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_31"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmodf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmod", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_fmod"}> ({
    ^bb0(%arg56: f32, %arg57: f64):
      %228 = "llvm.call"(%arg56, %arg56) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmodf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %229 = "llvm.call"(%arg57, %arg57) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmod, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %230 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %231 = "llvm.insertvalue"(%230, %228) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %232 = "llvm.insertvalue"(%231, %229) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%232) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_32"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erff", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_erf"}> ({
    ^bb0(%arg54: f32, %arg55: f64):
      %223 = "llvm.call"(%arg54) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erff, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %224 = "llvm.call"(%arg55) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %225 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %226 = "llvm.insertvalue"(%225, %223) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %227 = "llvm.insertvalue"(%226, %224) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%227) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_33"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_block_size", visibility_ = 0 : i64}> ({
    ^bb0(%arg53: !llvm.ptr):
      %215 = "nvvm.read.ptx.sreg.tid.x"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %216 = "llvm.sext"(%215) : (i32) -> i64
      %217 = "nvvm.read.ptx.sreg.tid.y"() <{range = #llvm.constant_range<i32, 0, 4>}> : () -> i32
      %218 = "llvm.sext"(%217) : (i32) -> i64
      %219 = "nvvm.read.ptx.sreg.tid.z"() <{range = #llvm.constant_range<i32, 0, 2>}> : () -> i32
      %220 = "llvm.sext"(%219) : (i32) -> i64
      %221 = "llvm.add"(%216, %218) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %222 = "llvm.add"(%221, %220) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.store"(%222, %arg53) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_block_size = array<i32: 32, 4, 2>, nvvm.kernel, nvvm.maxntid = array<i32: 32, 4, 2>} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_34"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)> (ptr, ptr, i64, i64, i64, f32)>, linkage = #llvm.linkage<external>, sym_name = "memref_signature", visibility_ = 0 : i64}> ({
    ^bb0(%arg47: !llvm.ptr, %arg48: !llvm.ptr, %arg49: i64, %arg50: i64, %arg51: i64, %arg52: f32):
      %206 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %207 = "llvm.insertvalue"(%206, %arg47) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %208 = "llvm.insertvalue"(%207, %arg48) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %209 = "llvm.insertvalue"(%208, %arg49) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %210 = "llvm.insertvalue"(%209, %arg50) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %211 = "llvm.insertvalue"(%210, %arg51) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %212 = "llvm.mlir.poison"() : () -> !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>
      %213 = "llvm.insertvalue"(%212, %211) <{position = array<i64: 0>}> : (!llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>
      %214 = "llvm.insertvalue"(%213, %arg52) <{position = array<i64: 1>}> : (!llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>, f32) -> !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>
      "llvm.return"(%214) : (!llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_35"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acos", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_acos"}> ({
    ^bb0(%arg45: f32, %arg46: f64):
      %201 = "llvm.call"(%arg45) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %202 = "llvm.call"(%arg46) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %203 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %204 = "llvm.insertvalue"(%203, %201) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %205 = "llvm.insertvalue"(%204, %202) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%205) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_36"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acoshf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_acosh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_acosh"}> ({
    ^bb0(%arg43: f32, %arg44: f64):
      %196 = "llvm.call"(%arg43) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acoshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %197 = "llvm.call"(%arg44) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_acosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %198 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %199 = "llvm.insertvalue"(%198, %196) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %200 = "llvm.insertvalue"(%199, %197) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%200) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_37"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asinf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asin", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_asin"}> ({
    ^bb0(%arg41: f32, %arg42: f64):
      %191 = "llvm.call"(%arg41) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %192 = "llvm.call"(%arg42) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %193 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %194 = "llvm.insertvalue"(%193, %191) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %195 = "llvm.insertvalue"(%194, %192) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%195) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_38"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asinhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_asinh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_asinh"}> ({
    ^bb0(%arg39: f32, %arg40: f64):
      %186 = "llvm.call"(%arg39) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %187 = "llvm.call"(%arg40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_asinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %188 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %189 = "llvm.insertvalue"(%188, %186) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %190 = "llvm.insertvalue"(%189, %187) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%190) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_39"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atanh"}> ({
    ^bb0(%arg36: f16, %arg37: f32, %arg38: f64):
      %177 = "llvm.fpext"(%arg36) : (f16) -> f32
      %178 = "llvm.call"(%177) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %179 = "llvm.fptrunc"(%178) : (f32) -> f16
      %180 = "llvm.call"(%arg37) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %181 = "llvm.call"(%arg38) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %182 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %183 = "llvm.insertvalue"(%182, %179) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %184 = "llvm.insertvalue"(%183, %180) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %185 = "llvm.insertvalue"(%184, %181) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%185) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_40"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_copysignf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_copysign", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_copysign"}> ({
    ^bb0(%arg34: f32, %arg35: f64):
      %172 = "llvm.call"(%arg34, %arg34) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_copysignf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %173 = "llvm.call"(%arg35, %arg35) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_copysign, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %174 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %175 = "llvm.insertvalue"(%174, %172) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %176 = "llvm.insertvalue"(%175, %173) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%176) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_41"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_coshf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cosh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_cosh"}> ({
    ^bb0(%arg32: f32, %arg33: f64):
      %167 = "llvm.call"(%arg32) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_coshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %168 = "llvm.call"(%arg33) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %169 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %170 = "llvm.insertvalue"(%169, %167) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %171 = "llvm.insertvalue"(%170, %168) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%171) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_42"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fmaf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fma", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_fma"}> ({
    ^bb0(%arg30: f32, %arg31: f64):
      %162 = "llvm.call"(%arg30, %arg30, %arg30) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fmaf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, f32, f32) -> f32
      %163 = "llvm.call"(%arg31, %arg31, %arg31) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fma, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f64, f64, f64) -> f64
      %164 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %165 = "llvm.insertvalue"(%164, %162) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %166 = "llvm.insertvalue"(%165, %163) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%166) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_43"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_roundf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_round", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_round"}> ({
    ^bb0(%arg28: f32, %arg29: f64):
      %157 = "llvm.call"(%arg28) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_roundf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %158 = "llvm.call"(%arg29) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_round, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %159 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %160 = "llvm.insertvalue"(%159, %157) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %161 = "llvm.insertvalue"(%160, %158) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%161) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_44"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rintf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rint", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_roundeven"}> ({
    ^bb0(%arg26: f32, %arg27: f64):
      %152 = "llvm.call"(%arg26) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %153 = "llvm.call"(%arg27) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rint, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %154 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %155 = "llvm.insertvalue"(%154, %152) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %156 = "llvm.insertvalue"(%155, %153) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%156) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_45"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_sinh"}> ({
    ^bb0(%arg24: f32, %arg25: f64):
      %147 = "llvm.call"(%arg24) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %148 = "llvm.call"(%arg25) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %149 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %150 = "llvm.insertvalue"(%149, %147) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %151 = "llvm.insertvalue"(%150, %148) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%151) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_46"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_coshf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cosh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_cosh_with_fastmath"}> ({
    ^bb0(%arg22: f32, %arg23: f64):
      %142 = "llvm.call"(%arg22) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_coshf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %143 = "llvm.call"(%arg23) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %144 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %145 = "llvm.insertvalue"(%144, %142) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %146 = "llvm.insertvalue"(%145, %143) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%146) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_47"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sinh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_sinh_with_fastmath"}> ({
    ^bb0(%arg20: f32, %arg21: f64):
      %137 = "llvm.call"(%arg20) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %138 = "llvm.call"(%arg21) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %139 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %140 = "llvm.insertvalue"(%139, %137) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %141 = "llvm.insertvalue"(%140, %138) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%141) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_48"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_exp_with_fastmath"}> ({
    ^bb0(%arg18: f32, %arg19: f64):
      %130 = "llvm.call"(%arg18) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %131 = "llvm.call"(%arg19) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %132 = "llvm.call"(%arg18) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %133 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %134 = "llvm.insertvalue"(%133, %130) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %135 = "llvm.insertvalue"(%134, %131) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %136 = "llvm.insertvalue"(%135, %132) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%136) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_49"}> ({
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "explicit_id_bounds"}> ({
      %120 = "nvvm.read.ptx.sreg.tid.x"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %121 = "llvm.sext"(%120) : (i32) -> i64
      %122 = "nvvm.read.ptx.sreg.ntid.x"() <{range = #llvm.constant_range<i32, 1, 33>}> : () -> i32
      %123 = "llvm.sext"(%122) : (i32) -> i64
      %124 = "nvvm.read.ptx.sreg.laneid"() <{range = #llvm.constant_range<i32, 0, 16>}> : () -> i32
      %125 = "llvm.sext"(%124) : (i32) -> i64
      %126 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, i64, i64)>
      %127 = "llvm.insertvalue"(%126, %121) <{position = array<i64: 0>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
      %128 = "llvm.insertvalue"(%127, %123) <{position = array<i64: 1>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
      %129 = "llvm.insertvalue"(%128, %125) <{position = array<i64: 2>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
      "llvm.return"(%129) : (!llvm.struct<(i64, i64, i64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_50"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_grid_size", visibility_ = 0 : i64}> ({
    ^bb0(%arg17: !llvm.ptr):
      %112 = "nvvm.read.ptx.sreg.ctaid.x"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %113 = "llvm.sext"(%112) : (i32) -> i64
      %114 = "nvvm.read.ptx.sreg.ctaid.y"() <{range = #llvm.constant_range<i32, 0, 4>}> : () -> i32
      %115 = "llvm.sext"(%114) : (i32) -> i64
      %116 = "nvvm.read.ptx.sreg.ctaid.z"() <{range = #llvm.constant_range<i32, 0, 2>}> : () -> i32
      %117 = "llvm.sext"(%116) : (i32) -> i64
      %118 = "llvm.add"(%113, %115) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %119 = "llvm.add"(%118, %117) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.store"(%119, %arg17) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
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
    ^bb0(%arg16: i1):
      "llvm.cond_br"(%arg16)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %104 = "llvm.mlir.addressof"() <{global_name = @assert_message_0}> : () -> !llvm.ptr
      %105 = "llvm.getelementptr"(%104) <{elem_type = !llvm.array<15 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %106 = "llvm.mlir.addressof"() <{global_name = @assert_file_0}> : () -> !llvm.ptr
      %107 = "llvm.getelementptr"(%106) <{elem_type = !llvm.array<77 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %108 = "llvm.mlir.addressof"() <{global_name = @assert_func_0}> : () -> !llvm.ptr
      %109 = "llvm.getelementptr"(%108) <{elem_type = !llvm.array<10 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %110 = "llvm.mlir.constant"() <{value = 998 : i32}> : () -> i32
      %111 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
      "llvm.call"(%105, %107, %110, %109, %111) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__assertfail, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (!llvm.ptr, !llvm.ptr, i32, !llvm.ptr, i64) -> ()
      "llvm.br"()[^bb2] : () -> ()
    ^bb2:  // 2 preds: ^bb0, ^bb1
      "llvm.return"() : () -> ()
    }) {gpu.kernel, nvvm.kernel} : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg15: !transform.any_op):
      %103 = "transform.structured.match"(%arg15) <{ops = ["gpu.module"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%103) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.gpu_rewrite_patterns"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.apply_conversion_patterns"(%103) <{illegal_dialects = ["gpu"], illegal_ops = ["llvm.copysign", "llvm.cos", "llvm.exp", "llvm.exp2", "llvm.fabs", "llvm.fceil", "llvm.ffloor", "llvm.frem", "llvm.log", "llvm.log10", "llvm.log2", "llvm.pow", "llvm.roundeven", "llvm.round", "llvm.sin", "llvm.sqrt"], legal_dialects = ["llvm", "memref", "nvvm", "test"], legal_ops = ["func.func", "gpu.module", "gpu.yield"], partial_conversion}> ({
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
    "func.func"() <{function_type = (i32) -> i32, sym_name = "gpu_abs"}> ({
    ^bb0(%arg14: i32):
      %102 = "llvm.call"(%arg14) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_abs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i32
      "llvm.return"(%102) : (i32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_53"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, i32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_powif", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, i32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_powi", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64, i32) -> (f32, f64), sym_name = "gpu_powi"}> ({
    ^bb0(%arg11: f32, %arg12: f64, %arg13: i32):
      %97 = "llvm.call"(%arg11, %arg13) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powif, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, i32) -> f32
      %98 = "llvm.call"(%arg12, %arg13) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powi, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, i32) -> f64
      %99 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %100 = "llvm.insertvalue"(%99, %97) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %101 = "llvm.insertvalue"(%100, %98) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%101) : (!llvm.struct<(f32, f64)>) -> ()
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
    "func.func"() <{function_type = (f32, f64) -> (i1, i1, i1, i1, i1, i1), sym_name = "fpclassify"}> ({
    ^bb0(%arg9: f32, %arg10: f64):
      %72 = "llvm.call"(%arg9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isinff, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> i32
      %73 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %74 = "llvm.icmp"(%72, %73) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %75 = "llvm.call"(%arg10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isinfd, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> i32
      %76 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %77 = "llvm.icmp"(%75, %76) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %78 = "llvm.call"(%arg9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isnanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> i32
      %79 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %80 = "llvm.icmp"(%78, %79) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %81 = "llvm.call"(%arg10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isnand, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> i32
      %82 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %83 = "llvm.icmp"(%81, %82) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %84 = "llvm.call"(%arg9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_finitef, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> i32
      %85 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %86 = "llvm.icmp"(%84, %85) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %87 = "llvm.call"(%arg10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_isfinited, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> i32
      %88 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %89 = "llvm.icmp"(%87, %88) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %90 = "llvm.mlir.poison"() : () -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %91 = "llvm.insertvalue"(%90, %74) <{position = array<i64: 0>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %92 = "llvm.insertvalue"(%91, %77) <{position = array<i64: 1>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %93 = "llvm.insertvalue"(%92, %80) <{position = array<i64: 2>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %94 = "llvm.insertvalue"(%93, %83) <{position = array<i64: 3>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %95 = "llvm.insertvalue"(%94, %86) <{position = array<i64: 4>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %96 = "llvm.insertvalue"(%95, %89) <{position = array<i64: 5>}> : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>, i1) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      "llvm.return"(%96) : (!llvm.struct<(i1, i1, i1, i1, i1, i1)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_55"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erfcf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_erfc", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_erfc"}> ({
    ^bb0(%arg7: f32, %arg8: f64):
      %67 = "llvm.call"(%arg7) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erfcf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %68 = "llvm.call"(%arg8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_erfc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %69 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %70 = "llvm.insertvalue"(%69, %67) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %71 = "llvm.insertvalue"(%70, %68) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%71) : (!llvm.struct<(f32, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_56"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sincosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f64, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sincos", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f16, f32, f32, f64, f64), sym_name = "gpu_sincos"}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %42 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %43 = "llvm.alloca"(%42) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %44 = "llvm.alloca"(%42) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %45 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %46 = "llvm.alloca"(%45) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %47 = "llvm.alloca"(%45) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %48 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %49 = "llvm.alloca"(%48) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %50 = "llvm.alloca"(%48) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %51 = "llvm.fpext"(%arg4) : (f16) -> f32
      "llvm.call"(%51, %49, %50) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %52 = "llvm.load"(%49) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %53 = "llvm.load"(%50) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %54 = "llvm.fptrunc"(%52) : (f32) -> f16
      %55 = "llvm.fptrunc"(%53) : (f32) -> f16
      "llvm.call"(%arg5, %46, %47) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %56 = "llvm.load"(%46) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %57 = "llvm.load"(%47) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      "llvm.call"(%arg6, %43, %44) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f64, !llvm.ptr, !llvm.ptr) -> ()
      %58 = "llvm.load"(%43) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %59 = "llvm.load"(%44) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %60 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %61 = "llvm.insertvalue"(%60, %54) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %62 = "llvm.insertvalue"(%61, %55) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %63 = "llvm.insertvalue"(%62, %56) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %64 = "llvm.insertvalue"(%63, %57) <{position = array<i64: 3>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %65 = "llvm.insertvalue"(%64, %58) <{position = array<i64: 4>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %66 = "llvm.insertvalue"(%65, %59) <{position = array<i64: 5>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      "llvm.return"(%66) : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>) -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fast_sincosf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f16, f32, f32, f64, f64), sym_name = "gpu_sincos_fastmath"}> ({
    ^bb0(%arg1: f16, %arg2: f32, %arg3: f64):
      %17 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %18 = "llvm.alloca"(%17) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %19 = "llvm.alloca"(%17) <{elem_type = f64}> : (i32) -> !llvm.ptr
      %20 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %21 = "llvm.alloca"(%20) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %22 = "llvm.alloca"(%20) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %23 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %24 = "llvm.alloca"(%23) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %25 = "llvm.alloca"(%23) <{elem_type = f32}> : (i32) -> !llvm.ptr
      %26 = "llvm.fpext"(%arg1) : (f16) -> f32
      "llvm.call"(%26, %24, %25) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %27 = "llvm.load"(%24) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %28 = "llvm.load"(%25) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %29 = "llvm.fptrunc"(%27) : (f32) -> f16
      %30 = "llvm.fptrunc"(%28) : (f32) -> f16
      "llvm.call"(%arg2, %21, %22) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %31 = "llvm.load"(%21) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %32 = "llvm.load"(%22) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      "llvm.call"(%arg3, %18, %19) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f64, !llvm.ptr, !llvm.ptr) -> ()
      %33 = "llvm.load"(%18) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %34 = "llvm.load"(%19) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      %35 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %36 = "llvm.insertvalue"(%35, %29) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %37 = "llvm.insertvalue"(%36, %30) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f16) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %38 = "llvm.insertvalue"(%37, %31) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %39 = "llvm.insertvalue"(%38, %32) <{position = array<i64: 3>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f32) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %40 = "llvm.insertvalue"(%39, %33) <{position = array<i64: 4>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %41 = "llvm.insertvalue"(%40, %34) <{position = array<i64: 5>}> : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>, f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      "llvm.return"(%41) : (!llvm.struct<(f16, f16, f32, f32, f64, f64)>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_cluster_size"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_cluster_size", visibility_ = 0 : i64}> ({
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_cluster_size = array<i32: 8, 2, 4>, nvvm.cluster_dim = array<i32: 8, 2, 4>, nvvm.kernel} : () -> ()
  }) : () -> ()
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


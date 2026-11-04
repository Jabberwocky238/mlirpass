"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_0"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_ops", visibility_ = 0 : i64}> ({
      %1009 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %1010 = "llvm.sext"(%1009) : (i32) -> i64
      %1011 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %1012 = "llvm.sext"(%1011) : (i32) -> i64
      %1013 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %1014 = "llvm.sext"(%1013) : (i32) -> i64
      %1015 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %1016 = "llvm.sext"(%1015) : (i32) -> i64
      %1017 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %1018 = "llvm.sext"(%1017) : (i32) -> i64
      %1019 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %1020 = "llvm.sext"(%1019) : (i32) -> i64
      %1021 = "nvvm.read.ptx.sreg.ctaid.x"() : () -> i32
      %1022 = "llvm.sext"(%1021) : (i32) -> i64
      %1023 = "nvvm.read.ptx.sreg.ctaid.y"() : () -> i32
      %1024 = "llvm.sext"(%1023) : (i32) -> i64
      %1025 = "nvvm.read.ptx.sreg.ctaid.z"() : () -> i32
      %1026 = "llvm.sext"(%1025) : (i32) -> i64
      %1027 = "nvvm.read.ptx.sreg.nctaid.x"() : () -> i32
      %1028 = "llvm.sext"(%1027) : (i32) -> i64
      %1029 = "nvvm.read.ptx.sreg.nctaid.y"() : () -> i32
      %1030 = "llvm.sext"(%1029) : (i32) -> i64
      %1031 = "nvvm.read.ptx.sreg.nctaid.z"() : () -> i32
      %1032 = "llvm.sext"(%1031) : (i32) -> i64
      %1033 = "nvvm.read.ptx.sreg.laneid"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %1034 = "llvm.sext"(%1033) : (i32) -> i64
      %1035 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1036 = "llvm.insertvalue"(%1035, %1010) <{position = array<i64: 0>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1037 = "llvm.insertvalue"(%1036, %1012) <{position = array<i64: 1>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1038 = "llvm.insertvalue"(%1037, %1014) <{position = array<i64: 2>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1039 = "llvm.insertvalue"(%1038, %1016) <{position = array<i64: 3>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1040 = "llvm.insertvalue"(%1039, %1018) <{position = array<i64: 4>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1041 = "llvm.insertvalue"(%1040, %1020) <{position = array<i64: 5>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1042 = "llvm.insertvalue"(%1041, %1022) <{position = array<i64: 6>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1043 = "llvm.insertvalue"(%1042, %1024) <{position = array<i64: 7>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1044 = "llvm.insertvalue"(%1043, %1026) <{position = array<i64: 8>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1045 = "llvm.insertvalue"(%1044, %1028) <{position = array<i64: 9>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1046 = "llvm.insertvalue"(%1045, %1030) <{position = array<i64: 10>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1047 = "llvm.insertvalue"(%1046, %1032) <{position = array<i64: 11>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %1048 = "llvm.insertvalue"(%1047, %1034) <{position = array<i64: 12>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      "llvm.return"(%1048) : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_comp", visibility_ = 0 : i64}> ({
    ^bb0(%arg110: i64):
      %1008 = "llvm.add"(%arg110, %arg110) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.return"(%1008) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_2"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<32 x f32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_gpu_all_reduce_op_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_all_reduce_op", visibility_ = 0 : i64}> ({
      %752 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_op_0}> : () -> !llvm.ptr<3>
      %753 = "llvm.getelementptr"(%752) <{elem_type = !llvm.array<32 x f32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %754 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %755 = "llvm.insertvalue"(%754, %753) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %756 = "llvm.insertvalue"(%755, %753) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %757 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %758 = "llvm.insertvalue"(%756, %757) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %759 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %760 = "llvm.insertvalue"(%758, %759) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %761 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %762 = "llvm.insertvalue"(%760, %761) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %763 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %764 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %765 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %766 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %767 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %768 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %769 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %770 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %771 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %772 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %773 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %774 = "llvm.sext"(%773) : (i32) -> i64
      %775 = "llvm.trunc"(%774) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %776 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %777 = "llvm.sext"(%776) : (i32) -> i64
      %778 = "llvm.trunc"(%777) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %779 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %780 = "llvm.sext"(%779) : (i32) -> i64
      %781 = "llvm.trunc"(%780) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %782 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %783 = "llvm.sext"(%782) : (i32) -> i64
      %784 = "llvm.trunc"(%783) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %785 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %786 = "llvm.sext"(%785) : (i32) -> i64
      %787 = "llvm.trunc"(%786) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %788 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %789 = "llvm.sext"(%788) : (i32) -> i64
      %790 = "llvm.trunc"(%789) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %791 = "llvm.mul"(%790, %778) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %792 = "llvm.add"(%791, %787) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %793 = "llvm.mul"(%792, %775) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %794 = "llvm.mul"(%775, %778) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %795 = "llvm.add"(%793, %784) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %796 = "llvm.mul"(%794, %781) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %797 = "llvm.and"(%795, %771) : (i32, i32) -> i32
      %798 = "llvm.icmp"(%797, %770) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %799 = "llvm.sub"(%795, %797) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %800 = "llvm.sub"(%796, %799) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %801 = "llvm.icmp"(%800, %769) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%801)[^bb1, ^bb17] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %802 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %803 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %804 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %805 = "llvm.sub"(%804, %800) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %806 = "llvm.lshr"(%803, %805) : (i32, i32) -> i32
      %807 = "llvm.sub"(%800, %802) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %808 = "nvvm.shfl.sync"(%806, %772, %768, %807) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %809 = "llvm.extractvalue"(%808) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %810 = "llvm.extractvalue"(%808) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%810)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %811 = "llvm.fadd"(%809, %772) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%811)[^bb4] : (f32) -> ()
    ^bb3:  // pred: ^bb1
      "llvm.br"(%772)[^bb4] : (f32) -> ()
    ^bb4(%812: f32):  // 2 preds: ^bb2, ^bb3
      %813 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %814 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %815 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %816 = "llvm.sub"(%815, %800) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %817 = "llvm.lshr"(%814, %816) : (i32, i32) -> i32
      %818 = "llvm.sub"(%800, %813) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %819 = "nvvm.shfl.sync"(%817, %812, %767, %818) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %820 = "llvm.extractvalue"(%819) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %821 = "llvm.extractvalue"(%819) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%821)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb5:  // pred: ^bb4
      %822 = "llvm.fadd"(%812, %820) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%822)[^bb7] : (f32) -> ()
    ^bb6:  // pred: ^bb4
      "llvm.br"(%812)[^bb7] : (f32) -> ()
    ^bb7(%823: f32):  // 2 preds: ^bb5, ^bb6
      %824 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %825 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %826 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %827 = "llvm.sub"(%826, %800) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %828 = "llvm.lshr"(%825, %827) : (i32, i32) -> i32
      %829 = "llvm.sub"(%800, %824) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %830 = "nvvm.shfl.sync"(%828, %823, %766, %829) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %831 = "llvm.extractvalue"(%830) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %832 = "llvm.extractvalue"(%830) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%832)[^bb8, ^bb9] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb8:  // pred: ^bb7
      %833 = "llvm.fadd"(%823, %831) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%833)[^bb10] : (f32) -> ()
    ^bb9:  // pred: ^bb7
      "llvm.br"(%823)[^bb10] : (f32) -> ()
    ^bb10(%834: f32):  // 2 preds: ^bb8, ^bb9
      %835 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %836 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %837 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %838 = "llvm.sub"(%837, %800) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %839 = "llvm.lshr"(%836, %838) : (i32, i32) -> i32
      %840 = "llvm.sub"(%800, %835) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %841 = "nvvm.shfl.sync"(%839, %834, %765, %840) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %842 = "llvm.extractvalue"(%841) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %843 = "llvm.extractvalue"(%841) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%843)[^bb11, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb11:  // pred: ^bb10
      %844 = "llvm.fadd"(%834, %842) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%844)[^bb13] : (f32) -> ()
    ^bb12:  // pred: ^bb10
      "llvm.br"(%834)[^bb13] : (f32) -> ()
    ^bb13(%845: f32):  // 2 preds: ^bb11, ^bb12
      %846 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %847 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %848 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %849 = "llvm.sub"(%848, %800) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %850 = "llvm.lshr"(%847, %849) : (i32, i32) -> i32
      %851 = "llvm.sub"(%800, %846) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %852 = "nvvm.shfl.sync"(%850, %845, %764, %851) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %853 = "llvm.extractvalue"(%852) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %854 = "llvm.extractvalue"(%852) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%854)[^bb14, ^bb15] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb14:  // pred: ^bb13
      %855 = "llvm.fadd"(%845, %853) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%855)[^bb16] : (f32) -> ()
    ^bb15:  // pred: ^bb13
      "llvm.br"(%845)[^bb16] : (f32) -> ()
    ^bb16(%856: f32):  // 2 preds: ^bb14, ^bb15
      "llvm.br"(%856)[^bb18] : (f32) -> ()
    ^bb17:  // pred: ^bb0
      %857 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %858 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %859 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %860 = "llvm.sub"(%859, %769) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %861 = "llvm.lshr"(%858, %860) : (i32, i32) -> i32
      %862 = "llvm.sub"(%769, %857) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %863 = "nvvm.shfl.sync"(%861, %772, %768, %862) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %864 = "llvm.fadd"(%863, %772) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %865 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %866 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %867 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %868 = "llvm.sub"(%867, %769) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %869 = "llvm.lshr"(%866, %868) : (i32, i32) -> i32
      %870 = "llvm.sub"(%769, %865) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %871 = "nvvm.shfl.sync"(%869, %864, %767, %870) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %872 = "llvm.fadd"(%864, %871) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %873 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %874 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %875 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %876 = "llvm.sub"(%875, %769) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %877 = "llvm.lshr"(%874, %876) : (i32, i32) -> i32
      %878 = "llvm.sub"(%769, %873) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %879 = "nvvm.shfl.sync"(%877, %872, %766, %878) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %880 = "llvm.fadd"(%872, %879) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %881 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %882 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %883 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %884 = "llvm.sub"(%883, %769) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %885 = "llvm.lshr"(%882, %884) : (i32, i32) -> i32
      %886 = "llvm.sub"(%769, %881) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %887 = "nvvm.shfl.sync"(%885, %880, %765, %886) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %888 = "llvm.fadd"(%880, %887) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %889 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %890 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %891 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %892 = "llvm.sub"(%891, %769) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %893 = "llvm.lshr"(%890, %892) : (i32, i32) -> i32
      %894 = "llvm.sub"(%769, %889) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %895 = "nvvm.shfl.sync"(%893, %888, %764, %894) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %896 = "llvm.fadd"(%888, %895) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%896)[^bb18] : (f32) -> ()
    ^bb18(%897: f32):  // 2 preds: ^bb16, ^bb17
      "llvm.cond_br"(%798)[^bb19, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb19:  // pred: ^bb18
      %898 = "llvm.sdiv"(%795, %769) : (i32, i32) -> i32
      %899 = "llvm.sext"(%898) : (i32) -> i64
      %900 = "llvm.extractvalue"(%762) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %901 = "llvm.getelementptr"(%900, %899) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%897, %901) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb21] : () -> ()
    ^bb20:  // pred: ^bb18
      "llvm.br"()[^bb21] : () -> ()
    ^bb21:  // 2 preds: ^bb19, ^bb20
      "nvvm.barrier0"() : () -> ()
      %902 = "llvm.add"(%796, %771) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %903 = "llvm.sdiv"(%902, %769) : (i32, i32) -> i32
      %904 = "llvm.icmp"(%795, %903) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%904)[^bb22, ^bb41] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb22:  // pred: ^bb21
      %905 = "llvm.sext"(%795) : (i32) -> i64
      %906 = "llvm.extractvalue"(%762) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %907 = "llvm.getelementptr"(%906, %905) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      %908 = "llvm.load"(%907) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f32
      %909 = "llvm.icmp"(%903, %769) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%909)[^bb23, ^bb39] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb23:  // pred: ^bb22
      %910 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %911 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %912 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %913 = "llvm.sub"(%912, %903) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %914 = "llvm.lshr"(%911, %913) : (i32, i32) -> i32
      %915 = "llvm.sub"(%903, %910) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %916 = "nvvm.shfl.sync"(%914, %908, %768, %915) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %917 = "llvm.extractvalue"(%916) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %918 = "llvm.extractvalue"(%916) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%918)[^bb24, ^bb25] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb24:  // pred: ^bb23
      %919 = "llvm.fadd"(%908, %917) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%919)[^bb26] : (f32) -> ()
    ^bb25:  // pred: ^bb23
      "llvm.br"(%908)[^bb26] : (f32) -> ()
    ^bb26(%920: f32):  // 2 preds: ^bb24, ^bb25
      %921 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %922 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %923 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %924 = "llvm.sub"(%923, %903) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %925 = "llvm.lshr"(%922, %924) : (i32, i32) -> i32
      %926 = "llvm.sub"(%903, %921) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %927 = "nvvm.shfl.sync"(%925, %920, %767, %926) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %928 = "llvm.extractvalue"(%927) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %929 = "llvm.extractvalue"(%927) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%929)[^bb27, ^bb28] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb27:  // pred: ^bb26
      %930 = "llvm.fadd"(%920, %928) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%930)[^bb29] : (f32) -> ()
    ^bb28:  // pred: ^bb26
      "llvm.br"(%920)[^bb29] : (f32) -> ()
    ^bb29(%931: f32):  // 2 preds: ^bb27, ^bb28
      %932 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %933 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %934 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %935 = "llvm.sub"(%934, %903) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %936 = "llvm.lshr"(%933, %935) : (i32, i32) -> i32
      %937 = "llvm.sub"(%903, %932) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %938 = "nvvm.shfl.sync"(%936, %931, %766, %937) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %939 = "llvm.extractvalue"(%938) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %940 = "llvm.extractvalue"(%938) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%940)[^bb30, ^bb31] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb30:  // pred: ^bb29
      %941 = "llvm.fadd"(%931, %939) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%941)[^bb32] : (f32) -> ()
    ^bb31:  // pred: ^bb29
      "llvm.br"(%931)[^bb32] : (f32) -> ()
    ^bb32(%942: f32):  // 2 preds: ^bb30, ^bb31
      %943 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %944 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %945 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %946 = "llvm.sub"(%945, %903) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %947 = "llvm.lshr"(%944, %946) : (i32, i32) -> i32
      %948 = "llvm.sub"(%903, %943) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %949 = "nvvm.shfl.sync"(%947, %942, %765, %948) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %950 = "llvm.extractvalue"(%949) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %951 = "llvm.extractvalue"(%949) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%951)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %952 = "llvm.fadd"(%942, %950) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%952)[^bb35] : (f32) -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"(%942)[^bb35] : (f32) -> ()
    ^bb35(%953: f32):  // 2 preds: ^bb33, ^bb34
      %954 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %955 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %956 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %957 = "llvm.sub"(%956, %903) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %958 = "llvm.lshr"(%955, %957) : (i32, i32) -> i32
      %959 = "llvm.sub"(%903, %954) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %960 = "nvvm.shfl.sync"(%958, %953, %764, %959) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %961 = "llvm.extractvalue"(%960) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %962 = "llvm.extractvalue"(%960) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      "llvm.cond_br"(%962)[^bb36, ^bb37] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %963 = "llvm.fadd"(%953, %961) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%963)[^bb38] : (f32) -> ()
    ^bb37:  // pred: ^bb35
      "llvm.br"(%953)[^bb38] : (f32) -> ()
    ^bb38(%964: f32):  // 2 preds: ^bb36, ^bb37
      "llvm.br"(%964)[^bb40] : (f32) -> ()
    ^bb39:  // pred: ^bb22
      %965 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %966 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %967 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %968 = "llvm.sub"(%967, %769) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %969 = "llvm.lshr"(%966, %968) : (i32, i32) -> i32
      %970 = "llvm.sub"(%769, %965) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %971 = "nvvm.shfl.sync"(%969, %908, %768, %970) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %972 = "llvm.fadd"(%908, %971) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %973 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %974 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %975 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %976 = "llvm.sub"(%975, %769) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %977 = "llvm.lshr"(%974, %976) : (i32, i32) -> i32
      %978 = "llvm.sub"(%769, %973) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %979 = "nvvm.shfl.sync"(%977, %972, %767, %978) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %980 = "llvm.fadd"(%972, %979) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %981 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %982 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %983 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %984 = "llvm.sub"(%983, %769) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %985 = "llvm.lshr"(%982, %984) : (i32, i32) -> i32
      %986 = "llvm.sub"(%769, %981) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %987 = "nvvm.shfl.sync"(%985, %980, %766, %986) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %988 = "llvm.fadd"(%980, %987) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %989 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %990 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %991 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %992 = "llvm.sub"(%991, %769) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %993 = "llvm.lshr"(%990, %992) : (i32, i32) -> i32
      %994 = "llvm.sub"(%769, %989) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %995 = "nvvm.shfl.sync"(%993, %988, %765, %994) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %996 = "llvm.fadd"(%988, %995) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %997 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %998 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %999 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %1000 = "llvm.sub"(%999, %769) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1001 = "llvm.lshr"(%998, %1000) : (i32, i32) -> i32
      %1002 = "llvm.sub"(%769, %997) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %1003 = "nvvm.shfl.sync"(%1001, %996, %764, %1002) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %1004 = "llvm.fadd"(%996, %1003) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%1004)[^bb40] : (f32) -> ()
    ^bb40(%1005: f32):  // 2 preds: ^bb38, ^bb39
      %1006 = "llvm.extractvalue"(%762) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %1007 = "llvm.getelementptr"(%1006, %763) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%1005, %1007) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
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
      %497 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_region_0}> : () -> !llvm.ptr<3>
      %498 = "llvm.getelementptr"(%497) <{elem_type = !llvm.array<32 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %499 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %500 = "llvm.insertvalue"(%499, %498) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %501 = "llvm.insertvalue"(%500, %498) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %502 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %503 = "llvm.insertvalue"(%501, %502) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %504 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %505 = "llvm.insertvalue"(%503, %504) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %506 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %507 = "llvm.insertvalue"(%505, %506) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %508 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %509 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %510 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %511 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %512 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %513 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %514 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %515 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %516 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %517 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %518 = "llvm.sext"(%517) : (i32) -> i64
      %519 = "llvm.trunc"(%518) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %520 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %521 = "llvm.sext"(%520) : (i32) -> i64
      %522 = "llvm.trunc"(%521) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %523 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %524 = "llvm.sext"(%523) : (i32) -> i64
      %525 = "llvm.trunc"(%524) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %526 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %527 = "llvm.sext"(%526) : (i32) -> i64
      %528 = "llvm.trunc"(%527) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %529 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %530 = "llvm.sext"(%529) : (i32) -> i64
      %531 = "llvm.trunc"(%530) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %532 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %533 = "llvm.sext"(%532) : (i32) -> i64
      %534 = "llvm.trunc"(%533) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %535 = "llvm.mul"(%534, %522) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %536 = "llvm.add"(%535, %531) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %537 = "llvm.mul"(%536, %519) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %538 = "llvm.mul"(%519, %522) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %539 = "llvm.add"(%537, %528) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %540 = "llvm.mul"(%538, %525) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %541 = "llvm.and"(%539, %515) : (i32, i32) -> i32
      %542 = "llvm.icmp"(%541, %514) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %543 = "llvm.sub"(%539, %541) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %544 = "llvm.sub"(%540, %543) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %545 = "llvm.icmp"(%544, %513) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%545)[^bb1, ^bb22] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %546 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %547 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %548 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %549 = "llvm.sub"(%548, %544) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %550 = "llvm.lshr"(%547, %549) : (i32, i32) -> i32
      %551 = "llvm.sub"(%544, %546) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %552 = "nvvm.shfl.sync"(%550, %516, %516, %551) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %553 = "llvm.extractvalue"(%552) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %554 = "llvm.extractvalue"(%552) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%554, %516)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb2:  // pred: ^bb1
      "llvm.br"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      %555 = "llvm.xor"(%553, %516) : (i32, i32) -> i32
      "llvm.br"(%555)[^bb4] : (i32) -> ()
    ^bb4(%556: i32):  // 2 preds: ^bb1, ^bb3
      "llvm.br"()[^bb5] : () -> ()
    ^bb5:  // pred: ^bb4
      %557 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %558 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %559 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %560 = "llvm.sub"(%559, %544) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %561 = "llvm.lshr"(%558, %560) : (i32, i32) -> i32
      %562 = "llvm.sub"(%544, %557) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %563 = "nvvm.shfl.sync"(%561, %556, %512, %562) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %564 = "llvm.extractvalue"(%563) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %565 = "llvm.extractvalue"(%563) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%565, %556)[^bb6, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb6:  // pred: ^bb5
      "llvm.br"()[^bb7] : () -> ()
    ^bb7:  // pred: ^bb6
      %566 = "llvm.xor"(%556, %564) : (i32, i32) -> i32
      "llvm.br"(%566)[^bb8] : (i32) -> ()
    ^bb8(%567: i32):  // 2 preds: ^bb5, ^bb7
      "llvm.br"()[^bb9] : () -> ()
    ^bb9:  // pred: ^bb8
      %568 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %569 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %570 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %571 = "llvm.sub"(%570, %544) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %572 = "llvm.lshr"(%569, %571) : (i32, i32) -> i32
      %573 = "llvm.sub"(%544, %568) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %574 = "nvvm.shfl.sync"(%572, %567, %511, %573) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %575 = "llvm.extractvalue"(%574) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %576 = "llvm.extractvalue"(%574) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%576, %567)[^bb10, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb10:  // pred: ^bb9
      "llvm.br"()[^bb11] : () -> ()
    ^bb11:  // pred: ^bb10
      %577 = "llvm.xor"(%567, %575) : (i32, i32) -> i32
      "llvm.br"(%577)[^bb12] : (i32) -> ()
    ^bb12(%578: i32):  // 2 preds: ^bb9, ^bb11
      "llvm.br"()[^bb13] : () -> ()
    ^bb13:  // pred: ^bb12
      %579 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %580 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %581 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %582 = "llvm.sub"(%581, %544) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %583 = "llvm.lshr"(%580, %582) : (i32, i32) -> i32
      %584 = "llvm.sub"(%544, %579) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %585 = "nvvm.shfl.sync"(%583, %578, %510, %584) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %586 = "llvm.extractvalue"(%585) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %587 = "llvm.extractvalue"(%585) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%587, %578)[^bb14, ^bb16] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb14:  // pred: ^bb13
      "llvm.br"()[^bb15] : () -> ()
    ^bb15:  // pred: ^bb14
      %588 = "llvm.xor"(%578, %586) : (i32, i32) -> i32
      "llvm.br"(%588)[^bb16] : (i32) -> ()
    ^bb16(%589: i32):  // 2 preds: ^bb13, ^bb15
      "llvm.br"()[^bb17] : () -> ()
    ^bb17:  // pred: ^bb16
      %590 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %591 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %592 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %593 = "llvm.sub"(%592, %544) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %594 = "llvm.lshr"(%591, %593) : (i32, i32) -> i32
      %595 = "llvm.sub"(%544, %590) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %596 = "nvvm.shfl.sync"(%594, %589, %509, %595) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %597 = "llvm.extractvalue"(%596) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %598 = "llvm.extractvalue"(%596) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%598, %589)[^bb18, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb18:  // pred: ^bb17
      "llvm.br"()[^bb19] : () -> ()
    ^bb19:  // pred: ^bb18
      %599 = "llvm.xor"(%589, %597) : (i32, i32) -> i32
      "llvm.br"(%599)[^bb20] : (i32) -> ()
    ^bb20(%600: i32):  // 2 preds: ^bb17, ^bb19
      "llvm.br"(%600)[^bb21] : (i32) -> ()
    ^bb21(%601: i32):  // 2 preds: ^bb20, ^bb31
      "llvm.br"()[^bb32] : () -> ()
    ^bb22:  // pred: ^bb0
      %602 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %603 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %604 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %605 = "llvm.sub"(%604, %513) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %606 = "llvm.lshr"(%603, %605) : (i32, i32) -> i32
      %607 = "llvm.sub"(%513, %602) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %608 = "nvvm.shfl.sync"(%606, %516, %516, %607) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb23] : () -> ()
    ^bb23:  // pred: ^bb22
      %609 = "llvm.xor"(%608, %516) : (i32, i32) -> i32
      "llvm.br"()[^bb24] : () -> ()
    ^bb24:  // pred: ^bb23
      %610 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %611 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %612 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %613 = "llvm.sub"(%612, %513) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %614 = "llvm.lshr"(%611, %613) : (i32, i32) -> i32
      %615 = "llvm.sub"(%513, %610) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %616 = "nvvm.shfl.sync"(%614, %609, %512, %615) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb25] : () -> ()
    ^bb25:  // pred: ^bb24
      %617 = "llvm.xor"(%609, %616) : (i32, i32) -> i32
      "llvm.br"()[^bb26] : () -> ()
    ^bb26:  // pred: ^bb25
      %618 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %619 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %620 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %621 = "llvm.sub"(%620, %513) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %622 = "llvm.lshr"(%619, %621) : (i32, i32) -> i32
      %623 = "llvm.sub"(%513, %618) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %624 = "nvvm.shfl.sync"(%622, %617, %511, %623) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb27] : () -> ()
    ^bb27:  // pred: ^bb26
      %625 = "llvm.xor"(%617, %624) : (i32, i32) -> i32
      "llvm.br"()[^bb28] : () -> ()
    ^bb28:  // pred: ^bb27
      %626 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %627 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %628 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %629 = "llvm.sub"(%628, %513) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %630 = "llvm.lshr"(%627, %629) : (i32, i32) -> i32
      %631 = "llvm.sub"(%513, %626) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %632 = "nvvm.shfl.sync"(%630, %625, %510, %631) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb29] : () -> ()
    ^bb29:  // pred: ^bb28
      %633 = "llvm.xor"(%625, %632) : (i32, i32) -> i32
      "llvm.br"()[^bb30] : () -> ()
    ^bb30:  // pred: ^bb29
      %634 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %635 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %636 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %637 = "llvm.sub"(%636, %513) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %638 = "llvm.lshr"(%635, %637) : (i32, i32) -> i32
      %639 = "llvm.sub"(%513, %634) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %640 = "nvvm.shfl.sync"(%638, %633, %509, %639) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb31] : () -> ()
    ^bb31:  // pred: ^bb30
      %641 = "llvm.xor"(%633, %640) : (i32, i32) -> i32
      "llvm.br"(%641)[^bb21] : (i32) -> ()
    ^bb32:  // pred: ^bb21
      "llvm.cond_br"(%542)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %642 = "llvm.sdiv"(%539, %513) : (i32, i32) -> i32
      %643 = "llvm.sext"(%642) : (i32) -> i64
      %644 = "llvm.extractvalue"(%507) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %645 = "llvm.getelementptr"(%644, %643) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%601, %645) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb35] : () -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"()[^bb35] : () -> ()
    ^bb35:  // 2 preds: ^bb33, ^bb34
      "nvvm.barrier0"() : () -> ()
      %646 = "llvm.add"(%540, %515) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %647 = "llvm.sdiv"(%646, %513) : (i32, i32) -> i32
      %648 = "llvm.icmp"(%539, %647) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%648)[^bb36, ^bb69] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %649 = "llvm.sext"(%539) : (i32) -> i64
      %650 = "llvm.extractvalue"(%507) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %651 = "llvm.getelementptr"(%650, %649) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      %652 = "llvm.load"(%651) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> i32
      %653 = "llvm.icmp"(%647, %513) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%653)[^bb37, ^bb58] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb37:  // pred: ^bb36
      %654 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %655 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %656 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %657 = "llvm.sub"(%656, %647) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %658 = "llvm.lshr"(%655, %657) : (i32, i32) -> i32
      %659 = "llvm.sub"(%647, %654) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %660 = "nvvm.shfl.sync"(%658, %652, %516, %659) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %661 = "llvm.extractvalue"(%660) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %662 = "llvm.extractvalue"(%660) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%662, %652)[^bb38, ^bb40] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb38:  // pred: ^bb37
      "llvm.br"()[^bb39] : () -> ()
    ^bb39:  // pred: ^bb38
      %663 = "llvm.xor"(%652, %661) : (i32, i32) -> i32
      "llvm.br"(%663)[^bb40] : (i32) -> ()
    ^bb40(%664: i32):  // 2 preds: ^bb37, ^bb39
      "llvm.br"()[^bb41] : () -> ()
    ^bb41:  // pred: ^bb40
      %665 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %666 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %667 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %668 = "llvm.sub"(%667, %647) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %669 = "llvm.lshr"(%666, %668) : (i32, i32) -> i32
      %670 = "llvm.sub"(%647, %665) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %671 = "nvvm.shfl.sync"(%669, %664, %512, %670) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %672 = "llvm.extractvalue"(%671) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %673 = "llvm.extractvalue"(%671) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%673, %664)[^bb42, ^bb44] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb42:  // pred: ^bb41
      "llvm.br"()[^bb43] : () -> ()
    ^bb43:  // pred: ^bb42
      %674 = "llvm.xor"(%664, %672) : (i32, i32) -> i32
      "llvm.br"(%674)[^bb44] : (i32) -> ()
    ^bb44(%675: i32):  // 2 preds: ^bb41, ^bb43
      "llvm.br"()[^bb45] : () -> ()
    ^bb45:  // pred: ^bb44
      %676 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %677 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %678 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %679 = "llvm.sub"(%678, %647) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %680 = "llvm.lshr"(%677, %679) : (i32, i32) -> i32
      %681 = "llvm.sub"(%647, %676) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %682 = "nvvm.shfl.sync"(%680, %675, %511, %681) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %683 = "llvm.extractvalue"(%682) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %684 = "llvm.extractvalue"(%682) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%684, %675)[^bb46, ^bb48] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb46:  // pred: ^bb45
      "llvm.br"()[^bb47] : () -> ()
    ^bb47:  // pred: ^bb46
      %685 = "llvm.xor"(%675, %683) : (i32, i32) -> i32
      "llvm.br"(%685)[^bb48] : (i32) -> ()
    ^bb48(%686: i32):  // 2 preds: ^bb45, ^bb47
      "llvm.br"()[^bb49] : () -> ()
    ^bb49:  // pred: ^bb48
      %687 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %688 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %689 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %690 = "llvm.sub"(%689, %647) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %691 = "llvm.lshr"(%688, %690) : (i32, i32) -> i32
      %692 = "llvm.sub"(%647, %687) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %693 = "nvvm.shfl.sync"(%691, %686, %510, %692) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %694 = "llvm.extractvalue"(%693) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %695 = "llvm.extractvalue"(%693) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%695, %686)[^bb50, ^bb52] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb50:  // pred: ^bb49
      "llvm.br"()[^bb51] : () -> ()
    ^bb51:  // pred: ^bb50
      %696 = "llvm.xor"(%686, %694) : (i32, i32) -> i32
      "llvm.br"(%696)[^bb52] : (i32) -> ()
    ^bb52(%697: i32):  // 2 preds: ^bb49, ^bb51
      "llvm.br"()[^bb53] : () -> ()
    ^bb53:  // pred: ^bb52
      %698 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %699 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %700 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %701 = "llvm.sub"(%700, %647) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %702 = "llvm.lshr"(%699, %701) : (i32, i32) -> i32
      %703 = "llvm.sub"(%647, %698) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %704 = "nvvm.shfl.sync"(%702, %697, %509, %703) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, i32, i32, i32) -> !llvm.struct<(i32, i1)>
      %705 = "llvm.extractvalue"(%704) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
      %706 = "llvm.extractvalue"(%704) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
      "llvm.cond_br"(%706, %697)[^bb54, ^bb56] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb54:  // pred: ^bb53
      "llvm.br"()[^bb55] : () -> ()
    ^bb55:  // pred: ^bb54
      %707 = "llvm.xor"(%697, %705) : (i32, i32) -> i32
      "llvm.br"(%707)[^bb56] : (i32) -> ()
    ^bb56(%708: i32):  // 2 preds: ^bb53, ^bb55
      "llvm.br"(%708)[^bb57] : (i32) -> ()
    ^bb57(%709: i32):  // 2 preds: ^bb56, ^bb67
      "llvm.br"()[^bb68] : () -> ()
    ^bb58:  // pred: ^bb36
      %710 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %711 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %712 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %713 = "llvm.sub"(%712, %513) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %714 = "llvm.lshr"(%711, %713) : (i32, i32) -> i32
      %715 = "llvm.sub"(%513, %710) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %716 = "nvvm.shfl.sync"(%714, %652, %516, %715) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb59] : () -> ()
    ^bb59:  // pred: ^bb58
      %717 = "llvm.xor"(%652, %716) : (i32, i32) -> i32
      "llvm.br"()[^bb60] : () -> ()
    ^bb60:  // pred: ^bb59
      %718 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %719 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %720 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %721 = "llvm.sub"(%720, %513) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %722 = "llvm.lshr"(%719, %721) : (i32, i32) -> i32
      %723 = "llvm.sub"(%513, %718) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %724 = "nvvm.shfl.sync"(%722, %717, %512, %723) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb61] : () -> ()
    ^bb61:  // pred: ^bb60
      %725 = "llvm.xor"(%717, %724) : (i32, i32) -> i32
      "llvm.br"()[^bb62] : () -> ()
    ^bb62:  // pred: ^bb61
      %726 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %727 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %728 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %729 = "llvm.sub"(%728, %513) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %730 = "llvm.lshr"(%727, %729) : (i32, i32) -> i32
      %731 = "llvm.sub"(%513, %726) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %732 = "nvvm.shfl.sync"(%730, %725, %511, %731) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb63] : () -> ()
    ^bb63:  // pred: ^bb62
      %733 = "llvm.xor"(%725, %732) : (i32, i32) -> i32
      "llvm.br"()[^bb64] : () -> ()
    ^bb64:  // pred: ^bb63
      %734 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %735 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %736 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %737 = "llvm.sub"(%736, %513) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %738 = "llvm.lshr"(%735, %737) : (i32, i32) -> i32
      %739 = "llvm.sub"(%513, %734) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %740 = "nvvm.shfl.sync"(%738, %733, %510, %739) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb65] : () -> ()
    ^bb65:  // pred: ^bb64
      %741 = "llvm.xor"(%733, %740) : (i32, i32) -> i32
      "llvm.br"()[^bb66] : () -> ()
    ^bb66:  // pred: ^bb65
      %742 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %743 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %744 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %745 = "llvm.sub"(%744, %513) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %746 = "llvm.lshr"(%743, %745) : (i32, i32) -> i32
      %747 = "llvm.sub"(%513, %742) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %748 = "nvvm.shfl.sync"(%746, %741, %509, %747) <{kind = #nvvm<shfl_kind bfly>}> : (i32, i32, i32, i32) -> i32
      "llvm.br"()[^bb67] : () -> ()
    ^bb67:  // pred: ^bb66
      %749 = "llvm.xor"(%741, %748) : (i32, i32) -> i32
      "llvm.br"(%749)[^bb57] : (i32) -> ()
    ^bb68:  // pred: ^bb57
      %750 = "llvm.extractvalue"(%507) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %751 = "llvm.getelementptr"(%750, %508) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%709, %751) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
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
      %450 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %451 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %452 = "llvm.mlir.constant"() <{value = 23 : i32}> : () -> i32
      %453 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %454 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %455 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %456 = "llvm.sub"(%455, %452) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %457 = "llvm.lshr"(%454, %456) : (i32, i32) -> i32
      %458 = "llvm.sub"(%452, %453) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %459 = "nvvm.shfl.sync"(%457, %450, %451, %458) <{kind = #nvvm<shfl_kind bfly>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %460 = "llvm.extractvalue"(%459) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %461 = "llvm.extractvalue"(%459) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %462 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %463 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %464 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %465 = "llvm.sub"(%464, %452) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %466 = "llvm.lshr"(%463, %465) : (i32, i32) -> i32
      %467 = "nvvm.shfl.sync"(%466, %450, %451, %465) <{kind = #nvvm<shfl_kind up>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %468 = "llvm.extractvalue"(%467) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %469 = "llvm.extractvalue"(%467) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %470 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %471 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %472 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %473 = "llvm.sub"(%472, %452) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %474 = "llvm.lshr"(%471, %473) : (i32, i32) -> i32
      %475 = "llvm.sub"(%452, %470) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %476 = "nvvm.shfl.sync"(%474, %450, %451, %475) <{kind = #nvvm<shfl_kind down>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %477 = "llvm.extractvalue"(%476) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %478 = "llvm.extractvalue"(%476) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %479 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %480 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %481 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %482 = "llvm.sub"(%481, %452) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %483 = "llvm.lshr"(%480, %482) : (i32, i32) -> i32
      %484 = "llvm.sub"(%452, %479) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %485 = "nvvm.shfl.sync"(%483, %450, %451, %484) <{kind = #nvvm<shfl_kind idx>, return_value_and_is_valid}> : (i32, f32, i32, i32) -> !llvm.struct<(f32, i1)>
      %486 = "llvm.extractvalue"(%485) <{position = array<i64: 0>}> : (!llvm.struct<(f32, i1)>) -> f32
      %487 = "llvm.extractvalue"(%485) <{position = array<i64: 1>}> : (!llvm.struct<(f32, i1)>) -> i1
      %488 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %489 = "llvm.insertvalue"(%488, %460) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %490 = "llvm.insertvalue"(%489, %468) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %491 = "llvm.insertvalue"(%490, %477) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %492 = "llvm.insertvalue"(%491, %486) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, f32) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %493 = "llvm.insertvalue"(%492, %461) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %494 = "llvm.insertvalue"(%493, %469) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %495 = "llvm.insertvalue"(%494, %478) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %496 = "llvm.insertvalue"(%495, %487) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>, i1) -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      "llvm.return"(%496) : (!llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f32, f32)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffle_unused_pred", visibility_ = 0 : i64}> ({
      %415 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %416 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %417 = "llvm.mlir.constant"() <{value = 23 : i32}> : () -> i32
      %418 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %419 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %420 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %421 = "llvm.sub"(%420, %417) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %422 = "llvm.lshr"(%419, %421) : (i32, i32) -> i32
      %423 = "llvm.sub"(%417, %418) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %424 = "nvvm.shfl.sync"(%422, %415, %416, %423) <{kind = #nvvm<shfl_kind bfly>}> : (i32, f32, i32, i32) -> f32
      %425 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %426 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %427 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %428 = "llvm.sub"(%427, %417) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %429 = "llvm.lshr"(%426, %428) : (i32, i32) -> i32
      %430 = "nvvm.shfl.sync"(%429, %415, %416, %428) <{kind = #nvvm<shfl_kind up>}> : (i32, f32, i32, i32) -> f32
      %431 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %432 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %433 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %434 = "llvm.sub"(%433, %417) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %435 = "llvm.lshr"(%432, %434) : (i32, i32) -> i32
      %436 = "llvm.sub"(%417, %431) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %437 = "nvvm.shfl.sync"(%435, %415, %416, %436) <{kind = #nvvm<shfl_kind down>}> : (i32, f32, i32, i32) -> f32
      %438 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %439 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %440 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %441 = "llvm.sub"(%440, %417) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %442 = "llvm.lshr"(%439, %441) : (i32, i32) -> i32
      %443 = "llvm.sub"(%417, %438) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %444 = "nvvm.shfl.sync"(%442, %415, %416, %443) <{kind = #nvvm<shfl_kind idx>}> : (i32, f32, i32, i32) -> f32
      %445 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32, f32)>
      %446 = "llvm.insertvalue"(%445, %424) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %447 = "llvm.insertvalue"(%446, %430) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %448 = "llvm.insertvalue"(%447, %437) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %449 = "llvm.insertvalue"(%448, %444) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      "llvm.return"(%449) : (!llvm.struct<(f32, f32, f32, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_5"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_sync", visibility_ = 0 : i64}> ({
      "nvvm.barrier0"() : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_6"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fabsf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_fabs", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_fabs", visibility_ = 0 : i64}> ({
    ^bb0(%arg108: f32, %arg109: f64):
      %410 = "llvm.call"(%arg108) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fabsf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %411 = "llvm.call"(%arg109) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fabs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %412 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %413 = "llvm.insertvalue"(%412, %410) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %414 = "llvm.insertvalue"(%413, %411) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%414) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_7"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cbrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_cbrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cbrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg106: f32, %arg107: f64):
      %405 = "llvm.call"(%arg106) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cbrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %406 = "llvm.call"(%arg107) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cbrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %407 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %408 = "llvm.insertvalue"(%407, %405) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %409 = "llvm.insertvalue"(%408, %406) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%409) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_8"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_ceilf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_ceil", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_ceil", visibility_ = 0 : i64}> ({
    ^bb0(%arg104: f32, %arg105: f64):
      %400 = "llvm.call"(%arg104) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_ceilf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %401 = "llvm.call"(%arg105) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_ceil, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %402 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %403 = "llvm.insertvalue"(%402, %400) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %404 = "llvm.insertvalue"(%403, %401) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%404) : (!llvm.struct<(f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_9"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_floorf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_floor", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_floor", visibility_ = 0 : i64}> ({
    ^bb0(%arg102: f32, %arg103: f64):
      %395 = "llvm.call"(%arg102) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_floorf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %396 = "llvm.call"(%arg103) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_floor, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %397 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %398 = "llvm.insertvalue"(%397, %395) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %399 = "llvm.insertvalue"(%398, %396) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%399) : (!llvm.struct<(f32, f64)>) -> ()
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
    ^bb0(%arg100: f32, %arg101: f64):
      %388 = "llvm.call"(%arg100) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %389 = "llvm.call"(%arg101) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_cos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %390 = "llvm.call"(%arg100) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_cosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %391 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %392 = "llvm.insertvalue"(%391, %388) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %393 = "llvm.insertvalue"(%392, %389) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %394 = "llvm.insertvalue"(%393, %390) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%394) : (!llvm.struct<(f32, f64, f32)>) -> ()
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
    ^bb0(%arg98: f32, %arg99: f64):
      %381 = "llvm.call"(%arg98) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %382 = "llvm.call"(%arg99) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %383 = "llvm.call"(%arg98) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %384 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %385 = "llvm.insertvalue"(%384, %381) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %386 = "llvm.insertvalue"(%385, %382) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %387 = "llvm.insertvalue"(%386, %383) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%387) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_12"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_exp2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_exp2", visibility_ = 0 : i64}> ({
    ^bb0(%arg96: f32, %arg97: f64):
      %376 = "llvm.call"(%arg96) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %377 = "llvm.call"(%arg97) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %378 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %379 = "llvm.insertvalue"(%378, %376) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %380 = "llvm.insertvalue"(%379, %377) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%380) : (!llvm.struct<(f32, f64)>) -> ()
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
    ^bb0(%arg94: f32, %arg95: f64):
      %369 = "llvm.call"(%arg94) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_logf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %370 = "llvm.call"(%arg95) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %371 = "llvm.call"(%arg94) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_logf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %372 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %373 = "llvm.insertvalue"(%372, %369) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %374 = "llvm.insertvalue"(%373, %370) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %375 = "llvm.insertvalue"(%374, %371) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%375) : (!llvm.struct<(f32, f64, f32)>) -> ()
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
    ^bb0(%arg92: f32, %arg93: f64):
      %362 = "llvm.call"(%arg92) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log10f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %363 = "llvm.call"(%arg93) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log10, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %364 = "llvm.call"(%arg92) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_log10f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %365 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %366 = "llvm.insertvalue"(%365, %362) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %367 = "llvm.insertvalue"(%366, %363) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %368 = "llvm.insertvalue"(%367, %364) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%368) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_15"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log1pf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_log1p", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f64)> (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log1p", visibility_ = 0 : i64}> ({
    ^bb0(%arg90: f32, %arg91: f64):
      %357 = "llvm.call"(%arg90) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log1pf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %358 = "llvm.call"(%arg91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log1p, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %359 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %360 = "llvm.insertvalue"(%359, %357) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %361 = "llvm.insertvalue"(%360, %358) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%361) : (!llvm.struct<(f32, f64)>) -> ()
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
    ^bb0(%arg88: f32, %arg89: f64):
      %350 = "llvm.call"(%arg88) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %351 = "llvm.call"(%arg89) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_log2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %352 = "llvm.call"(%arg88) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_log2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %353 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %354 = "llvm.insertvalue"(%353, %350) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %355 = "llvm.insertvalue"(%354, %351) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %356 = "llvm.insertvalue"(%355, %352) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%356) : (!llvm.struct<(f32, f64, f32)>) -> ()
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
    ^bb0(%arg86: f32, %arg87: f64):
      %343 = "llvm.call"(%arg86) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %344 = "llvm.call"(%arg87) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %345 = "llvm.call"(%arg86) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sinf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %346 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %347 = "llvm.insertvalue"(%346, %343) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %348 = "llvm.insertvalue"(%347, %344) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %349 = "llvm.insertvalue"(%348, %345) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%349) : (!llvm.struct<(f32, f64, f32)>) -> ()
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
    ^bb0(%arg83: f16, %arg84: f32, %arg85: f64):
      %332 = "llvm.fpext"(%arg83) : (f16) -> f32
      %333 = "llvm.call"(%332) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %334 = "llvm.fptrunc"(%333) : (f32) -> f16
      %335 = "llvm.call"(%arg84) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %336 = "llvm.call"(%arg85) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %337 = "llvm.call"(%arg84) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_tanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %338 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64, f32)>
      %339 = "llvm.insertvalue"(%338, %334) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64, f32)>, f16) -> !llvm.struct<(f16, f32, f64, f32)>
      %340 = "llvm.insertvalue"(%339, %335) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64, f32)>, f32) -> !llvm.struct<(f16, f32, f64, f32)>
      %341 = "llvm.insertvalue"(%340, %336) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64, f32)>, f64) -> !llvm.struct<(f16, f32, f64, f32)>
      %342 = "llvm.insertvalue"(%341, %337) <{position = array<i64: 3>}> : (!llvm.struct<(f16, f32, f64, f32)>, f32) -> !llvm.struct<(f16, f32, f64, f32)>
      "llvm.return"(%342) : (!llvm.struct<(f16, f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_19"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanhf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_tanh", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_tanh", visibility_ = 0 : i64}> ({
    ^bb0(%arg80: f16, %arg81: f32, %arg82: f64):
      %323 = "llvm.fpext"(%arg80) : (f16) -> f32
      %324 = "llvm.call"(%323) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %325 = "llvm.fptrunc"(%324) : (f32) -> f16
      %326 = "llvm.call"(%arg81) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %327 = "llvm.call"(%arg82) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_tanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %328 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %329 = "llvm.insertvalue"(%328, %325) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %330 = "llvm.insertvalue"(%329, %326) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %331 = "llvm.insertvalue"(%330, %327) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%331) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_20"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rsqrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_rsqrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_rsqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg77: f16, %arg78: f32, %arg79: f64):
      %314 = "llvm.fpext"(%arg77) : (f16) -> f32
      %315 = "llvm.call"(%314) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %316 = "llvm.fptrunc"(%315) : (f32) -> f16
      %317 = "llvm.call"(%arg78) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %318 = "llvm.call"(%arg79) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_rsqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %319 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %320 = "llvm.insertvalue"(%319, %316) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %321 = "llvm.insertvalue"(%320, %317) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %322 = "llvm.insertvalue"(%321, %318) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%322) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_21"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sqrtf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_sqrt", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg74: f16, %arg75: f32, %arg76: f64):
      %305 = "llvm.fpext"(%arg74) : (f16) -> f32
      %306 = "llvm.call"(%305) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %307 = "llvm.fptrunc"(%306) : (f32) -> f16
      %308 = "llvm.call"(%arg75) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrtf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %309 = "llvm.call"(%arg76) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %310 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %311 = "llvm.insertvalue"(%310, %307) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %312 = "llvm.insertvalue"(%311, %308) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %313 = "llvm.insertvalue"(%312, %309) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%313) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_22"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atanf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atan", visibility_ = 0 : i64}> ({
    ^bb0(%arg71: f16, %arg72: f32, %arg73: f64):
      %296 = "llvm.fpext"(%arg71) : (f16) -> f32
      %297 = "llvm.call"(%296) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %298 = "llvm.fptrunc"(%297) : (f32) -> f16
      %299 = "llvm.call"(%arg72) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %300 = "llvm.call"(%arg73) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %301 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %302 = "llvm.insertvalue"(%301, %298) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %303 = "llvm.insertvalue"(%302, %299) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %304 = "llvm.insertvalue"(%303, %300) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%304) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_23"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan2f", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__nv_atan2", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atan2", visibility_ = 0 : i64}> ({
    ^bb0(%arg68: f16, %arg69: f32, %arg70: f64):
      %286 = "llvm.fpext"(%arg68) : (f16) -> f32
      %287 = "llvm.fpext"(%arg68) : (f16) -> f32
      %288 = "llvm.call"(%286, %287) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %289 = "llvm.fptrunc"(%288) : (f32) -> f16
      %290 = "llvm.call"(%arg69, %arg69) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %291 = "llvm.call"(%arg70, %arg70) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atan2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %292 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %293 = "llvm.insertvalue"(%292, %289) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %294 = "llvm.insertvalue"(%293, %290) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %295 = "llvm.insertvalue"(%294, %291) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%295) : (!llvm.struct<(f16, f32, f64)>) -> ()
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
      ^bb0(%arg66: f32, %arg67: f64):
        %279 = "llvm.call"(%arg66) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
        %280 = "llvm.call"(%arg67) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
        %281 = "llvm.call"(%arg66) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
        %282 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
        %283 = "llvm.insertvalue"(%282, %279) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
        %284 = "llvm.insertvalue"(%283, %280) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
        %285 = "llvm.insertvalue"(%284, %281) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
        "llvm.return"(%285) : (!llvm.struct<(f32, f64, f32)>) -> ()
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
    ^bb0(%arg64: f32, %arg65: f64):
      %274 = "llvm.call"(%arg64) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expm1f, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %275 = "llvm.call"(%arg65) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expm1, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %276 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64)>
      %277 = "llvm.insertvalue"(%276, %274) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64)>, f32) -> !llvm.struct<(f32, f64)>
      %278 = "llvm.insertvalue"(%277, %275) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64)>, f64) -> !llvm.struct<(f32, f64)>
      "llvm.return"(%278) : (!llvm.struct<(f32, f64)>) -> ()
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
    ^bb0(%arg62: f32, %arg63: f64):
      %267 = "llvm.call"(%arg62, %arg62) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_powf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %268 = "llvm.call"(%arg63, %arg63) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_pow, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %269 = "llvm.call"(%arg62, %arg62) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_powf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %270 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f64, f32)>
      %271 = "llvm.insertvalue"(%270, %267) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      %272 = "llvm.insertvalue"(%271, %268) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f64, f32)>, f64) -> !llvm.struct<(f32, f64, f32)>
      %273 = "llvm.insertvalue"(%272, %269) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f64, f32)>, f32) -> !llvm.struct<(f32, f64, f32)>
      "llvm.return"(%273) : (!llvm.struct<(f32, f64, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_27"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_expf", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xf32> (vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "gpu_unroll", visibility_ = 0 : i64}> ({
    ^bb0(%arg61: vector<4xf32>):
      %250 = "llvm.mlir.poison"() : () -> vector<4xf32>
      %251 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
      %252 = "llvm.extractelement"(%arg61, %251) : (vector<4xf32>, i64) -> f32
      %253 = "llvm.call"(%252) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %254 = "llvm.insertelement"(%250, %253, %251) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %255 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
      %256 = "llvm.extractelement"(%arg61, %255) : (vector<4xf32>, i64) -> f32
      %257 = "llvm.call"(%256) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %258 = "llvm.insertelement"(%254, %257, %255) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %259 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
      %260 = "llvm.extractelement"(%arg61, %259) : (vector<4xf32>, i64) -> f32
      %261 = "llvm.call"(%260) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %262 = "llvm.insertelement"(%258, %261, %259) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %263 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
      %264 = "llvm.extractelement"(%arg61, %263) : (vector<4xf32>, i64) -> f32
      %265 = "llvm.call"(%264) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_expf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %266 = "llvm.insertelement"(%262, %265, %263) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      "llvm.return"(%266) : (vector<4xf32>) -> ()
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
      %240 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
      %241 = "llvm.getelementptr"(%240) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %242 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %243 = "llvm.alloca"(%242) <{elem_type = !llvm.struct<()>}> : (i64) -> !llvm.ptr
      %244 = "llvm.call"(%241, %243) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      %245 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
      %246 = "llvm.getelementptr"(%245) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %247 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %248 = "llvm.alloca"(%247) <{elem_type = !llvm.struct<()>}> : (i64) -> !llvm.ptr
      %249 = "llvm.call"(%246, %248) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, f32)>, linkage = #llvm.linkage<external>, sym_name = "test_printf", visibility_ = 0 : i64}> ({
    ^bb0(%arg59: i32, %arg60: f32):
      %232 = "llvm.mlir.addressof"() <{global_name = @printfFormat_1}> : () -> !llvm.ptr
      %233 = "llvm.getelementptr"(%232) <{elem_type = !llvm.array<11 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %234 = "llvm.fpext"(%arg60) : (f32) -> f64
      %235 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %236 = "llvm.alloca"(%235) <{elem_type = !llvm.struct<(i32, f64)>}> : (i64) -> !llvm.ptr
      %237 = "llvm.getelementptr"(%236) <{elem_type = !llvm.struct<(i32, f64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      "llvm.store"(%arg59, %237) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      %238 = "llvm.getelementptr"(%236) <{elem_type = !llvm.struct<(i32, f64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
      "llvm.store"(%234, %238) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
      %239 = "llvm.call"(%233, %236) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_30"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_add", visibility_ = 0 : i64}> ({
    ^bb0(%arg58: i32):
      %230 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %231 = "nvvm.redux.sync"(%arg58, %230) <{abs = false, kind = #nvvm<redux_kind add>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_minsi", visibility_ = 0 : i64}> ({
    ^bb0(%arg57: i32):
      %228 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %229 = "nvvm.redux.sync"(%arg57, %228) <{abs = false, kind = #nvvm<redux_kind min>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_maxsi", visibility_ = 0 : i64}> ({
    ^bb0(%arg56: i32):
      %226 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %227 = "nvvm.redux.sync"(%arg56, %226) <{abs = false, kind = #nvvm<redux_kind max>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_and", visibility_ = 0 : i64}> ({
    ^bb0(%arg55: i32):
      %224 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %225 = "nvvm.redux.sync"(%arg55, %224) <{abs = false, kind = #nvvm<redux_kind and>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_or", visibility_ = 0 : i64}> ({
    ^bb0(%arg54: i32):
      %222 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %223 = "nvvm.redux.sync"(%arg54, %222) <{abs = false, kind = #nvvm<redux_kind or>, nan = false}> : (i32, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_reduce_xor", visibility_ = 0 : i64}> ({
    ^bb0(%arg53: i32):
      %220 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %221 = "nvvm.redux.sync"(%arg53, %220) <{abs = false, kind = #nvvm<redux_kind xor>, nan = false}> : (i32, i32) -> i32
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
      %160 = "llvm.fpext"(%arg35) : (f16) -> f32
      %161 = "llvm.call"(%160) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_atanhf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %162 = "llvm.fptrunc"(%161) : (f32) -> f16
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
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<77 x i8>, linkage = #llvm.linkage<internal>, sym_name = "assert_file_0", value = "/home/zq/coding/llvm-project/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm.mlir\00", visibility_ = 0 : i64}> ({
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
      %90 = "llvm.getelementptr"(%89) <{elem_type = !llvm.array<77 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %91 = "llvm.mlir.addressof"() <{global_name = @assert_func_0}> : () -> !llvm.ptr
      %92 = "llvm.getelementptr"(%91) <{elem_type = !llvm.array<10 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %93 = "llvm.mlir.constant"() <{value = 998 : i32}> : () -> i32
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
      "transform.apply_conversion_patterns"(%86) <{illegal_dialects = ["gpu"], illegal_ops = ["llvm.copysign", "llvm.cos", "llvm.exp", "llvm.exp2", "llvm.fabs", "llvm.fceil", "llvm.ffloor", "llvm.frem", "llvm.log", "llvm.log10", "llvm.log2", "llvm.pow", "llvm.roundeven", "llvm.round", "llvm.sin", "llvm.sqrt"], legal_dialects = ["llvm", "memref", "nvvm", "test"], legal_ops = ["func.func", "gpu.module", "gpu.yield"], partial_conversion}> ({
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
      %34 = "llvm.fpext"(%arg3) : (f16) -> f32
      "llvm.call"(%34, %32, %33) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %35 = "llvm.load"(%32) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %36 = "llvm.load"(%33) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %37 = "llvm.fptrunc"(%35) : (f32) -> f16
      %38 = "llvm.fptrunc"(%36) : (f32) -> f16
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
      %9 = "llvm.fpext"(%arg0) : (f16) -> f32
      "llvm.call"(%9, %7, %8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_fast_sincosf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %10 = "llvm.load"(%7) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %11 = "llvm.load"(%8) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
      %12 = "llvm.fptrunc"(%10) : (f32) -> f16
      %13 = "llvm.fptrunc"(%11) : (f32) -> f16
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


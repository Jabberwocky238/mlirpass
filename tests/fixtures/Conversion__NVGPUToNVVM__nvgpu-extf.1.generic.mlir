"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf8E4M3FN>) -> (), sym_name = "cvt_float_e4m3fn_to_f16"}> ({
  ^bb0(%arg34: vector<8xf8E4M3FN>):
    %901 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %902 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %903 = "builtin.unrealized_conversion_cast"(%arg34) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %904 = "llvm.bitcast"(%903) : (vector<8xi8>) -> vector<2xi32>
    %905 = "llvm.extractelement"(%904, %902) : (vector<2xi32>, i64) -> i32
    %906 = "llvm.bitcast"(%905) : (i32) -> vector<2xi16>
    %907 = "llvm.extractelement"(%906, %902) : (vector<2xi16>, i64) -> i16
    %908 = "llvm.bitcast"(%907) : (i16) -> vector<2xi8>
    %909 = "nvvm.convert.f8x2.to.f16x2"(%908) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %910 = "llvm.extractelement"(%906, %901) : (vector<2xi16>, i64) -> i16
    %911 = "llvm.bitcast"(%910) : (i16) -> vector<2xi8>
    %912 = "nvvm.convert.f8x2.to.f16x2"(%911) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %913 = "llvm.extractelement"(%904, %901) : (vector<2xi32>, i64) -> i32
    %914 = "llvm.bitcast"(%913) : (i32) -> vector<2xi16>
    %915 = "llvm.extractelement"(%914, %902) : (vector<2xi16>, i64) -> i16
    %916 = "llvm.bitcast"(%915) : (i16) -> vector<2xi8>
    %917 = "nvvm.convert.f8x2.to.f16x2"(%916) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %918 = "llvm.extractelement"(%914, %901) : (vector<2xi16>, i64) -> i16
    %919 = "llvm.bitcast"(%918) : (i16) -> vector<2xi8>
    %920 = "nvvm.convert.f8x2.to.f16x2"(%919) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf8E5M2>) -> (), sym_name = "cvt_float_e5m2_to_f16"}> ({
  ^bb0(%arg33: vector<8xf8E5M2>):
    %881 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %882 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %883 = "builtin.unrealized_conversion_cast"(%arg33) : (vector<8xf8E5M2>) -> vector<8xi8>
    %884 = "llvm.bitcast"(%883) : (vector<8xi8>) -> vector<2xi32>
    %885 = "llvm.extractelement"(%884, %882) : (vector<2xi32>, i64) -> i32
    %886 = "llvm.bitcast"(%885) : (i32) -> vector<2xi16>
    %887 = "llvm.extractelement"(%886, %882) : (vector<2xi16>, i64) -> i16
    %888 = "llvm.bitcast"(%887) : (i16) -> vector<2xi8>
    %889 = "nvvm.convert.f8x2.to.f16x2"(%888) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %890 = "llvm.extractelement"(%886, %881) : (vector<2xi16>, i64) -> i16
    %891 = "llvm.bitcast"(%890) : (i16) -> vector<2xi8>
    %892 = "nvvm.convert.f8x2.to.f16x2"(%891) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %893 = "llvm.extractelement"(%884, %881) : (vector<2xi32>, i64) -> i32
    %894 = "llvm.bitcast"(%893) : (i32) -> vector<2xi16>
    %895 = "llvm.extractelement"(%894, %882) : (vector<2xi16>, i64) -> i16
    %896 = "llvm.bitcast"(%895) : (i16) -> vector<2xi8>
    %897 = "nvvm.convert.f8x2.to.f16x2"(%896) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %898 = "llvm.extractelement"(%894, %881) : (vector<2xi16>, i64) -> i16
    %899 = "llvm.bitcast"(%898) : (i16) -> vector<2xi8>
    %900 = "nvvm.convert.f8x2.to.f16x2"(%899) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf8E8M0FNU>) -> (), sym_name = "cvt_float_e8m0_to_bf16"}> ({
  ^bb0(%arg32: vector<8xf8E8M0FNU>):
    %861 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %862 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %863 = "builtin.unrealized_conversion_cast"(%arg32) : (vector<8xf8E8M0FNU>) -> vector<8xi8>
    %864 = "llvm.bitcast"(%863) : (vector<8xi8>) -> vector<2xi32>
    %865 = "llvm.extractelement"(%864, %862) : (vector<2xi32>, i64) -> i32
    %866 = "llvm.bitcast"(%865) : (i32) -> vector<2xi16>
    %867 = "llvm.extractelement"(%866, %862) : (vector<2xi16>, i64) -> i16
    %868 = "llvm.bitcast"(%867) : (i16) -> vector<2xi8>
    %869 = "nvvm.convert.f8x2.to.bf16x2"(%868) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f8E8M0FNU}> : (vector<2xi8>) -> vector<2xbf16>
    %870 = "llvm.extractelement"(%866, %861) : (vector<2xi16>, i64) -> i16
    %871 = "llvm.bitcast"(%870) : (i16) -> vector<2xi8>
    %872 = "nvvm.convert.f8x2.to.bf16x2"(%871) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f8E8M0FNU}> : (vector<2xi8>) -> vector<2xbf16>
    %873 = "llvm.extractelement"(%864, %861) : (vector<2xi32>, i64) -> i32
    %874 = "llvm.bitcast"(%873) : (i32) -> vector<2xi16>
    %875 = "llvm.extractelement"(%874, %862) : (vector<2xi16>, i64) -> i16
    %876 = "llvm.bitcast"(%875) : (i16) -> vector<2xi8>
    %877 = "nvvm.convert.f8x2.to.bf16x2"(%876) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f8E8M0FNU}> : (vector<2xi8>) -> vector<2xbf16>
    %878 = "llvm.extractelement"(%874, %861) : (vector<2xi16>, i64) -> i16
    %879 = "llvm.bitcast"(%878) : (i16) -> vector<2xi8>
    %880 = "nvvm.convert.f8x2.to.bf16x2"(%879) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f8E8M0FNU}> : (vector<2xi8>) -> vector<2xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf6E2M3FN>) -> (), sym_name = "cvt_float_e2m3_to_f16"}> ({
  ^bb0(%arg31: vector<8xf6E2M3FN>):
    %840 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %841 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %842 = "builtin.unrealized_conversion_cast"(%arg31) : (vector<8xf6E2M3FN>) -> vector<8xi6>
    %843 = "llvm.zext"(%842) : (vector<8xi6>) -> vector<8xi8>
    %844 = "llvm.bitcast"(%843) : (vector<8xi8>) -> vector<2xi32>
    %845 = "llvm.extractelement"(%844, %841) : (vector<2xi32>, i64) -> i32
    %846 = "llvm.bitcast"(%845) : (i32) -> vector<2xi16>
    %847 = "llvm.extractelement"(%846, %841) : (vector<2xi16>, i64) -> i16
    %848 = "llvm.bitcast"(%847) : (i16) -> vector<2xi8>
    %849 = "nvvm.convert.f6x2.to.f16x2"(%848) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %850 = "llvm.extractelement"(%846, %840) : (vector<2xi16>, i64) -> i16
    %851 = "llvm.bitcast"(%850) : (i16) -> vector<2xi8>
    %852 = "nvvm.convert.f6x2.to.f16x2"(%851) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %853 = "llvm.extractelement"(%844, %840) : (vector<2xi32>, i64) -> i32
    %854 = "llvm.bitcast"(%853) : (i32) -> vector<2xi16>
    %855 = "llvm.extractelement"(%854, %841) : (vector<2xi16>, i64) -> i16
    %856 = "llvm.bitcast"(%855) : (i16) -> vector<2xi8>
    %857 = "nvvm.convert.f6x2.to.f16x2"(%856) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %858 = "llvm.extractelement"(%854, %840) : (vector<2xi16>, i64) -> i16
    %859 = "llvm.bitcast"(%858) : (i16) -> vector<2xi8>
    %860 = "nvvm.convert.f6x2.to.f16x2"(%859) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf6E3M2FN>) -> (), sym_name = "cvt_float_e3m2_to_f16"}> ({
  ^bb0(%arg30: vector<8xf6E3M2FN>):
    %819 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %820 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %821 = "builtin.unrealized_conversion_cast"(%arg30) : (vector<8xf6E3M2FN>) -> vector<8xi6>
    %822 = "llvm.zext"(%821) : (vector<8xi6>) -> vector<8xi8>
    %823 = "llvm.bitcast"(%822) : (vector<8xi8>) -> vector<2xi32>
    %824 = "llvm.extractelement"(%823, %820) : (vector<2xi32>, i64) -> i32
    %825 = "llvm.bitcast"(%824) : (i32) -> vector<2xi16>
    %826 = "llvm.extractelement"(%825, %820) : (vector<2xi16>, i64) -> i16
    %827 = "llvm.bitcast"(%826) : (i16) -> vector<2xi8>
    %828 = "nvvm.convert.f6x2.to.f16x2"(%827) <{relu = false, srcType = f6E3M2FN}> : (vector<2xi8>) -> vector<2xf16>
    %829 = "llvm.extractelement"(%825, %819) : (vector<2xi16>, i64) -> i16
    %830 = "llvm.bitcast"(%829) : (i16) -> vector<2xi8>
    %831 = "nvvm.convert.f6x2.to.f16x2"(%830) <{relu = false, srcType = f6E3M2FN}> : (vector<2xi8>) -> vector<2xf16>
    %832 = "llvm.extractelement"(%823, %819) : (vector<2xi32>, i64) -> i32
    %833 = "llvm.bitcast"(%832) : (i32) -> vector<2xi16>
    %834 = "llvm.extractelement"(%833, %820) : (vector<2xi16>, i64) -> i16
    %835 = "llvm.bitcast"(%834) : (i16) -> vector<2xi8>
    %836 = "nvvm.convert.f6x2.to.f16x2"(%835) <{relu = false, srcType = f6E3M2FN}> : (vector<2xi8>) -> vector<2xf16>
    %837 = "llvm.extractelement"(%833, %819) : (vector<2xi16>, i64) -> i16
    %838 = "llvm.bitcast"(%837) : (i16) -> vector<2xi8>
    %839 = "nvvm.convert.f6x2.to.f16x2"(%838) <{relu = false, srcType = f6E3M2FN}> : (vector<2xi8>) -> vector<2xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xf4E2M1FN>) -> (), sym_name = "cvt_float_e2m1_to_f16"}> ({
  ^bb0(%arg29: vector<16xf4E2M1FN>):
    %793 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %794 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %795 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %796 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %797 = "builtin.unrealized_conversion_cast"(%arg29) : (vector<16xf4E2M1FN>) -> vector<16xi4>
    %798 = "llvm.bitcast"(%797) : (vector<16xi4>) -> vector<2xi32>
    %799 = "llvm.extractelement"(%798, %796) : (vector<2xi32>, i64) -> i32
    %800 = "llvm.bitcast"(%799) : (i32) -> vector<4xi8>
    %801 = "llvm.extractelement"(%800, %796) : (vector<4xi8>, i64) -> i8
    %802 = "nvvm.convert.f4x2.to.f16x2"(%801) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %803 = "llvm.extractelement"(%800, %795) : (vector<4xi8>, i64) -> i8
    %804 = "nvvm.convert.f4x2.to.f16x2"(%803) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %805 = "llvm.extractelement"(%800, %794) : (vector<4xi8>, i64) -> i8
    %806 = "nvvm.convert.f4x2.to.f16x2"(%805) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %807 = "llvm.extractelement"(%800, %793) : (vector<4xi8>, i64) -> i8
    %808 = "nvvm.convert.f4x2.to.f16x2"(%807) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %809 = "llvm.extractelement"(%798, %795) : (vector<2xi32>, i64) -> i32
    %810 = "llvm.bitcast"(%809) : (i32) -> vector<4xi8>
    %811 = "llvm.extractelement"(%810, %796) : (vector<4xi8>, i64) -> i8
    %812 = "nvvm.convert.f4x2.to.f16x2"(%811) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %813 = "llvm.extractelement"(%810, %795) : (vector<4xi8>, i64) -> i8
    %814 = "nvvm.convert.f4x2.to.f16x2"(%813) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %815 = "llvm.extractelement"(%810, %794) : (vector<4xi8>, i64) -> i8
    %816 = "nvvm.convert.f4x2.to.f16x2"(%815) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %817 = "llvm.extractelement"(%810, %793) : (vector<4xi8>, i64) -> i8
    %818 = "nvvm.convert.f4x2.to.f16x2"(%817) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf6E2M3FN>) -> (), sym_name = "cvt_float_e2m3_to_bf16"}> ({
  ^bb0(%arg28: vector<8xf6E2M3FN>):
    %772 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %773 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %774 = "builtin.unrealized_conversion_cast"(%arg28) : (vector<8xf6E2M3FN>) -> vector<8xi6>
    %775 = "llvm.zext"(%774) : (vector<8xi6>) -> vector<8xi8>
    %776 = "llvm.bitcast"(%775) : (vector<8xi8>) -> vector<2xi32>
    %777 = "llvm.extractelement"(%776, %773) : (vector<2xi32>, i64) -> i32
    %778 = "llvm.bitcast"(%777) : (i32) -> vector<2xi16>
    %779 = "llvm.extractelement"(%778, %773) : (vector<2xi16>, i64) -> i16
    %780 = "llvm.bitcast"(%779) : (i16) -> vector<2xi8>
    %781 = "nvvm.convert.f6x2.to.bf16x2"(%780) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xbf16>
    %782 = "llvm.extractelement"(%778, %772) : (vector<2xi16>, i64) -> i16
    %783 = "llvm.bitcast"(%782) : (i16) -> vector<2xi8>
    %784 = "nvvm.convert.f6x2.to.bf16x2"(%783) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xbf16>
    %785 = "llvm.extractelement"(%776, %772) : (vector<2xi32>, i64) -> i32
    %786 = "llvm.bitcast"(%785) : (i32) -> vector<2xi16>
    %787 = "llvm.extractelement"(%786, %773) : (vector<2xi16>, i64) -> i16
    %788 = "llvm.bitcast"(%787) : (i16) -> vector<2xi8>
    %789 = "nvvm.convert.f6x2.to.bf16x2"(%788) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xbf16>
    %790 = "llvm.extractelement"(%786, %772) : (vector<2xi16>, i64) -> i16
    %791 = "llvm.bitcast"(%790) : (i16) -> vector<2xi8>
    %792 = "nvvm.convert.f6x2.to.bf16x2"(%791) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xf4E2M1FN>) -> (), sym_name = "cvt_float_e2m1_to_bf16"}> ({
  ^bb0(%arg27: vector<16xf4E2M1FN>):
    %746 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %747 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %748 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %749 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %750 = "builtin.unrealized_conversion_cast"(%arg27) : (vector<16xf4E2M1FN>) -> vector<16xi4>
    %751 = "llvm.bitcast"(%750) : (vector<16xi4>) -> vector<2xi32>
    %752 = "llvm.extractelement"(%751, %749) : (vector<2xi32>, i64) -> i32
    %753 = "llvm.bitcast"(%752) : (i32) -> vector<4xi8>
    %754 = "llvm.extractelement"(%753, %749) : (vector<4xi8>, i64) -> i8
    %755 = "nvvm.convert.f4x2.to.bf16x2"(%754) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %756 = "llvm.extractelement"(%753, %748) : (vector<4xi8>, i64) -> i8
    %757 = "nvvm.convert.f4x2.to.bf16x2"(%756) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %758 = "llvm.extractelement"(%753, %747) : (vector<4xi8>, i64) -> i8
    %759 = "nvvm.convert.f4x2.to.bf16x2"(%758) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %760 = "llvm.extractelement"(%753, %746) : (vector<4xi8>, i64) -> i8
    %761 = "nvvm.convert.f4x2.to.bf16x2"(%760) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %762 = "llvm.extractelement"(%751, %748) : (vector<2xi32>, i64) -> i32
    %763 = "llvm.bitcast"(%762) : (i32) -> vector<4xi8>
    %764 = "llvm.extractelement"(%763, %749) : (vector<4xi8>, i64) -> i8
    %765 = "nvvm.convert.f4x2.to.bf16x2"(%764) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %766 = "llvm.extractelement"(%763, %748) : (vector<4xi8>, i64) -> i8
    %767 = "nvvm.convert.f4x2.to.bf16x2"(%766) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %768 = "llvm.extractelement"(%763, %747) : (vector<4xi8>, i64) -> i8
    %769 = "nvvm.convert.f4x2.to.bf16x2"(%768) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %770 = "llvm.extractelement"(%763, %746) : (vector<4xi8>, i64) -> i8
    %771 = "nvvm.convert.f4x2.to.bf16x2"(%770) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>) -> vector<4xf32>, sym_name = "fpext_e4m3fn_to_f32"}> ({
  ^bb0(%arg26: vector<4xf8E4M3FN>):
    %727 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %728 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %729 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %730 = "builtin.unrealized_conversion_cast"(%arg26) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %731 = "llvm.bitcast"(%730) : (vector<4xi8>) -> vector<1xi32>
    %732 = "llvm.extractelement"(%731, %728) : (vector<1xi32>, i64) -> i32
    %733 = "llvm.bitcast"(%732) : (i32) -> vector<2xi16>
    %734 = "llvm.extractelement"(%733, %728) : (vector<2xi16>, i64) -> i16
    %735 = "llvm.bitcast"(%734) : (i16) -> vector<2xi8>
    %736 = "nvvm.convert.f8x2.to.f16x2"(%735) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %737 = "llvm.bitcast"(%736) : (vector<2xf16>) -> i32
    %738 = "llvm.insertelement"(%729, %737, %728) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %739 = "llvm.extractelement"(%733, %727) : (vector<2xi16>, i64) -> i16
    %740 = "llvm.bitcast"(%739) : (i16) -> vector<2xi8>
    %741 = "nvvm.convert.f8x2.to.f16x2"(%740) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %742 = "llvm.bitcast"(%741) : (vector<2xf16>) -> i32
    %743 = "llvm.insertelement"(%738, %742, %727) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %744 = "llvm.bitcast"(%743) : (vector<2xi32>) -> vector<4xf16>
    %745 = "llvm.fpext"(%744) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    "func.return"(%745) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E5M2>) -> vector<4xf32>, sym_name = "fpext_e5m2_to_f32"}> ({
  ^bb0(%arg25: vector<4xf8E5M2>):
    %708 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %709 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %710 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %711 = "builtin.unrealized_conversion_cast"(%arg25) : (vector<4xf8E5M2>) -> vector<4xi8>
    %712 = "llvm.bitcast"(%711) : (vector<4xi8>) -> vector<1xi32>
    %713 = "llvm.extractelement"(%712, %709) : (vector<1xi32>, i64) -> i32
    %714 = "llvm.bitcast"(%713) : (i32) -> vector<2xi16>
    %715 = "llvm.extractelement"(%714, %709) : (vector<2xi16>, i64) -> i16
    %716 = "llvm.bitcast"(%715) : (i16) -> vector<2xi8>
    %717 = "nvvm.convert.f8x2.to.f16x2"(%716) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %718 = "llvm.bitcast"(%717) : (vector<2xf16>) -> i32
    %719 = "llvm.insertelement"(%710, %718, %709) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %720 = "llvm.extractelement"(%714, %708) : (vector<2xi16>, i64) -> i16
    %721 = "llvm.bitcast"(%720) : (i16) -> vector<2xi8>
    %722 = "nvvm.convert.f8x2.to.f16x2"(%721) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %723 = "llvm.bitcast"(%722) : (vector<2xf16>) -> i32
    %724 = "llvm.insertelement"(%719, %723, %708) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %725 = "llvm.bitcast"(%724) : (vector<2xi32>) -> vector<4xf16>
    %726 = "llvm.fpext"(%725) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    "func.return"(%726) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E8M0FNU>) -> vector<4xf32>, sym_name = "fpext_e8m0_to_f32"}> ({
  ^bb0(%arg24: vector<4xf8E8M0FNU>):
    %689 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %690 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %691 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %692 = "builtin.unrealized_conversion_cast"(%arg24) : (vector<4xf8E8M0FNU>) -> vector<4xi8>
    %693 = "llvm.bitcast"(%692) : (vector<4xi8>) -> vector<1xi32>
    %694 = "llvm.extractelement"(%693, %690) : (vector<1xi32>, i64) -> i32
    %695 = "llvm.bitcast"(%694) : (i32) -> vector<2xi16>
    %696 = "llvm.extractelement"(%695, %690) : (vector<2xi16>, i64) -> i16
    %697 = "llvm.bitcast"(%696) : (i16) -> vector<2xi8>
    %698 = "nvvm.convert.f8x2.to.bf16x2"(%697) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f8E8M0FNU}> : (vector<2xi8>) -> vector<2xbf16>
    %699 = "llvm.bitcast"(%698) : (vector<2xbf16>) -> i32
    %700 = "llvm.insertelement"(%691, %699, %690) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %701 = "llvm.extractelement"(%695, %689) : (vector<2xi16>, i64) -> i16
    %702 = "llvm.bitcast"(%701) : (i16) -> vector<2xi8>
    %703 = "nvvm.convert.f8x2.to.bf16x2"(%702) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f8E8M0FNU}> : (vector<2xi8>) -> vector<2xbf16>
    %704 = "llvm.bitcast"(%703) : (vector<2xbf16>) -> i32
    %705 = "llvm.insertelement"(%700, %704, %689) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %706 = "llvm.bitcast"(%705) : (vector<2xi32>) -> vector<4xbf16>
    %707 = "llvm.fpext"(%706) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xbf16>) -> vector<4xf32>
    "func.return"(%707) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf6E2M3FN>) -> vector<4xf32>, sym_name = "fpext_e2m3_to_f32"}> ({
  ^bb0(%arg23: vector<4xf6E2M3FN>):
    %669 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %670 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %671 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %672 = "builtin.unrealized_conversion_cast"(%arg23) : (vector<4xf6E2M3FN>) -> vector<4xi6>
    %673 = "llvm.zext"(%672) : (vector<4xi6>) -> vector<4xi8>
    %674 = "llvm.bitcast"(%673) : (vector<4xi8>) -> vector<1xi32>
    %675 = "llvm.extractelement"(%674, %670) : (vector<1xi32>, i64) -> i32
    %676 = "llvm.bitcast"(%675) : (i32) -> vector<2xi16>
    %677 = "llvm.extractelement"(%676, %670) : (vector<2xi16>, i64) -> i16
    %678 = "llvm.bitcast"(%677) : (i16) -> vector<2xi8>
    %679 = "nvvm.convert.f6x2.to.f16x2"(%678) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %680 = "llvm.bitcast"(%679) : (vector<2xf16>) -> i32
    %681 = "llvm.insertelement"(%671, %680, %670) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %682 = "llvm.extractelement"(%676, %669) : (vector<2xi16>, i64) -> i16
    %683 = "llvm.bitcast"(%682) : (i16) -> vector<2xi8>
    %684 = "nvvm.convert.f6x2.to.f16x2"(%683) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %685 = "llvm.bitcast"(%684) : (vector<2xf16>) -> i32
    %686 = "llvm.insertelement"(%681, %685, %669) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %687 = "llvm.bitcast"(%686) : (vector<2xi32>) -> vector<4xf16>
    %688 = "llvm.fpext"(%687) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    "func.return"(%688) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>) -> vector<8xf32>, sym_name = "fpext_e2m1_to_f32"}> ({
  ^bb0(%arg22: vector<8xf4E2M1FN>):
    %642 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %643 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %644 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %645 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %646 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %647 = "builtin.unrealized_conversion_cast"(%arg22) : (vector<8xf4E2M1FN>) -> vector<8xi4>
    %648 = "llvm.bitcast"(%647) : (vector<8xi4>) -> vector<1xi32>
    %649 = "llvm.extractelement"(%648, %645) : (vector<1xi32>, i64) -> i32
    %650 = "llvm.bitcast"(%649) : (i32) -> vector<4xi8>
    %651 = "llvm.extractelement"(%650, %645) : (vector<4xi8>, i64) -> i8
    %652 = "nvvm.convert.f4x2.to.f16x2"(%651) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %653 = "llvm.bitcast"(%652) : (vector<2xf16>) -> i32
    %654 = "llvm.insertelement"(%646, %653, %645) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %655 = "llvm.extractelement"(%650, %644) : (vector<4xi8>, i64) -> i8
    %656 = "nvvm.convert.f4x2.to.f16x2"(%655) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %657 = "llvm.bitcast"(%656) : (vector<2xf16>) -> i32
    %658 = "llvm.insertelement"(%654, %657, %644) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %659 = "llvm.extractelement"(%650, %643) : (vector<4xi8>, i64) -> i8
    %660 = "nvvm.convert.f4x2.to.f16x2"(%659) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %661 = "llvm.bitcast"(%660) : (vector<2xf16>) -> i32
    %662 = "llvm.insertelement"(%658, %661, %643) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %663 = "llvm.extractelement"(%650, %642) : (vector<4xi8>, i64) -> i8
    %664 = "nvvm.convert.f4x2.to.f16x2"(%663) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %665 = "llvm.bitcast"(%664) : (vector<2xf16>) -> i32
    %666 = "llvm.insertelement"(%662, %665, %642) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %667 = "llvm.bitcast"(%666) : (vector<4xi32>) -> vector<8xf16>
    %668 = "llvm.fpext"(%667) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf16>) -> vector<8xf32>
    "func.return"(%668) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf32>, sym_name = "fpext_f16_to_f32"}> ({
  ^bb0(%arg21: vector<4xf16>):
    %641 = "llvm.fpext"(%arg21) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    "func.return"(%641) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xbf16>) -> vector<4xf32>, sym_name = "fpext_bf16_to_f32"}> ({
  ^bb0(%arg20: vector<4xbf16>):
    %640 = "llvm.fpext"(%arg20) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xbf16>) -> vector<4xf32>
    "func.return"(%640) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf64>, sym_name = "fpext_f16_to_f64"}> ({
  ^bb0(%arg19: vector<4xf16>):
    %639 = "llvm.fpext"(%arg19) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf64>
    "func.return"(%639) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xbf16>) -> vector<4xf64>, sym_name = "fpext_bf16_to_f64"}> ({
  ^bb0(%arg18: vector<4xbf16>):
    %638 = "llvm.fpext"(%arg18) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xbf16>) -> vector<4xf64>
    "func.return"(%638) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf64>, sym_name = "fpext_f32_to_f64"}> ({
  ^bb0(%arg17: vector<4xf32>):
    %637 = "llvm.fpext"(%arg17) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>) -> vector<4xf64>
    "func.return"(%637) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>) -> vector<4xf64>, sym_name = "fpext_f8_to_f64"}> ({
  ^bb0(%arg16: vector<4xf8E4M3FN>):
    %597 = "builtin.unrealized_conversion_cast"(%arg16) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %598 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %599 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %600 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %601 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %602 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %603 = "arith.constant"() <{value = dense<0.000000e+00> : vector<8xf8E4M3FN>}> : () -> vector<8xf8E4M3FN>
    %604 = "builtin.unrealized_conversion_cast"(%603) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %605 = "llvm.shufflevector"(%597, %597) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xi8>, vector<4xi8>) -> vector<8xi8>
    %606 = "llvm.shufflevector"(%605, %604) <{mask = array<i32: 0, 1, 2, 3, 12, 13, 14, 15>}> : (vector<8xi8>, vector<8xi8>) -> vector<8xi8>
    %607 = "builtin.unrealized_conversion_cast"(%606) : (vector<8xi8>) -> vector<8xf8E4M3FN>
    %608 = "builtin.unrealized_conversion_cast"(%607) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %609 = "llvm.bitcast"(%608) : (vector<8xi8>) -> vector<2xi32>
    %610 = "llvm.extractelement"(%609, %601) : (vector<2xi32>, i64) -> i32
    %611 = "llvm.bitcast"(%610) : (i32) -> vector<2xi16>
    %612 = "llvm.extractelement"(%611, %601) : (vector<2xi16>, i64) -> i16
    %613 = "llvm.bitcast"(%612) : (i16) -> vector<2xi8>
    %614 = "nvvm.convert.f8x2.to.f16x2"(%613) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %615 = "llvm.bitcast"(%614) : (vector<2xf16>) -> i32
    %616 = "llvm.insertelement"(%602, %615, %601) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %617 = "llvm.extractelement"(%611, %600) : (vector<2xi16>, i64) -> i16
    %618 = "llvm.bitcast"(%617) : (i16) -> vector<2xi8>
    %619 = "nvvm.convert.f8x2.to.f16x2"(%618) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %620 = "llvm.bitcast"(%619) : (vector<2xf16>) -> i32
    %621 = "llvm.insertelement"(%616, %620, %600) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %622 = "llvm.extractelement"(%609, %600) : (vector<2xi32>, i64) -> i32
    %623 = "llvm.bitcast"(%622) : (i32) -> vector<2xi16>
    %624 = "llvm.extractelement"(%623, %601) : (vector<2xi16>, i64) -> i16
    %625 = "llvm.bitcast"(%624) : (i16) -> vector<2xi8>
    %626 = "nvvm.convert.f8x2.to.f16x2"(%625) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %627 = "llvm.bitcast"(%626) : (vector<2xf16>) -> i32
    %628 = "llvm.insertelement"(%621, %627, %599) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %629 = "llvm.extractelement"(%623, %600) : (vector<2xi16>, i64) -> i16
    %630 = "llvm.bitcast"(%629) : (i16) -> vector<2xi8>
    %631 = "nvvm.convert.f8x2.to.f16x2"(%630) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %632 = "llvm.bitcast"(%631) : (vector<2xf16>) -> i32
    %633 = "llvm.insertelement"(%628, %632, %598) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %634 = "llvm.bitcast"(%633) : (vector<4xi32>) -> vector<8xf16>
    %635 = "llvm.fpext"(%634) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf16>) -> vector<8xf64>
    %636 = "llvm.shufflevector"(%635, %635) <{mask = array<i32: 0, 1, 2, 3>}> : (vector<8xf64>, vector<8xf64>) -> vector<4xf64>
    "func.return"(%636) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>) -> vector<8xf64>, sym_name = "fpext_f4_to_f64"}> ({
  ^bb0(%arg15: vector<8xf4E2M1FN>):
    %541 = "builtin.unrealized_conversion_cast"(%arg15) : (vector<8xf4E2M1FN>) -> vector<8xi4>
    %542 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %543 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %544 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %545 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %546 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %547 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %548 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %549 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %550 = "llvm.mlir.undef"() : () -> vector<8xi32>
    %551 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16xf4E2M1FN>}> : () -> vector<16xf4E2M1FN>
    %552 = "builtin.unrealized_conversion_cast"(%551) : (vector<16xf4E2M1FN>) -> vector<16xi4>
    %553 = "llvm.shufflevector"(%541, %541) <{mask = array<i32: 0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<8xi4>, vector<8xi4>) -> vector<16xi4>
    %554 = "llvm.shufflevector"(%553, %552) <{mask = array<i32: 0, 1, 2, 3, 4, 5, 6, 7, 24, 25, 26, 27, 28, 29, 30, 31>}> : (vector<16xi4>, vector<16xi4>) -> vector<16xi4>
    %555 = "builtin.unrealized_conversion_cast"(%554) : (vector<16xi4>) -> vector<16xf4E2M1FN>
    %556 = "builtin.unrealized_conversion_cast"(%555) : (vector<16xf4E2M1FN>) -> vector<16xi4>
    %557 = "llvm.bitcast"(%556) : (vector<16xi4>) -> vector<2xi32>
    %558 = "llvm.extractelement"(%557, %549) : (vector<2xi32>, i64) -> i32
    %559 = "llvm.bitcast"(%558) : (i32) -> vector<4xi8>
    %560 = "llvm.extractelement"(%559, %549) : (vector<4xi8>, i64) -> i8
    %561 = "nvvm.convert.f4x2.to.f16x2"(%560) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %562 = "llvm.bitcast"(%561) : (vector<2xf16>) -> i32
    %563 = "llvm.insertelement"(%550, %562, %549) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %564 = "llvm.extractelement"(%559, %548) : (vector<4xi8>, i64) -> i8
    %565 = "nvvm.convert.f4x2.to.f16x2"(%564) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %566 = "llvm.bitcast"(%565) : (vector<2xf16>) -> i32
    %567 = "llvm.insertelement"(%563, %566, %548) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %568 = "llvm.extractelement"(%559, %547) : (vector<4xi8>, i64) -> i8
    %569 = "nvvm.convert.f4x2.to.f16x2"(%568) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %570 = "llvm.bitcast"(%569) : (vector<2xf16>) -> i32
    %571 = "llvm.insertelement"(%567, %570, %547) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %572 = "llvm.extractelement"(%559, %546) : (vector<4xi8>, i64) -> i8
    %573 = "nvvm.convert.f4x2.to.f16x2"(%572) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %574 = "llvm.bitcast"(%573) : (vector<2xf16>) -> i32
    %575 = "llvm.insertelement"(%571, %574, %546) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %576 = "llvm.extractelement"(%557, %548) : (vector<2xi32>, i64) -> i32
    %577 = "llvm.bitcast"(%576) : (i32) -> vector<4xi8>
    %578 = "llvm.extractelement"(%577, %549) : (vector<4xi8>, i64) -> i8
    %579 = "nvvm.convert.f4x2.to.f16x2"(%578) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %580 = "llvm.bitcast"(%579) : (vector<2xf16>) -> i32
    %581 = "llvm.insertelement"(%575, %580, %545) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %582 = "llvm.extractelement"(%577, %548) : (vector<4xi8>, i64) -> i8
    %583 = "nvvm.convert.f4x2.to.f16x2"(%582) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %584 = "llvm.bitcast"(%583) : (vector<2xf16>) -> i32
    %585 = "llvm.insertelement"(%581, %584, %544) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %586 = "llvm.extractelement"(%577, %547) : (vector<4xi8>, i64) -> i8
    %587 = "nvvm.convert.f4x2.to.f16x2"(%586) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %588 = "llvm.bitcast"(%587) : (vector<2xf16>) -> i32
    %589 = "llvm.insertelement"(%585, %588, %543) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %590 = "llvm.extractelement"(%577, %546) : (vector<4xi8>, i64) -> i8
    %591 = "nvvm.convert.f4x2.to.f16x2"(%590) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %592 = "llvm.bitcast"(%591) : (vector<2xf16>) -> i32
    %593 = "llvm.insertelement"(%589, %592, %542) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %594 = "llvm.bitcast"(%593) : (vector<8xi32>) -> vector<16xf16>
    %595 = "llvm.fpext"(%594) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<16xf16>) -> vector<16xf64>
    %596 = "llvm.shufflevector"(%595, %595) <{mask = array<i32: 0, 1, 2, 3, 4, 5, 6, 7>}> : (vector<16xf64>, vector<16xf64>) -> vector<8xf64>
    "func.return"(%596) : (vector<8xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf6E2M3FN>) -> vector<4xf64>, sym_name = "fpext_e2m3_to_f64"}> ({
  ^bb0(%arg14: vector<4xf6E2M3FN>):
    %500 = "builtin.unrealized_conversion_cast"(%arg14) : (vector<4xf6E2M3FN>) -> vector<4xi6>
    %501 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %502 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %503 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %504 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %505 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %506 = "arith.constant"() <{value = dense<0.000000e+00> : vector<8xf6E2M3FN>}> : () -> vector<8xf6E2M3FN>
    %507 = "builtin.unrealized_conversion_cast"(%506) : (vector<8xf6E2M3FN>) -> vector<8xi6>
    %508 = "llvm.shufflevector"(%500, %500) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xi6>, vector<4xi6>) -> vector<8xi6>
    %509 = "llvm.shufflevector"(%508, %507) <{mask = array<i32: 0, 1, 2, 3, 12, 13, 14, 15>}> : (vector<8xi6>, vector<8xi6>) -> vector<8xi6>
    %510 = "builtin.unrealized_conversion_cast"(%509) : (vector<8xi6>) -> vector<8xf6E2M3FN>
    %511 = "builtin.unrealized_conversion_cast"(%510) : (vector<8xf6E2M3FN>) -> vector<8xi6>
    %512 = "llvm.zext"(%511) : (vector<8xi6>) -> vector<8xi8>
    %513 = "llvm.bitcast"(%512) : (vector<8xi8>) -> vector<2xi32>
    %514 = "llvm.extractelement"(%513, %504) : (vector<2xi32>, i64) -> i32
    %515 = "llvm.bitcast"(%514) : (i32) -> vector<2xi16>
    %516 = "llvm.extractelement"(%515, %504) : (vector<2xi16>, i64) -> i16
    %517 = "llvm.bitcast"(%516) : (i16) -> vector<2xi8>
    %518 = "nvvm.convert.f6x2.to.f16x2"(%517) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %519 = "llvm.bitcast"(%518) : (vector<2xf16>) -> i32
    %520 = "llvm.insertelement"(%505, %519, %504) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %521 = "llvm.extractelement"(%515, %503) : (vector<2xi16>, i64) -> i16
    %522 = "llvm.bitcast"(%521) : (i16) -> vector<2xi8>
    %523 = "nvvm.convert.f6x2.to.f16x2"(%522) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %524 = "llvm.bitcast"(%523) : (vector<2xf16>) -> i32
    %525 = "llvm.insertelement"(%520, %524, %503) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %526 = "llvm.extractelement"(%513, %503) : (vector<2xi32>, i64) -> i32
    %527 = "llvm.bitcast"(%526) : (i32) -> vector<2xi16>
    %528 = "llvm.extractelement"(%527, %504) : (vector<2xi16>, i64) -> i16
    %529 = "llvm.bitcast"(%528) : (i16) -> vector<2xi8>
    %530 = "nvvm.convert.f6x2.to.f16x2"(%529) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %531 = "llvm.bitcast"(%530) : (vector<2xf16>) -> i32
    %532 = "llvm.insertelement"(%525, %531, %502) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %533 = "llvm.extractelement"(%527, %503) : (vector<2xi16>, i64) -> i16
    %534 = "llvm.bitcast"(%533) : (i16) -> vector<2xi8>
    %535 = "nvvm.convert.f6x2.to.f16x2"(%534) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %536 = "llvm.bitcast"(%535) : (vector<2xf16>) -> i32
    %537 = "llvm.insertelement"(%532, %536, %501) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %538 = "llvm.bitcast"(%537) : (vector<4xi32>) -> vector<8xf16>
    %539 = "llvm.fpext"(%538) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf16>) -> vector<8xf64>
    %540 = "llvm.shufflevector"(%539, %539) <{mask = array<i32: 0, 1, 2, 3>}> : (vector<8xf64>, vector<8xf64>) -> vector<4xf64>
    "func.return"(%540) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f8E4M3FN) -> f16, sym_name = "fpext_scalar_f8_to_f16"}> ({
  ^bb0(%arg13: f8E4M3FN):
    %471 = "builtin.unrealized_conversion_cast"(%arg13) : (f8E4M3FN) -> i8
    %472 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %473 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %474 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %475 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %476 = "builtin.unrealized_conversion_cast"(%475) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %477 = "llvm.mlir.poison"() : () -> vector<1xi8>
    %478 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %479 = "llvm.insertelement"(%477, %471, %478) : (vector<1xi8>, i8, i32) -> vector<1xi8>
    %480 = "llvm.shufflevector"(%479, %479) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<1xi8>, vector<1xi8>) -> vector<4xi8>
    %481 = "llvm.shufflevector"(%480, %476) <{mask = array<i32: 0, 5, 6, 7>}> : (vector<4xi8>, vector<4xi8>) -> vector<4xi8>
    %482 = "builtin.unrealized_conversion_cast"(%481) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    %483 = "builtin.unrealized_conversion_cast"(%482) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %484 = "llvm.bitcast"(%483) : (vector<4xi8>) -> vector<1xi32>
    %485 = "llvm.extractelement"(%484, %473) : (vector<1xi32>, i64) -> i32
    %486 = "llvm.bitcast"(%485) : (i32) -> vector<2xi16>
    %487 = "llvm.extractelement"(%486, %473) : (vector<2xi16>, i64) -> i16
    %488 = "llvm.bitcast"(%487) : (i16) -> vector<2xi8>
    %489 = "nvvm.convert.f8x2.to.f16x2"(%488) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %490 = "llvm.bitcast"(%489) : (vector<2xf16>) -> i32
    %491 = "llvm.insertelement"(%474, %490, %473) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %492 = "llvm.extractelement"(%486, %472) : (vector<2xi16>, i64) -> i16
    %493 = "llvm.bitcast"(%492) : (i16) -> vector<2xi8>
    %494 = "nvvm.convert.f8x2.to.f16x2"(%493) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %495 = "llvm.bitcast"(%494) : (vector<2xf16>) -> i32
    %496 = "llvm.insertelement"(%491, %495, %472) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %497 = "llvm.bitcast"(%496) : (vector<2xi32>) -> vector<4xf16>
    %498 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %499 = "llvm.extractelement"(%497, %498) : (vector<4xf16>, i64) -> f16
    "func.return"(%499) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f8E4M3FN) -> f32, sym_name = "fpext_scalar_f8_to_f32"}> ({
  ^bb0(%arg12: f8E4M3FN):
    %441 = "builtin.unrealized_conversion_cast"(%arg12) : (f8E4M3FN) -> i8
    %442 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %443 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %444 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %445 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %446 = "builtin.unrealized_conversion_cast"(%445) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %447 = "llvm.mlir.poison"() : () -> vector<1xi8>
    %448 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %449 = "llvm.insertelement"(%447, %441, %448) : (vector<1xi8>, i8, i32) -> vector<1xi8>
    %450 = "llvm.shufflevector"(%449, %449) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<1xi8>, vector<1xi8>) -> vector<4xi8>
    %451 = "llvm.shufflevector"(%450, %446) <{mask = array<i32: 0, 5, 6, 7>}> : (vector<4xi8>, vector<4xi8>) -> vector<4xi8>
    %452 = "builtin.unrealized_conversion_cast"(%451) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    %453 = "builtin.unrealized_conversion_cast"(%452) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %454 = "llvm.bitcast"(%453) : (vector<4xi8>) -> vector<1xi32>
    %455 = "llvm.extractelement"(%454, %443) : (vector<1xi32>, i64) -> i32
    %456 = "llvm.bitcast"(%455) : (i32) -> vector<2xi16>
    %457 = "llvm.extractelement"(%456, %443) : (vector<2xi16>, i64) -> i16
    %458 = "llvm.bitcast"(%457) : (i16) -> vector<2xi8>
    %459 = "nvvm.convert.f8x2.to.f16x2"(%458) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %460 = "llvm.bitcast"(%459) : (vector<2xf16>) -> i32
    %461 = "llvm.insertelement"(%444, %460, %443) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %462 = "llvm.extractelement"(%456, %442) : (vector<2xi16>, i64) -> i16
    %463 = "llvm.bitcast"(%462) : (i16) -> vector<2xi8>
    %464 = "nvvm.convert.f8x2.to.f16x2"(%463) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %465 = "llvm.bitcast"(%464) : (vector<2xf16>) -> i32
    %466 = "llvm.insertelement"(%461, %465, %442) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %467 = "llvm.bitcast"(%466) : (vector<2xi32>) -> vector<4xf16>
    %468 = "llvm.fpext"(%467) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    %469 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %470 = "llvm.extractelement"(%468, %469) : (vector<4xf32>, i64) -> f32
    "func.return"(%470) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf8E4M3FN>) -> vector<2x4xf16>, sym_name = "fpext_v2x4_f8_to_f16"}> ({
  ^bb0(%arg11: vector<2x4xf8E4M3FN>):
    %392 = "builtin.unrealized_conversion_cast"(%arg11) : (vector<2x4xf8E4M3FN>) -> !llvm.array<2 x vector<4xi8>>
    %393 = "ub.poison"() <{value = #ub.poison}> : () -> vector<2x4xf16>
    %394 = "builtin.unrealized_conversion_cast"(%393) : (vector<2x4xf16>) -> !llvm.array<2 x vector<4xf16>>
    %395 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %396 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %397 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %398 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %399 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %400 = "ub.poison"() <{value = #ub.poison}> : () -> vector<8xf8E4M3FN>
    %401 = "builtin.unrealized_conversion_cast"(%400) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %402 = "llvm.extractvalue"(%392) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xi8>>) -> vector<4xi8>
    %403 = "llvm.shufflevector"(%402, %402) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xi8>, vector<4xi8>) -> vector<8xi8>
    %404 = "llvm.shufflevector"(%403, %401) <{mask = array<i32: 0, 1, 2, 3, -1, -1, -1, -1>}> : (vector<8xi8>, vector<8xi8>) -> vector<8xi8>
    %405 = "llvm.extractvalue"(%392) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xi8>>) -> vector<4xi8>
    %406 = "llvm.shufflevector"(%405, %405) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xi8>, vector<4xi8>) -> vector<8xi8>
    %407 = "llvm.shufflevector"(%406, %404) <{mask = array<i32: 8, 9, 10, 11, 0, 1, 2, 3>}> : (vector<8xi8>, vector<8xi8>) -> vector<8xi8>
    %408 = "builtin.unrealized_conversion_cast"(%407) : (vector<8xi8>) -> vector<8xf8E4M3FN>
    %409 = "builtin.unrealized_conversion_cast"(%408) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %410 = "llvm.bitcast"(%409) : (vector<8xi8>) -> vector<2xi32>
    %411 = "llvm.extractelement"(%410, %398) : (vector<2xi32>, i64) -> i32
    %412 = "llvm.bitcast"(%411) : (i32) -> vector<2xi16>
    %413 = "llvm.extractelement"(%412, %398) : (vector<2xi16>, i64) -> i16
    %414 = "llvm.bitcast"(%413) : (i16) -> vector<2xi8>
    %415 = "nvvm.convert.f8x2.to.f16x2"(%414) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %416 = "llvm.bitcast"(%415) : (vector<2xf16>) -> i32
    %417 = "llvm.insertelement"(%399, %416, %398) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %418 = "llvm.extractelement"(%412, %397) : (vector<2xi16>, i64) -> i16
    %419 = "llvm.bitcast"(%418) : (i16) -> vector<2xi8>
    %420 = "nvvm.convert.f8x2.to.f16x2"(%419) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %421 = "llvm.bitcast"(%420) : (vector<2xf16>) -> i32
    %422 = "llvm.insertelement"(%417, %421, %397) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %423 = "llvm.extractelement"(%410, %397) : (vector<2xi32>, i64) -> i32
    %424 = "llvm.bitcast"(%423) : (i32) -> vector<2xi16>
    %425 = "llvm.extractelement"(%424, %398) : (vector<2xi16>, i64) -> i16
    %426 = "llvm.bitcast"(%425) : (i16) -> vector<2xi8>
    %427 = "nvvm.convert.f8x2.to.f16x2"(%426) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %428 = "llvm.bitcast"(%427) : (vector<2xf16>) -> i32
    %429 = "llvm.insertelement"(%422, %428, %396) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %430 = "llvm.extractelement"(%424, %397) : (vector<2xi16>, i64) -> i16
    %431 = "llvm.bitcast"(%430) : (i16) -> vector<2xi8>
    %432 = "nvvm.convert.f8x2.to.f16x2"(%431) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %433 = "llvm.bitcast"(%432) : (vector<2xf16>) -> i32
    %434 = "llvm.insertelement"(%429, %433, %395) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %435 = "llvm.bitcast"(%434) : (vector<4xi32>) -> vector<8xf16>
    %436 = "llvm.shufflevector"(%435, %435) <{mask = array<i32: 0, 1, 2, 3>}> : (vector<8xf16>, vector<8xf16>) -> vector<4xf16>
    %437 = "llvm.insertvalue"(%394, %436) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf16>>, vector<4xf16>) -> !llvm.array<2 x vector<4xf16>>
    %438 = "llvm.shufflevector"(%435, %435) <{mask = array<i32: 4, 5, 6, 7>}> : (vector<8xf16>, vector<8xf16>) -> vector<4xf16>
    %439 = "llvm.insertvalue"(%437, %438) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf16>>, vector<4xf16>) -> !llvm.array<2 x vector<4xf16>>
    %440 = "builtin.unrealized_conversion_cast"(%439) : (!llvm.array<2 x vector<4xf16>>) -> vector<2x4xf16>
    "func.return"(%440) : (vector<2x4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf8E4M3FN>) -> vector<2x4xf32>, sym_name = "fpext_v2x4_f8_to_f32"}> ({
  ^bb0(%arg10: vector<2x4xf8E4M3FN>):
    %342 = "builtin.unrealized_conversion_cast"(%arg10) : (vector<2x4xf8E4M3FN>) -> !llvm.array<2 x vector<4xi8>>
    %343 = "ub.poison"() <{value = #ub.poison}> : () -> vector<2x4xf32>
    %344 = "builtin.unrealized_conversion_cast"(%343) : (vector<2x4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %345 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %346 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %347 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %348 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %349 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %350 = "ub.poison"() <{value = #ub.poison}> : () -> vector<8xf8E4M3FN>
    %351 = "builtin.unrealized_conversion_cast"(%350) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %352 = "llvm.extractvalue"(%342) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xi8>>) -> vector<4xi8>
    %353 = "llvm.shufflevector"(%352, %352) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xi8>, vector<4xi8>) -> vector<8xi8>
    %354 = "llvm.shufflevector"(%353, %351) <{mask = array<i32: 0, 1, 2, 3, -1, -1, -1, -1>}> : (vector<8xi8>, vector<8xi8>) -> vector<8xi8>
    %355 = "llvm.extractvalue"(%342) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xi8>>) -> vector<4xi8>
    %356 = "llvm.shufflevector"(%355, %355) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xi8>, vector<4xi8>) -> vector<8xi8>
    %357 = "llvm.shufflevector"(%356, %354) <{mask = array<i32: 8, 9, 10, 11, 0, 1, 2, 3>}> : (vector<8xi8>, vector<8xi8>) -> vector<8xi8>
    %358 = "builtin.unrealized_conversion_cast"(%357) : (vector<8xi8>) -> vector<8xf8E4M3FN>
    %359 = "builtin.unrealized_conversion_cast"(%358) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %360 = "llvm.bitcast"(%359) : (vector<8xi8>) -> vector<2xi32>
    %361 = "llvm.extractelement"(%360, %348) : (vector<2xi32>, i64) -> i32
    %362 = "llvm.bitcast"(%361) : (i32) -> vector<2xi16>
    %363 = "llvm.extractelement"(%362, %348) : (vector<2xi16>, i64) -> i16
    %364 = "llvm.bitcast"(%363) : (i16) -> vector<2xi8>
    %365 = "nvvm.convert.f8x2.to.f16x2"(%364) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %366 = "llvm.bitcast"(%365) : (vector<2xf16>) -> i32
    %367 = "llvm.insertelement"(%349, %366, %348) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %368 = "llvm.extractelement"(%362, %347) : (vector<2xi16>, i64) -> i16
    %369 = "llvm.bitcast"(%368) : (i16) -> vector<2xi8>
    %370 = "nvvm.convert.f8x2.to.f16x2"(%369) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %371 = "llvm.bitcast"(%370) : (vector<2xf16>) -> i32
    %372 = "llvm.insertelement"(%367, %371, %347) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %373 = "llvm.extractelement"(%360, %347) : (vector<2xi32>, i64) -> i32
    %374 = "llvm.bitcast"(%373) : (i32) -> vector<2xi16>
    %375 = "llvm.extractelement"(%374, %348) : (vector<2xi16>, i64) -> i16
    %376 = "llvm.bitcast"(%375) : (i16) -> vector<2xi8>
    %377 = "nvvm.convert.f8x2.to.f16x2"(%376) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %378 = "llvm.bitcast"(%377) : (vector<2xf16>) -> i32
    %379 = "llvm.insertelement"(%372, %378, %346) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %380 = "llvm.extractelement"(%374, %347) : (vector<2xi16>, i64) -> i16
    %381 = "llvm.bitcast"(%380) : (i16) -> vector<2xi8>
    %382 = "nvvm.convert.f8x2.to.f16x2"(%381) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %383 = "llvm.bitcast"(%382) : (vector<2xf16>) -> i32
    %384 = "llvm.insertelement"(%379, %383, %345) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %385 = "llvm.bitcast"(%384) : (vector<4xi32>) -> vector<8xf16>
    %386 = "llvm.fpext"(%385) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf16>) -> vector<8xf32>
    %387 = "llvm.shufflevector"(%386, %386) <{mask = array<i32: 0, 1, 2, 3>}> : (vector<8xf32>, vector<8xf32>) -> vector<4xf32>
    %388 = "llvm.insertvalue"(%344, %387) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %389 = "llvm.shufflevector"(%386, %386) <{mask = array<i32: 4, 5, 6, 7>}> : (vector<8xf32>, vector<8xf32>) -> vector<4xf32>
    %390 = "llvm.insertvalue"(%388, %389) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %391 = "builtin.unrealized_conversion_cast"(%390) : (!llvm.array<2 x vector<4xf32>>) -> vector<2x4xf32>
    "func.return"(%391) : (vector<2x4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf8E5M2>) -> vector<3xf16>, sym_name = "fpext_v3f8_to_v3f16"}> ({
  ^bb0(%arg9: vector<3xf8E5M2>):
    %317 = "builtin.unrealized_conversion_cast"(%arg9) : (vector<3xf8E5M2>) -> vector<3xi8>
    %318 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %319 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %320 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %321 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E5M2>}> : () -> vector<4xf8E5M2>
    %322 = "builtin.unrealized_conversion_cast"(%321) : (vector<4xf8E5M2>) -> vector<4xi8>
    %323 = "llvm.shufflevector"(%317, %317) <{mask = array<i32: 0, 1, 2, 0>}> : (vector<3xi8>, vector<3xi8>) -> vector<4xi8>
    %324 = "llvm.shufflevector"(%323, %322) <{mask = array<i32: 0, 1, 2, 7>}> : (vector<4xi8>, vector<4xi8>) -> vector<4xi8>
    %325 = "builtin.unrealized_conversion_cast"(%324) : (vector<4xi8>) -> vector<4xf8E5M2>
    %326 = "builtin.unrealized_conversion_cast"(%325) : (vector<4xf8E5M2>) -> vector<4xi8>
    %327 = "llvm.bitcast"(%326) : (vector<4xi8>) -> vector<1xi32>
    %328 = "llvm.extractelement"(%327, %319) : (vector<1xi32>, i64) -> i32
    %329 = "llvm.bitcast"(%328) : (i32) -> vector<2xi16>
    %330 = "llvm.extractelement"(%329, %319) : (vector<2xi16>, i64) -> i16
    %331 = "llvm.bitcast"(%330) : (i16) -> vector<2xi8>
    %332 = "nvvm.convert.f8x2.to.f16x2"(%331) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %333 = "llvm.bitcast"(%332) : (vector<2xf16>) -> i32
    %334 = "llvm.insertelement"(%320, %333, %319) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %335 = "llvm.extractelement"(%329, %318) : (vector<2xi16>, i64) -> i16
    %336 = "llvm.bitcast"(%335) : (i16) -> vector<2xi8>
    %337 = "nvvm.convert.f8x2.to.f16x2"(%336) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %338 = "llvm.bitcast"(%337) : (vector<2xf16>) -> i32
    %339 = "llvm.insertelement"(%334, %338, %318) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %340 = "llvm.bitcast"(%339) : (vector<2xi32>) -> vector<4xf16>
    %341 = "llvm.shufflevector"(%340, %340) <{mask = array<i32: 0, 1, 2>}> : (vector<4xf16>, vector<4xf16>) -> vector<3xf16>
    "func.return"(%341) : (vector<3xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf8E5M2>) -> vector<3xf32>, sym_name = "fpext_v3_f8_to_f32"}> ({
  ^bb0(%arg8: vector<3xf8E5M2>):
    %291 = "builtin.unrealized_conversion_cast"(%arg8) : (vector<3xf8E5M2>) -> vector<3xi8>
    %292 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %293 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %294 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %295 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E5M2>}> : () -> vector<4xf8E5M2>
    %296 = "builtin.unrealized_conversion_cast"(%295) : (vector<4xf8E5M2>) -> vector<4xi8>
    %297 = "llvm.shufflevector"(%291, %291) <{mask = array<i32: 0, 1, 2, 0>}> : (vector<3xi8>, vector<3xi8>) -> vector<4xi8>
    %298 = "llvm.shufflevector"(%297, %296) <{mask = array<i32: 0, 1, 2, 7>}> : (vector<4xi8>, vector<4xi8>) -> vector<4xi8>
    %299 = "builtin.unrealized_conversion_cast"(%298) : (vector<4xi8>) -> vector<4xf8E5M2>
    %300 = "builtin.unrealized_conversion_cast"(%299) : (vector<4xf8E5M2>) -> vector<4xi8>
    %301 = "llvm.bitcast"(%300) : (vector<4xi8>) -> vector<1xi32>
    %302 = "llvm.extractelement"(%301, %293) : (vector<1xi32>, i64) -> i32
    %303 = "llvm.bitcast"(%302) : (i32) -> vector<2xi16>
    %304 = "llvm.extractelement"(%303, %293) : (vector<2xi16>, i64) -> i16
    %305 = "llvm.bitcast"(%304) : (i16) -> vector<2xi8>
    %306 = "nvvm.convert.f8x2.to.f16x2"(%305) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %307 = "llvm.bitcast"(%306) : (vector<2xf16>) -> i32
    %308 = "llvm.insertelement"(%294, %307, %293) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %309 = "llvm.extractelement"(%303, %292) : (vector<2xi16>, i64) -> i16
    %310 = "llvm.bitcast"(%309) : (i16) -> vector<2xi8>
    %311 = "nvvm.convert.f8x2.to.f16x2"(%310) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %312 = "llvm.bitcast"(%311) : (vector<2xf16>) -> i32
    %313 = "llvm.insertelement"(%308, %312, %292) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %314 = "llvm.bitcast"(%313) : (vector<2xi32>) -> vector<4xf16>
    %315 = "llvm.fpext"(%314) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    %316 = "llvm.shufflevector"(%315, %315) <{mask = array<i32: 0, 1, 2>}> : (vector<4xf32>, vector<4xf32>) -> vector<3xf32>
    "func.return"(%316) : (vector<3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3x1xf8E4M3FN>) -> vector<3x1xf16>, sym_name = "fpext_v3x1_f8_to_f16"}> ({
  ^bb0(%arg7: vector<3x1xf8E4M3FN>):
    %229 = "builtin.unrealized_conversion_cast"(%arg7) : (vector<3x1xf8E4M3FN>) -> !llvm.array<3 x vector<1xi8>>
    %230 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x1xf16>
    %231 = "builtin.unrealized_conversion_cast"(%230) : (vector<3x1xf16>) -> !llvm.array<3 x vector<1xf16>>
    %232 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %233 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %234 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %235 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %236 = "builtin.unrealized_conversion_cast"(%235) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %237 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3xf8E4M3FN>
    %238 = "builtin.unrealized_conversion_cast"(%237) : (vector<3xf8E4M3FN>) -> vector<3xi8>
    %239 = "llvm.extractvalue"(%229) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<1xi8>>) -> vector<1xi8>
    %240 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %241 = "llvm.extractelement"(%239, %240) : (vector<1xi8>, i64) -> i8
    %242 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %243 = "llvm.insertelement"(%238, %241, %242) : (vector<3xi8>, i8, i64) -> vector<3xi8>
    %244 = "llvm.extractvalue"(%229) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<1xi8>>) -> vector<1xi8>
    %245 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %246 = "llvm.extractelement"(%244, %245) : (vector<1xi8>, i64) -> i8
    %247 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %248 = "llvm.insertelement"(%243, %246, %247) : (vector<3xi8>, i8, i64) -> vector<3xi8>
    %249 = "llvm.extractvalue"(%229) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<1xi8>>) -> vector<1xi8>
    %250 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %251 = "llvm.extractelement"(%249, %250) : (vector<1xi8>, i64) -> i8
    %252 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %253 = "llvm.insertelement"(%248, %251, %252) : (vector<3xi8>, i8, i64) -> vector<3xi8>
    %254 = "llvm.shufflevector"(%253, %253) <{mask = array<i32: 0, 1, 2, 0>}> : (vector<3xi8>, vector<3xi8>) -> vector<4xi8>
    %255 = "llvm.shufflevector"(%254, %236) <{mask = array<i32: 0, 1, 2, 7>}> : (vector<4xi8>, vector<4xi8>) -> vector<4xi8>
    %256 = "builtin.unrealized_conversion_cast"(%255) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    %257 = "builtin.unrealized_conversion_cast"(%256) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %258 = "llvm.bitcast"(%257) : (vector<4xi8>) -> vector<1xi32>
    %259 = "llvm.extractelement"(%258, %233) : (vector<1xi32>, i64) -> i32
    %260 = "llvm.bitcast"(%259) : (i32) -> vector<2xi16>
    %261 = "llvm.extractelement"(%260, %233) : (vector<2xi16>, i64) -> i16
    %262 = "llvm.bitcast"(%261) : (i16) -> vector<2xi8>
    %263 = "nvvm.convert.f8x2.to.f16x2"(%262) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %264 = "llvm.bitcast"(%263) : (vector<2xf16>) -> i32
    %265 = "llvm.insertelement"(%234, %264, %233) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %266 = "llvm.extractelement"(%260, %232) : (vector<2xi16>, i64) -> i16
    %267 = "llvm.bitcast"(%266) : (i16) -> vector<2xi8>
    %268 = "nvvm.convert.f8x2.to.f16x2"(%267) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %269 = "llvm.bitcast"(%268) : (vector<2xf16>) -> i32
    %270 = "llvm.insertelement"(%265, %269, %232) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %271 = "llvm.bitcast"(%270) : (vector<2xi32>) -> vector<4xf16>
    %272 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %273 = "llvm.extractelement"(%271, %272) : (vector<4xf16>, i64) -> f16
    %274 = "llvm.extractvalue"(%231) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<1xf16>>) -> vector<1xf16>
    %275 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %276 = "llvm.insertelement"(%274, %273, %275) : (vector<1xf16>, f16, i64) -> vector<1xf16>
    %277 = "llvm.insertvalue"(%231, %276) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<1xf16>>, vector<1xf16>) -> !llvm.array<3 x vector<1xf16>>
    %278 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %279 = "llvm.extractelement"(%271, %278) : (vector<4xf16>, i64) -> f16
    %280 = "llvm.extractvalue"(%277) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<1xf16>>) -> vector<1xf16>
    %281 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %282 = "llvm.insertelement"(%280, %279, %281) : (vector<1xf16>, f16, i64) -> vector<1xf16>
    %283 = "llvm.insertvalue"(%277, %282) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<1xf16>>, vector<1xf16>) -> !llvm.array<3 x vector<1xf16>>
    %284 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %285 = "llvm.extractelement"(%271, %284) : (vector<4xf16>, i64) -> f16
    %286 = "llvm.extractvalue"(%283) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<1xf16>>) -> vector<1xf16>
    %287 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %288 = "llvm.insertelement"(%286, %285, %287) : (vector<1xf16>, f16, i64) -> vector<1xf16>
    %289 = "llvm.insertvalue"(%283, %288) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<1xf16>>, vector<1xf16>) -> !llvm.array<3 x vector<1xf16>>
    %290 = "builtin.unrealized_conversion_cast"(%289) : (!llvm.array<3 x vector<1xf16>>) -> vector<3x1xf16>
    "func.return"(%290) : (vector<3x1xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf8E4M3FN>) -> (), sym_name = "fpext_f8_to_f16_relu"}> ({
  ^bb0(%arg6: vector<8xf8E4M3FN>):
    %209 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %210 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %211 = "builtin.unrealized_conversion_cast"(%arg6) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %212 = "llvm.bitcast"(%211) : (vector<8xi8>) -> vector<2xi32>
    %213 = "llvm.extractelement"(%212, %210) : (vector<2xi32>, i64) -> i32
    %214 = "llvm.bitcast"(%213) : (i32) -> vector<2xi16>
    %215 = "llvm.extractelement"(%214, %210) : (vector<2xi16>, i64) -> i16
    %216 = "llvm.bitcast"(%215) : (i16) -> vector<2xi8>
    %217 = "nvvm.convert.f8x2.to.f16x2"(%216) <{relu = true, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %218 = "llvm.extractelement"(%214, %209) : (vector<2xi16>, i64) -> i16
    %219 = "llvm.bitcast"(%218) : (i16) -> vector<2xi8>
    %220 = "nvvm.convert.f8x2.to.f16x2"(%219) <{relu = true, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %221 = "llvm.extractelement"(%212, %209) : (vector<2xi32>, i64) -> i32
    %222 = "llvm.bitcast"(%221) : (i32) -> vector<2xi16>
    %223 = "llvm.extractelement"(%222, %210) : (vector<2xi16>, i64) -> i16
    %224 = "llvm.bitcast"(%223) : (i16) -> vector<2xi8>
    %225 = "nvvm.convert.f8x2.to.f16x2"(%224) <{relu = true, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %226 = "llvm.extractelement"(%222, %209) : (vector<2xi16>, i64) -> i16
    %227 = "llvm.bitcast"(%226) : (i16) -> vector<2xi8>
    %228 = "nvvm.convert.f8x2.to.f16x2"(%227) <{relu = true, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f8E4M3FN) -> f16, sym_name = "e2e_scalar_f8_to_f16"}> ({
  ^bb0(%arg5: f8E4M3FN):
    %180 = "builtin.unrealized_conversion_cast"(%arg5) : (f8E4M3FN) -> i8
    %181 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %182 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %183 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %184 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %185 = "builtin.unrealized_conversion_cast"(%184) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %186 = "llvm.mlir.poison"() : () -> vector<1xi8>
    %187 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %188 = "llvm.insertelement"(%186, %180, %187) : (vector<1xi8>, i8, i32) -> vector<1xi8>
    %189 = "llvm.shufflevector"(%188, %188) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<1xi8>, vector<1xi8>) -> vector<4xi8>
    %190 = "llvm.shufflevector"(%189, %185) <{mask = array<i32: 0, 5, 6, 7>}> : (vector<4xi8>, vector<4xi8>) -> vector<4xi8>
    %191 = "builtin.unrealized_conversion_cast"(%190) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    %192 = "builtin.unrealized_conversion_cast"(%191) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %193 = "llvm.bitcast"(%192) : (vector<4xi8>) -> vector<1xi32>
    %194 = "llvm.extractelement"(%193, %182) : (vector<1xi32>, i64) -> i32
    %195 = "llvm.bitcast"(%194) : (i32) -> vector<2xi16>
    %196 = "llvm.extractelement"(%195, %182) : (vector<2xi16>, i64) -> i16
    %197 = "llvm.bitcast"(%196) : (i16) -> vector<2xi8>
    %198 = "nvvm.convert.f8x2.to.f16x2"(%197) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %199 = "llvm.bitcast"(%198) : (vector<2xf16>) -> i32
    %200 = "llvm.insertelement"(%183, %199, %182) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %201 = "llvm.extractelement"(%195, %181) : (vector<2xi16>, i64) -> i16
    %202 = "llvm.bitcast"(%201) : (i16) -> vector<2xi8>
    %203 = "nvvm.convert.f8x2.to.f16x2"(%202) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %204 = "llvm.bitcast"(%203) : (vector<2xf16>) -> i32
    %205 = "llvm.insertelement"(%200, %204, %181) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %206 = "llvm.bitcast"(%205) : (vector<2xi32>) -> vector<4xf16>
    %207 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %208 = "llvm.extractelement"(%206, %207) : (vector<4xf16>, i64) -> f16
    "func.return"(%208) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf8E4M3FN>) -> vector<2x4xf16>, sym_name = "e2e_v2x4_f8_to_f16"}> ({
  ^bb0(%arg4: vector<2x4xf8E4M3FN>):
    %131 = "builtin.unrealized_conversion_cast"(%arg4) : (vector<2x4xf8E4M3FN>) -> !llvm.array<2 x vector<4xi8>>
    %132 = "ub.poison"() <{value = #ub.poison}> : () -> vector<2x4xf16>
    %133 = "builtin.unrealized_conversion_cast"(%132) : (vector<2x4xf16>) -> !llvm.array<2 x vector<4xf16>>
    %134 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %135 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %136 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %137 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %138 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %139 = "ub.poison"() <{value = #ub.poison}> : () -> vector<8xf8E4M3FN>
    %140 = "builtin.unrealized_conversion_cast"(%139) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %141 = "llvm.extractvalue"(%131) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xi8>>) -> vector<4xi8>
    %142 = "llvm.shufflevector"(%141, %141) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xi8>, vector<4xi8>) -> vector<8xi8>
    %143 = "llvm.shufflevector"(%142, %140) <{mask = array<i32: 0, 1, 2, 3, -1, -1, -1, -1>}> : (vector<8xi8>, vector<8xi8>) -> vector<8xi8>
    %144 = "llvm.extractvalue"(%131) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xi8>>) -> vector<4xi8>
    %145 = "llvm.shufflevector"(%144, %144) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xi8>, vector<4xi8>) -> vector<8xi8>
    %146 = "llvm.shufflevector"(%145, %143) <{mask = array<i32: 8, 9, 10, 11, 0, 1, 2, 3>}> : (vector<8xi8>, vector<8xi8>) -> vector<8xi8>
    %147 = "builtin.unrealized_conversion_cast"(%146) : (vector<8xi8>) -> vector<8xf8E4M3FN>
    %148 = "builtin.unrealized_conversion_cast"(%147) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %149 = "llvm.bitcast"(%148) : (vector<8xi8>) -> vector<2xi32>
    %150 = "llvm.extractelement"(%149, %137) : (vector<2xi32>, i64) -> i32
    %151 = "llvm.bitcast"(%150) : (i32) -> vector<2xi16>
    %152 = "llvm.extractelement"(%151, %137) : (vector<2xi16>, i64) -> i16
    %153 = "llvm.bitcast"(%152) : (i16) -> vector<2xi8>
    %154 = "nvvm.convert.f8x2.to.f16x2"(%153) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %155 = "llvm.bitcast"(%154) : (vector<2xf16>) -> i32
    %156 = "llvm.insertelement"(%138, %155, %137) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %157 = "llvm.extractelement"(%151, %136) : (vector<2xi16>, i64) -> i16
    %158 = "llvm.bitcast"(%157) : (i16) -> vector<2xi8>
    %159 = "nvvm.convert.f8x2.to.f16x2"(%158) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %160 = "llvm.bitcast"(%159) : (vector<2xf16>) -> i32
    %161 = "llvm.insertelement"(%156, %160, %136) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %162 = "llvm.extractelement"(%149, %136) : (vector<2xi32>, i64) -> i32
    %163 = "llvm.bitcast"(%162) : (i32) -> vector<2xi16>
    %164 = "llvm.extractelement"(%163, %137) : (vector<2xi16>, i64) -> i16
    %165 = "llvm.bitcast"(%164) : (i16) -> vector<2xi8>
    %166 = "nvvm.convert.f8x2.to.f16x2"(%165) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %167 = "llvm.bitcast"(%166) : (vector<2xf16>) -> i32
    %168 = "llvm.insertelement"(%161, %167, %135) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %169 = "llvm.extractelement"(%163, %136) : (vector<2xi16>, i64) -> i16
    %170 = "llvm.bitcast"(%169) : (i16) -> vector<2xi8>
    %171 = "nvvm.convert.f8x2.to.f16x2"(%170) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %172 = "llvm.bitcast"(%171) : (vector<2xf16>) -> i32
    %173 = "llvm.insertelement"(%168, %172, %134) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %174 = "llvm.bitcast"(%173) : (vector<4xi32>) -> vector<8xf16>
    %175 = "llvm.shufflevector"(%174, %174) <{mask = array<i32: 0, 1, 2, 3>}> : (vector<8xf16>, vector<8xf16>) -> vector<4xf16>
    %176 = "llvm.insertvalue"(%133, %175) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf16>>, vector<4xf16>) -> !llvm.array<2 x vector<4xf16>>
    %177 = "llvm.shufflevector"(%174, %174) <{mask = array<i32: 4, 5, 6, 7>}> : (vector<8xf16>, vector<8xf16>) -> vector<4xf16>
    %178 = "llvm.insertvalue"(%176, %177) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf16>>, vector<4xf16>) -> !llvm.array<2 x vector<4xf16>>
    %179 = "builtin.unrealized_conversion_cast"(%178) : (!llvm.array<2 x vector<4xf16>>) -> vector<2x4xf16>
    "func.return"(%179) : (vector<2x4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf8E5M2>) -> vector<3xf16>, sym_name = "e2e_v3f8_to_v3f16"}> ({
  ^bb0(%arg3: vector<3xf8E5M2>):
    %106 = "builtin.unrealized_conversion_cast"(%arg3) : (vector<3xf8E5M2>) -> vector<3xi8>
    %107 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %108 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %109 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %110 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E5M2>}> : () -> vector<4xf8E5M2>
    %111 = "builtin.unrealized_conversion_cast"(%110) : (vector<4xf8E5M2>) -> vector<4xi8>
    %112 = "llvm.shufflevector"(%106, %106) <{mask = array<i32: 0, 1, 2, 0>}> : (vector<3xi8>, vector<3xi8>) -> vector<4xi8>
    %113 = "llvm.shufflevector"(%112, %111) <{mask = array<i32: 0, 1, 2, 7>}> : (vector<4xi8>, vector<4xi8>) -> vector<4xi8>
    %114 = "builtin.unrealized_conversion_cast"(%113) : (vector<4xi8>) -> vector<4xf8E5M2>
    %115 = "builtin.unrealized_conversion_cast"(%114) : (vector<4xf8E5M2>) -> vector<4xi8>
    %116 = "llvm.bitcast"(%115) : (vector<4xi8>) -> vector<1xi32>
    %117 = "llvm.extractelement"(%116, %108) : (vector<1xi32>, i64) -> i32
    %118 = "llvm.bitcast"(%117) : (i32) -> vector<2xi16>
    %119 = "llvm.extractelement"(%118, %108) : (vector<2xi16>, i64) -> i16
    %120 = "llvm.bitcast"(%119) : (i16) -> vector<2xi8>
    %121 = "nvvm.convert.f8x2.to.f16x2"(%120) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %122 = "llvm.bitcast"(%121) : (vector<2xf16>) -> i32
    %123 = "llvm.insertelement"(%109, %122, %108) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %124 = "llvm.extractelement"(%118, %107) : (vector<2xi16>, i64) -> i16
    %125 = "llvm.bitcast"(%124) : (i16) -> vector<2xi8>
    %126 = "nvvm.convert.f8x2.to.f16x2"(%125) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %127 = "llvm.bitcast"(%126) : (vector<2xf16>) -> i32
    %128 = "llvm.insertelement"(%123, %127, %107) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %129 = "llvm.bitcast"(%128) : (vector<2xi32>) -> vector<4xf16>
    %130 = "llvm.shufflevector"(%129, %129) <{mask = array<i32: 0, 1, 2>}> : (vector<4xf16>, vector<4xf16>) -> vector<3xf16>
    "func.return"(%130) : (vector<3xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f8E4M3FN) -> f32, sym_name = "e2e_scalar_f8_to_f32"}> ({
  ^bb0(%arg2: f8E4M3FN):
    %76 = "builtin.unrealized_conversion_cast"(%arg2) : (f8E4M3FN) -> i8
    %77 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %78 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %79 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %80 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %81 = "builtin.unrealized_conversion_cast"(%80) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %82 = "llvm.mlir.poison"() : () -> vector<1xi8>
    %83 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %84 = "llvm.insertelement"(%82, %76, %83) : (vector<1xi8>, i8, i32) -> vector<1xi8>
    %85 = "llvm.shufflevector"(%84, %84) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<1xi8>, vector<1xi8>) -> vector<4xi8>
    %86 = "llvm.shufflevector"(%85, %81) <{mask = array<i32: 0, 5, 6, 7>}> : (vector<4xi8>, vector<4xi8>) -> vector<4xi8>
    %87 = "builtin.unrealized_conversion_cast"(%86) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    %88 = "builtin.unrealized_conversion_cast"(%87) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %89 = "llvm.bitcast"(%88) : (vector<4xi8>) -> vector<1xi32>
    %90 = "llvm.extractelement"(%89, %78) : (vector<1xi32>, i64) -> i32
    %91 = "llvm.bitcast"(%90) : (i32) -> vector<2xi16>
    %92 = "llvm.extractelement"(%91, %78) : (vector<2xi16>, i64) -> i16
    %93 = "llvm.bitcast"(%92) : (i16) -> vector<2xi8>
    %94 = "nvvm.convert.f8x2.to.f16x2"(%93) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %95 = "llvm.bitcast"(%94) : (vector<2xf16>) -> i32
    %96 = "llvm.insertelement"(%79, %95, %78) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %97 = "llvm.extractelement"(%91, %77) : (vector<2xi16>, i64) -> i16
    %98 = "llvm.bitcast"(%97) : (i16) -> vector<2xi8>
    %99 = "nvvm.convert.f8x2.to.f16x2"(%98) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %100 = "llvm.bitcast"(%99) : (vector<2xf16>) -> i32
    %101 = "llvm.insertelement"(%96, %100, %77) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %102 = "llvm.bitcast"(%101) : (vector<2xi32>) -> vector<4xf16>
    %103 = "llvm.fpext"(%102) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    %104 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %105 = "llvm.extractelement"(%103, %104) : (vector<4xf32>, i64) -> f32
    "func.return"(%105) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf8E4M3FN>) -> vector<2x4xf32>, sym_name = "e2e_v2x4_f8_to_f32"}> ({
  ^bb0(%arg1: vector<2x4xf8E4M3FN>):
    %26 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<2x4xf8E4M3FN>) -> !llvm.array<2 x vector<4xi8>>
    %27 = "ub.poison"() <{value = #ub.poison}> : () -> vector<2x4xf32>
    %28 = "builtin.unrealized_conversion_cast"(%27) : (vector<2x4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %29 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %30 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %31 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %32 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %33 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %34 = "ub.poison"() <{value = #ub.poison}> : () -> vector<8xf8E4M3FN>
    %35 = "builtin.unrealized_conversion_cast"(%34) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %36 = "llvm.extractvalue"(%26) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xi8>>) -> vector<4xi8>
    %37 = "llvm.shufflevector"(%36, %36) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xi8>, vector<4xi8>) -> vector<8xi8>
    %38 = "llvm.shufflevector"(%37, %35) <{mask = array<i32: 0, 1, 2, 3, -1, -1, -1, -1>}> : (vector<8xi8>, vector<8xi8>) -> vector<8xi8>
    %39 = "llvm.extractvalue"(%26) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xi8>>) -> vector<4xi8>
    %40 = "llvm.shufflevector"(%39, %39) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xi8>, vector<4xi8>) -> vector<8xi8>
    %41 = "llvm.shufflevector"(%40, %38) <{mask = array<i32: 8, 9, 10, 11, 0, 1, 2, 3>}> : (vector<8xi8>, vector<8xi8>) -> vector<8xi8>
    %42 = "builtin.unrealized_conversion_cast"(%41) : (vector<8xi8>) -> vector<8xf8E4M3FN>
    %43 = "builtin.unrealized_conversion_cast"(%42) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %44 = "llvm.bitcast"(%43) : (vector<8xi8>) -> vector<2xi32>
    %45 = "llvm.extractelement"(%44, %32) : (vector<2xi32>, i64) -> i32
    %46 = "llvm.bitcast"(%45) : (i32) -> vector<2xi16>
    %47 = "llvm.extractelement"(%46, %32) : (vector<2xi16>, i64) -> i16
    %48 = "llvm.bitcast"(%47) : (i16) -> vector<2xi8>
    %49 = "nvvm.convert.f8x2.to.f16x2"(%48) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %50 = "llvm.bitcast"(%49) : (vector<2xf16>) -> i32
    %51 = "llvm.insertelement"(%33, %50, %32) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %52 = "llvm.extractelement"(%46, %31) : (vector<2xi16>, i64) -> i16
    %53 = "llvm.bitcast"(%52) : (i16) -> vector<2xi8>
    %54 = "nvvm.convert.f8x2.to.f16x2"(%53) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %55 = "llvm.bitcast"(%54) : (vector<2xf16>) -> i32
    %56 = "llvm.insertelement"(%51, %55, %31) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %57 = "llvm.extractelement"(%44, %31) : (vector<2xi32>, i64) -> i32
    %58 = "llvm.bitcast"(%57) : (i32) -> vector<2xi16>
    %59 = "llvm.extractelement"(%58, %32) : (vector<2xi16>, i64) -> i16
    %60 = "llvm.bitcast"(%59) : (i16) -> vector<2xi8>
    %61 = "nvvm.convert.f8x2.to.f16x2"(%60) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %62 = "llvm.bitcast"(%61) : (vector<2xf16>) -> i32
    %63 = "llvm.insertelement"(%56, %62, %30) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %64 = "llvm.extractelement"(%58, %31) : (vector<2xi16>, i64) -> i16
    %65 = "llvm.bitcast"(%64) : (i16) -> vector<2xi8>
    %66 = "nvvm.convert.f8x2.to.f16x2"(%65) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %67 = "llvm.bitcast"(%66) : (vector<2xf16>) -> i32
    %68 = "llvm.insertelement"(%63, %67, %29) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %69 = "llvm.bitcast"(%68) : (vector<4xi32>) -> vector<8xf16>
    %70 = "llvm.fpext"(%69) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf16>) -> vector<8xf32>
    %71 = "llvm.shufflevector"(%70, %70) <{mask = array<i32: 0, 1, 2, 3>}> : (vector<8xf32>, vector<8xf32>) -> vector<4xf32>
    %72 = "llvm.insertvalue"(%28, %71) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %73 = "llvm.shufflevector"(%70, %70) <{mask = array<i32: 4, 5, 6, 7>}> : (vector<8xf32>, vector<8xf32>) -> vector<4xf32>
    %74 = "llvm.insertvalue"(%72, %73) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %75 = "builtin.unrealized_conversion_cast"(%74) : (!llvm.array<2 x vector<4xf32>>) -> vector<2x4xf32>
    "func.return"(%75) : (vector<2x4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf8E5M2>) -> vector<3xf32>, sym_name = "e2e_v3f8_to_v3f32"}> ({
  ^bb0(%arg0: vector<3xf8E5M2>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<3xf8E5M2>) -> vector<3xi8>
    %1 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %3 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E5M2>}> : () -> vector<4xf8E5M2>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (vector<4xf8E5M2>) -> vector<4xi8>
    %6 = "llvm.shufflevector"(%0, %0) <{mask = array<i32: 0, 1, 2, 0>}> : (vector<3xi8>, vector<3xi8>) -> vector<4xi8>
    %7 = "llvm.shufflevector"(%6, %5) <{mask = array<i32: 0, 1, 2, 7>}> : (vector<4xi8>, vector<4xi8>) -> vector<4xi8>
    %8 = "builtin.unrealized_conversion_cast"(%7) : (vector<4xi8>) -> vector<4xf8E5M2>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (vector<4xf8E5M2>) -> vector<4xi8>
    %10 = "llvm.bitcast"(%9) : (vector<4xi8>) -> vector<1xi32>
    %11 = "llvm.extractelement"(%10, %2) : (vector<1xi32>, i64) -> i32
    %12 = "llvm.bitcast"(%11) : (i32) -> vector<2xi16>
    %13 = "llvm.extractelement"(%12, %2) : (vector<2xi16>, i64) -> i16
    %14 = "llvm.bitcast"(%13) : (i16) -> vector<2xi8>
    %15 = "nvvm.convert.f8x2.to.f16x2"(%14) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %16 = "llvm.bitcast"(%15) : (vector<2xf16>) -> i32
    %17 = "llvm.insertelement"(%3, %16, %2) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %18 = "llvm.extractelement"(%12, %1) : (vector<2xi16>, i64) -> i16
    %19 = "llvm.bitcast"(%18) : (i16) -> vector<2xi8>
    %20 = "nvvm.convert.f8x2.to.f16x2"(%19) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %21 = "llvm.bitcast"(%20) : (vector<2xf16>) -> i32
    %22 = "llvm.insertelement"(%17, %21, %1) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %23 = "llvm.bitcast"(%22) : (vector<2xi32>) -> vector<4xf16>
    %24 = "llvm.fpext"(%23) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    %25 = "llvm.shufflevector"(%24, %24) <{mask = array<i32: 0, 1, 2>}> : (vector<4xf32>, vector<4xf32>) -> vector<3xf32>
    "func.return"(%25) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()


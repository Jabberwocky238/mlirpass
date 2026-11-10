"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "cvt_float_f32_to_f16"}> ({
  ^bb0(%arg34: vector<4xf32>):
    %933 = "llvm.bitcast"(%arg34) : (vector<4xf32>) -> vector<4xi32>
    %934 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %935 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %936 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %937 = "llvm.extractelement"(%933, %936) : (vector<4xi32>, i64) -> i32
    %938 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %939 = "llvm.extractelement"(%933, %938) : (vector<4xi32>, i64) -> i32
    %940 = "llvm.bitcast"(%937) : (i32) -> f32
    %941 = "llvm.bitcast"(%939) : (i32) -> f32
    %942 = "nvvm.convert.f32x2.to.f16x2"(%941, %940) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %943 = "llvm.bitcast"(%942) : (vector<2xf16>) -> i32
    %944 = "llvm.insertelement"(%934, %943, %935) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %945 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %946 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %947 = "llvm.extractelement"(%933, %946) : (vector<4xi32>, i64) -> i32
    %948 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %949 = "llvm.extractelement"(%933, %948) : (vector<4xi32>, i64) -> i32
    %950 = "llvm.bitcast"(%947) : (i32) -> f32
    %951 = "llvm.bitcast"(%949) : (i32) -> f32
    %952 = "nvvm.convert.f32x2.to.f16x2"(%951, %950) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %953 = "llvm.bitcast"(%952) : (vector<2xf16>) -> i32
    %954 = "llvm.insertelement"(%944, %953, %945) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %955 = "llvm.bitcast"(%954) : (vector<2xi32>) -> vector<4xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_f16_v8"}> ({
  ^bb0(%arg33: vector<8xf32>):
    %890 = "llvm.bitcast"(%arg33) : (vector<8xf32>) -> vector<8xi32>
    %891 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %892 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %893 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %894 = "llvm.extractelement"(%890, %893) : (vector<8xi32>, i64) -> i32
    %895 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %896 = "llvm.extractelement"(%890, %895) : (vector<8xi32>, i64) -> i32
    %897 = "llvm.bitcast"(%894) : (i32) -> f32
    %898 = "llvm.bitcast"(%896) : (i32) -> f32
    %899 = "nvvm.convert.f32x2.to.f16x2"(%898, %897) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %900 = "llvm.bitcast"(%899) : (vector<2xf16>) -> i32
    %901 = "llvm.insertelement"(%891, %900, %892) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %902 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %903 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %904 = "llvm.extractelement"(%890, %903) : (vector<8xi32>, i64) -> i32
    %905 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %906 = "llvm.extractelement"(%890, %905) : (vector<8xi32>, i64) -> i32
    %907 = "llvm.bitcast"(%904) : (i32) -> f32
    %908 = "llvm.bitcast"(%906) : (i32) -> f32
    %909 = "nvvm.convert.f32x2.to.f16x2"(%908, %907) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %910 = "llvm.bitcast"(%909) : (vector<2xf16>) -> i32
    %911 = "llvm.insertelement"(%901, %910, %902) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %912 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %913 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %914 = "llvm.extractelement"(%890, %913) : (vector<8xi32>, i64) -> i32
    %915 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %916 = "llvm.extractelement"(%890, %915) : (vector<8xi32>, i64) -> i32
    %917 = "llvm.bitcast"(%914) : (i32) -> f32
    %918 = "llvm.bitcast"(%916) : (i32) -> f32
    %919 = "nvvm.convert.f32x2.to.f16x2"(%918, %917) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %920 = "llvm.bitcast"(%919) : (vector<2xf16>) -> i32
    %921 = "llvm.insertelement"(%911, %920, %912) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %922 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %923 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %924 = "llvm.extractelement"(%890, %923) : (vector<8xi32>, i64) -> i32
    %925 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %926 = "llvm.extractelement"(%890, %925) : (vector<8xi32>, i64) -> i32
    %927 = "llvm.bitcast"(%924) : (i32) -> f32
    %928 = "llvm.bitcast"(%926) : (i32) -> f32
    %929 = "nvvm.convert.f32x2.to.f16x2"(%928, %927) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %930 = "llvm.bitcast"(%929) : (vector<2xf16>) -> i32
    %931 = "llvm.insertelement"(%921, %930, %922) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %932 = "llvm.bitcast"(%931) : (vector<4xi32>) -> vector<8xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "cvt_float_f32_to_bf16"}> ({
  ^bb0(%arg32: vector<4xf32>):
    %867 = "llvm.bitcast"(%arg32) : (vector<4xf32>) -> vector<4xi32>
    %868 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %869 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %870 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %871 = "llvm.extractelement"(%867, %870) : (vector<4xi32>, i64) -> i32
    %872 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %873 = "llvm.extractelement"(%867, %872) : (vector<4xi32>, i64) -> i32
    %874 = "llvm.bitcast"(%871) : (i32) -> f32
    %875 = "llvm.bitcast"(%873) : (i32) -> f32
    %876 = "nvvm.convert.f32x2.to.bf16x2"(%875, %874) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xbf16>
    %877 = "llvm.bitcast"(%876) : (vector<2xbf16>) -> i32
    %878 = "llvm.insertelement"(%868, %877, %869) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %879 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %880 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %881 = "llvm.extractelement"(%867, %880) : (vector<4xi32>, i64) -> i32
    %882 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %883 = "llvm.extractelement"(%867, %882) : (vector<4xi32>, i64) -> i32
    %884 = "llvm.bitcast"(%881) : (i32) -> f32
    %885 = "llvm.bitcast"(%883) : (i32) -> f32
    %886 = "nvvm.convert.f32x2.to.bf16x2"(%885, %884) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xbf16>
    %887 = "llvm.bitcast"(%886) : (vector<2xbf16>) -> i32
    %888 = "llvm.insertelement"(%878, %887, %879) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %889 = "llvm.bitcast"(%888) : (vector<2xi32>) -> vector<4xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_e4m3"}> ({
  ^bb0(%arg31: vector<8xf32>):
    %820 = "llvm.bitcast"(%arg31) : (vector<8xf32>) -> vector<8xi32>
    %821 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %822 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %823 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %824 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %825 = "llvm.extractelement"(%820, %824) : (vector<8xi32>, i64) -> i32
    %826 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %827 = "llvm.extractelement"(%820, %826) : (vector<8xi32>, i64) -> i32
    %828 = "llvm.bitcast"(%825) : (i32) -> f32
    %829 = "llvm.bitcast"(%827) : (i32) -> f32
    %830 = "nvvm.convert.f32x2.to.f8x2"(%829, %828) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %831 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %832 = "llvm.insertelement"(%823, %830, %831) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %833 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %834 = "llvm.extractelement"(%820, %833) : (vector<8xi32>, i64) -> i32
    %835 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %836 = "llvm.extractelement"(%820, %835) : (vector<8xi32>, i64) -> i32
    %837 = "llvm.bitcast"(%834) : (i32) -> f32
    %838 = "llvm.bitcast"(%836) : (i32) -> f32
    %839 = "nvvm.convert.f32x2.to.f8x2"(%838, %837) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %840 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %841 = "llvm.insertelement"(%832, %839, %840) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %842 = "llvm.bitcast"(%841) : (vector<2xi16>) -> i32
    %843 = "llvm.insertelement"(%821, %842, %822) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %844 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %845 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %846 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %847 = "llvm.extractelement"(%820, %846) : (vector<8xi32>, i64) -> i32
    %848 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %849 = "llvm.extractelement"(%820, %848) : (vector<8xi32>, i64) -> i32
    %850 = "llvm.bitcast"(%847) : (i32) -> f32
    %851 = "llvm.bitcast"(%849) : (i32) -> f32
    %852 = "nvvm.convert.f32x2.to.f8x2"(%851, %850) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %853 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %854 = "llvm.insertelement"(%845, %852, %853) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %855 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %856 = "llvm.extractelement"(%820, %855) : (vector<8xi32>, i64) -> i32
    %857 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %858 = "llvm.extractelement"(%820, %857) : (vector<8xi32>, i64) -> i32
    %859 = "llvm.bitcast"(%856) : (i32) -> f32
    %860 = "llvm.bitcast"(%858) : (i32) -> f32
    %861 = "nvvm.convert.f32x2.to.f8x2"(%860, %859) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %862 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %863 = "llvm.insertelement"(%854, %861, %862) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %864 = "llvm.bitcast"(%863) : (vector<2xi16>) -> i32
    %865 = "llvm.insertelement"(%843, %864, %844) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %866 = "llvm.bitcast"(%865) : (vector<2xi32>) -> vector<8xi8>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf16>) -> (), sym_name = "cvt_float_f16_to_e2m3"}> ({
  ^bb0(%arg30: vector<8xf16>):
    %784 = "llvm.bitcast"(%arg30) : (vector<8xf16>) -> vector<4xi32>
    %785 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %786 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %787 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %788 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %789 = "llvm.extractelement"(%784, %788) : (vector<4xi32>, i64) -> i32
    %790 = "llvm.bitcast"(%789) : (i32) -> vector<2xf16>
    %791 = "nvvm.convert.f16x2.to.f6x2"(%790) <{dstTy = f6E2M3FN, relu = false}> : (vector<2xf16>) -> i16
    %792 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %793 = "llvm.insertelement"(%787, %791, %792) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %794 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %795 = "llvm.extractelement"(%784, %794) : (vector<4xi32>, i64) -> i32
    %796 = "llvm.bitcast"(%795) : (i32) -> vector<2xf16>
    %797 = "nvvm.convert.f16x2.to.f6x2"(%796) <{dstTy = f6E2M3FN, relu = false}> : (vector<2xf16>) -> i16
    %798 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %799 = "llvm.insertelement"(%793, %797, %798) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %800 = "llvm.bitcast"(%799) : (vector<2xi16>) -> i32
    %801 = "llvm.insertelement"(%785, %800, %786) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %802 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %803 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %804 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %805 = "llvm.extractelement"(%784, %804) : (vector<4xi32>, i64) -> i32
    %806 = "llvm.bitcast"(%805) : (i32) -> vector<2xf16>
    %807 = "nvvm.convert.f16x2.to.f6x2"(%806) <{dstTy = f6E2M3FN, relu = false}> : (vector<2xf16>) -> i16
    %808 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %809 = "llvm.insertelement"(%803, %807, %808) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %810 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %811 = "llvm.extractelement"(%784, %810) : (vector<4xi32>, i64) -> i32
    %812 = "llvm.bitcast"(%811) : (i32) -> vector<2xf16>
    %813 = "nvvm.convert.f16x2.to.f6x2"(%812) <{dstTy = f6E2M3FN, relu = false}> : (vector<2xf16>) -> i16
    %814 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %815 = "llvm.insertelement"(%809, %813, %814) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %816 = "llvm.bitcast"(%815) : (vector<2xi16>) -> i32
    %817 = "llvm.insertelement"(%801, %816, %802) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %818 = "llvm.bitcast"(%817) : (vector<2xi32>) -> vector<8xi8>
    %819 = "llvm.trunc"(%818) <{overflowFlags = 0 : i32}> : (vector<8xi8>) -> vector<8xi6>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xbf16>) -> (), sym_name = "cvt_float_bf16_to_e3m2"}> ({
  ^bb0(%arg29: vector<8xbf16>):
    %748 = "llvm.bitcast"(%arg29) : (vector<8xbf16>) -> vector<4xi32>
    %749 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %750 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %751 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %752 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %753 = "llvm.extractelement"(%748, %752) : (vector<4xi32>, i64) -> i32
    %754 = "llvm.bitcast"(%753) : (i32) -> vector<2xbf16>
    %755 = "nvvm.convert.bf16x2.to.f6x2"(%754) <{dstTy = f6E3M2FN, relu = false}> : (vector<2xbf16>) -> i16
    %756 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %757 = "llvm.insertelement"(%751, %755, %756) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %758 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %759 = "llvm.extractelement"(%748, %758) : (vector<4xi32>, i64) -> i32
    %760 = "llvm.bitcast"(%759) : (i32) -> vector<2xbf16>
    %761 = "nvvm.convert.bf16x2.to.f6x2"(%760) <{dstTy = f6E3M2FN, relu = false}> : (vector<2xbf16>) -> i16
    %762 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %763 = "llvm.insertelement"(%757, %761, %762) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %764 = "llvm.bitcast"(%763) : (vector<2xi16>) -> i32
    %765 = "llvm.insertelement"(%749, %764, %750) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %766 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %767 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %768 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %769 = "llvm.extractelement"(%748, %768) : (vector<4xi32>, i64) -> i32
    %770 = "llvm.bitcast"(%769) : (i32) -> vector<2xbf16>
    %771 = "nvvm.convert.bf16x2.to.f6x2"(%770) <{dstTy = f6E3M2FN, relu = false}> : (vector<2xbf16>) -> i16
    %772 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %773 = "llvm.insertelement"(%767, %771, %772) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %774 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %775 = "llvm.extractelement"(%748, %774) : (vector<4xi32>, i64) -> i32
    %776 = "llvm.bitcast"(%775) : (i32) -> vector<2xbf16>
    %777 = "nvvm.convert.bf16x2.to.f6x2"(%776) <{dstTy = f6E3M2FN, relu = false}> : (vector<2xbf16>) -> i16
    %778 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %779 = "llvm.insertelement"(%773, %777, %778) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %780 = "llvm.bitcast"(%779) : (vector<2xi16>) -> i32
    %781 = "llvm.insertelement"(%765, %780, %766) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %782 = "llvm.bitcast"(%781) : (vector<2xi32>) -> vector<8xi8>
    %783 = "llvm.trunc"(%782) <{overflowFlags = 0 : i32}> : (vector<8xi8>) -> vector<8xi6>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_e2m3"}> ({
  ^bb0(%arg28: vector<8xf32>):
    %700 = "llvm.bitcast"(%arg28) : (vector<8xf32>) -> vector<8xi32>
    %701 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %702 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %703 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %704 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %705 = "llvm.extractelement"(%700, %704) : (vector<8xi32>, i64) -> i32
    %706 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %707 = "llvm.extractelement"(%700, %706) : (vector<8xi32>, i64) -> i32
    %708 = "llvm.bitcast"(%705) : (i32) -> f32
    %709 = "llvm.bitcast"(%707) : (i32) -> f32
    %710 = "nvvm.convert.f32x2.to.f6x2"(%709, %708) <{dstTy = f6E2M3FN, relu = false}> : (f32, f32) -> i16
    %711 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %712 = "llvm.insertelement"(%703, %710, %711) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %713 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %714 = "llvm.extractelement"(%700, %713) : (vector<8xi32>, i64) -> i32
    %715 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %716 = "llvm.extractelement"(%700, %715) : (vector<8xi32>, i64) -> i32
    %717 = "llvm.bitcast"(%714) : (i32) -> f32
    %718 = "llvm.bitcast"(%716) : (i32) -> f32
    %719 = "nvvm.convert.f32x2.to.f6x2"(%718, %717) <{dstTy = f6E2M3FN, relu = false}> : (f32, f32) -> i16
    %720 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %721 = "llvm.insertelement"(%712, %719, %720) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %722 = "llvm.bitcast"(%721) : (vector<2xi16>) -> i32
    %723 = "llvm.insertelement"(%701, %722, %702) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %724 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %725 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %726 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %727 = "llvm.extractelement"(%700, %726) : (vector<8xi32>, i64) -> i32
    %728 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %729 = "llvm.extractelement"(%700, %728) : (vector<8xi32>, i64) -> i32
    %730 = "llvm.bitcast"(%727) : (i32) -> f32
    %731 = "llvm.bitcast"(%729) : (i32) -> f32
    %732 = "nvvm.convert.f32x2.to.f6x2"(%731, %730) <{dstTy = f6E2M3FN, relu = false}> : (f32, f32) -> i16
    %733 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %734 = "llvm.insertelement"(%725, %732, %733) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %735 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %736 = "llvm.extractelement"(%700, %735) : (vector<8xi32>, i64) -> i32
    %737 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %738 = "llvm.extractelement"(%700, %737) : (vector<8xi32>, i64) -> i32
    %739 = "llvm.bitcast"(%736) : (i32) -> f32
    %740 = "llvm.bitcast"(%738) : (i32) -> f32
    %741 = "nvvm.convert.f32x2.to.f6x2"(%740, %739) <{dstTy = f6E2M3FN, relu = false}> : (f32, f32) -> i16
    %742 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %743 = "llvm.insertelement"(%734, %741, %742) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %744 = "llvm.bitcast"(%743) : (vector<2xi16>) -> i32
    %745 = "llvm.insertelement"(%723, %744, %724) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %746 = "llvm.bitcast"(%745) : (vector<2xi32>) -> vector<8xi8>
    %747 = "llvm.trunc"(%746) <{overflowFlags = 0 : i32}> : (vector<8xi8>) -> vector<8xi6>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_e8m0_rz"}> ({
  ^bb0(%arg27: vector<8xf32>):
    %653 = "llvm.bitcast"(%arg27) : (vector<8xf32>) -> vector<8xi32>
    %654 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %655 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %656 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %657 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %658 = "llvm.extractelement"(%653, %657) : (vector<8xi32>, i64) -> i32
    %659 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %660 = "llvm.extractelement"(%653, %659) : (vector<8xi32>, i64) -> i32
    %661 = "llvm.bitcast"(%658) : (i32) -> f32
    %662 = "llvm.bitcast"(%660) : (i32) -> f32
    %663 = "nvvm.convert.f32x2.to.f8x2"(%662, %661) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %664 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %665 = "llvm.insertelement"(%656, %663, %664) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %666 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %667 = "llvm.extractelement"(%653, %666) : (vector<8xi32>, i64) -> i32
    %668 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %669 = "llvm.extractelement"(%653, %668) : (vector<8xi32>, i64) -> i32
    %670 = "llvm.bitcast"(%667) : (i32) -> f32
    %671 = "llvm.bitcast"(%669) : (i32) -> f32
    %672 = "nvvm.convert.f32x2.to.f8x2"(%671, %670) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %673 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %674 = "llvm.insertelement"(%665, %672, %673) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %675 = "llvm.bitcast"(%674) : (vector<2xi16>) -> i32
    %676 = "llvm.insertelement"(%654, %675, %655) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %677 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %678 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %679 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %680 = "llvm.extractelement"(%653, %679) : (vector<8xi32>, i64) -> i32
    %681 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %682 = "llvm.extractelement"(%653, %681) : (vector<8xi32>, i64) -> i32
    %683 = "llvm.bitcast"(%680) : (i32) -> f32
    %684 = "llvm.bitcast"(%682) : (i32) -> f32
    %685 = "nvvm.convert.f32x2.to.f8x2"(%684, %683) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %686 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %687 = "llvm.insertelement"(%678, %685, %686) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %688 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %689 = "llvm.extractelement"(%653, %688) : (vector<8xi32>, i64) -> i32
    %690 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %691 = "llvm.extractelement"(%653, %690) : (vector<8xi32>, i64) -> i32
    %692 = "llvm.bitcast"(%689) : (i32) -> f32
    %693 = "llvm.bitcast"(%691) : (i32) -> f32
    %694 = "nvvm.convert.f32x2.to.f8x2"(%693, %692) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %695 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %696 = "llvm.insertelement"(%687, %694, %695) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %697 = "llvm.bitcast"(%696) : (vector<2xi16>) -> i32
    %698 = "llvm.insertelement"(%676, %697, %677) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %699 = "llvm.bitcast"(%698) : (vector<2xi32>) -> vector<8xi8>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_e8m0_rp"}> ({
  ^bb0(%arg26: vector<8xf32>):
    %606 = "llvm.bitcast"(%arg26) : (vector<8xf32>) -> vector<8xi32>
    %607 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %608 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %609 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %610 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %611 = "llvm.extractelement"(%606, %610) : (vector<8xi32>, i64) -> i32
    %612 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %613 = "llvm.extractelement"(%606, %612) : (vector<8xi32>, i64) -> i32
    %614 = "llvm.bitcast"(%611) : (i32) -> f32
    %615 = "llvm.bitcast"(%613) : (i32) -> f32
    %616 = "nvvm.convert.f32x2.to.f8x2"(%615, %614) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %617 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %618 = "llvm.insertelement"(%609, %616, %617) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %619 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %620 = "llvm.extractelement"(%606, %619) : (vector<8xi32>, i64) -> i32
    %621 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %622 = "llvm.extractelement"(%606, %621) : (vector<8xi32>, i64) -> i32
    %623 = "llvm.bitcast"(%620) : (i32) -> f32
    %624 = "llvm.bitcast"(%622) : (i32) -> f32
    %625 = "nvvm.convert.f32x2.to.f8x2"(%624, %623) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %626 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %627 = "llvm.insertelement"(%618, %625, %626) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %628 = "llvm.bitcast"(%627) : (vector<2xi16>) -> i32
    %629 = "llvm.insertelement"(%607, %628, %608) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %630 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %631 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %632 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %633 = "llvm.extractelement"(%606, %632) : (vector<8xi32>, i64) -> i32
    %634 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %635 = "llvm.extractelement"(%606, %634) : (vector<8xi32>, i64) -> i32
    %636 = "llvm.bitcast"(%633) : (i32) -> f32
    %637 = "llvm.bitcast"(%635) : (i32) -> f32
    %638 = "nvvm.convert.f32x2.to.f8x2"(%637, %636) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %639 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %640 = "llvm.insertelement"(%631, %638, %639) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %641 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %642 = "llvm.extractelement"(%606, %641) : (vector<8xi32>, i64) -> i32
    %643 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %644 = "llvm.extractelement"(%606, %643) : (vector<8xi32>, i64) -> i32
    %645 = "llvm.bitcast"(%642) : (i32) -> f32
    %646 = "llvm.bitcast"(%644) : (i32) -> f32
    %647 = "nvvm.convert.f32x2.to.f8x2"(%646, %645) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %648 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %649 = "llvm.insertelement"(%640, %647, %648) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %650 = "llvm.bitcast"(%649) : (vector<2xi16>) -> i32
    %651 = "llvm.insertelement"(%629, %650, %630) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %652 = "llvm.bitcast"(%651) : (vector<2xi32>) -> vector<8xi8>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f16, sym_name = "fptrunc_scalar_f32_to_f16"}> ({
  ^bb0(%arg25: f32):
    %588 = "vector.broadcast"(%arg25) : (f32) -> vector<1xf32>
    %589 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2xf32>}> : () -> vector<2xf32>
    %590 = "vector.insert_strided_slice"(%588, %589) <{offsets = [0], strides = [1]}> : (vector<1xf32>, vector<2xf32>) -> vector<2xf32>
    %591 = "llvm.bitcast"(%590) : (vector<2xf32>) -> vector<2xi32>
    %592 = "llvm.mlir.undef"() : () -> vector<1xi32>
    %593 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %594 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %595 = "llvm.extractelement"(%591, %594) : (vector<2xi32>, i64) -> i32
    %596 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %597 = "llvm.extractelement"(%591, %596) : (vector<2xi32>, i64) -> i32
    %598 = "llvm.bitcast"(%595) : (i32) -> f32
    %599 = "llvm.bitcast"(%597) : (i32) -> f32
    %600 = "nvvm.convert.f32x2.to.f16x2"(%599, %598) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %601 = "llvm.bitcast"(%600) : (vector<2xf16>) -> i32
    %602 = "llvm.insertelement"(%592, %601, %593) : (vector<1xi32>, i32, i64) -> vector<1xi32>
    %603 = "llvm.bitcast"(%602) : (vector<1xi32>) -> vector<2xf16>
    %604 = "vector.extract_strided_slice"(%603) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf16>) -> vector<1xf16>
    %605 = "vector.extract"(%604) <{static_position = array<i64: 0>}> : (vector<1xf16>) -> f16
    "func.return"(%605) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> bf16, sym_name = "fptrunc_scalar_f32_to_bf16"}> ({
  ^bb0(%arg24: f32):
    %570 = "vector.broadcast"(%arg24) : (f32) -> vector<1xf32>
    %571 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2xf32>}> : () -> vector<2xf32>
    %572 = "vector.insert_strided_slice"(%570, %571) <{offsets = [0], strides = [1]}> : (vector<1xf32>, vector<2xf32>) -> vector<2xf32>
    %573 = "llvm.bitcast"(%572) : (vector<2xf32>) -> vector<2xi32>
    %574 = "llvm.mlir.undef"() : () -> vector<1xi32>
    %575 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %576 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %577 = "llvm.extractelement"(%573, %576) : (vector<2xi32>, i64) -> i32
    %578 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %579 = "llvm.extractelement"(%573, %578) : (vector<2xi32>, i64) -> i32
    %580 = "llvm.bitcast"(%577) : (i32) -> f32
    %581 = "llvm.bitcast"(%579) : (i32) -> f32
    %582 = "nvvm.convert.f32x2.to.bf16x2"(%581, %580) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xbf16>
    %583 = "llvm.bitcast"(%582) : (vector<2xbf16>) -> i32
    %584 = "llvm.insertelement"(%574, %583, %575) : (vector<1xi32>, i32, i64) -> vector<1xi32>
    %585 = "llvm.bitcast"(%584) : (vector<1xi32>) -> vector<2xbf16>
    %586 = "vector.extract_strided_slice"(%585) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xbf16>) -> vector<1xbf16>
    %587 = "vector.extract"(%586) <{static_position = array<i64: 0>}> : (vector<1xbf16>) -> bf16
    "func.return"(%587) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> f32, sym_name = "fptrunc_scalar_f64_to_f32"}> ({
  ^bb0(%arg23: f64):
    %564 = "vector.broadcast"(%arg23) : (f64) -> vector<1xf64>
    %565 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2xf64>}> : () -> vector<2xf64>
    %566 = "vector.insert_strided_slice"(%564, %565) <{offsets = [0], strides = [1]}> : (vector<1xf64>, vector<2xf64>) -> vector<2xf64>
    %567 = "llvm.fptrunc"(%566) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf64>) -> vector<2xf32>
    %568 = "vector.extract_strided_slice"(%567) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf32>) -> vector<1xf32>
    %569 = "vector.extract"(%568) <{static_position = array<i64: 0>}> : (vector<1xf32>) -> f32
    "func.return"(%569) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf32>) -> vector<2x4xf16>, sym_name = "fptrunc_v2x4_f32_to_f16"}> ({
  ^bb0(%arg22: vector<2x4xf32>):
    %519 = "vector.shape_cast"(%arg22) : (vector<2x4xf32>) -> vector<8xf32>
    %520 = "llvm.bitcast"(%519) : (vector<8xf32>) -> vector<8xi32>
    %521 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %522 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %523 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %524 = "llvm.extractelement"(%520, %523) : (vector<8xi32>, i64) -> i32
    %525 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %526 = "llvm.extractelement"(%520, %525) : (vector<8xi32>, i64) -> i32
    %527 = "llvm.bitcast"(%524) : (i32) -> f32
    %528 = "llvm.bitcast"(%526) : (i32) -> f32
    %529 = "nvvm.convert.f32x2.to.f16x2"(%528, %527) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %530 = "llvm.bitcast"(%529) : (vector<2xf16>) -> i32
    %531 = "llvm.insertelement"(%521, %530, %522) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %532 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %533 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %534 = "llvm.extractelement"(%520, %533) : (vector<8xi32>, i64) -> i32
    %535 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %536 = "llvm.extractelement"(%520, %535) : (vector<8xi32>, i64) -> i32
    %537 = "llvm.bitcast"(%534) : (i32) -> f32
    %538 = "llvm.bitcast"(%536) : (i32) -> f32
    %539 = "nvvm.convert.f32x2.to.f16x2"(%538, %537) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %540 = "llvm.bitcast"(%539) : (vector<2xf16>) -> i32
    %541 = "llvm.insertelement"(%531, %540, %532) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %542 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %543 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %544 = "llvm.extractelement"(%520, %543) : (vector<8xi32>, i64) -> i32
    %545 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %546 = "llvm.extractelement"(%520, %545) : (vector<8xi32>, i64) -> i32
    %547 = "llvm.bitcast"(%544) : (i32) -> f32
    %548 = "llvm.bitcast"(%546) : (i32) -> f32
    %549 = "nvvm.convert.f32x2.to.f16x2"(%548, %547) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %550 = "llvm.bitcast"(%549) : (vector<2xf16>) -> i32
    %551 = "llvm.insertelement"(%541, %550, %542) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %552 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %553 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %554 = "llvm.extractelement"(%520, %553) : (vector<8xi32>, i64) -> i32
    %555 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %556 = "llvm.extractelement"(%520, %555) : (vector<8xi32>, i64) -> i32
    %557 = "llvm.bitcast"(%554) : (i32) -> f32
    %558 = "llvm.bitcast"(%556) : (i32) -> f32
    %559 = "nvvm.convert.f32x2.to.f16x2"(%558, %557) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %560 = "llvm.bitcast"(%559) : (vector<2xf16>) -> i32
    %561 = "llvm.insertelement"(%551, %560, %552) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %562 = "llvm.bitcast"(%561) : (vector<4xi32>) -> vector<8xf16>
    %563 = "vector.shape_cast"(%562) : (vector<8xf16>) -> vector<2x4xf16>
    "func.return"(%563) : (vector<2x4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4x2xf32>) -> vector<4x2xf8E4M3FN>, sym_name = "fptrunc_v4x2_f32_to_f8"}> ({
  ^bb0(%arg21: vector<4x2xf32>):
    %469 = "vector.shape_cast"(%arg21) : (vector<4x2xf32>) -> vector<8xf32>
    %470 = "llvm.bitcast"(%469) : (vector<8xf32>) -> vector<8xi32>
    %471 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %472 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %473 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %474 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %475 = "llvm.extractelement"(%470, %474) : (vector<8xi32>, i64) -> i32
    %476 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %477 = "llvm.extractelement"(%470, %476) : (vector<8xi32>, i64) -> i32
    %478 = "llvm.bitcast"(%475) : (i32) -> f32
    %479 = "llvm.bitcast"(%477) : (i32) -> f32
    %480 = "nvvm.convert.f32x2.to.f8x2"(%479, %478) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %481 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %482 = "llvm.insertelement"(%473, %480, %481) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %483 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %484 = "llvm.extractelement"(%470, %483) : (vector<8xi32>, i64) -> i32
    %485 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %486 = "llvm.extractelement"(%470, %485) : (vector<8xi32>, i64) -> i32
    %487 = "llvm.bitcast"(%484) : (i32) -> f32
    %488 = "llvm.bitcast"(%486) : (i32) -> f32
    %489 = "nvvm.convert.f32x2.to.f8x2"(%488, %487) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %490 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %491 = "llvm.insertelement"(%482, %489, %490) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %492 = "llvm.bitcast"(%491) : (vector<2xi16>) -> i32
    %493 = "llvm.insertelement"(%471, %492, %472) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %494 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %495 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %496 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %497 = "llvm.extractelement"(%470, %496) : (vector<8xi32>, i64) -> i32
    %498 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %499 = "llvm.extractelement"(%470, %498) : (vector<8xi32>, i64) -> i32
    %500 = "llvm.bitcast"(%497) : (i32) -> f32
    %501 = "llvm.bitcast"(%499) : (i32) -> f32
    %502 = "nvvm.convert.f32x2.to.f8x2"(%501, %500) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %503 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %504 = "llvm.insertelement"(%495, %502, %503) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %505 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %506 = "llvm.extractelement"(%470, %505) : (vector<8xi32>, i64) -> i32
    %507 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %508 = "llvm.extractelement"(%470, %507) : (vector<8xi32>, i64) -> i32
    %509 = "llvm.bitcast"(%506) : (i32) -> f32
    %510 = "llvm.bitcast"(%508) : (i32) -> f32
    %511 = "nvvm.convert.f32x2.to.f8x2"(%510, %509) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %512 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %513 = "llvm.insertelement"(%504, %511, %512) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %514 = "llvm.bitcast"(%513) : (vector<2xi16>) -> i32
    %515 = "llvm.insertelement"(%493, %514, %494) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %516 = "llvm.bitcast"(%515) : (vector<2xi32>) -> vector<8xi8>
    %517 = "builtin.unrealized_conversion_cast"(%516) : (vector<8xi8>) -> vector<8xf8E4M3FN>
    %518 = "vector.shape_cast"(%517) : (vector<8xf8E4M3FN>) -> vector<4x2xf8E4M3FN>
    "func.return"(%518) : (vector<4x2xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>) -> vector<1xf16>, sym_name = "fptrunc_v1f32_to_v1f16"}> ({
  ^bb0(%arg20: vector<1xf32>):
    %453 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2xf32>}> : () -> vector<2xf32>
    %454 = "vector.insert_strided_slice"(%arg20, %453) <{offsets = [0], strides = [1]}> : (vector<1xf32>, vector<2xf32>) -> vector<2xf32>
    %455 = "llvm.bitcast"(%454) : (vector<2xf32>) -> vector<2xi32>
    %456 = "llvm.mlir.undef"() : () -> vector<1xi32>
    %457 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %458 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %459 = "llvm.extractelement"(%455, %458) : (vector<2xi32>, i64) -> i32
    %460 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %461 = "llvm.extractelement"(%455, %460) : (vector<2xi32>, i64) -> i32
    %462 = "llvm.bitcast"(%459) : (i32) -> f32
    %463 = "llvm.bitcast"(%461) : (i32) -> f32
    %464 = "nvvm.convert.f32x2.to.f16x2"(%463, %462) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %465 = "llvm.bitcast"(%464) : (vector<2xf16>) -> i32
    %466 = "llvm.insertelement"(%456, %465, %457) : (vector<1xi32>, i32, i64) -> vector<1xi32>
    %467 = "llvm.bitcast"(%466) : (vector<1xi32>) -> vector<2xf16>
    %468 = "vector.extract_strided_slice"(%467) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf16>) -> vector<1xf16>
    "func.return"(%468) : (vector<1xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf16>) -> vector<3xf8E4M3FN>, sym_name = "fptrunc_v3f16_to_v3f8"}> ({
  ^bb0(%arg19: vector<3xf16>):
    %430 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf16>}> : () -> vector<4xf16>
    %431 = "vector.insert_strided_slice"(%arg19, %430) <{offsets = [0], strides = [1]}> : (vector<3xf16>, vector<4xf16>) -> vector<4xf16>
    %432 = "llvm.bitcast"(%431) : (vector<4xf16>) -> vector<2xi32>
    %433 = "llvm.mlir.undef"() : () -> vector<1xi32>
    %434 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %435 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %436 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %437 = "llvm.extractelement"(%432, %436) : (vector<2xi32>, i64) -> i32
    %438 = "llvm.bitcast"(%437) : (i32) -> vector<2xf16>
    %439 = "nvvm.convert.f16x2.to.f8x2"(%438) <{dstTy = f8E4M3FN, relu = false}> : (vector<2xf16>) -> i16
    %440 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %441 = "llvm.insertelement"(%435, %439, %440) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %442 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %443 = "llvm.extractelement"(%432, %442) : (vector<2xi32>, i64) -> i32
    %444 = "llvm.bitcast"(%443) : (i32) -> vector<2xf16>
    %445 = "nvvm.convert.f16x2.to.f8x2"(%444) <{dstTy = f8E4M3FN, relu = false}> : (vector<2xf16>) -> i16
    %446 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %447 = "llvm.insertelement"(%441, %445, %446) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %448 = "llvm.bitcast"(%447) : (vector<2xi16>) -> i32
    %449 = "llvm.insertelement"(%433, %448, %434) : (vector<1xi32>, i32, i64) -> vector<1xi32>
    %450 = "llvm.bitcast"(%449) : (vector<1xi32>) -> vector<4xi8>
    %451 = "builtin.unrealized_conversion_cast"(%450) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    %452 = "vector.extract_strided_slice"(%451) <{offsets = [0], sizes = [3], strides = [1]}> : (vector<4xf8E4M3FN>) -> vector<3xf8E4M3FN>
    "func.return"(%452) : (vector<3xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3x1xf32>) -> vector<3x1xf16>, sym_name = "fptrunc_v3x1_f32_to_f16"}> ({
  ^bb0(%arg18: vector<3x1xf32>):
    %402 = "vector.shape_cast"(%arg18) : (vector<3x1xf32>) -> vector<3xf32>
    %403 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %404 = "vector.insert_strided_slice"(%402, %403) <{offsets = [0], strides = [1]}> : (vector<3xf32>, vector<4xf32>) -> vector<4xf32>
    %405 = "llvm.bitcast"(%404) : (vector<4xf32>) -> vector<4xi32>
    %406 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %407 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %408 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %409 = "llvm.extractelement"(%405, %408) : (vector<4xi32>, i64) -> i32
    %410 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %411 = "llvm.extractelement"(%405, %410) : (vector<4xi32>, i64) -> i32
    %412 = "llvm.bitcast"(%409) : (i32) -> f32
    %413 = "llvm.bitcast"(%411) : (i32) -> f32
    %414 = "nvvm.convert.f32x2.to.f16x2"(%413, %412) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %415 = "llvm.bitcast"(%414) : (vector<2xf16>) -> i32
    %416 = "llvm.insertelement"(%406, %415, %407) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %417 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %418 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %419 = "llvm.extractelement"(%405, %418) : (vector<4xi32>, i64) -> i32
    %420 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %421 = "llvm.extractelement"(%405, %420) : (vector<4xi32>, i64) -> i32
    %422 = "llvm.bitcast"(%419) : (i32) -> f32
    %423 = "llvm.bitcast"(%421) : (i32) -> f32
    %424 = "nvvm.convert.f32x2.to.f16x2"(%423, %422) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %425 = "llvm.bitcast"(%424) : (vector<2xf16>) -> i32
    %426 = "llvm.insertelement"(%416, %425, %417) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %427 = "llvm.bitcast"(%426) : (vector<2xi32>) -> vector<4xf16>
    %428 = "vector.extract_strided_slice"(%427) <{offsets = [0], sizes = [3], strides = [1]}> : (vector<4xf16>) -> vector<3xf16>
    %429 = "vector.shape_cast"(%428) : (vector<3xf16>) -> vector<3x1xf16>
    "func.return"(%429) : (vector<3x1xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf64>) -> vector<4xf32>, sym_name = "fptrunc_f64_to_f32"}> ({
  ^bb0(%arg17: vector<4xf64>):
    %401 = "llvm.fptrunc"(%arg17) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf64>) -> vector<4xf32>
    "func.return"(%401) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf64>) -> vector<2xf16>, sym_name = "fptrunc_f64_to_f16"}> ({
  ^bb0(%arg16: vector<2xf64>):
    %397 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf64>}> : () -> vector<4xf64>
    %398 = "vector.insert_strided_slice"(%arg16, %397) <{offsets = [0], strides = [1]}> : (vector<2xf64>, vector<4xf64>) -> vector<4xf64>
    %399 = "llvm.fptrunc"(%398) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf64>) -> vector<4xf16>
    %400 = "vector.extract_strided_slice"(%399) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf16>) -> vector<2xf16>
    "func.return"(%400) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf64>) -> vector<2xbf16>, sym_name = "fptrunc_f64_to_bf16"}> ({
  ^bb0(%arg15: vector<2xf64>):
    %393 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf64>}> : () -> vector<4xf64>
    %394 = "vector.insert_strided_slice"(%arg15, %393) <{offsets = [0], strides = [1]}> : (vector<2xf64>, vector<4xf64>) -> vector<4xf64>
    %395 = "llvm.fptrunc"(%394) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf64>) -> vector<4xbf16>
    %396 = "vector.extract_strided_slice"(%395) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xbf16>) -> vector<2xbf16>
    "func.return"(%396) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf64>) -> vector<4xf8E4M3FN>, sym_name = "fptrunc_f64_to_f8"}> ({
  ^bb0(%arg14: vector<4xf64>):
    %341 = "arith.constant"() <{value = dense<0.000000e+00> : vector<8xf64>}> : () -> vector<8xf64>
    %342 = "vector.insert_strided_slice"(%arg14, %341) <{offsets = [0], strides = [1]}> : (vector<4xf64>, vector<8xf64>) -> vector<8xf64>
    %343 = "llvm.fptrunc"(%342) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf64>) -> vector<8xf32>
    %344 = "llvm.bitcast"(%343) : (vector<8xf32>) -> vector<8xi32>
    %345 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %346 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %347 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %348 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %349 = "llvm.extractelement"(%344, %348) : (vector<8xi32>, i64) -> i32
    %350 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %351 = "llvm.extractelement"(%344, %350) : (vector<8xi32>, i64) -> i32
    %352 = "llvm.bitcast"(%349) : (i32) -> f32
    %353 = "llvm.bitcast"(%351) : (i32) -> f32
    %354 = "nvvm.convert.f32x2.to.f8x2"(%353, %352) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %355 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %356 = "llvm.insertelement"(%347, %354, %355) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %357 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %358 = "llvm.extractelement"(%344, %357) : (vector<8xi32>, i64) -> i32
    %359 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %360 = "llvm.extractelement"(%344, %359) : (vector<8xi32>, i64) -> i32
    %361 = "llvm.bitcast"(%358) : (i32) -> f32
    %362 = "llvm.bitcast"(%360) : (i32) -> f32
    %363 = "nvvm.convert.f32x2.to.f8x2"(%362, %361) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %364 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %365 = "llvm.insertelement"(%356, %363, %364) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %366 = "llvm.bitcast"(%365) : (vector<2xi16>) -> i32
    %367 = "llvm.insertelement"(%345, %366, %346) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %368 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %369 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %370 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %371 = "llvm.extractelement"(%344, %370) : (vector<8xi32>, i64) -> i32
    %372 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %373 = "llvm.extractelement"(%344, %372) : (vector<8xi32>, i64) -> i32
    %374 = "llvm.bitcast"(%371) : (i32) -> f32
    %375 = "llvm.bitcast"(%373) : (i32) -> f32
    %376 = "nvvm.convert.f32x2.to.f8x2"(%375, %374) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %377 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %378 = "llvm.insertelement"(%369, %376, %377) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %379 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %380 = "llvm.extractelement"(%344, %379) : (vector<8xi32>, i64) -> i32
    %381 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %382 = "llvm.extractelement"(%344, %381) : (vector<8xi32>, i64) -> i32
    %383 = "llvm.bitcast"(%380) : (i32) -> f32
    %384 = "llvm.bitcast"(%382) : (i32) -> f32
    %385 = "nvvm.convert.f32x2.to.f8x2"(%384, %383) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %386 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %387 = "llvm.insertelement"(%378, %385, %386) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %388 = "llvm.bitcast"(%387) : (vector<2xi16>) -> i32
    %389 = "llvm.insertelement"(%367, %388, %368) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %390 = "llvm.bitcast"(%389) : (vector<2xi32>) -> vector<8xi8>
    %391 = "builtin.unrealized_conversion_cast"(%390) : (vector<8xi8>) -> vector<8xf8E4M3FN>
    %392 = "vector.extract_strided_slice"(%391) <{offsets = [0], sizes = [4], strides = [1]}> : (vector<8xf8E4M3FN>) -> vector<4xf8E4M3FN>
    "func.return"(%392) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "fptrunc_f32_to_f8_satfinite"}> ({
  ^bb0(%arg13: vector<8xf32>):
    %294 = "llvm.bitcast"(%arg13) : (vector<8xf32>) -> vector<8xi32>
    %295 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %296 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %297 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %298 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %299 = "llvm.extractelement"(%294, %298) : (vector<8xi32>, i64) -> i32
    %300 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %301 = "llvm.extractelement"(%294, %300) : (vector<8xi32>, i64) -> i32
    %302 = "llvm.bitcast"(%299) : (i32) -> f32
    %303 = "llvm.bitcast"(%301) : (i32) -> f32
    %304 = "nvvm.convert.f32x2.to.f8x2"(%303, %302) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %305 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %306 = "llvm.insertelement"(%297, %304, %305) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %307 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %308 = "llvm.extractelement"(%294, %307) : (vector<8xi32>, i64) -> i32
    %309 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %310 = "llvm.extractelement"(%294, %309) : (vector<8xi32>, i64) -> i32
    %311 = "llvm.bitcast"(%308) : (i32) -> f32
    %312 = "llvm.bitcast"(%310) : (i32) -> f32
    %313 = "nvvm.convert.f32x2.to.f8x2"(%312, %311) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %314 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %315 = "llvm.insertelement"(%306, %313, %314) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %316 = "llvm.bitcast"(%315) : (vector<2xi16>) -> i32
    %317 = "llvm.insertelement"(%295, %316, %296) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %318 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %319 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %320 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %321 = "llvm.extractelement"(%294, %320) : (vector<8xi32>, i64) -> i32
    %322 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %323 = "llvm.extractelement"(%294, %322) : (vector<8xi32>, i64) -> i32
    %324 = "llvm.bitcast"(%321) : (i32) -> f32
    %325 = "llvm.bitcast"(%323) : (i32) -> f32
    %326 = "nvvm.convert.f32x2.to.f8x2"(%325, %324) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %327 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %328 = "llvm.insertelement"(%319, %326, %327) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %329 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %330 = "llvm.extractelement"(%294, %329) : (vector<8xi32>, i64) -> i32
    %331 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %332 = "llvm.extractelement"(%294, %331) : (vector<8xi32>, i64) -> i32
    %333 = "llvm.bitcast"(%330) : (i32) -> f32
    %334 = "llvm.bitcast"(%332) : (i32) -> f32
    %335 = "nvvm.convert.f32x2.to.f8x2"(%334, %333) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %336 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %337 = "llvm.insertelement"(%328, %335, %336) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %338 = "llvm.bitcast"(%337) : (vector<2xi16>) -> i32
    %339 = "llvm.insertelement"(%317, %338, %318) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %340 = "llvm.bitcast"(%339) : (vector<2xi32>) -> vector<8xi8>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_f16_relu"}> ({
  ^bb0(%arg12: vector<4xf32>):
    %271 = "llvm.bitcast"(%arg12) : (vector<4xf32>) -> vector<4xi32>
    %272 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %273 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %274 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %275 = "llvm.extractelement"(%271, %274) : (vector<4xi32>, i64) -> i32
    %276 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %277 = "llvm.extractelement"(%271, %276) : (vector<4xi32>, i64) -> i32
    %278 = "llvm.bitcast"(%275) : (i32) -> f32
    %279 = "llvm.bitcast"(%277) : (i32) -> f32
    %280 = "nvvm.convert.f32x2.to.f16x2"(%279, %278) <{relu = true, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %281 = "llvm.bitcast"(%280) : (vector<2xf16>) -> i32
    %282 = "llvm.insertelement"(%272, %281, %273) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %283 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %284 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %285 = "llvm.extractelement"(%271, %284) : (vector<4xi32>, i64) -> i32
    %286 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %287 = "llvm.extractelement"(%271, %286) : (vector<4xi32>, i64) -> i32
    %288 = "llvm.bitcast"(%285) : (i32) -> f32
    %289 = "llvm.bitcast"(%287) : (i32) -> f32
    %290 = "nvvm.convert.f32x2.to.f16x2"(%289, %288) <{relu = true, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %291 = "llvm.bitcast"(%290) : (vector<2xf16>) -> i32
    %292 = "llvm.insertelement"(%282, %291, %283) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %293 = "llvm.bitcast"(%292) : (vector<2xi32>) -> vector<4xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "fptrunc_f32_to_f8_default_sat"}> ({
  ^bb0(%arg11: vector<8xf32>):
    %224 = "llvm.bitcast"(%arg11) : (vector<8xf32>) -> vector<8xi32>
    %225 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %226 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %227 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %228 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %229 = "llvm.extractelement"(%224, %228) : (vector<8xi32>, i64) -> i32
    %230 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %231 = "llvm.extractelement"(%224, %230) : (vector<8xi32>, i64) -> i32
    %232 = "llvm.bitcast"(%229) : (i32) -> f32
    %233 = "llvm.bitcast"(%231) : (i32) -> f32
    %234 = "nvvm.convert.f32x2.to.f8x2"(%233, %232) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %235 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %236 = "llvm.insertelement"(%227, %234, %235) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %237 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %238 = "llvm.extractelement"(%224, %237) : (vector<8xi32>, i64) -> i32
    %239 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %240 = "llvm.extractelement"(%224, %239) : (vector<8xi32>, i64) -> i32
    %241 = "llvm.bitcast"(%238) : (i32) -> f32
    %242 = "llvm.bitcast"(%240) : (i32) -> f32
    %243 = "nvvm.convert.f32x2.to.f8x2"(%242, %241) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %244 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %245 = "llvm.insertelement"(%236, %243, %244) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %246 = "llvm.bitcast"(%245) : (vector<2xi16>) -> i32
    %247 = "llvm.insertelement"(%225, %246, %226) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %248 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %249 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %250 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %251 = "llvm.extractelement"(%224, %250) : (vector<8xi32>, i64) -> i32
    %252 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %253 = "llvm.extractelement"(%224, %252) : (vector<8xi32>, i64) -> i32
    %254 = "llvm.bitcast"(%251) : (i32) -> f32
    %255 = "llvm.bitcast"(%253) : (i32) -> f32
    %256 = "nvvm.convert.f32x2.to.f8x2"(%255, %254) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %257 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %258 = "llvm.insertelement"(%249, %256, %257) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %259 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %260 = "llvm.extractelement"(%224, %259) : (vector<8xi32>, i64) -> i32
    %261 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %262 = "llvm.extractelement"(%224, %261) : (vector<8xi32>, i64) -> i32
    %263 = "llvm.bitcast"(%260) : (i32) -> f32
    %264 = "llvm.bitcast"(%262) : (i32) -> f32
    %265 = "nvvm.convert.f32x2.to.f8x2"(%264, %263) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %266 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %267 = "llvm.insertelement"(%258, %265, %266) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %268 = "llvm.bitcast"(%267) : (vector<2xi16>) -> i32
    %269 = "llvm.insertelement"(%247, %268, %248) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %270 = "llvm.bitcast"(%269) : (vector<2xi32>) -> vector<8xi8>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_f16_default_sat"}> ({
  ^bb0(%arg10: vector<4xf32>):
    %201 = "llvm.bitcast"(%arg10) : (vector<4xf32>) -> vector<4xi32>
    %202 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %203 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %204 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %205 = "llvm.extractelement"(%201, %204) : (vector<4xi32>, i64) -> i32
    %206 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %207 = "llvm.extractelement"(%201, %206) : (vector<4xi32>, i64) -> i32
    %208 = "llvm.bitcast"(%205) : (i32) -> f32
    %209 = "llvm.bitcast"(%207) : (i32) -> f32
    %210 = "nvvm.convert.f32x2.to.f16x2"(%209, %208) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %211 = "llvm.bitcast"(%210) : (vector<2xf16>) -> i32
    %212 = "llvm.insertelement"(%202, %211, %203) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %213 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %214 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %215 = "llvm.extractelement"(%201, %214) : (vector<4xi32>, i64) -> i32
    %216 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %217 = "llvm.extractelement"(%201, %216) : (vector<4xi32>, i64) -> i32
    %218 = "llvm.bitcast"(%215) : (i32) -> f32
    %219 = "llvm.bitcast"(%217) : (i32) -> f32
    %220 = "nvvm.convert.f32x2.to.f16x2"(%219, %218) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %221 = "llvm.bitcast"(%220) : (vector<2xf16>) -> i32
    %222 = "llvm.insertelement"(%212, %221, %213) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %223 = "llvm.bitcast"(%222) : (vector<2xi32>) -> vector<4xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_f16_explicit_none"}> ({
  ^bb0(%arg9: vector<4xf32>):
    %178 = "llvm.bitcast"(%arg9) : (vector<4xf32>) -> vector<4xi32>
    %179 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %180 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %181 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %182 = "llvm.extractelement"(%178, %181) : (vector<4xi32>, i64) -> i32
    %183 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %184 = "llvm.extractelement"(%178, %183) : (vector<4xi32>, i64) -> i32
    %185 = "llvm.bitcast"(%182) : (i32) -> f32
    %186 = "llvm.bitcast"(%184) : (i32) -> f32
    %187 = "nvvm.convert.f32x2.to.f16x2"(%186, %185) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<none>}> : (f32, f32) -> vector<2xf16>
    %188 = "llvm.bitcast"(%187) : (vector<2xf16>) -> i32
    %189 = "llvm.insertelement"(%179, %188, %180) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %190 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %191 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %192 = "llvm.extractelement"(%178, %191) : (vector<4xi32>, i64) -> i32
    %193 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %194 = "llvm.extractelement"(%178, %193) : (vector<4xi32>, i64) -> i32
    %195 = "llvm.bitcast"(%192) : (i32) -> f32
    %196 = "llvm.bitcast"(%194) : (i32) -> f32
    %197 = "nvvm.convert.f32x2.to.f16x2"(%196, %195) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<none>}> : (f32, f32) -> vector<2xf16>
    %198 = "llvm.bitcast"(%197) : (vector<2xf16>) -> i32
    %199 = "llvm.insertelement"(%189, %198, %190) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %200 = "llvm.bitcast"(%199) : (vector<2xi32>) -> vector<4xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, i32) -> (), sym_name = "fptrunc_f32_to_f16_rs"}> ({
  ^bb0(%arg7: vector<4xf32>, %arg8: i32):
    %155 = "llvm.bitcast"(%arg7) : (vector<4xf32>) -> vector<4xi32>
    %156 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %157 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %158 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %159 = "llvm.extractelement"(%155, %158) : (vector<4xi32>, i64) -> i32
    %160 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %161 = "llvm.extractelement"(%155, %160) : (vector<4xi32>, i64) -> i32
    %162 = "llvm.bitcast"(%159) : (i32) -> f32
    %163 = "llvm.bitcast"(%161) : (i32) -> f32
    %164 = "nvvm.convert.f32x2.to.f16x2"(%163, %162, %arg8) <{relu = false, rnd = #nvvm.fp_rnd_mode<rs>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32, i32) -> vector<2xf16>
    %165 = "llvm.bitcast"(%164) : (vector<2xf16>) -> i32
    %166 = "llvm.insertelement"(%156, %165, %157) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %167 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %168 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %169 = "llvm.extractelement"(%155, %168) : (vector<4xi32>, i64) -> i32
    %170 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %171 = "llvm.extractelement"(%155, %170) : (vector<4xi32>, i64) -> i32
    %172 = "llvm.bitcast"(%169) : (i32) -> f32
    %173 = "llvm.bitcast"(%171) : (i32) -> f32
    %174 = "nvvm.convert.f32x2.to.f16x2"(%173, %172, %arg8) <{relu = false, rnd = #nvvm.fp_rnd_mode<rs>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32, i32) -> vector<2xf16>
    %175 = "llvm.bitcast"(%174) : (vector<2xf16>) -> i32
    %176 = "llvm.insertelement"(%166, %175, %167) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %177 = "llvm.bitcast"(%176) : (vector<2xi32>) -> vector<4xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, i32) -> (), sym_name = "fptrunc_f32_to_bf16_rs"}> ({
  ^bb0(%arg5: vector<4xf32>, %arg6: i32):
    %132 = "llvm.bitcast"(%arg5) : (vector<4xf32>) -> vector<4xi32>
    %133 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %134 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %135 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %136 = "llvm.extractelement"(%132, %135) : (vector<4xi32>, i64) -> i32
    %137 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %138 = "llvm.extractelement"(%132, %137) : (vector<4xi32>, i64) -> i32
    %139 = "llvm.bitcast"(%136) : (i32) -> f32
    %140 = "llvm.bitcast"(%138) : (i32) -> f32
    %141 = "nvvm.convert.f32x2.to.bf16x2"(%140, %139, %arg6) <{relu = false, rnd = #nvvm.fp_rnd_mode<rs>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32, i32) -> vector<2xbf16>
    %142 = "llvm.bitcast"(%141) : (vector<2xbf16>) -> i32
    %143 = "llvm.insertelement"(%133, %142, %134) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %144 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %145 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %146 = "llvm.extractelement"(%132, %145) : (vector<4xi32>, i64) -> i32
    %147 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %148 = "llvm.extractelement"(%132, %147) : (vector<4xi32>, i64) -> i32
    %149 = "llvm.bitcast"(%146) : (i32) -> f32
    %150 = "llvm.bitcast"(%148) : (i32) -> f32
    %151 = "nvvm.convert.f32x2.to.bf16x2"(%150, %149, %arg6) <{relu = false, rnd = #nvvm.fp_rnd_mode<rs>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32, i32) -> vector<2xbf16>
    %152 = "llvm.bitcast"(%151) : (vector<2xbf16>) -> i32
    %153 = "llvm.insertelement"(%143, %152, %144) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %154 = "llvm.bitcast"(%153) : (vector<2xi32>) -> vector<4xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_f16_rz"}> ({
  ^bb0(%arg4: vector<4xf32>):
    %109 = "llvm.bitcast"(%arg4) : (vector<4xf32>) -> vector<4xi32>
    %110 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %111 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %112 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %113 = "llvm.extractelement"(%109, %112) : (vector<4xi32>, i64) -> i32
    %114 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %115 = "llvm.extractelement"(%109, %114) : (vector<4xi32>, i64) -> i32
    %116 = "llvm.bitcast"(%113) : (i32) -> f32
    %117 = "llvm.bitcast"(%115) : (i32) -> f32
    %118 = "nvvm.convert.f32x2.to.f16x2"(%117, %116) <{relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %119 = "llvm.bitcast"(%118) : (vector<2xf16>) -> i32
    %120 = "llvm.insertelement"(%110, %119, %111) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %121 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %122 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %123 = "llvm.extractelement"(%109, %122) : (vector<4xi32>, i64) -> i32
    %124 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %125 = "llvm.extractelement"(%109, %124) : (vector<4xi32>, i64) -> i32
    %126 = "llvm.bitcast"(%123) : (i32) -> f32
    %127 = "llvm.bitcast"(%125) : (i32) -> f32
    %128 = "nvvm.convert.f32x2.to.f16x2"(%127, %126) <{relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %129 = "llvm.bitcast"(%128) : (vector<2xf16>) -> i32
    %130 = "llvm.insertelement"(%120, %129, %121) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %131 = "llvm.bitcast"(%130) : (vector<2xi32>) -> vector<4xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_bf16_rz"}> ({
  ^bb0(%arg3: vector<4xf32>):
    %86 = "llvm.bitcast"(%arg3) : (vector<4xf32>) -> vector<4xi32>
    %87 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %88 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %89 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %90 = "llvm.extractelement"(%86, %89) : (vector<4xi32>, i64) -> i32
    %91 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %92 = "llvm.extractelement"(%86, %91) : (vector<4xi32>, i64) -> i32
    %93 = "llvm.bitcast"(%90) : (i32) -> f32
    %94 = "llvm.bitcast"(%92) : (i32) -> f32
    %95 = "nvvm.convert.f32x2.to.bf16x2"(%94, %93) <{relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xbf16>
    %96 = "llvm.bitcast"(%95) : (vector<2xbf16>) -> i32
    %97 = "llvm.insertelement"(%87, %96, %88) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %98 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %99 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %100 = "llvm.extractelement"(%86, %99) : (vector<4xi32>, i64) -> i32
    %101 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %102 = "llvm.extractelement"(%86, %101) : (vector<4xi32>, i64) -> i32
    %103 = "llvm.bitcast"(%100) : (i32) -> f32
    %104 = "llvm.bitcast"(%102) : (i32) -> f32
    %105 = "nvvm.convert.f32x2.to.bf16x2"(%104, %103) <{relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xbf16>
    %106 = "llvm.bitcast"(%105) : (vector<2xbf16>) -> i32
    %107 = "llvm.insertelement"(%97, %106, %98) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %108 = "llvm.bitcast"(%107) : (vector<2xi32>) -> vector<4xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f16, sym_name = "e2e_scalar_f32_to_f16"}> ({
  ^bb0(%arg2: f32):
    %68 = "vector.broadcast"(%arg2) : (f32) -> vector<1xf32>
    %69 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2xf32>}> : () -> vector<2xf32>
    %70 = "vector.insert_strided_slice"(%68, %69) <{offsets = [0], strides = [1]}> : (vector<1xf32>, vector<2xf32>) -> vector<2xf32>
    %71 = "llvm.bitcast"(%70) : (vector<2xf32>) -> vector<2xi32>
    %72 = "llvm.mlir.undef"() : () -> vector<1xi32>
    %73 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %74 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %75 = "llvm.extractelement"(%71, %74) : (vector<2xi32>, i64) -> i32
    %76 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %77 = "llvm.extractelement"(%71, %76) : (vector<2xi32>, i64) -> i32
    %78 = "llvm.bitcast"(%75) : (i32) -> f32
    %79 = "llvm.bitcast"(%77) : (i32) -> f32
    %80 = "nvvm.convert.f32x2.to.f16x2"(%79, %78) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %81 = "llvm.bitcast"(%80) : (vector<2xf16>) -> i32
    %82 = "llvm.insertelement"(%72, %81, %73) : (vector<1xi32>, i32, i64) -> vector<1xi32>
    %83 = "llvm.bitcast"(%82) : (vector<1xi32>) -> vector<2xf16>
    %84 = "vector.extract_strided_slice"(%83) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf16>) -> vector<1xf16>
    %85 = "vector.extract"(%84) <{static_position = array<i64: 0>}> : (vector<1xf16>) -> f16
    "func.return"(%85) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf32>) -> vector<2x4xf16>, sym_name = "e2e_v2x4_f32_to_f16"}> ({
  ^bb0(%arg1: vector<2x4xf32>):
    %23 = "vector.shape_cast"(%arg1) : (vector<2x4xf32>) -> vector<8xf32>
    %24 = "llvm.bitcast"(%23) : (vector<8xf32>) -> vector<8xi32>
    %25 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %26 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %27 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %28 = "llvm.extractelement"(%24, %27) : (vector<8xi32>, i64) -> i32
    %29 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %30 = "llvm.extractelement"(%24, %29) : (vector<8xi32>, i64) -> i32
    %31 = "llvm.bitcast"(%28) : (i32) -> f32
    %32 = "llvm.bitcast"(%30) : (i32) -> f32
    %33 = "nvvm.convert.f32x2.to.f16x2"(%32, %31) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %34 = "llvm.bitcast"(%33) : (vector<2xf16>) -> i32
    %35 = "llvm.insertelement"(%25, %34, %26) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %36 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %37 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %38 = "llvm.extractelement"(%24, %37) : (vector<8xi32>, i64) -> i32
    %39 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %40 = "llvm.extractelement"(%24, %39) : (vector<8xi32>, i64) -> i32
    %41 = "llvm.bitcast"(%38) : (i32) -> f32
    %42 = "llvm.bitcast"(%40) : (i32) -> f32
    %43 = "nvvm.convert.f32x2.to.f16x2"(%42, %41) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %44 = "llvm.bitcast"(%43) : (vector<2xf16>) -> i32
    %45 = "llvm.insertelement"(%35, %44, %36) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %46 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %47 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %48 = "llvm.extractelement"(%24, %47) : (vector<8xi32>, i64) -> i32
    %49 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %50 = "llvm.extractelement"(%24, %49) : (vector<8xi32>, i64) -> i32
    %51 = "llvm.bitcast"(%48) : (i32) -> f32
    %52 = "llvm.bitcast"(%50) : (i32) -> f32
    %53 = "nvvm.convert.f32x2.to.f16x2"(%52, %51) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %54 = "llvm.bitcast"(%53) : (vector<2xf16>) -> i32
    %55 = "llvm.insertelement"(%45, %54, %46) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %56 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %57 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %58 = "llvm.extractelement"(%24, %57) : (vector<8xi32>, i64) -> i32
    %59 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %60 = "llvm.extractelement"(%24, %59) : (vector<8xi32>, i64) -> i32
    %61 = "llvm.bitcast"(%58) : (i32) -> f32
    %62 = "llvm.bitcast"(%60) : (i32) -> f32
    %63 = "nvvm.convert.f32x2.to.f16x2"(%62, %61) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %64 = "llvm.bitcast"(%63) : (vector<2xf16>) -> i32
    %65 = "llvm.insertelement"(%55, %64, %56) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %66 = "llvm.bitcast"(%65) : (vector<4xi32>) -> vector<8xf16>
    %67 = "vector.shape_cast"(%66) : (vector<8xf16>) -> vector<2x4xf16>
    "func.return"(%67) : (vector<2x4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf16>) -> vector<3xf8E4M3FN>, sym_name = "e2e_v3f16_to_v3f8"}> ({
  ^bb0(%arg0: vector<3xf16>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf16>}> : () -> vector<4xf16>
    %1 = "vector.insert_strided_slice"(%arg0, %0) <{offsets = [0], strides = [1]}> : (vector<3xf16>, vector<4xf16>) -> vector<4xf16>
    %2 = "llvm.bitcast"(%1) : (vector<4xf16>) -> vector<2xi32>
    %3 = "llvm.mlir.undef"() : () -> vector<1xi32>
    %4 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %5 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %6 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %7 = "llvm.extractelement"(%2, %6) : (vector<2xi32>, i64) -> i32
    %8 = "llvm.bitcast"(%7) : (i32) -> vector<2xf16>
    %9 = "nvvm.convert.f16x2.to.f8x2"(%8) <{dstTy = f8E4M3FN, relu = false}> : (vector<2xf16>) -> i16
    %10 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %11 = "llvm.insertelement"(%5, %9, %10) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %12 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %13 = "llvm.extractelement"(%2, %12) : (vector<2xi32>, i64) -> i32
    %14 = "llvm.bitcast"(%13) : (i32) -> vector<2xf16>
    %15 = "nvvm.convert.f16x2.to.f8x2"(%14) <{dstTy = f8E4M3FN, relu = false}> : (vector<2xf16>) -> i16
    %16 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %17 = "llvm.insertelement"(%11, %15, %16) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %18 = "llvm.bitcast"(%17) : (vector<2xi16>) -> i32
    %19 = "llvm.insertelement"(%3, %18, %4) : (vector<1xi32>, i32, i64) -> vector<1xi32>
    %20 = "llvm.bitcast"(%19) : (vector<1xi32>) -> vector<4xi8>
    %21 = "builtin.unrealized_conversion_cast"(%20) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    %22 = "vector.extract_strided_slice"(%21) <{offsets = [0], sizes = [3], strides = [1]}> : (vector<4xf8E4M3FN>) -> vector<3xf8E4M3FN>
    "func.return"(%22) : (vector<3xf8E4M3FN>) -> ()
  }) : () -> ()
}) : () -> ()


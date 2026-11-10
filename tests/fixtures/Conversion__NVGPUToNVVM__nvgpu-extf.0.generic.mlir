"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf8E4M3FN>) -> (), sym_name = "cvt_float_e4m3fn_to_f16"}> ({
  ^bb0(%arg34: vector<8xf8E4M3FN>):
    %1012 = "builtin.unrealized_conversion_cast"(%arg34) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %1013 = "llvm.bitcast"(%1012) : (vector<8xi8>) -> vector<2xi32>
    %1014 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %1015 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %1016 = "llvm.extractelement"(%1013, %1015) : (vector<2xi32>, i64) -> i32
    %1017 = "llvm.bitcast"(%1016) : (i32) -> vector<2xi16>
    %1018 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %1019 = "llvm.extractelement"(%1017, %1018) : (vector<2xi16>, i64) -> i16
    %1020 = "llvm.bitcast"(%1019) : (i16) -> vector<2xi8>
    %1021 = "nvvm.convert.f8x2.to.f16x2"(%1020) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %1022 = "llvm.bitcast"(%1021) : (vector<2xf16>) -> i32
    %1023 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %1024 = "llvm.insertelement"(%1014, %1022, %1023) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %1025 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %1026 = "llvm.extractelement"(%1017, %1025) : (vector<2xi16>, i64) -> i16
    %1027 = "llvm.bitcast"(%1026) : (i16) -> vector<2xi8>
    %1028 = "nvvm.convert.f8x2.to.f16x2"(%1027) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %1029 = "llvm.bitcast"(%1028) : (vector<2xf16>) -> i32
    %1030 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %1031 = "llvm.insertelement"(%1024, %1029, %1030) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %1032 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %1033 = "llvm.extractelement"(%1013, %1032) : (vector<2xi32>, i64) -> i32
    %1034 = "llvm.bitcast"(%1033) : (i32) -> vector<2xi16>
    %1035 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %1036 = "llvm.extractelement"(%1034, %1035) : (vector<2xi16>, i64) -> i16
    %1037 = "llvm.bitcast"(%1036) : (i16) -> vector<2xi8>
    %1038 = "nvvm.convert.f8x2.to.f16x2"(%1037) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %1039 = "llvm.bitcast"(%1038) : (vector<2xf16>) -> i32
    %1040 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %1041 = "llvm.insertelement"(%1031, %1039, %1040) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %1042 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %1043 = "llvm.extractelement"(%1034, %1042) : (vector<2xi16>, i64) -> i16
    %1044 = "llvm.bitcast"(%1043) : (i16) -> vector<2xi8>
    %1045 = "nvvm.convert.f8x2.to.f16x2"(%1044) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %1046 = "llvm.bitcast"(%1045) : (vector<2xf16>) -> i32
    %1047 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %1048 = "llvm.insertelement"(%1041, %1046, %1047) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %1049 = "llvm.bitcast"(%1048) : (vector<4xi32>) -> vector<8xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf8E5M2>) -> (), sym_name = "cvt_float_e5m2_to_f16"}> ({
  ^bb0(%arg33: vector<8xf8E5M2>):
    %974 = "builtin.unrealized_conversion_cast"(%arg33) : (vector<8xf8E5M2>) -> vector<8xi8>
    %975 = "llvm.bitcast"(%974) : (vector<8xi8>) -> vector<2xi32>
    %976 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %977 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %978 = "llvm.extractelement"(%975, %977) : (vector<2xi32>, i64) -> i32
    %979 = "llvm.bitcast"(%978) : (i32) -> vector<2xi16>
    %980 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %981 = "llvm.extractelement"(%979, %980) : (vector<2xi16>, i64) -> i16
    %982 = "llvm.bitcast"(%981) : (i16) -> vector<2xi8>
    %983 = "nvvm.convert.f8x2.to.f16x2"(%982) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %984 = "llvm.bitcast"(%983) : (vector<2xf16>) -> i32
    %985 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %986 = "llvm.insertelement"(%976, %984, %985) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %987 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %988 = "llvm.extractelement"(%979, %987) : (vector<2xi16>, i64) -> i16
    %989 = "llvm.bitcast"(%988) : (i16) -> vector<2xi8>
    %990 = "nvvm.convert.f8x2.to.f16x2"(%989) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %991 = "llvm.bitcast"(%990) : (vector<2xf16>) -> i32
    %992 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %993 = "llvm.insertelement"(%986, %991, %992) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %994 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %995 = "llvm.extractelement"(%975, %994) : (vector<2xi32>, i64) -> i32
    %996 = "llvm.bitcast"(%995) : (i32) -> vector<2xi16>
    %997 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %998 = "llvm.extractelement"(%996, %997) : (vector<2xi16>, i64) -> i16
    %999 = "llvm.bitcast"(%998) : (i16) -> vector<2xi8>
    %1000 = "nvvm.convert.f8x2.to.f16x2"(%999) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %1001 = "llvm.bitcast"(%1000) : (vector<2xf16>) -> i32
    %1002 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %1003 = "llvm.insertelement"(%993, %1001, %1002) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %1004 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %1005 = "llvm.extractelement"(%996, %1004) : (vector<2xi16>, i64) -> i16
    %1006 = "llvm.bitcast"(%1005) : (i16) -> vector<2xi8>
    %1007 = "nvvm.convert.f8x2.to.f16x2"(%1006) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %1008 = "llvm.bitcast"(%1007) : (vector<2xf16>) -> i32
    %1009 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %1010 = "llvm.insertelement"(%1003, %1008, %1009) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %1011 = "llvm.bitcast"(%1010) : (vector<4xi32>) -> vector<8xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf8E8M0FNU>) -> (), sym_name = "cvt_float_e8m0_to_bf16"}> ({
  ^bb0(%arg32: vector<8xf8E8M0FNU>):
    %936 = "builtin.unrealized_conversion_cast"(%arg32) : (vector<8xf8E8M0FNU>) -> vector<8xi8>
    %937 = "llvm.bitcast"(%936) : (vector<8xi8>) -> vector<2xi32>
    %938 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %939 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %940 = "llvm.extractelement"(%937, %939) : (vector<2xi32>, i64) -> i32
    %941 = "llvm.bitcast"(%940) : (i32) -> vector<2xi16>
    %942 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %943 = "llvm.extractelement"(%941, %942) : (vector<2xi16>, i64) -> i16
    %944 = "llvm.bitcast"(%943) : (i16) -> vector<2xi8>
    %945 = "nvvm.convert.f8x2.to.bf16x2"(%944) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f8E8M0FNU}> : (vector<2xi8>) -> vector<2xbf16>
    %946 = "llvm.bitcast"(%945) : (vector<2xbf16>) -> i32
    %947 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %948 = "llvm.insertelement"(%938, %946, %947) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %949 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %950 = "llvm.extractelement"(%941, %949) : (vector<2xi16>, i64) -> i16
    %951 = "llvm.bitcast"(%950) : (i16) -> vector<2xi8>
    %952 = "nvvm.convert.f8x2.to.bf16x2"(%951) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f8E8M0FNU}> : (vector<2xi8>) -> vector<2xbf16>
    %953 = "llvm.bitcast"(%952) : (vector<2xbf16>) -> i32
    %954 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %955 = "llvm.insertelement"(%948, %953, %954) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %956 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %957 = "llvm.extractelement"(%937, %956) : (vector<2xi32>, i64) -> i32
    %958 = "llvm.bitcast"(%957) : (i32) -> vector<2xi16>
    %959 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %960 = "llvm.extractelement"(%958, %959) : (vector<2xi16>, i64) -> i16
    %961 = "llvm.bitcast"(%960) : (i16) -> vector<2xi8>
    %962 = "nvvm.convert.f8x2.to.bf16x2"(%961) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f8E8M0FNU}> : (vector<2xi8>) -> vector<2xbf16>
    %963 = "llvm.bitcast"(%962) : (vector<2xbf16>) -> i32
    %964 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %965 = "llvm.insertelement"(%955, %963, %964) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %966 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %967 = "llvm.extractelement"(%958, %966) : (vector<2xi16>, i64) -> i16
    %968 = "llvm.bitcast"(%967) : (i16) -> vector<2xi8>
    %969 = "nvvm.convert.f8x2.to.bf16x2"(%968) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f8E8M0FNU}> : (vector<2xi8>) -> vector<2xbf16>
    %970 = "llvm.bitcast"(%969) : (vector<2xbf16>) -> i32
    %971 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %972 = "llvm.insertelement"(%965, %970, %971) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %973 = "llvm.bitcast"(%972) : (vector<4xi32>) -> vector<8xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf6E2M3FN>) -> (), sym_name = "cvt_float_e2m3_to_f16"}> ({
  ^bb0(%arg31: vector<8xf6E2M3FN>):
    %897 = "builtin.unrealized_conversion_cast"(%arg31) : (vector<8xf6E2M3FN>) -> vector<8xi6>
    %898 = "llvm.zext"(%897) : (vector<8xi6>) -> vector<8xi8>
    %899 = "llvm.bitcast"(%898) : (vector<8xi8>) -> vector<2xi32>
    %900 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %901 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %902 = "llvm.extractelement"(%899, %901) : (vector<2xi32>, i64) -> i32
    %903 = "llvm.bitcast"(%902) : (i32) -> vector<2xi16>
    %904 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %905 = "llvm.extractelement"(%903, %904) : (vector<2xi16>, i64) -> i16
    %906 = "llvm.bitcast"(%905) : (i16) -> vector<2xi8>
    %907 = "nvvm.convert.f6x2.to.f16x2"(%906) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %908 = "llvm.bitcast"(%907) : (vector<2xf16>) -> i32
    %909 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %910 = "llvm.insertelement"(%900, %908, %909) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %911 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %912 = "llvm.extractelement"(%903, %911) : (vector<2xi16>, i64) -> i16
    %913 = "llvm.bitcast"(%912) : (i16) -> vector<2xi8>
    %914 = "nvvm.convert.f6x2.to.f16x2"(%913) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %915 = "llvm.bitcast"(%914) : (vector<2xf16>) -> i32
    %916 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %917 = "llvm.insertelement"(%910, %915, %916) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %918 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %919 = "llvm.extractelement"(%899, %918) : (vector<2xi32>, i64) -> i32
    %920 = "llvm.bitcast"(%919) : (i32) -> vector<2xi16>
    %921 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %922 = "llvm.extractelement"(%920, %921) : (vector<2xi16>, i64) -> i16
    %923 = "llvm.bitcast"(%922) : (i16) -> vector<2xi8>
    %924 = "nvvm.convert.f6x2.to.f16x2"(%923) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %925 = "llvm.bitcast"(%924) : (vector<2xf16>) -> i32
    %926 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %927 = "llvm.insertelement"(%917, %925, %926) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %928 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %929 = "llvm.extractelement"(%920, %928) : (vector<2xi16>, i64) -> i16
    %930 = "llvm.bitcast"(%929) : (i16) -> vector<2xi8>
    %931 = "nvvm.convert.f6x2.to.f16x2"(%930) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %932 = "llvm.bitcast"(%931) : (vector<2xf16>) -> i32
    %933 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %934 = "llvm.insertelement"(%927, %932, %933) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %935 = "llvm.bitcast"(%934) : (vector<4xi32>) -> vector<8xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf6E3M2FN>) -> (), sym_name = "cvt_float_e3m2_to_f16"}> ({
  ^bb0(%arg30: vector<8xf6E3M2FN>):
    %858 = "builtin.unrealized_conversion_cast"(%arg30) : (vector<8xf6E3M2FN>) -> vector<8xi6>
    %859 = "llvm.zext"(%858) : (vector<8xi6>) -> vector<8xi8>
    %860 = "llvm.bitcast"(%859) : (vector<8xi8>) -> vector<2xi32>
    %861 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %862 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %863 = "llvm.extractelement"(%860, %862) : (vector<2xi32>, i64) -> i32
    %864 = "llvm.bitcast"(%863) : (i32) -> vector<2xi16>
    %865 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %866 = "llvm.extractelement"(%864, %865) : (vector<2xi16>, i64) -> i16
    %867 = "llvm.bitcast"(%866) : (i16) -> vector<2xi8>
    %868 = "nvvm.convert.f6x2.to.f16x2"(%867) <{relu = false, srcType = f6E3M2FN}> : (vector<2xi8>) -> vector<2xf16>
    %869 = "llvm.bitcast"(%868) : (vector<2xf16>) -> i32
    %870 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %871 = "llvm.insertelement"(%861, %869, %870) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %872 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %873 = "llvm.extractelement"(%864, %872) : (vector<2xi16>, i64) -> i16
    %874 = "llvm.bitcast"(%873) : (i16) -> vector<2xi8>
    %875 = "nvvm.convert.f6x2.to.f16x2"(%874) <{relu = false, srcType = f6E3M2FN}> : (vector<2xi8>) -> vector<2xf16>
    %876 = "llvm.bitcast"(%875) : (vector<2xf16>) -> i32
    %877 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %878 = "llvm.insertelement"(%871, %876, %877) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %879 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %880 = "llvm.extractelement"(%860, %879) : (vector<2xi32>, i64) -> i32
    %881 = "llvm.bitcast"(%880) : (i32) -> vector<2xi16>
    %882 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %883 = "llvm.extractelement"(%881, %882) : (vector<2xi16>, i64) -> i16
    %884 = "llvm.bitcast"(%883) : (i16) -> vector<2xi8>
    %885 = "nvvm.convert.f6x2.to.f16x2"(%884) <{relu = false, srcType = f6E3M2FN}> : (vector<2xi8>) -> vector<2xf16>
    %886 = "llvm.bitcast"(%885) : (vector<2xf16>) -> i32
    %887 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %888 = "llvm.insertelement"(%878, %886, %887) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %889 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %890 = "llvm.extractelement"(%881, %889) : (vector<2xi16>, i64) -> i16
    %891 = "llvm.bitcast"(%890) : (i16) -> vector<2xi8>
    %892 = "nvvm.convert.f6x2.to.f16x2"(%891) <{relu = false, srcType = f6E3M2FN}> : (vector<2xi8>) -> vector<2xf16>
    %893 = "llvm.bitcast"(%892) : (vector<2xf16>) -> i32
    %894 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %895 = "llvm.insertelement"(%888, %893, %894) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %896 = "llvm.bitcast"(%895) : (vector<4xi32>) -> vector<8xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xf4E2M1FN>) -> (), sym_name = "cvt_float_e2m1_to_f16"}> ({
  ^bb0(%arg29: vector<16xf4E2M1FN>):
    %800 = "builtin.unrealized_conversion_cast"(%arg29) : (vector<16xf4E2M1FN>) -> vector<16xi4>
    %801 = "llvm.bitcast"(%800) : (vector<16xi4>) -> vector<2xi32>
    %802 = "llvm.mlir.undef"() : () -> vector<8xi32>
    %803 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %804 = "llvm.extractelement"(%801, %803) : (vector<2xi32>, i64) -> i32
    %805 = "llvm.bitcast"(%804) : (i32) -> vector<4xi8>
    %806 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %807 = "llvm.extractelement"(%805, %806) : (vector<4xi8>, i64) -> i8
    %808 = "nvvm.convert.f4x2.to.f16x2"(%807) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %809 = "llvm.bitcast"(%808) : (vector<2xf16>) -> i32
    %810 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %811 = "llvm.insertelement"(%802, %809, %810) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %812 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %813 = "llvm.extractelement"(%805, %812) : (vector<4xi8>, i64) -> i8
    %814 = "nvvm.convert.f4x2.to.f16x2"(%813) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %815 = "llvm.bitcast"(%814) : (vector<2xf16>) -> i32
    %816 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %817 = "llvm.insertelement"(%811, %815, %816) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %818 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %819 = "llvm.extractelement"(%805, %818) : (vector<4xi8>, i64) -> i8
    %820 = "nvvm.convert.f4x2.to.f16x2"(%819) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %821 = "llvm.bitcast"(%820) : (vector<2xf16>) -> i32
    %822 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %823 = "llvm.insertelement"(%817, %821, %822) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %824 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %825 = "llvm.extractelement"(%805, %824) : (vector<4xi8>, i64) -> i8
    %826 = "nvvm.convert.f4x2.to.f16x2"(%825) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %827 = "llvm.bitcast"(%826) : (vector<2xf16>) -> i32
    %828 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %829 = "llvm.insertelement"(%823, %827, %828) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %830 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %831 = "llvm.extractelement"(%801, %830) : (vector<2xi32>, i64) -> i32
    %832 = "llvm.bitcast"(%831) : (i32) -> vector<4xi8>
    %833 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %834 = "llvm.extractelement"(%832, %833) : (vector<4xi8>, i64) -> i8
    %835 = "nvvm.convert.f4x2.to.f16x2"(%834) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %836 = "llvm.bitcast"(%835) : (vector<2xf16>) -> i32
    %837 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %838 = "llvm.insertelement"(%829, %836, %837) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %839 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %840 = "llvm.extractelement"(%832, %839) : (vector<4xi8>, i64) -> i8
    %841 = "nvvm.convert.f4x2.to.f16x2"(%840) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %842 = "llvm.bitcast"(%841) : (vector<2xf16>) -> i32
    %843 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %844 = "llvm.insertelement"(%838, %842, %843) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %845 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %846 = "llvm.extractelement"(%832, %845) : (vector<4xi8>, i64) -> i8
    %847 = "nvvm.convert.f4x2.to.f16x2"(%846) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %848 = "llvm.bitcast"(%847) : (vector<2xf16>) -> i32
    %849 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %850 = "llvm.insertelement"(%844, %848, %849) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %851 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %852 = "llvm.extractelement"(%832, %851) : (vector<4xi8>, i64) -> i8
    %853 = "nvvm.convert.f4x2.to.f16x2"(%852) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %854 = "llvm.bitcast"(%853) : (vector<2xf16>) -> i32
    %855 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %856 = "llvm.insertelement"(%850, %854, %855) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %857 = "llvm.bitcast"(%856) : (vector<8xi32>) -> vector<16xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf6E2M3FN>) -> (), sym_name = "cvt_float_e2m3_to_bf16"}> ({
  ^bb0(%arg28: vector<8xf6E2M3FN>):
    %761 = "builtin.unrealized_conversion_cast"(%arg28) : (vector<8xf6E2M3FN>) -> vector<8xi6>
    %762 = "llvm.zext"(%761) : (vector<8xi6>) -> vector<8xi8>
    %763 = "llvm.bitcast"(%762) : (vector<8xi8>) -> vector<2xi32>
    %764 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %765 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %766 = "llvm.extractelement"(%763, %765) : (vector<2xi32>, i64) -> i32
    %767 = "llvm.bitcast"(%766) : (i32) -> vector<2xi16>
    %768 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %769 = "llvm.extractelement"(%767, %768) : (vector<2xi16>, i64) -> i16
    %770 = "llvm.bitcast"(%769) : (i16) -> vector<2xi8>
    %771 = "nvvm.convert.f6x2.to.bf16x2"(%770) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xbf16>
    %772 = "llvm.bitcast"(%771) : (vector<2xbf16>) -> i32
    %773 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %774 = "llvm.insertelement"(%764, %772, %773) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %775 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %776 = "llvm.extractelement"(%767, %775) : (vector<2xi16>, i64) -> i16
    %777 = "llvm.bitcast"(%776) : (i16) -> vector<2xi8>
    %778 = "nvvm.convert.f6x2.to.bf16x2"(%777) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xbf16>
    %779 = "llvm.bitcast"(%778) : (vector<2xbf16>) -> i32
    %780 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %781 = "llvm.insertelement"(%774, %779, %780) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %782 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %783 = "llvm.extractelement"(%763, %782) : (vector<2xi32>, i64) -> i32
    %784 = "llvm.bitcast"(%783) : (i32) -> vector<2xi16>
    %785 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %786 = "llvm.extractelement"(%784, %785) : (vector<2xi16>, i64) -> i16
    %787 = "llvm.bitcast"(%786) : (i16) -> vector<2xi8>
    %788 = "nvvm.convert.f6x2.to.bf16x2"(%787) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xbf16>
    %789 = "llvm.bitcast"(%788) : (vector<2xbf16>) -> i32
    %790 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %791 = "llvm.insertelement"(%781, %789, %790) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %792 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %793 = "llvm.extractelement"(%784, %792) : (vector<2xi16>, i64) -> i16
    %794 = "llvm.bitcast"(%793) : (i16) -> vector<2xi8>
    %795 = "nvvm.convert.f6x2.to.bf16x2"(%794) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xbf16>
    %796 = "llvm.bitcast"(%795) : (vector<2xbf16>) -> i32
    %797 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %798 = "llvm.insertelement"(%791, %796, %797) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %799 = "llvm.bitcast"(%798) : (vector<4xi32>) -> vector<8xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xf4E2M1FN>) -> (), sym_name = "cvt_float_e2m1_to_bf16"}> ({
  ^bb0(%arg27: vector<16xf4E2M1FN>):
    %703 = "builtin.unrealized_conversion_cast"(%arg27) : (vector<16xf4E2M1FN>) -> vector<16xi4>
    %704 = "llvm.bitcast"(%703) : (vector<16xi4>) -> vector<2xi32>
    %705 = "llvm.mlir.undef"() : () -> vector<8xi32>
    %706 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %707 = "llvm.extractelement"(%704, %706) : (vector<2xi32>, i64) -> i32
    %708 = "llvm.bitcast"(%707) : (i32) -> vector<4xi8>
    %709 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %710 = "llvm.extractelement"(%708, %709) : (vector<4xi8>, i64) -> i8
    %711 = "nvvm.convert.f4x2.to.bf16x2"(%710) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %712 = "llvm.bitcast"(%711) : (vector<2xbf16>) -> i32
    %713 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %714 = "llvm.insertelement"(%705, %712, %713) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %715 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %716 = "llvm.extractelement"(%708, %715) : (vector<4xi8>, i64) -> i8
    %717 = "nvvm.convert.f4x2.to.bf16x2"(%716) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %718 = "llvm.bitcast"(%717) : (vector<2xbf16>) -> i32
    %719 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %720 = "llvm.insertelement"(%714, %718, %719) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %721 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %722 = "llvm.extractelement"(%708, %721) : (vector<4xi8>, i64) -> i8
    %723 = "nvvm.convert.f4x2.to.bf16x2"(%722) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %724 = "llvm.bitcast"(%723) : (vector<2xbf16>) -> i32
    %725 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %726 = "llvm.insertelement"(%720, %724, %725) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %727 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %728 = "llvm.extractelement"(%708, %727) : (vector<4xi8>, i64) -> i8
    %729 = "nvvm.convert.f4x2.to.bf16x2"(%728) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %730 = "llvm.bitcast"(%729) : (vector<2xbf16>) -> i32
    %731 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %732 = "llvm.insertelement"(%726, %730, %731) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %733 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %734 = "llvm.extractelement"(%704, %733) : (vector<2xi32>, i64) -> i32
    %735 = "llvm.bitcast"(%734) : (i32) -> vector<4xi8>
    %736 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %737 = "llvm.extractelement"(%735, %736) : (vector<4xi8>, i64) -> i8
    %738 = "nvvm.convert.f4x2.to.bf16x2"(%737) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %739 = "llvm.bitcast"(%738) : (vector<2xbf16>) -> i32
    %740 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %741 = "llvm.insertelement"(%732, %739, %740) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %742 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %743 = "llvm.extractelement"(%735, %742) : (vector<4xi8>, i64) -> i8
    %744 = "nvvm.convert.f4x2.to.bf16x2"(%743) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %745 = "llvm.bitcast"(%744) : (vector<2xbf16>) -> i32
    %746 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %747 = "llvm.insertelement"(%741, %745, %746) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %748 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %749 = "llvm.extractelement"(%735, %748) : (vector<4xi8>, i64) -> i8
    %750 = "nvvm.convert.f4x2.to.bf16x2"(%749) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %751 = "llvm.bitcast"(%750) : (vector<2xbf16>) -> i32
    %752 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %753 = "llvm.insertelement"(%747, %751, %752) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %754 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %755 = "llvm.extractelement"(%735, %754) : (vector<4xi8>, i64) -> i8
    %756 = "nvvm.convert.f4x2.to.bf16x2"(%755) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f4E2M1FN}> : (i8) -> vector<2xbf16>
    %757 = "llvm.bitcast"(%756) : (vector<2xbf16>) -> i32
    %758 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %759 = "llvm.insertelement"(%753, %757, %758) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %760 = "llvm.bitcast"(%759) : (vector<8xi32>) -> vector<16xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>) -> vector<4xf32>, sym_name = "fpext_e4m3fn_to_f32"}> ({
  ^bb0(%arg26: vector<4xf8E4M3FN>):
    %681 = "builtin.unrealized_conversion_cast"(%arg26) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %682 = "llvm.bitcast"(%681) : (vector<4xi8>) -> vector<1xi32>
    %683 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %684 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %685 = "llvm.extractelement"(%682, %684) : (vector<1xi32>, i64) -> i32
    %686 = "llvm.bitcast"(%685) : (i32) -> vector<2xi16>
    %687 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %688 = "llvm.extractelement"(%686, %687) : (vector<2xi16>, i64) -> i16
    %689 = "llvm.bitcast"(%688) : (i16) -> vector<2xi8>
    %690 = "nvvm.convert.f8x2.to.f16x2"(%689) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %691 = "llvm.bitcast"(%690) : (vector<2xf16>) -> i32
    %692 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %693 = "llvm.insertelement"(%683, %691, %692) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %694 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %695 = "llvm.extractelement"(%686, %694) : (vector<2xi16>, i64) -> i16
    %696 = "llvm.bitcast"(%695) : (i16) -> vector<2xi8>
    %697 = "nvvm.convert.f8x2.to.f16x2"(%696) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %698 = "llvm.bitcast"(%697) : (vector<2xf16>) -> i32
    %699 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %700 = "llvm.insertelement"(%693, %698, %699) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %701 = "llvm.bitcast"(%700) : (vector<2xi32>) -> vector<4xf16>
    %702 = "llvm.fpext"(%701) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    "func.return"(%702) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E5M2>) -> vector<4xf32>, sym_name = "fpext_e5m2_to_f32"}> ({
  ^bb0(%arg25: vector<4xf8E5M2>):
    %659 = "builtin.unrealized_conversion_cast"(%arg25) : (vector<4xf8E5M2>) -> vector<4xi8>
    %660 = "llvm.bitcast"(%659) : (vector<4xi8>) -> vector<1xi32>
    %661 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %662 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %663 = "llvm.extractelement"(%660, %662) : (vector<1xi32>, i64) -> i32
    %664 = "llvm.bitcast"(%663) : (i32) -> vector<2xi16>
    %665 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %666 = "llvm.extractelement"(%664, %665) : (vector<2xi16>, i64) -> i16
    %667 = "llvm.bitcast"(%666) : (i16) -> vector<2xi8>
    %668 = "nvvm.convert.f8x2.to.f16x2"(%667) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %669 = "llvm.bitcast"(%668) : (vector<2xf16>) -> i32
    %670 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %671 = "llvm.insertelement"(%661, %669, %670) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %672 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %673 = "llvm.extractelement"(%664, %672) : (vector<2xi16>, i64) -> i16
    %674 = "llvm.bitcast"(%673) : (i16) -> vector<2xi8>
    %675 = "nvvm.convert.f8x2.to.f16x2"(%674) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %676 = "llvm.bitcast"(%675) : (vector<2xf16>) -> i32
    %677 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %678 = "llvm.insertelement"(%671, %676, %677) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %679 = "llvm.bitcast"(%678) : (vector<2xi32>) -> vector<4xf16>
    %680 = "llvm.fpext"(%679) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    "func.return"(%680) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E8M0FNU>) -> vector<4xf32>, sym_name = "fpext_e8m0_to_f32"}> ({
  ^bb0(%arg24: vector<4xf8E8M0FNU>):
    %637 = "builtin.unrealized_conversion_cast"(%arg24) : (vector<4xf8E8M0FNU>) -> vector<4xi8>
    %638 = "llvm.bitcast"(%637) : (vector<4xi8>) -> vector<1xi32>
    %639 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %640 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %641 = "llvm.extractelement"(%638, %640) : (vector<1xi32>, i64) -> i32
    %642 = "llvm.bitcast"(%641) : (i32) -> vector<2xi16>
    %643 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %644 = "llvm.extractelement"(%642, %643) : (vector<2xi16>, i64) -> i16
    %645 = "llvm.bitcast"(%644) : (i16) -> vector<2xi8>
    %646 = "nvvm.convert.f8x2.to.bf16x2"(%645) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f8E8M0FNU}> : (vector<2xi8>) -> vector<2xbf16>
    %647 = "llvm.bitcast"(%646) : (vector<2xbf16>) -> i32
    %648 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %649 = "llvm.insertelement"(%639, %647, %648) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %650 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %651 = "llvm.extractelement"(%642, %650) : (vector<2xi16>, i64) -> i16
    %652 = "llvm.bitcast"(%651) : (i16) -> vector<2xi8>
    %653 = "nvvm.convert.f8x2.to.bf16x2"(%652) <{relu = false, sat = #nvvm.sat_mode<none>, srcType = f8E8M0FNU}> : (vector<2xi8>) -> vector<2xbf16>
    %654 = "llvm.bitcast"(%653) : (vector<2xbf16>) -> i32
    %655 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %656 = "llvm.insertelement"(%649, %654, %655) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %657 = "llvm.bitcast"(%656) : (vector<2xi32>) -> vector<4xbf16>
    %658 = "llvm.fpext"(%657) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xbf16>) -> vector<4xf32>
    "func.return"(%658) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf6E2M3FN>) -> vector<4xf32>, sym_name = "fpext_e2m3_to_f32"}> ({
  ^bb0(%arg23: vector<4xf6E2M3FN>):
    %614 = "builtin.unrealized_conversion_cast"(%arg23) : (vector<4xf6E2M3FN>) -> vector<4xi6>
    %615 = "llvm.zext"(%614) : (vector<4xi6>) -> vector<4xi8>
    %616 = "llvm.bitcast"(%615) : (vector<4xi8>) -> vector<1xi32>
    %617 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %618 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %619 = "llvm.extractelement"(%616, %618) : (vector<1xi32>, i64) -> i32
    %620 = "llvm.bitcast"(%619) : (i32) -> vector<2xi16>
    %621 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %622 = "llvm.extractelement"(%620, %621) : (vector<2xi16>, i64) -> i16
    %623 = "llvm.bitcast"(%622) : (i16) -> vector<2xi8>
    %624 = "nvvm.convert.f6x2.to.f16x2"(%623) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %625 = "llvm.bitcast"(%624) : (vector<2xf16>) -> i32
    %626 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %627 = "llvm.insertelement"(%617, %625, %626) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %628 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %629 = "llvm.extractelement"(%620, %628) : (vector<2xi16>, i64) -> i16
    %630 = "llvm.bitcast"(%629) : (i16) -> vector<2xi8>
    %631 = "nvvm.convert.f6x2.to.f16x2"(%630) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %632 = "llvm.bitcast"(%631) : (vector<2xf16>) -> i32
    %633 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %634 = "llvm.insertelement"(%627, %632, %633) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %635 = "llvm.bitcast"(%634) : (vector<2xi32>) -> vector<4xf16>
    %636 = "llvm.fpext"(%635) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    "func.return"(%636) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>) -> vector<8xf32>, sym_name = "fpext_e2m1_to_f32"}> ({
  ^bb0(%arg22: vector<8xf4E2M1FN>):
    %582 = "builtin.unrealized_conversion_cast"(%arg22) : (vector<8xf4E2M1FN>) -> vector<8xi4>
    %583 = "llvm.bitcast"(%582) : (vector<8xi4>) -> vector<1xi32>
    %584 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %585 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %586 = "llvm.extractelement"(%583, %585) : (vector<1xi32>, i64) -> i32
    %587 = "llvm.bitcast"(%586) : (i32) -> vector<4xi8>
    %588 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %589 = "llvm.extractelement"(%587, %588) : (vector<4xi8>, i64) -> i8
    %590 = "nvvm.convert.f4x2.to.f16x2"(%589) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %591 = "llvm.bitcast"(%590) : (vector<2xf16>) -> i32
    %592 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %593 = "llvm.insertelement"(%584, %591, %592) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %594 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %595 = "llvm.extractelement"(%587, %594) : (vector<4xi8>, i64) -> i8
    %596 = "nvvm.convert.f4x2.to.f16x2"(%595) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %597 = "llvm.bitcast"(%596) : (vector<2xf16>) -> i32
    %598 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %599 = "llvm.insertelement"(%593, %597, %598) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %600 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %601 = "llvm.extractelement"(%587, %600) : (vector<4xi8>, i64) -> i8
    %602 = "nvvm.convert.f4x2.to.f16x2"(%601) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %603 = "llvm.bitcast"(%602) : (vector<2xf16>) -> i32
    %604 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %605 = "llvm.insertelement"(%599, %603, %604) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %606 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %607 = "llvm.extractelement"(%587, %606) : (vector<4xi8>, i64) -> i8
    %608 = "nvvm.convert.f4x2.to.f16x2"(%607) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %609 = "llvm.bitcast"(%608) : (vector<2xf16>) -> i32
    %610 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %611 = "llvm.insertelement"(%605, %609, %610) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %612 = "llvm.bitcast"(%611) : (vector<4xi32>) -> vector<8xf16>
    %613 = "llvm.fpext"(%612) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf16>) -> vector<8xf32>
    "func.return"(%613) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf32>, sym_name = "fpext_f16_to_f32"}> ({
  ^bb0(%arg21: vector<4xf16>):
    %581 = "llvm.fpext"(%arg21) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    "func.return"(%581) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xbf16>) -> vector<4xf32>, sym_name = "fpext_bf16_to_f32"}> ({
  ^bb0(%arg20: vector<4xbf16>):
    %580 = "llvm.fpext"(%arg20) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xbf16>) -> vector<4xf32>
    "func.return"(%580) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf64>, sym_name = "fpext_f16_to_f64"}> ({
  ^bb0(%arg19: vector<4xf16>):
    %579 = "llvm.fpext"(%arg19) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf64>
    "func.return"(%579) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xbf16>) -> vector<4xf64>, sym_name = "fpext_bf16_to_f64"}> ({
  ^bb0(%arg18: vector<4xbf16>):
    %578 = "llvm.fpext"(%arg18) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xbf16>) -> vector<4xf64>
    "func.return"(%578) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf64>, sym_name = "fpext_f32_to_f64"}> ({
  ^bb0(%arg17: vector<4xf32>):
    %577 = "llvm.fpext"(%arg17) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>) -> vector<4xf64>
    "func.return"(%577) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>) -> vector<4xf64>, sym_name = "fpext_f8_to_f64"}> ({
  ^bb0(%arg16: vector<4xf8E4M3FN>):
    %535 = "arith.constant"() <{value = dense<0.000000e+00> : vector<8xf8E4M3FN>}> : () -> vector<8xf8E4M3FN>
    %536 = "vector.insert_strided_slice"(%arg16, %535) <{offsets = [0], strides = [1]}> : (vector<4xf8E4M3FN>, vector<8xf8E4M3FN>) -> vector<8xf8E4M3FN>
    %537 = "builtin.unrealized_conversion_cast"(%536) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %538 = "llvm.bitcast"(%537) : (vector<8xi8>) -> vector<2xi32>
    %539 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %540 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %541 = "llvm.extractelement"(%538, %540) : (vector<2xi32>, i64) -> i32
    %542 = "llvm.bitcast"(%541) : (i32) -> vector<2xi16>
    %543 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %544 = "llvm.extractelement"(%542, %543) : (vector<2xi16>, i64) -> i16
    %545 = "llvm.bitcast"(%544) : (i16) -> vector<2xi8>
    %546 = "nvvm.convert.f8x2.to.f16x2"(%545) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %547 = "llvm.bitcast"(%546) : (vector<2xf16>) -> i32
    %548 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %549 = "llvm.insertelement"(%539, %547, %548) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %550 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %551 = "llvm.extractelement"(%542, %550) : (vector<2xi16>, i64) -> i16
    %552 = "llvm.bitcast"(%551) : (i16) -> vector<2xi8>
    %553 = "nvvm.convert.f8x2.to.f16x2"(%552) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %554 = "llvm.bitcast"(%553) : (vector<2xf16>) -> i32
    %555 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %556 = "llvm.insertelement"(%549, %554, %555) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %557 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %558 = "llvm.extractelement"(%538, %557) : (vector<2xi32>, i64) -> i32
    %559 = "llvm.bitcast"(%558) : (i32) -> vector<2xi16>
    %560 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %561 = "llvm.extractelement"(%559, %560) : (vector<2xi16>, i64) -> i16
    %562 = "llvm.bitcast"(%561) : (i16) -> vector<2xi8>
    %563 = "nvvm.convert.f8x2.to.f16x2"(%562) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %564 = "llvm.bitcast"(%563) : (vector<2xf16>) -> i32
    %565 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %566 = "llvm.insertelement"(%556, %564, %565) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %567 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %568 = "llvm.extractelement"(%559, %567) : (vector<2xi16>, i64) -> i16
    %569 = "llvm.bitcast"(%568) : (i16) -> vector<2xi8>
    %570 = "nvvm.convert.f8x2.to.f16x2"(%569) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %571 = "llvm.bitcast"(%570) : (vector<2xf16>) -> i32
    %572 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %573 = "llvm.insertelement"(%566, %571, %572) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %574 = "llvm.bitcast"(%573) : (vector<4xi32>) -> vector<8xf16>
    %575 = "llvm.fpext"(%574) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf16>) -> vector<8xf64>
    %576 = "vector.extract_strided_slice"(%575) <{offsets = [0], sizes = [4], strides = [1]}> : (vector<8xf64>) -> vector<4xf64>
    "func.return"(%576) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>) -> vector<8xf64>, sym_name = "fpext_f4_to_f64"}> ({
  ^bb0(%arg15: vector<8xf4E2M1FN>):
    %473 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16xf4E2M1FN>}> : () -> vector<16xf4E2M1FN>
    %474 = "vector.insert_strided_slice"(%arg15, %473) <{offsets = [0], strides = [1]}> : (vector<8xf4E2M1FN>, vector<16xf4E2M1FN>) -> vector<16xf4E2M1FN>
    %475 = "builtin.unrealized_conversion_cast"(%474) : (vector<16xf4E2M1FN>) -> vector<16xi4>
    %476 = "llvm.bitcast"(%475) : (vector<16xi4>) -> vector<2xi32>
    %477 = "llvm.mlir.undef"() : () -> vector<8xi32>
    %478 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %479 = "llvm.extractelement"(%476, %478) : (vector<2xi32>, i64) -> i32
    %480 = "llvm.bitcast"(%479) : (i32) -> vector<4xi8>
    %481 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %482 = "llvm.extractelement"(%480, %481) : (vector<4xi8>, i64) -> i8
    %483 = "nvvm.convert.f4x2.to.f16x2"(%482) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %484 = "llvm.bitcast"(%483) : (vector<2xf16>) -> i32
    %485 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %486 = "llvm.insertelement"(%477, %484, %485) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %487 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %488 = "llvm.extractelement"(%480, %487) : (vector<4xi8>, i64) -> i8
    %489 = "nvvm.convert.f4x2.to.f16x2"(%488) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %490 = "llvm.bitcast"(%489) : (vector<2xf16>) -> i32
    %491 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %492 = "llvm.insertelement"(%486, %490, %491) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %493 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %494 = "llvm.extractelement"(%480, %493) : (vector<4xi8>, i64) -> i8
    %495 = "nvvm.convert.f4x2.to.f16x2"(%494) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %496 = "llvm.bitcast"(%495) : (vector<2xf16>) -> i32
    %497 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %498 = "llvm.insertelement"(%492, %496, %497) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %499 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %500 = "llvm.extractelement"(%480, %499) : (vector<4xi8>, i64) -> i8
    %501 = "nvvm.convert.f4x2.to.f16x2"(%500) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %502 = "llvm.bitcast"(%501) : (vector<2xf16>) -> i32
    %503 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %504 = "llvm.insertelement"(%498, %502, %503) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %505 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %506 = "llvm.extractelement"(%476, %505) : (vector<2xi32>, i64) -> i32
    %507 = "llvm.bitcast"(%506) : (i32) -> vector<4xi8>
    %508 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %509 = "llvm.extractelement"(%507, %508) : (vector<4xi8>, i64) -> i8
    %510 = "nvvm.convert.f4x2.to.f16x2"(%509) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %511 = "llvm.bitcast"(%510) : (vector<2xf16>) -> i32
    %512 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %513 = "llvm.insertelement"(%504, %511, %512) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %514 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %515 = "llvm.extractelement"(%507, %514) : (vector<4xi8>, i64) -> i8
    %516 = "nvvm.convert.f4x2.to.f16x2"(%515) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %517 = "llvm.bitcast"(%516) : (vector<2xf16>) -> i32
    %518 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %519 = "llvm.insertelement"(%513, %517, %518) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %520 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %521 = "llvm.extractelement"(%507, %520) : (vector<4xi8>, i64) -> i8
    %522 = "nvvm.convert.f4x2.to.f16x2"(%521) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %523 = "llvm.bitcast"(%522) : (vector<2xf16>) -> i32
    %524 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %525 = "llvm.insertelement"(%519, %523, %524) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %526 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %527 = "llvm.extractelement"(%507, %526) : (vector<4xi8>, i64) -> i8
    %528 = "nvvm.convert.f4x2.to.f16x2"(%527) <{relu = false, srcType = f4E2M1FN}> : (i8) -> vector<2xf16>
    %529 = "llvm.bitcast"(%528) : (vector<2xf16>) -> i32
    %530 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %531 = "llvm.insertelement"(%525, %529, %530) : (vector<8xi32>, i32, i64) -> vector<8xi32>
    %532 = "llvm.bitcast"(%531) : (vector<8xi32>) -> vector<16xf16>
    %533 = "llvm.fpext"(%532) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<16xf16>) -> vector<16xf64>
    %534 = "vector.extract_strided_slice"(%533) <{offsets = [0], sizes = [8], strides = [1]}> : (vector<16xf64>) -> vector<8xf64>
    "func.return"(%534) : (vector<8xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf6E2M3FN>) -> vector<4xf64>, sym_name = "fpext_e2m3_to_f64"}> ({
  ^bb0(%arg14: vector<4xf6E2M3FN>):
    %430 = "arith.constant"() <{value = dense<0.000000e+00> : vector<8xf6E2M3FN>}> : () -> vector<8xf6E2M3FN>
    %431 = "vector.insert_strided_slice"(%arg14, %430) <{offsets = [0], strides = [1]}> : (vector<4xf6E2M3FN>, vector<8xf6E2M3FN>) -> vector<8xf6E2M3FN>
    %432 = "builtin.unrealized_conversion_cast"(%431) : (vector<8xf6E2M3FN>) -> vector<8xi6>
    %433 = "llvm.zext"(%432) : (vector<8xi6>) -> vector<8xi8>
    %434 = "llvm.bitcast"(%433) : (vector<8xi8>) -> vector<2xi32>
    %435 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %436 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %437 = "llvm.extractelement"(%434, %436) : (vector<2xi32>, i64) -> i32
    %438 = "llvm.bitcast"(%437) : (i32) -> vector<2xi16>
    %439 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %440 = "llvm.extractelement"(%438, %439) : (vector<2xi16>, i64) -> i16
    %441 = "llvm.bitcast"(%440) : (i16) -> vector<2xi8>
    %442 = "nvvm.convert.f6x2.to.f16x2"(%441) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %443 = "llvm.bitcast"(%442) : (vector<2xf16>) -> i32
    %444 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %445 = "llvm.insertelement"(%435, %443, %444) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %446 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %447 = "llvm.extractelement"(%438, %446) : (vector<2xi16>, i64) -> i16
    %448 = "llvm.bitcast"(%447) : (i16) -> vector<2xi8>
    %449 = "nvvm.convert.f6x2.to.f16x2"(%448) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %450 = "llvm.bitcast"(%449) : (vector<2xf16>) -> i32
    %451 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %452 = "llvm.insertelement"(%445, %450, %451) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %453 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %454 = "llvm.extractelement"(%434, %453) : (vector<2xi32>, i64) -> i32
    %455 = "llvm.bitcast"(%454) : (i32) -> vector<2xi16>
    %456 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %457 = "llvm.extractelement"(%455, %456) : (vector<2xi16>, i64) -> i16
    %458 = "llvm.bitcast"(%457) : (i16) -> vector<2xi8>
    %459 = "nvvm.convert.f6x2.to.f16x2"(%458) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %460 = "llvm.bitcast"(%459) : (vector<2xf16>) -> i32
    %461 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %462 = "llvm.insertelement"(%452, %460, %461) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %463 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %464 = "llvm.extractelement"(%455, %463) : (vector<2xi16>, i64) -> i16
    %465 = "llvm.bitcast"(%464) : (i16) -> vector<2xi8>
    %466 = "nvvm.convert.f6x2.to.f16x2"(%465) <{relu = false, srcType = f6E2M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %467 = "llvm.bitcast"(%466) : (vector<2xf16>) -> i32
    %468 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %469 = "llvm.insertelement"(%462, %467, %468) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %470 = "llvm.bitcast"(%469) : (vector<4xi32>) -> vector<8xf16>
    %471 = "llvm.fpext"(%470) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf16>) -> vector<8xf64>
    %472 = "vector.extract_strided_slice"(%471) <{offsets = [0], sizes = [4], strides = [1]}> : (vector<8xf64>) -> vector<4xf64>
    "func.return"(%472) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f8E4M3FN) -> f16, sym_name = "fpext_scalar_f8_to_f16"}> ({
  ^bb0(%arg13: f8E4M3FN):
    %404 = "vector.broadcast"(%arg13) : (f8E4M3FN) -> vector<1xf8E4M3FN>
    %405 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %406 = "vector.insert_strided_slice"(%404, %405) <{offsets = [0], strides = [1]}> : (vector<1xf8E4M3FN>, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %407 = "builtin.unrealized_conversion_cast"(%406) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %408 = "llvm.bitcast"(%407) : (vector<4xi8>) -> vector<1xi32>
    %409 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %410 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %411 = "llvm.extractelement"(%408, %410) : (vector<1xi32>, i64) -> i32
    %412 = "llvm.bitcast"(%411) : (i32) -> vector<2xi16>
    %413 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %414 = "llvm.extractelement"(%412, %413) : (vector<2xi16>, i64) -> i16
    %415 = "llvm.bitcast"(%414) : (i16) -> vector<2xi8>
    %416 = "nvvm.convert.f8x2.to.f16x2"(%415) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %417 = "llvm.bitcast"(%416) : (vector<2xf16>) -> i32
    %418 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %419 = "llvm.insertelement"(%409, %417, %418) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %420 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %421 = "llvm.extractelement"(%412, %420) : (vector<2xi16>, i64) -> i16
    %422 = "llvm.bitcast"(%421) : (i16) -> vector<2xi8>
    %423 = "nvvm.convert.f8x2.to.f16x2"(%422) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %424 = "llvm.bitcast"(%423) : (vector<2xf16>) -> i32
    %425 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %426 = "llvm.insertelement"(%419, %424, %425) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %427 = "llvm.bitcast"(%426) : (vector<2xi32>) -> vector<4xf16>
    %428 = "vector.extract_strided_slice"(%427) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<4xf16>) -> vector<1xf16>
    %429 = "vector.extract"(%428) <{static_position = array<i64: 0>}> : (vector<1xf16>) -> f16
    "func.return"(%429) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f8E4M3FN) -> f32, sym_name = "fpext_scalar_f8_to_f32"}> ({
  ^bb0(%arg12: f8E4M3FN):
    %377 = "vector.broadcast"(%arg12) : (f8E4M3FN) -> vector<1xf8E4M3FN>
    %378 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %379 = "vector.insert_strided_slice"(%377, %378) <{offsets = [0], strides = [1]}> : (vector<1xf8E4M3FN>, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %380 = "builtin.unrealized_conversion_cast"(%379) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %381 = "llvm.bitcast"(%380) : (vector<4xi8>) -> vector<1xi32>
    %382 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %383 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %384 = "llvm.extractelement"(%381, %383) : (vector<1xi32>, i64) -> i32
    %385 = "llvm.bitcast"(%384) : (i32) -> vector<2xi16>
    %386 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %387 = "llvm.extractelement"(%385, %386) : (vector<2xi16>, i64) -> i16
    %388 = "llvm.bitcast"(%387) : (i16) -> vector<2xi8>
    %389 = "nvvm.convert.f8x2.to.f16x2"(%388) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %390 = "llvm.bitcast"(%389) : (vector<2xf16>) -> i32
    %391 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %392 = "llvm.insertelement"(%382, %390, %391) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %393 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %394 = "llvm.extractelement"(%385, %393) : (vector<2xi16>, i64) -> i16
    %395 = "llvm.bitcast"(%394) : (i16) -> vector<2xi8>
    %396 = "nvvm.convert.f8x2.to.f16x2"(%395) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %397 = "llvm.bitcast"(%396) : (vector<2xf16>) -> i32
    %398 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %399 = "llvm.insertelement"(%392, %397, %398) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %400 = "llvm.bitcast"(%399) : (vector<2xi32>) -> vector<4xf16>
    %401 = "llvm.fpext"(%400) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    %402 = "vector.extract_strided_slice"(%401) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<4xf32>) -> vector<1xf32>
    %403 = "vector.extract"(%402) <{static_position = array<i64: 0>}> : (vector<1xf32>) -> f32
    "func.return"(%403) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf8E4M3FN>) -> vector<2x4xf16>, sym_name = "fpext_v2x4_f8_to_f16"}> ({
  ^bb0(%arg11: vector<2x4xf8E4M3FN>):
    %337 = "vector.shape_cast"(%arg11) : (vector<2x4xf8E4M3FN>) -> vector<8xf8E4M3FN>
    %338 = "builtin.unrealized_conversion_cast"(%337) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %339 = "llvm.bitcast"(%338) : (vector<8xi8>) -> vector<2xi32>
    %340 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %341 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %342 = "llvm.extractelement"(%339, %341) : (vector<2xi32>, i64) -> i32
    %343 = "llvm.bitcast"(%342) : (i32) -> vector<2xi16>
    %344 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %345 = "llvm.extractelement"(%343, %344) : (vector<2xi16>, i64) -> i16
    %346 = "llvm.bitcast"(%345) : (i16) -> vector<2xi8>
    %347 = "nvvm.convert.f8x2.to.f16x2"(%346) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %348 = "llvm.bitcast"(%347) : (vector<2xf16>) -> i32
    %349 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %350 = "llvm.insertelement"(%340, %348, %349) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %351 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %352 = "llvm.extractelement"(%343, %351) : (vector<2xi16>, i64) -> i16
    %353 = "llvm.bitcast"(%352) : (i16) -> vector<2xi8>
    %354 = "nvvm.convert.f8x2.to.f16x2"(%353) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %355 = "llvm.bitcast"(%354) : (vector<2xf16>) -> i32
    %356 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %357 = "llvm.insertelement"(%350, %355, %356) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %358 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %359 = "llvm.extractelement"(%339, %358) : (vector<2xi32>, i64) -> i32
    %360 = "llvm.bitcast"(%359) : (i32) -> vector<2xi16>
    %361 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %362 = "llvm.extractelement"(%360, %361) : (vector<2xi16>, i64) -> i16
    %363 = "llvm.bitcast"(%362) : (i16) -> vector<2xi8>
    %364 = "nvvm.convert.f8x2.to.f16x2"(%363) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %365 = "llvm.bitcast"(%364) : (vector<2xf16>) -> i32
    %366 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %367 = "llvm.insertelement"(%357, %365, %366) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %368 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %369 = "llvm.extractelement"(%360, %368) : (vector<2xi16>, i64) -> i16
    %370 = "llvm.bitcast"(%369) : (i16) -> vector<2xi8>
    %371 = "nvvm.convert.f8x2.to.f16x2"(%370) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %372 = "llvm.bitcast"(%371) : (vector<2xf16>) -> i32
    %373 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %374 = "llvm.insertelement"(%367, %372, %373) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %375 = "llvm.bitcast"(%374) : (vector<4xi32>) -> vector<8xf16>
    %376 = "vector.shape_cast"(%375) : (vector<8xf16>) -> vector<2x4xf16>
    "func.return"(%376) : (vector<2x4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf8E4M3FN>) -> vector<2x4xf32>, sym_name = "fpext_v2x4_f8_to_f32"}> ({
  ^bb0(%arg10: vector<2x4xf8E4M3FN>):
    %296 = "vector.shape_cast"(%arg10) : (vector<2x4xf8E4M3FN>) -> vector<8xf8E4M3FN>
    %297 = "builtin.unrealized_conversion_cast"(%296) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %298 = "llvm.bitcast"(%297) : (vector<8xi8>) -> vector<2xi32>
    %299 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %300 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %301 = "llvm.extractelement"(%298, %300) : (vector<2xi32>, i64) -> i32
    %302 = "llvm.bitcast"(%301) : (i32) -> vector<2xi16>
    %303 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %304 = "llvm.extractelement"(%302, %303) : (vector<2xi16>, i64) -> i16
    %305 = "llvm.bitcast"(%304) : (i16) -> vector<2xi8>
    %306 = "nvvm.convert.f8x2.to.f16x2"(%305) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %307 = "llvm.bitcast"(%306) : (vector<2xf16>) -> i32
    %308 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %309 = "llvm.insertelement"(%299, %307, %308) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %310 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %311 = "llvm.extractelement"(%302, %310) : (vector<2xi16>, i64) -> i16
    %312 = "llvm.bitcast"(%311) : (i16) -> vector<2xi8>
    %313 = "nvvm.convert.f8x2.to.f16x2"(%312) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %314 = "llvm.bitcast"(%313) : (vector<2xf16>) -> i32
    %315 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %316 = "llvm.insertelement"(%309, %314, %315) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %317 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %318 = "llvm.extractelement"(%298, %317) : (vector<2xi32>, i64) -> i32
    %319 = "llvm.bitcast"(%318) : (i32) -> vector<2xi16>
    %320 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %321 = "llvm.extractelement"(%319, %320) : (vector<2xi16>, i64) -> i16
    %322 = "llvm.bitcast"(%321) : (i16) -> vector<2xi8>
    %323 = "nvvm.convert.f8x2.to.f16x2"(%322) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %324 = "llvm.bitcast"(%323) : (vector<2xf16>) -> i32
    %325 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %326 = "llvm.insertelement"(%316, %324, %325) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %327 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %328 = "llvm.extractelement"(%319, %327) : (vector<2xi16>, i64) -> i16
    %329 = "llvm.bitcast"(%328) : (i16) -> vector<2xi8>
    %330 = "nvvm.convert.f8x2.to.f16x2"(%329) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %331 = "llvm.bitcast"(%330) : (vector<2xf16>) -> i32
    %332 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %333 = "llvm.insertelement"(%326, %331, %332) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %334 = "llvm.bitcast"(%333) : (vector<4xi32>) -> vector<8xf16>
    %335 = "llvm.fpext"(%334) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf16>) -> vector<8xf32>
    %336 = "vector.shape_cast"(%335) : (vector<8xf32>) -> vector<2x4xf32>
    "func.return"(%336) : (vector<2x4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf8E5M2>) -> vector<3xf16>, sym_name = "fpext_v3f8_to_v3f16"}> ({
  ^bb0(%arg9: vector<3xf8E5M2>):
    %272 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E5M2>}> : () -> vector<4xf8E5M2>
    %273 = "vector.insert_strided_slice"(%arg9, %272) <{offsets = [0], strides = [1]}> : (vector<3xf8E5M2>, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %274 = "builtin.unrealized_conversion_cast"(%273) : (vector<4xf8E5M2>) -> vector<4xi8>
    %275 = "llvm.bitcast"(%274) : (vector<4xi8>) -> vector<1xi32>
    %276 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %277 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %278 = "llvm.extractelement"(%275, %277) : (vector<1xi32>, i64) -> i32
    %279 = "llvm.bitcast"(%278) : (i32) -> vector<2xi16>
    %280 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %281 = "llvm.extractelement"(%279, %280) : (vector<2xi16>, i64) -> i16
    %282 = "llvm.bitcast"(%281) : (i16) -> vector<2xi8>
    %283 = "nvvm.convert.f8x2.to.f16x2"(%282) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %284 = "llvm.bitcast"(%283) : (vector<2xf16>) -> i32
    %285 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %286 = "llvm.insertelement"(%276, %284, %285) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %287 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %288 = "llvm.extractelement"(%279, %287) : (vector<2xi16>, i64) -> i16
    %289 = "llvm.bitcast"(%288) : (i16) -> vector<2xi8>
    %290 = "nvvm.convert.f8x2.to.f16x2"(%289) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %291 = "llvm.bitcast"(%290) : (vector<2xf16>) -> i32
    %292 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %293 = "llvm.insertelement"(%286, %291, %292) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %294 = "llvm.bitcast"(%293) : (vector<2xi32>) -> vector<4xf16>
    %295 = "vector.extract_strided_slice"(%294) <{offsets = [0], sizes = [3], strides = [1]}> : (vector<4xf16>) -> vector<3xf16>
    "func.return"(%295) : (vector<3xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf8E5M2>) -> vector<3xf32>, sym_name = "fpext_v3_f8_to_f32"}> ({
  ^bb0(%arg8: vector<3xf8E5M2>):
    %247 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E5M2>}> : () -> vector<4xf8E5M2>
    %248 = "vector.insert_strided_slice"(%arg8, %247) <{offsets = [0], strides = [1]}> : (vector<3xf8E5M2>, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %249 = "builtin.unrealized_conversion_cast"(%248) : (vector<4xf8E5M2>) -> vector<4xi8>
    %250 = "llvm.bitcast"(%249) : (vector<4xi8>) -> vector<1xi32>
    %251 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %252 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %253 = "llvm.extractelement"(%250, %252) : (vector<1xi32>, i64) -> i32
    %254 = "llvm.bitcast"(%253) : (i32) -> vector<2xi16>
    %255 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %256 = "llvm.extractelement"(%254, %255) : (vector<2xi16>, i64) -> i16
    %257 = "llvm.bitcast"(%256) : (i16) -> vector<2xi8>
    %258 = "nvvm.convert.f8x2.to.f16x2"(%257) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %259 = "llvm.bitcast"(%258) : (vector<2xf16>) -> i32
    %260 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %261 = "llvm.insertelement"(%251, %259, %260) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %262 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %263 = "llvm.extractelement"(%254, %262) : (vector<2xi16>, i64) -> i16
    %264 = "llvm.bitcast"(%263) : (i16) -> vector<2xi8>
    %265 = "nvvm.convert.f8x2.to.f16x2"(%264) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %266 = "llvm.bitcast"(%265) : (vector<2xf16>) -> i32
    %267 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %268 = "llvm.insertelement"(%261, %266, %267) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %269 = "llvm.bitcast"(%268) : (vector<2xi32>) -> vector<4xf16>
    %270 = "llvm.fpext"(%269) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    %271 = "vector.extract_strided_slice"(%270) <{offsets = [0], sizes = [3], strides = [1]}> : (vector<4xf32>) -> vector<3xf32>
    "func.return"(%271) : (vector<3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3x1xf8E4M3FN>) -> vector<3x1xf16>, sym_name = "fpext_v3x1_f8_to_f16"}> ({
  ^bb0(%arg7: vector<3x1xf8E4M3FN>):
    %221 = "vector.shape_cast"(%arg7) : (vector<3x1xf8E4M3FN>) -> vector<3xf8E4M3FN>
    %222 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %223 = "vector.insert_strided_slice"(%221, %222) <{offsets = [0], strides = [1]}> : (vector<3xf8E4M3FN>, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %224 = "builtin.unrealized_conversion_cast"(%223) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %225 = "llvm.bitcast"(%224) : (vector<4xi8>) -> vector<1xi32>
    %226 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %227 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %228 = "llvm.extractelement"(%225, %227) : (vector<1xi32>, i64) -> i32
    %229 = "llvm.bitcast"(%228) : (i32) -> vector<2xi16>
    %230 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %231 = "llvm.extractelement"(%229, %230) : (vector<2xi16>, i64) -> i16
    %232 = "llvm.bitcast"(%231) : (i16) -> vector<2xi8>
    %233 = "nvvm.convert.f8x2.to.f16x2"(%232) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %234 = "llvm.bitcast"(%233) : (vector<2xf16>) -> i32
    %235 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %236 = "llvm.insertelement"(%226, %234, %235) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %237 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %238 = "llvm.extractelement"(%229, %237) : (vector<2xi16>, i64) -> i16
    %239 = "llvm.bitcast"(%238) : (i16) -> vector<2xi8>
    %240 = "nvvm.convert.f8x2.to.f16x2"(%239) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %241 = "llvm.bitcast"(%240) : (vector<2xf16>) -> i32
    %242 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %243 = "llvm.insertelement"(%236, %241, %242) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %244 = "llvm.bitcast"(%243) : (vector<2xi32>) -> vector<4xf16>
    %245 = "vector.extract_strided_slice"(%244) <{offsets = [0], sizes = [3], strides = [1]}> : (vector<4xf16>) -> vector<3xf16>
    %246 = "vector.shape_cast"(%245) : (vector<3xf16>) -> vector<3x1xf16>
    "func.return"(%246) : (vector<3x1xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf8E4M3FN>) -> (), sym_name = "fpext_f8_to_f16_relu"}> ({
  ^bb0(%arg6: vector<8xf8E4M3FN>):
    %183 = "builtin.unrealized_conversion_cast"(%arg6) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %184 = "llvm.bitcast"(%183) : (vector<8xi8>) -> vector<2xi32>
    %185 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %186 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %187 = "llvm.extractelement"(%184, %186) : (vector<2xi32>, i64) -> i32
    %188 = "llvm.bitcast"(%187) : (i32) -> vector<2xi16>
    %189 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %190 = "llvm.extractelement"(%188, %189) : (vector<2xi16>, i64) -> i16
    %191 = "llvm.bitcast"(%190) : (i16) -> vector<2xi8>
    %192 = "nvvm.convert.f8x2.to.f16x2"(%191) <{relu = true, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %193 = "llvm.bitcast"(%192) : (vector<2xf16>) -> i32
    %194 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %195 = "llvm.insertelement"(%185, %193, %194) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %196 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %197 = "llvm.extractelement"(%188, %196) : (vector<2xi16>, i64) -> i16
    %198 = "llvm.bitcast"(%197) : (i16) -> vector<2xi8>
    %199 = "nvvm.convert.f8x2.to.f16x2"(%198) <{relu = true, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %200 = "llvm.bitcast"(%199) : (vector<2xf16>) -> i32
    %201 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %202 = "llvm.insertelement"(%195, %200, %201) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %203 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %204 = "llvm.extractelement"(%184, %203) : (vector<2xi32>, i64) -> i32
    %205 = "llvm.bitcast"(%204) : (i32) -> vector<2xi16>
    %206 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %207 = "llvm.extractelement"(%205, %206) : (vector<2xi16>, i64) -> i16
    %208 = "llvm.bitcast"(%207) : (i16) -> vector<2xi8>
    %209 = "nvvm.convert.f8x2.to.f16x2"(%208) <{relu = true, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %210 = "llvm.bitcast"(%209) : (vector<2xf16>) -> i32
    %211 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %212 = "llvm.insertelement"(%202, %210, %211) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %213 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %214 = "llvm.extractelement"(%205, %213) : (vector<2xi16>, i64) -> i16
    %215 = "llvm.bitcast"(%214) : (i16) -> vector<2xi8>
    %216 = "nvvm.convert.f8x2.to.f16x2"(%215) <{relu = true, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %217 = "llvm.bitcast"(%216) : (vector<2xf16>) -> i32
    %218 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %219 = "llvm.insertelement"(%212, %217, %218) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %220 = "llvm.bitcast"(%219) : (vector<4xi32>) -> vector<8xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f8E4M3FN) -> f16, sym_name = "e2e_scalar_f8_to_f16"}> ({
  ^bb0(%arg5: f8E4M3FN):
    %157 = "vector.broadcast"(%arg5) : (f8E4M3FN) -> vector<1xf8E4M3FN>
    %158 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %159 = "vector.insert_strided_slice"(%157, %158) <{offsets = [0], strides = [1]}> : (vector<1xf8E4M3FN>, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %160 = "builtin.unrealized_conversion_cast"(%159) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %161 = "llvm.bitcast"(%160) : (vector<4xi8>) -> vector<1xi32>
    %162 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %163 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %164 = "llvm.extractelement"(%161, %163) : (vector<1xi32>, i64) -> i32
    %165 = "llvm.bitcast"(%164) : (i32) -> vector<2xi16>
    %166 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %167 = "llvm.extractelement"(%165, %166) : (vector<2xi16>, i64) -> i16
    %168 = "llvm.bitcast"(%167) : (i16) -> vector<2xi8>
    %169 = "nvvm.convert.f8x2.to.f16x2"(%168) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %170 = "llvm.bitcast"(%169) : (vector<2xf16>) -> i32
    %171 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %172 = "llvm.insertelement"(%162, %170, %171) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %173 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %174 = "llvm.extractelement"(%165, %173) : (vector<2xi16>, i64) -> i16
    %175 = "llvm.bitcast"(%174) : (i16) -> vector<2xi8>
    %176 = "nvvm.convert.f8x2.to.f16x2"(%175) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %177 = "llvm.bitcast"(%176) : (vector<2xf16>) -> i32
    %178 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %179 = "llvm.insertelement"(%172, %177, %178) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %180 = "llvm.bitcast"(%179) : (vector<2xi32>) -> vector<4xf16>
    %181 = "vector.extract_strided_slice"(%180) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<4xf16>) -> vector<1xf16>
    %182 = "vector.extract"(%181) <{static_position = array<i64: 0>}> : (vector<1xf16>) -> f16
    "func.return"(%182) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf8E4M3FN>) -> vector<2x4xf16>, sym_name = "e2e_v2x4_f8_to_f16"}> ({
  ^bb0(%arg4: vector<2x4xf8E4M3FN>):
    %117 = "vector.shape_cast"(%arg4) : (vector<2x4xf8E4M3FN>) -> vector<8xf8E4M3FN>
    %118 = "builtin.unrealized_conversion_cast"(%117) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %119 = "llvm.bitcast"(%118) : (vector<8xi8>) -> vector<2xi32>
    %120 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %121 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %122 = "llvm.extractelement"(%119, %121) : (vector<2xi32>, i64) -> i32
    %123 = "llvm.bitcast"(%122) : (i32) -> vector<2xi16>
    %124 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %125 = "llvm.extractelement"(%123, %124) : (vector<2xi16>, i64) -> i16
    %126 = "llvm.bitcast"(%125) : (i16) -> vector<2xi8>
    %127 = "nvvm.convert.f8x2.to.f16x2"(%126) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %128 = "llvm.bitcast"(%127) : (vector<2xf16>) -> i32
    %129 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %130 = "llvm.insertelement"(%120, %128, %129) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %131 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %132 = "llvm.extractelement"(%123, %131) : (vector<2xi16>, i64) -> i16
    %133 = "llvm.bitcast"(%132) : (i16) -> vector<2xi8>
    %134 = "nvvm.convert.f8x2.to.f16x2"(%133) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %135 = "llvm.bitcast"(%134) : (vector<2xf16>) -> i32
    %136 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %137 = "llvm.insertelement"(%130, %135, %136) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %138 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %139 = "llvm.extractelement"(%119, %138) : (vector<2xi32>, i64) -> i32
    %140 = "llvm.bitcast"(%139) : (i32) -> vector<2xi16>
    %141 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %142 = "llvm.extractelement"(%140, %141) : (vector<2xi16>, i64) -> i16
    %143 = "llvm.bitcast"(%142) : (i16) -> vector<2xi8>
    %144 = "nvvm.convert.f8x2.to.f16x2"(%143) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %145 = "llvm.bitcast"(%144) : (vector<2xf16>) -> i32
    %146 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %147 = "llvm.insertelement"(%137, %145, %146) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %148 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %149 = "llvm.extractelement"(%140, %148) : (vector<2xi16>, i64) -> i16
    %150 = "llvm.bitcast"(%149) : (i16) -> vector<2xi8>
    %151 = "nvvm.convert.f8x2.to.f16x2"(%150) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %152 = "llvm.bitcast"(%151) : (vector<2xf16>) -> i32
    %153 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %154 = "llvm.insertelement"(%147, %152, %153) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %155 = "llvm.bitcast"(%154) : (vector<4xi32>) -> vector<8xf16>
    %156 = "vector.shape_cast"(%155) : (vector<8xf16>) -> vector<2x4xf16>
    "func.return"(%156) : (vector<2x4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf8E5M2>) -> vector<3xf16>, sym_name = "e2e_v3f8_to_v3f16"}> ({
  ^bb0(%arg3: vector<3xf8E5M2>):
    %93 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E5M2>}> : () -> vector<4xf8E5M2>
    %94 = "vector.insert_strided_slice"(%arg3, %93) <{offsets = [0], strides = [1]}> : (vector<3xf8E5M2>, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %95 = "builtin.unrealized_conversion_cast"(%94) : (vector<4xf8E5M2>) -> vector<4xi8>
    %96 = "llvm.bitcast"(%95) : (vector<4xi8>) -> vector<1xi32>
    %97 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %98 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %99 = "llvm.extractelement"(%96, %98) : (vector<1xi32>, i64) -> i32
    %100 = "llvm.bitcast"(%99) : (i32) -> vector<2xi16>
    %101 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %102 = "llvm.extractelement"(%100, %101) : (vector<2xi16>, i64) -> i16
    %103 = "llvm.bitcast"(%102) : (i16) -> vector<2xi8>
    %104 = "nvvm.convert.f8x2.to.f16x2"(%103) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %105 = "llvm.bitcast"(%104) : (vector<2xf16>) -> i32
    %106 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %107 = "llvm.insertelement"(%97, %105, %106) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %108 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %109 = "llvm.extractelement"(%100, %108) : (vector<2xi16>, i64) -> i16
    %110 = "llvm.bitcast"(%109) : (i16) -> vector<2xi8>
    %111 = "nvvm.convert.f8x2.to.f16x2"(%110) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %112 = "llvm.bitcast"(%111) : (vector<2xf16>) -> i32
    %113 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %114 = "llvm.insertelement"(%107, %112, %113) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %115 = "llvm.bitcast"(%114) : (vector<2xi32>) -> vector<4xf16>
    %116 = "vector.extract_strided_slice"(%115) <{offsets = [0], sizes = [3], strides = [1]}> : (vector<4xf16>) -> vector<3xf16>
    "func.return"(%116) : (vector<3xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f8E4M3FN) -> f32, sym_name = "e2e_scalar_f8_to_f32"}> ({
  ^bb0(%arg2: f8E4M3FN):
    %66 = "vector.broadcast"(%arg2) : (f8E4M3FN) -> vector<1xf8E4M3FN>
    %67 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %68 = "vector.insert_strided_slice"(%66, %67) <{offsets = [0], strides = [1]}> : (vector<1xf8E4M3FN>, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %69 = "builtin.unrealized_conversion_cast"(%68) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %70 = "llvm.bitcast"(%69) : (vector<4xi8>) -> vector<1xi32>
    %71 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %72 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %73 = "llvm.extractelement"(%70, %72) : (vector<1xi32>, i64) -> i32
    %74 = "llvm.bitcast"(%73) : (i32) -> vector<2xi16>
    %75 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %76 = "llvm.extractelement"(%74, %75) : (vector<2xi16>, i64) -> i16
    %77 = "llvm.bitcast"(%76) : (i16) -> vector<2xi8>
    %78 = "nvvm.convert.f8x2.to.f16x2"(%77) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %79 = "llvm.bitcast"(%78) : (vector<2xf16>) -> i32
    %80 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %81 = "llvm.insertelement"(%71, %79, %80) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %82 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %83 = "llvm.extractelement"(%74, %82) : (vector<2xi16>, i64) -> i16
    %84 = "llvm.bitcast"(%83) : (i16) -> vector<2xi8>
    %85 = "nvvm.convert.f8x2.to.f16x2"(%84) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %86 = "llvm.bitcast"(%85) : (vector<2xf16>) -> i32
    %87 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %88 = "llvm.insertelement"(%81, %86, %87) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %89 = "llvm.bitcast"(%88) : (vector<2xi32>) -> vector<4xf16>
    %90 = "llvm.fpext"(%89) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    %91 = "vector.extract_strided_slice"(%90) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<4xf32>) -> vector<1xf32>
    %92 = "vector.extract"(%91) <{static_position = array<i64: 0>}> : (vector<1xf32>) -> f32
    "func.return"(%92) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf8E4M3FN>) -> vector<2x4xf32>, sym_name = "e2e_v2x4_f8_to_f32"}> ({
  ^bb0(%arg1: vector<2x4xf8E4M3FN>):
    %25 = "vector.shape_cast"(%arg1) : (vector<2x4xf8E4M3FN>) -> vector<8xf8E4M3FN>
    %26 = "builtin.unrealized_conversion_cast"(%25) : (vector<8xf8E4M3FN>) -> vector<8xi8>
    %27 = "llvm.bitcast"(%26) : (vector<8xi8>) -> vector<2xi32>
    %28 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %29 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %30 = "llvm.extractelement"(%27, %29) : (vector<2xi32>, i64) -> i32
    %31 = "llvm.bitcast"(%30) : (i32) -> vector<2xi16>
    %32 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %33 = "llvm.extractelement"(%31, %32) : (vector<2xi16>, i64) -> i16
    %34 = "llvm.bitcast"(%33) : (i16) -> vector<2xi8>
    %35 = "nvvm.convert.f8x2.to.f16x2"(%34) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %36 = "llvm.bitcast"(%35) : (vector<2xf16>) -> i32
    %37 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %38 = "llvm.insertelement"(%28, %36, %37) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %39 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %40 = "llvm.extractelement"(%31, %39) : (vector<2xi16>, i64) -> i16
    %41 = "llvm.bitcast"(%40) : (i16) -> vector<2xi8>
    %42 = "nvvm.convert.f8x2.to.f16x2"(%41) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %43 = "llvm.bitcast"(%42) : (vector<2xf16>) -> i32
    %44 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %45 = "llvm.insertelement"(%38, %43, %44) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %46 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %47 = "llvm.extractelement"(%27, %46) : (vector<2xi32>, i64) -> i32
    %48 = "llvm.bitcast"(%47) : (i32) -> vector<2xi16>
    %49 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %50 = "llvm.extractelement"(%48, %49) : (vector<2xi16>, i64) -> i16
    %51 = "llvm.bitcast"(%50) : (i16) -> vector<2xi8>
    %52 = "nvvm.convert.f8x2.to.f16x2"(%51) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %53 = "llvm.bitcast"(%52) : (vector<2xf16>) -> i32
    %54 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %55 = "llvm.insertelement"(%45, %53, %54) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %56 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %57 = "llvm.extractelement"(%48, %56) : (vector<2xi16>, i64) -> i16
    %58 = "llvm.bitcast"(%57) : (i16) -> vector<2xi8>
    %59 = "nvvm.convert.f8x2.to.f16x2"(%58) <{relu = false, srcType = f8E4M3FN}> : (vector<2xi8>) -> vector<2xf16>
    %60 = "llvm.bitcast"(%59) : (vector<2xf16>) -> i32
    %61 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %62 = "llvm.insertelement"(%55, %60, %61) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %63 = "llvm.bitcast"(%62) : (vector<4xi32>) -> vector<8xf16>
    %64 = "llvm.fpext"(%63) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf16>) -> vector<8xf32>
    %65 = "vector.shape_cast"(%64) : (vector<8xf32>) -> vector<2x4xf32>
    "func.return"(%65) : (vector<2x4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf8E5M2>) -> vector<3xf32>, sym_name = "e2e_v3f8_to_v3f32"}> ({
  ^bb0(%arg0: vector<3xf8E5M2>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E5M2>}> : () -> vector<4xf8E5M2>
    %1 = "vector.insert_strided_slice"(%arg0, %0) <{offsets = [0], strides = [1]}> : (vector<3xf8E5M2>, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<4xf8E5M2>) -> vector<4xi8>
    %3 = "llvm.bitcast"(%2) : (vector<4xi8>) -> vector<1xi32>
    %4 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %5 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %6 = "llvm.extractelement"(%3, %5) : (vector<1xi32>, i64) -> i32
    %7 = "llvm.bitcast"(%6) : (i32) -> vector<2xi16>
    %8 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %9 = "llvm.extractelement"(%7, %8) : (vector<2xi16>, i64) -> i16
    %10 = "llvm.bitcast"(%9) : (i16) -> vector<2xi8>
    %11 = "nvvm.convert.f8x2.to.f16x2"(%10) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %12 = "llvm.bitcast"(%11) : (vector<2xf16>) -> i32
    %13 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %14 = "llvm.insertelement"(%4, %12, %13) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %15 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %16 = "llvm.extractelement"(%7, %15) : (vector<2xi16>, i64) -> i16
    %17 = "llvm.bitcast"(%16) : (i16) -> vector<2xi8>
    %18 = "nvvm.convert.f8x2.to.f16x2"(%17) <{relu = false, srcType = f8E5M2}> : (vector<2xi8>) -> vector<2xf16>
    %19 = "llvm.bitcast"(%18) : (vector<2xf16>) -> i32
    %20 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %21 = "llvm.insertelement"(%14, %19, %20) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %22 = "llvm.bitcast"(%21) : (vector<2xi32>) -> vector<4xf16>
    %23 = "llvm.fpext"(%22) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf16>) -> vector<4xf32>
    %24 = "vector.extract_strided_slice"(%23) <{offsets = [0], sizes = [3], strides = [1]}> : (vector<4xf32>) -> vector<3xf32>
    "func.return"(%24) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()


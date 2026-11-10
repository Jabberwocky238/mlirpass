module {
  llvm.func spir_funccc @__builtin_IB_hftobf8_16(vector<16xf16>) -> vector<16xi8> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @truncf_f16_to_bf8(%arg0: vector<16xf16>) -> vector<16xi8> {
    %0 = llvm.call spir_funccc @__builtin_IB_hftobf8_16(%arg0) {convergent, function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_hftobf8_16", visibility_ = 0 : i64, will_return} : (vector<16xf16>) -> vector<16xi8>
    llvm.return %0 : vector<16xi8>
  }
}

// -----
module {
  llvm.func spir_funccc @__builtin_IB_hftohf8_16(vector<16xf16>) -> vector<16xi8> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @truncf_f16_to_hf8(%arg0: vector<16xf16>) -> vector<16xi8> {
    %0 = llvm.call spir_funccc @__builtin_IB_hftohf8_16(%arg0) {convergent, function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_hftohf8_16", visibility_ = 0 : i64, will_return} : (vector<16xf16>) -> vector<16xi8>
    llvm.return %0 : vector<16xi8>
  }
}

// -----
module {
  llvm.func spir_funccc @__builtin_IB_hftobf8_16(vector<16xf16>) -> vector<16xi8> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func spir_funccc @_Z14convert_half16Dv16_f(vector<16xf32>) -> vector<16xf16> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func spir_funccc @__builtin_IB_bftof_16(vector<16xi16>) -> vector<16xf32> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @truncf_bf16_to_bf8(%arg0: vector<16xbf16>) -> vector<16xi8> {
    %0 = llvm.bitcast %arg0 : vector<16xbf16> to vector<16xi16>
    %1 = llvm.call spir_funccc @__builtin_IB_bftof_16(%0) {convergent, function_type = !llvm.func<vector<16xf32> (vector<16xi16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_bftof_16", visibility_ = 0 : i64, will_return} : (vector<16xi16>) -> vector<16xf32>
    %2 = llvm.call spir_funccc @_Z14convert_half16Dv16_f(%1) {convergent, function_type = !llvm.func<vector<16xf16> (vector<16xf32>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z14convert_half16Dv16_f", visibility_ = 0 : i64, will_return} : (vector<16xf32>) -> vector<16xf16>
    %3 = llvm.call spir_funccc @__builtin_IB_hftobf8_16(%2) {convergent, function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_hftobf8_16", visibility_ = 0 : i64, will_return} : (vector<16xf16>) -> vector<16xi8>
    llvm.return %3 : vector<16xi8>
  }
}

// -----
module {
  llvm.func spir_funccc @__builtin_IB_hftohf8_16(vector<16xf16>) -> vector<16xi8> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func spir_funccc @_Z14convert_half16Dv16_f(vector<16xf32>) -> vector<16xf16> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func spir_funccc @__builtin_IB_bftof_16(vector<16xi16>) -> vector<16xf32> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @truncf_bf16_to_hf8(%arg0: vector<16xbf16>) -> vector<16xi8> {
    %0 = llvm.bitcast %arg0 : vector<16xbf16> to vector<16xi16>
    %1 = llvm.call spir_funccc @__builtin_IB_bftof_16(%0) {convergent, function_type = !llvm.func<vector<16xf32> (vector<16xi16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_bftof_16", visibility_ = 0 : i64, will_return} : (vector<16xi16>) -> vector<16xf32>
    %2 = llvm.call spir_funccc @_Z14convert_half16Dv16_f(%1) {convergent, function_type = !llvm.func<vector<16xf16> (vector<16xf32>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z14convert_half16Dv16_f", visibility_ = 0 : i64, will_return} : (vector<16xf32>) -> vector<16xf16>
    %3 = llvm.call spir_funccc @__builtin_IB_hftohf8_16(%2) {convergent, function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_hftohf8_16", visibility_ = 0 : i64, will_return} : (vector<16xf16>) -> vector<16xi8>
    llvm.return %3 : vector<16xi8>
  }
}

// -----
module {
  llvm.func spir_funccc @__builtin_IB_dnscl_hf16(i32, i32, i32, i32) -> i32 attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @truncf_f16_to_e2m1(%arg0: vector<16xf16>) -> vector<8xi8> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.bitcast %arg0 : vector<16xf16> to vector<8xi32>
    %10 = llvm.extractelement %9[%8 : i32] : vector<8xi32>
    %11 = llvm.extractelement %9[%6 : i32] : vector<8xi32>
    %12 = llvm.call spir_funccc @__builtin_IB_dnscl_hf16(%10, %11, %7, %8) {convergent, function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_dnscl_hf16", visibility_ = 0 : i64, will_return} : (i32, i32, i32, i32) -> i32
    %13 = llvm.extractelement %9[%7 : i32] : vector<8xi32>
    %14 = llvm.extractelement %9[%5 : i32] : vector<8xi32>
    %15 = llvm.call spir_funccc @__builtin_IB_dnscl_hf16(%13, %14, %7, %6) {convergent, function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_dnscl_hf16", visibility_ = 0 : i64, will_return} : (i32, i32, i32, i32) -> i32
    %16 = llvm.or %12, %15 : i32
    %17 = llvm.extractelement %9[%4 : i32] : vector<8xi32>
    %18 = llvm.extractelement %9[%2 : i32] : vector<8xi32>
    %19 = llvm.call spir_funccc @__builtin_IB_dnscl_hf16(%17, %18, %7, %8) {convergent, function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_dnscl_hf16", visibility_ = 0 : i64, will_return} : (i32, i32, i32, i32) -> i32
    %20 = llvm.extractelement %9[%3 : i32] : vector<8xi32>
    %21 = llvm.extractelement %9[%1 : i32] : vector<8xi32>
    %22 = llvm.call spir_funccc @__builtin_IB_dnscl_hf16(%20, %21, %7, %6) {convergent, function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_dnscl_hf16", visibility_ = 0 : i64, will_return} : (i32, i32, i32, i32) -> i32
    %23 = llvm.or %19, %22 : i32
    %24 = llvm.insertelement %16, %0[%8 : i32] : vector<2xi32>
    %25 = llvm.insertelement %23, %24[%7 : i32] : vector<2xi32>
    %26 = llvm.bitcast %25 : vector<2xi32> to vector<8xi8>
    llvm.return %26 : vector<8xi8>
  }
}

// -----
module {
  llvm.func spir_funccc @__builtin_IB_dnscl_bf16(i32, i32, i32, i32) -> i32 attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @truncf_bf16_to_e2m1(%arg0: vector<16xbf16>) -> vector<8xi8> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.bitcast %arg0 : vector<16xbf16> to vector<8xi32>
    %10 = llvm.extractelement %9[%8 : i32] : vector<8xi32>
    %11 = llvm.extractelement %9[%6 : i32] : vector<8xi32>
    %12 = llvm.call spir_funccc @__builtin_IB_dnscl_bf16(%10, %11, %7, %8) {convergent, function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_dnscl_bf16", visibility_ = 0 : i64, will_return} : (i32, i32, i32, i32) -> i32
    %13 = llvm.extractelement %9[%7 : i32] : vector<8xi32>
    %14 = llvm.extractelement %9[%5 : i32] : vector<8xi32>
    %15 = llvm.call spir_funccc @__builtin_IB_dnscl_bf16(%13, %14, %7, %6) {convergent, function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_dnscl_bf16", visibility_ = 0 : i64, will_return} : (i32, i32, i32, i32) -> i32
    %16 = llvm.or %12, %15 : i32
    %17 = llvm.extractelement %9[%4 : i32] : vector<8xi32>
    %18 = llvm.extractelement %9[%2 : i32] : vector<8xi32>
    %19 = llvm.call spir_funccc @__builtin_IB_dnscl_bf16(%17, %18, %7, %8) {convergent, function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_dnscl_bf16", visibility_ = 0 : i64, will_return} : (i32, i32, i32, i32) -> i32
    %20 = llvm.extractelement %9[%3 : i32] : vector<8xi32>
    %21 = llvm.extractelement %9[%1 : i32] : vector<8xi32>
    %22 = llvm.call spir_funccc @__builtin_IB_dnscl_bf16(%20, %21, %7, %6) {convergent, function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_dnscl_bf16", visibility_ = 0 : i64, will_return} : (i32, i32, i32, i32) -> i32
    %23 = llvm.or %19, %22 : i32
    %24 = llvm.insertelement %16, %0[%8 : i32] : vector<2xi32>
    %25 = llvm.insertelement %23, %24[%7 : i32] : vector<2xi32>
    %26 = llvm.bitcast %25 : vector<2xi32> to vector<8xi8>
    llvm.return %26 : vector<8xi8>
  }
}

// -----
module {
  llvm.func spir_funccc @__builtin_IB_bf8tohf_16(vector<16xi8>) -> vector<16xf16> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @extf_bf8_to_f16(%arg0: vector<16xi8>) -> vector<16xf16> {
    %0 = llvm.call spir_funccc @__builtin_IB_bf8tohf_16(%arg0) {convergent, function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_bf8tohf_16", visibility_ = 0 : i64, will_return} : (vector<16xi8>) -> vector<16xf16>
    llvm.return %0 : vector<16xf16>
  }
}

// -----
module {
  llvm.func spir_funccc @__builtin_IB_hf8tohf_16(vector<16xi8>) -> vector<16xf16> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @extf_f8_to_f16(%arg0: vector<16xi8>) -> vector<16xf16> {
    %0 = llvm.call spir_funccc @__builtin_IB_hf8tohf_16(%arg0) {convergent, function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_hf8tohf_16", visibility_ = 0 : i64, will_return} : (vector<16xi8>) -> vector<16xf16>
    llvm.return %0 : vector<16xf16>
  }
}

// -----
module {
  llvm.func spir_funccc @__builtin_IB_ftobf_16(vector<16xf32>) -> vector<16xi16> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func spir_funccc @_Z15convert_float16Dv16_Dh(vector<16xf16>) -> vector<16xf32> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func spir_funccc @__builtin_IB_bf8tohf_16(vector<16xi8>) -> vector<16xf16> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @extf_bf8_to_bf16(%arg0: vector<16xi8>) -> vector<16xbf16> {
    %0 = llvm.call spir_funccc @__builtin_IB_bf8tohf_16(%arg0) {convergent, function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_bf8tohf_16", visibility_ = 0 : i64, will_return} : (vector<16xi8>) -> vector<16xf16>
    %1 = llvm.call spir_funccc @_Z15convert_float16Dv16_Dh(%0) {convergent, function_type = !llvm.func<vector<16xf32> (vector<16xf16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z15convert_float16Dv16_Dh", visibility_ = 0 : i64, will_return} : (vector<16xf16>) -> vector<16xf32>
    %2 = llvm.call spir_funccc @__builtin_IB_ftobf_16(%1) {convergent, function_type = !llvm.func<vector<16xi16> (vector<16xf32>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_ftobf_16", visibility_ = 0 : i64, will_return} : (vector<16xf32>) -> vector<16xi16>
    %3 = llvm.bitcast %2 : vector<16xi16> to vector<16xbf16>
    llvm.return %3 : vector<16xbf16>
  }
}

// -----
module {
  llvm.func spir_funccc @__builtin_IB_ftobf_16(vector<16xf32>) -> vector<16xi16> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func spir_funccc @_Z15convert_float16Dv16_Dh(vector<16xf16>) -> vector<16xf32> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func spir_funccc @__builtin_IB_hf8tohf_16(vector<16xi8>) -> vector<16xf16> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @extf_f8_to_bf16(%arg0: vector<16xi8>) -> vector<16xbf16> {
    %0 = llvm.call spir_funccc @__builtin_IB_hf8tohf_16(%arg0) {convergent, function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_hf8tohf_16", visibility_ = 0 : i64, will_return} : (vector<16xi8>) -> vector<16xf16>
    %1 = llvm.call spir_funccc @_Z15convert_float16Dv16_Dh(%0) {convergent, function_type = !llvm.func<vector<16xf32> (vector<16xf16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z15convert_float16Dv16_Dh", visibility_ = 0 : i64, will_return} : (vector<16xf16>) -> vector<16xf32>
    %2 = llvm.call spir_funccc @__builtin_IB_ftobf_16(%1) {convergent, function_type = !llvm.func<vector<16xi16> (vector<16xf32>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_ftobf_16", visibility_ = 0 : i64, will_return} : (vector<16xf32>) -> vector<16xi16>
    %3 = llvm.bitcast %2 : vector<16xi16> to vector<16xbf16>
    llvm.return %3 : vector<16xbf16>
  }
}

// -----
module {
  llvm.func spir_funccc @__builtin_IB_shfl_idx4_to_fp16_8_packed(vector<16xi32>, vector<8xi8>) -> vector<8xi32> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func spir_funccc @__builtin_IB_shfl_idx4_lut(i32) -> vector<16xi32> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @extf_e2m1_to_f16(%arg0: vector<8xi8>) -> vector<16xf16> {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.call spir_funccc @__builtin_IB_shfl_idx4_lut(%0) {convergent, function_type = !llvm.func<vector<16xi32> (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_shfl_idx4_lut", visibility_ = 0 : i64, will_return} : (i32) -> vector<16xi32>
    %2 = llvm.call spir_funccc @__builtin_IB_shfl_idx4_to_fp16_8_packed(%1, %arg0) {convergent, function_type = !llvm.func<vector<8xi32> (vector<16xi32>, vector<8xi8>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_shfl_idx4_to_fp16_8_packed", visibility_ = 0 : i64, will_return} : (vector<16xi32>, vector<8xi8>) -> vector<8xi32>
    %3 = llvm.bitcast %2 : vector<8xi32> to vector<16xf16>
    llvm.return %3 : vector<16xf16>
  }
}

// -----
module {
  llvm.func spir_funccc @__builtin_IB_shfl_idx4_to_fp16_8_packed(vector<16xi32>, vector<8xi8>) -> vector<8xi32> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func spir_funccc @__builtin_IB_shfl_idx4_lut(i32) -> vector<16xi32> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @extf_e2m1_to_bf16(%arg0: vector<8xi8>) -> vector<16xbf16> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call spir_funccc @__builtin_IB_shfl_idx4_lut(%0) {convergent, function_type = !llvm.func<vector<16xi32> (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_shfl_idx4_lut", visibility_ = 0 : i64, will_return} : (i32) -> vector<16xi32>
    %2 = llvm.call spir_funccc @__builtin_IB_shfl_idx4_to_fp16_8_packed(%1, %arg0) {convergent, function_type = !llvm.func<vector<8xi32> (vector<16xi32>, vector<8xi8>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_shfl_idx4_to_fp16_8_packed", visibility_ = 0 : i64, will_return} : (vector<16xi32>, vector<8xi8>) -> vector<8xi32>
    %3 = llvm.bitcast %2 : vector<8xi32> to vector<16xbf16>
    llvm.return %3 : vector<16xbf16>
  }
}

// -----
module {
  llvm.func spir_funccc @__builtin_IB_sub_group16_bdpas_f_f_bf8_bf8_8_8(vector<8xf32>, vector<8xi16>, vector<8xi32>, i8, i8) -> vector<8xf32> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @mma_mx_bf8_bf8_k32_f32(%arg0: vector<8xi16>, %arg1: vector<8xi32>, %arg2: i8, %arg3: i8, %arg4: vector<8xf32>) -> vector<8xf32> {
    %0 = llvm.call spir_funccc @__builtin_IB_sub_group16_bdpas_f_f_bf8_bf8_8_8(%arg4, %arg0, %arg1, %arg2, %arg3) {convergent, function_type = !llvm.func<vector<8xf32> (vector<8xf32>, vector<8xi16>, vector<8xi32>, i8, i8)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_sub_group16_bdpas_f_f_bf8_bf8_8_8", visibility_ = 0 : i64, will_return} : (vector<8xf32>, vector<8xi16>, vector<8xi32>, i8, i8) -> vector<8xf32>
    llvm.return %0 : vector<8xf32>
  }
}


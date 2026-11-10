"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<128x72xf16, 3>) -> vector<8xf16>, sym_name = "transpose_load_to_rocdl_8xf16"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<128x72xf16, 3>):
    %0 = "amdgpu.transpose_load"(%arg2, %arg0, %arg1) : (memref<128x72xf16, 3>, index, index) -> vector<8xf16>
    "func.return"(%0) : (vector<8xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<128x128xi8, 3>) -> vector<8xi8>, sym_name = "transpose_load_to_rocdl_8xi8"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<128x128xi8, 3>):
    %0 = "amdgpu.transpose_load"(%arg2, %arg0, %arg1) : (memref<128x128xi8, 3>, index, index) -> vector<8xi8>
    "func.return"(%0) : (vector<8xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<128x32xi8, 3>) -> vector<16xi4>, sym_name = "transpose_load_to_rocdl_16xi4"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<128x32xi8, 3>):
    %0 = "amdgpu.transpose_load"(%arg2, %arg0, %arg1) : (memref<128x32xi8, 3>, index, index) -> vector<16xi4>
    "func.return"(%0) : (vector<16xi4>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<128x32xi8, 3>) -> vector<16xi6>, sym_name = "transpose_load_to_rocdl_16xi6"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<128x32xi8, 3>):
    %0 = "amdgpu.transpose_load"(%arg2, %arg0, %arg1) : (memref<128x32xi8, 3>, index, index) -> vector<16xi6>
    "func.return"(%0) : (vector<16xi6>) -> ()
  }) : () -> ()
}) : () -> ()


"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "return_none_val"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "return_one_val"}> ({
  ^bb0(%arg3: f32):
    "func.return"(%arg3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (f32, f32), sym_name = "return_multi_val"}> ({
  ^bb0(%arg2: f32):
    "func.return"(%arg2, %arg2) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "return_one_index"}> ({
  ^bb0(%arg1: index):
    "func.return"(%arg1) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "call_functions"}> ({
  ^bb0(%arg0: index):
    "func.call"() <{callee = @return_none_val}> : () -> ()
    %0 = "func.call"(%arg0) <{callee = @return_one_index}> : (index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "dim_index_out_of_bounds"}> ({
    %0 = "arith.constant"() <{value = 6 : index}> : () -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xi64>
    %2 = "memref.dim"(%1, %0) : (memref<4xi64>, index) -> index
    %3 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100xi64>
    %4 = "affine.vector_load"(%3, %2) <{map = #map}> : (memref<100xi64>, index) -> vector<31xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
^bb0:
}) : () -> ()


"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x4xi32>) -> vector<2x2xi64>, sym_name = "bitcast_2d"}> ({
  ^bb0(%arg0: vector<2x4xi32>):
    %0 = "vector.bitcast"(%arg0) : (vector<2x4xi32>) -> vector<2x2xi64>
    "func.return"(%0) : (vector<2x2xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x[4]xi32>) -> vector<2x[2]xi64>, sym_name = "bitcast_2d_scalable"}> ({
  ^bb0(%arg0: vector<2x[4]xi32>):
    %0 = "vector.bitcast"(%arg0) : (vector<2x[4]xi32>) -> vector<2x[2]xi64>
    "func.return"(%0) : (vector<2x[2]xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<f32>, sym_name = "broadcast_vec0d_from_f32"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<f32>
    "func.return"(%0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<2xf32>, sym_name = "broadcast_vec1d_from_f32"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<1xf32>, sym_name = "broadcast_single_elem_vec1d_from_f32"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<1xf32>
    "func.return"(%0) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<[2]xf32>, sym_name = "broadcast_vec1d_from_f32_scalable"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<[2]xf32>
    "func.return"(%0) : (vector<[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<2xindex>, sym_name = "broadcast_vec1d_from_index"}> ({
  ^bb0(%arg0: index):
    %0 = "vector.broadcast"(%arg0) : (index) -> vector<2xindex>
    "func.return"(%0) : (vector<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<[2]xindex>, sym_name = "broadcast_vec1d_from_index_scalable"}> ({
  ^bb0(%arg0: index):
    %0 = "vector.broadcast"(%arg0) : (index) -> vector<[2]xindex>
    "func.return"(%0) : (vector<[2]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<2x3xf32>, sym_name = "broadcast_vec2d_from_scalar"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<2x3xf32>
    "func.return"(%0) : (vector<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<2x[3]xf32>, sym_name = "broadcast_vec2d_from_scalar_scalable"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<2x[3]xf32>
    "func.return"(%0) : (vector<2x[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<2x3x4xf32>, sym_name = "broadcast_vec3d_from_scalar"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<2x3x4xf32>
    "func.return"(%0) : (vector<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<2x3x[4]xf32>, sym_name = "broadcast_vec3d_from_scalar_scalable"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<2x3x[4]xf32>
    "func.return"(%0) : (vector<2x3x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> vector<3x2xf32>, sym_name = "broadcast_vec2d_from_vec0d"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "vector.broadcast"(%arg0) : (vector<f32>) -> vector<3x2xf32>
    "func.return"(%0) : (vector<3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<3x2xf32>, sym_name = "broadcast_vec2d_from_vec1d"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<2xf32>) -> vector<3x2xf32>
    "func.return"(%0) : (vector<3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>) -> vector<3x[2]xf32>, sym_name = "broadcast_vec2d_from_vec1d_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<[2]xf32>) -> vector<3x[2]xf32>
    "func.return"(%0) : (vector<3x[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xindex>) -> vector<3x2xindex>, sym_name = "broadcast_vec2d_from_index_vec1d"}> ({
  ^bb0(%arg0: vector<2xindex>):
    %0 = "vector.broadcast"(%arg0) : (vector<2xindex>) -> vector<3x2xindex>
    "func.return"(%0) : (vector<3x2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xindex>) -> vector<3x[2]xindex>, sym_name = "broadcast_vec2d_from_index_vec1d_scalable"}> ({
  ^bb0(%arg0: vector<[2]xindex>):
    %0 = "vector.broadcast"(%arg0) : (vector<[2]xindex>) -> vector<3x[2]xindex>
    "func.return"(%0) : (vector<3x[2]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<4x3x2xf32>, sym_name = "broadcast_vec3d_from_vec1d"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<2xf32>) -> vector<4x3x2xf32>
    "func.return"(%0) : (vector<4x3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>) -> vector<4x3x[2]xf32>, sym_name = "broadcast_vec3d_from_vec1d_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<[2]xf32>) -> vector<4x3x[2]xf32>
    "func.return"(%0) : (vector<4x3x[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x2xf32>) -> vector<4x3x2xf32>, sym_name = "broadcast_vec3d_from_vec2d"}> ({
  ^bb0(%arg0: vector<3x2xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<3x2xf32>) -> vector<4x3x2xf32>
    "func.return"(%0) : (vector<4x3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x[2]xf32>) -> vector<4x3x[2]xf32>, sym_name = "broadcast_vec3d_from_vec2d_scalable"}> ({
  ^bb0(%arg0: vector<3x[2]xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<3x[2]xf32>) -> vector<4x3x[2]xf32>
    "func.return"(%0) : (vector<4x3x[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>) -> vector<4xf32>, sym_name = "broadcast_stretch"}> ({
  ^bb0(%arg0: vector<1xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<1xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>) -> vector<[4]xf32>, sym_name = "broadcast_stretch_scalable"}> ({
  ^bb0(%arg0: vector<1xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<1xf32>) -> vector<[4]xf32>
    "func.return"(%0) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x4xf32>) -> vector<3x4xf32>, sym_name = "broadcast_stretch_at_start"}> ({
  ^bb0(%arg0: vector<1x4xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<1x4xf32>) -> vector<3x4xf32>
    "func.return"(%0) : (vector<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x[4]xf32>) -> vector<3x[4]xf32>, sym_name = "broadcast_stretch_at_start_scalable"}> ({
  ^bb0(%arg0: vector<1x[4]xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<1x[4]xf32>) -> vector<3x[4]xf32>
    "func.return"(%0) : (vector<3x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x1xf32>) -> vector<4x3xf32>, sym_name = "broadcast_stretch_at_end"}> ({
  ^bb0(%arg1: vector<4x1xf32>):
    %1 = "vector.broadcast"(%arg1) : (vector<4x1xf32>) -> vector<4x3xf32>
    "func.return"(%1) : (vector<4x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<[4]x1xf32>) -> vector<[4]x3xf32>, sym_name = "broadcast_stretch_at_end_scalable"}> ({
  ^bb0(%arg0: vector<[4]x1xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<[4]x1xf32>) -> vector<[4]x3xf32>
    "func.return"(%0) : (vector<[4]x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x1x2xf32>) -> vector<4x3x2xf32>, sym_name = "broadcast_stretch_in_middle"}> ({
  ^bb0(%arg0: vector<4x1x2xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<4x1x2xf32>) -> vector<4x3x2xf32>
    "func.return"(%0) : (vector<4x3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x1x[2]xf32>) -> vector<4x3x[2]xf32>, sym_name = "broadcast_stretch_in_middle_scalable_v1"}> ({
  ^bb0(%arg0: vector<4x1x[2]xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<4x1x[2]xf32>) -> vector<4x3x[2]xf32>
    "func.return"(%0) : (vector<4x3x[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]x1x2xf32>) -> vector<[4]x3x2xf32>, sym_name = "broadcast_stretch_in_middle_scalable_v2"}> ({
  ^bb0(%arg0: vector<[4]x1x2xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<[4]x1x2xf32>) -> vector<[4]x3x2xf32>
    "func.return"(%0) : (vector<[4]x3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<3xf32>) -> vector<2x3xf32>, sym_name = "outerproduct"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<3xf32>):
    %0 = "vector.outerproduct"(%arg0, %arg1) <{kind = #vector.kind<add>}> : (vector<2xf32>, vector<3xf32>) -> vector<2x3xf32>
    "func.return"(%0) : (vector<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<[3]xf32>) -> vector<2x[3]xf32>, sym_name = "outerproduct_scalable"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<[3]xf32>):
    %0 = "vector.outerproduct"(%arg0, %arg1) <{kind = #vector.kind<add>}> : (vector<2xf32>, vector<[3]xf32>) -> vector<2x[3]xf32>
    "func.return"(%0) : (vector<2x[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xindex>, vector<3xindex>) -> vector<2x3xindex>, sym_name = "outerproduct_index"}> ({
  ^bb0(%arg0: vector<2xindex>, %arg1: vector<3xindex>):
    %0 = "vector.outerproduct"(%arg0, %arg1) <{kind = #vector.kind<add>}> : (vector<2xindex>, vector<3xindex>) -> vector<2x3xindex>
    "func.return"(%0) : (vector<2x3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xindex>, vector<[3]xindex>) -> vector<2x[3]xindex>, sym_name = "outerproduct_index_scalable"}> ({
  ^bb0(%arg0: vector<2xindex>, %arg1: vector<[3]xindex>):
    %0 = "vector.outerproduct"(%arg0, %arg1) <{kind = #vector.kind<add>}> : (vector<2xindex>, vector<[3]xindex>) -> vector<2x[3]xindex>
    "func.return"(%0) : (vector<2x[3]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<3xf32>, vector<2x3xf32>) -> vector<2x3xf32>, sym_name = "outerproduct_add"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<3xf32>, %arg2: vector<2x3xf32>):
    %0 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<add>}> : (vector<2xf32>, vector<3xf32>, vector<2x3xf32>) -> vector<2x3xf32>
    "func.return"(%0) : (vector<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<[3]xf32>, vector<2x[3]xf32>) -> vector<2x[3]xf32>, sym_name = "outerproduct_add_scalable"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<[3]xf32>, %arg2: vector<2x[3]xf32>):
    %0 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<add>}> : (vector<2xf32>, vector<[3]xf32>, vector<2x[3]xf32>) -> vector<2x[3]xf32>
    "func.return"(%0) : (vector<2x[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, f32, vector<2xf32>, vector<2xi1>) -> vector<2xf32>, sym_name = "masked_float_add_outerprod"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: f32, %arg2: vector<2xf32>, %arg3: vector<2xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<add>}> : (vector<2xf32>, f32, vector<2xf32>) -> vector<2xf32>
      "vector.yield"(%1) : (vector<2xf32>) -> ()
    }) : (vector<2xi1>) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>, f32, vector<[2]xf32>, vector<[2]xi1>) -> vector<[2]xf32>, sym_name = "masked_float_add_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>, %arg1: f32, %arg2: vector<[2]xf32>, %arg3: vector<[2]xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<add>}> : (vector<[2]xf32>, f32, vector<[2]xf32>) -> vector<[2]xf32>
      "vector.yield"(%1) : (vector<[2]xf32>) -> ()
    }) : (vector<[2]xi1>) -> vector<[2]xf32>
    "func.return"(%0) : (vector<[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, f32, vector<2xf32>, vector<2xi1>) -> vector<2xf32>, sym_name = "masked_float_mul_outerprod"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: f32, %arg2: vector<2xf32>, %arg3: vector<2xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<mul>}> : (vector<2xf32>, f32, vector<2xf32>) -> vector<2xf32>
      "vector.yield"(%1) : (vector<2xf32>) -> ()
    }) : (vector<2xi1>) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>, f32, vector<[2]xf32>, vector<[2]xi1>) -> vector<[2]xf32>, sym_name = "masked_float_mul_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>, %arg1: f32, %arg2: vector<[2]xf32>, %arg3: vector<[2]xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<mul>}> : (vector<[2]xf32>, f32, vector<[2]xf32>) -> vector<[2]xf32>
      "vector.yield"(%1) : (vector<[2]xf32>) -> ()
    }) : (vector<[2]xi1>) -> vector<[2]xf32>
    "func.return"(%0) : (vector<[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, f32, vector<2xf32>, vector<2xi1>) -> vector<2xf32>, sym_name = "masked_float_max_outerprod"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: f32, %arg2: vector<2xf32>, %arg3: vector<2xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<maxnumf>}> : (vector<2xf32>, f32, vector<2xf32>) -> vector<2xf32>
      "vector.yield"(%1) : (vector<2xf32>) -> ()
    }) : (vector<2xi1>) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>, f32, vector<[2]xf32>, vector<[2]xi1>) -> vector<[2]xf32>, sym_name = "masked_float_max_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>, %arg1: f32, %arg2: vector<[2]xf32>, %arg3: vector<[2]xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<maxnumf>}> : (vector<[2]xf32>, f32, vector<[2]xf32>) -> vector<[2]xf32>
      "vector.yield"(%1) : (vector<[2]xf32>) -> ()
    }) : (vector<[2]xi1>) -> vector<[2]xf32>
    "func.return"(%0) : (vector<[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, f32, vector<2xf32>, vector<2xi1>) -> vector<2xf32>, sym_name = "masked_float_min_outerprod"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: f32, %arg2: vector<2xf32>, %arg3: vector<2xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<minnumf>}> : (vector<2xf32>, f32, vector<2xf32>) -> vector<2xf32>
      "vector.yield"(%1) : (vector<2xf32>) -> ()
    }) : (vector<2xi1>) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>, f32, vector<[2]xf32>, vector<[2]xi1>) -> vector<[2]xf32>, sym_name = "masked_float_min_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>, %arg1: f32, %arg2: vector<[2]xf32>, %arg3: vector<[2]xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<minnumf>}> : (vector<[2]xf32>, f32, vector<[2]xf32>) -> vector<[2]xf32>
      "vector.yield"(%1) : (vector<[2]xf32>) -> ()
    }) : (vector<[2]xi1>) -> vector<[2]xf32>
    "func.return"(%0) : (vector<[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>, i32, vector<2xi32>, vector<2xi1>) -> vector<2xi32>, sym_name = "masked_int_add_outerprod"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<add>}> : (vector<2xi32>, i32, vector<2xi32>) -> vector<2xi32>
      "vector.yield"(%1) : (vector<2xi32>) -> ()
    }) : (vector<2xi1>) -> vector<2xi32>
    "func.return"(%0) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xi32>, i32, vector<[2]xi32>, vector<[2]xi1>) -> vector<[2]xi32>, sym_name = "masked_int_add_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<add>}> : (vector<[2]xi32>, i32, vector<[2]xi32>) -> vector<[2]xi32>
      "vector.yield"(%1) : (vector<[2]xi32>) -> ()
    }) : (vector<[2]xi1>) -> vector<[2]xi32>
    "func.return"(%0) : (vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>, i32, vector<2xi32>, vector<2xi1>) -> vector<2xi32>, sym_name = "masked_int_mul_outerprod"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<mul>}> : (vector<2xi32>, i32, vector<2xi32>) -> vector<2xi32>
      "vector.yield"(%1) : (vector<2xi32>) -> ()
    }) : (vector<2xi1>) -> vector<2xi32>
    "func.return"(%0) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xi32>, i32, vector<[2]xi32>, vector<[2]xi1>) -> vector<[2]xi32>, sym_name = "masked_int_mul_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<mul>}> : (vector<[2]xi32>, i32, vector<[2]xi32>) -> vector<[2]xi32>
      "vector.yield"(%1) : (vector<[2]xi32>) -> ()
    }) : (vector<[2]xi1>) -> vector<[2]xi32>
    "func.return"(%0) : (vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>, i32, vector<2xi32>, vector<2xi1>) -> vector<2xi32>, sym_name = "masked_int_max_outerprod"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<maxsi>}> : (vector<2xi32>, i32, vector<2xi32>) -> vector<2xi32>
      "vector.yield"(%1) : (vector<2xi32>) -> ()
    }) : (vector<2xi1>) -> vector<2xi32>
    "func.return"(%0) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xi32>, i32, vector<[2]xi32>, vector<[2]xi1>) -> vector<[2]xi32>, sym_name = "masked_int_max_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<maxsi>}> : (vector<[2]xi32>, i32, vector<[2]xi32>) -> vector<[2]xi32>
      "vector.yield"(%1) : (vector<[2]xi32>) -> ()
    }) : (vector<[2]xi1>) -> vector<[2]xi32>
    "func.return"(%0) : (vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>, i32, vector<2xi32>, vector<2xi1>) -> vector<2xi32>, sym_name = "masked_int_min_outerprod"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<minui>}> : (vector<2xi32>, i32, vector<2xi32>) -> vector<2xi32>
      "vector.yield"(%1) : (vector<2xi32>) -> ()
    }) : (vector<2xi1>) -> vector<2xi32>
    "func.return"(%0) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xi32>, i32, vector<[2]xi32>, vector<[2]xi1>) -> vector<[2]xi32>, sym_name = "masked_int_min_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<minui>}> : (vector<[2]xi32>, i32, vector<[2]xi32>) -> vector<[2]xi32>
      "vector.yield"(%1) : (vector<[2]xi32>) -> ()
    }) : (vector<[2]xi1>) -> vector<[2]xi32>
    "func.return"(%0) : (vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>, i32, vector<2xi32>, vector<2xi1>) -> vector<2xi32>, sym_name = "masked_int_and_outerprod"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<and>}> : (vector<2xi32>, i32, vector<2xi32>) -> vector<2xi32>
      "vector.yield"(%1) : (vector<2xi32>) -> ()
    }) : (vector<2xi1>) -> vector<2xi32>
    "func.return"(%0) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xi32>, i32, vector<[2]xi32>, vector<[2]xi1>) -> vector<[2]xi32>, sym_name = "masked_int_and_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<and>}> : (vector<[2]xi32>, i32, vector<[2]xi32>) -> vector<[2]xi32>
      "vector.yield"(%1) : (vector<[2]xi32>) -> ()
    }) : (vector<[2]xi1>) -> vector<[2]xi32>
    "func.return"(%0) : (vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>, i32, vector<2xi32>, vector<2xi1>) -> vector<2xi32>, sym_name = "masked_int_or_outerprod"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<or>}> : (vector<2xi32>, i32, vector<2xi32>) -> vector<2xi32>
      "vector.yield"(%1) : (vector<2xi32>) -> ()
    }) : (vector<2xi1>) -> vector<2xi32>
    "func.return"(%0) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xi32>, i32, vector<[2]xi32>, vector<[2]xi1>) -> vector<[2]xi32>, sym_name = "masked_int_or_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.outerproduct"(%arg0, %arg1, %arg2) <{kind = #vector.kind<or>}> : (vector<[2]xi32>, i32, vector<[2]xi32>) -> vector<[2]xi32>
      "vector.yield"(%1) : (vector<[2]xi32>) -> ()
    }) : (vector<[2]xi1>) -> vector<[2]xi32>
    "func.return"(%0) : (vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> f32, sym_name = "extract_scalar_from_vec_1d_f32_poison_idx"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: -1>}> : (vector<16xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x16xf32>) -> vector<3x16xf32>, sym_name = "extract_vec_2d_from_vec_3d_f32_poison_idx"}> ({
  ^bb0(%arg0: vector<4x3x16xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: -1>}> : (vector<4x3x16xf32>) -> vector<3x16xf32>
    "func.return"(%0) : (vector<3x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "print_scalar_i1"}> ({
  ^bb0(%arg0: i1):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i4) -> (), sym_name = "print_scalar_i4"}> ({
  ^bb0(%arg0: i4):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (i4) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (si4) -> (), sym_name = "print_scalar_si4"}> ({
  ^bb0(%arg0: si4):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (si4) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (ui4) -> (), sym_name = "print_scalar_ui4"}> ({
  ^bb0(%arg0: ui4):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (ui4) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "print_scalar_i32"}> ({
  ^bb0(%arg0: i32):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (ui32) -> (), sym_name = "print_scalar_ui32"}> ({
  ^bb0(%arg0: ui32):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (ui32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i40) -> (), sym_name = "print_scalar_i40"}> ({
  ^bb0(%arg0: i40):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (i40) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (si40) -> (), sym_name = "print_scalar_si40"}> ({
  ^bb0(%arg0: si40):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (si40) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (ui40) -> (), sym_name = "print_scalar_ui40"}> ({
  ^bb0(%arg0: ui40):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (ui40) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> vector<2xf32>, sym_name = "extract_strided_slice_f32_1d_from_1d"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xindex>) -> vector<2xindex>, sym_name = "extract_strided_slice_index_1d_from_1d"}> ({
  ^bb0(%arg0: vector<4xindex>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xindex>) -> vector<2xindex>
    "func.return"(%0) : (vector<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x8xf32>) -> vector<2x8xf32>, sym_name = "extract_strided_slice_f32_1d_from_2d"}> ({
  ^bb0(%arg0: vector<4x8xf32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4x8xf32>) -> vector<2x8xf32>
    "func.return"(%0) : (vector<2x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[8]xf32>) -> vector<2x[8]xf32>, sym_name = "extract_strided_slice_f32_1d_from_2d_scalable"}> ({
  ^bb0(%arg0: vector<4x[8]xf32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4x[8]xf32>) -> vector<2x[8]xf32>
    "func.return"(%0) : (vector<2x[8]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x8xf32>) -> vector<2x2xf32>, sym_name = "extract_strided_slice_f32_2d_from_2d"}> ({
  ^bb0(%arg0: vector<4x8xf32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [2, 2], sizes = [2, 2], strides = [1, 1]}> : (vector<4x8xf32>) -> vector<2x2xf32>
    "func.return"(%0) : (vector<2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[8]xf32>) -> vector<2x[8]xf32>, sym_name = "extract_strided_slice_f32_2d_from_2d_scalable"}> ({
  ^bb0(%arg0: vector<4x[8]xf32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [2, 0], sizes = [2, 8], strides = [1, 1]}> : (vector<4x[8]xf32>) -> vector<2x[8]xf32>
    "func.return"(%0) : (vector<2x[8]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x4xf32>, vector<4x4x4xf32>) -> vector<4x4x4xf32>, sym_name = "insert_strided_slice_f32_2d_into_3d"}> ({
  ^bb0(%arg0: vector<4x4xf32>, %arg1: vector<4x4x4xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [2, 0, 0], strides = [1, 1]}> : (vector<4x4xf32>, vector<4x4x4xf32>) -> vector<4x4x4xf32>
    "func.return"(%0) : (vector<4x4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, vector<4x4x[4]xf32>) -> vector<4x4x[4]xf32>, sym_name = "insert_strided_slice_f32_2d_into_3d_scalable"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: vector<4x4x[4]xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [2, 0, 0], strides = [1, 1]}> : (vector<4x[4]xf32>, vector<4x4x[4]xf32>) -> vector<4x4x[4]xf32>
    "func.return"(%0) : (vector<4x4x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x4xindex>, vector<4x4x4xindex>) -> vector<4x4x4xindex>, sym_name = "insert_strided_index_slice_index_2d_into_3d"}> ({
  ^bb0(%arg0: vector<4x4xindex>, %arg1: vector<4x4x4xindex>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [2, 0, 0], strides = [1, 1]}> : (vector<4x4xindex>, vector<4x4x4xindex>) -> vector<4x4x4xindex>
    "func.return"(%0) : (vector<4x4x4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xindex>, vector<4x4x[4]xindex>) -> vector<4x4x[4]xindex>, sym_name = "insert_strided_index_slice_index_2d_into_3d_scalable"}> ({
  ^bb0(%arg0: vector<4x[4]xindex>, %arg1: vector<4x4x[4]xindex>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [2, 0, 0], strides = [1, 1]}> : (vector<4x[4]xindex>, vector<4x4x[4]xindex>) -> vector<4x4x[4]xindex>
    "func.return"(%0) : (vector<4x4x[4]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>, vector<4x4xf32>) -> vector<4x4xf32>, sym_name = "insert_strided_slice_f32_2d_into_2d"}> ({
  ^bb0(%arg0: vector<2x2xf32>, %arg1: vector<4x4xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [2, 2], strides = [1, 1]}> : (vector<2x2xf32>, vector<4x4xf32>) -> vector<4x4xf32>
    "func.return"(%0) : (vector<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x[2]xf32>, vector<4x[2]xf32>) -> vector<4x[2]xf32>, sym_name = "insert_strided_slice_f32_2d_into_2d_scalable"}> ({
  ^bb0(%arg0: vector<2x[2]xf32>, %arg1: vector<4x[2]xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [2, 0], strides = [1, 1]}> : (vector<2x[2]xf32>, vector<4x[2]xf32>) -> vector<4x[2]xf32>
    "func.return"(%0) : (vector<4x[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x4xf32>, vector<16x4x8xf32>) -> vector<16x4x8xf32>, sym_name = "insert_strided_slice_f32_2d_into_3d"}> ({
  ^bb0(%arg0: vector<2x4xf32>, %arg1: vector<16x4x8xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [0, 0, 2], strides = [1, 1]}> : (vector<2x4xf32>, vector<16x4x8xf32>) -> vector<16x4x8xf32>
    "func.return"(%0) : (vector<16x4x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x[4]xf32>, vector<16x4x[4]xf32>) -> vector<16x4x[4]xf32>, sym_name = "insert_strided_slice_f32_2d_into_3d_scalable"}> ({
  ^bb0(%arg0: vector<2x[4]xf32>, %arg1: vector<16x4x[4]xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [3, 2, 0], strides = [1, 1]}> : (vector<2x[4]xf32>, vector<16x4x[4]xf32>) -> vector<16x4x[4]xf32>
    "func.return"(%0) : (vector<16x4x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf32>, vector<2x4xf32>, vector<1x1x1xf32>, vector<f32>) -> (vector<8xf32>, vector<2x4xf32>, vector<1x1x1xf32>, vector<f32>), sym_name = "fma"}> ({
  ^bb0(%arg0: vector<8xf32>, %arg1: vector<2x4xf32>, %arg2: vector<1x1x1xf32>, %arg3: vector<f32>):
    %0 = "vector.fma"(%arg0, %arg0, %arg0) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %1 = "vector.fma"(%arg1, %arg1, %arg1) : (vector<2x4xf32>, vector<2x4xf32>, vector<2x4xf32>) -> vector<2x4xf32>
    %2 = "vector.fma"(%arg2, %arg2, %arg2) : (vector<1x1x1xf32>, vector<1x1x1xf32>, vector<1x1x1xf32>) -> vector<1x1x1xf32>
    %3 = "vector.fma"(%arg3, %arg3, %arg3) : (vector<f32>, vector<f32>, vector<f32>) -> vector<f32>
    "func.return"(%0, %1, %2, %3) : (vector<8xf32>, vector<2x4xf32>, vector<1x1x1xf32>, vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[8]xf32>, vector<2x[4]xf32>, vector<1x1x[1]xf32>, vector<f32>) -> (vector<[8]xf32>, vector<2x[4]xf32>, vector<1x1x[1]xf32>), sym_name = "fma_scalable"}> ({
  ^bb0(%arg0: vector<[8]xf32>, %arg1: vector<2x[4]xf32>, %arg2: vector<1x1x[1]xf32>, %arg3: vector<f32>):
    %0 = "vector.fma"(%arg0, %arg0, %arg0) : (vector<[8]xf32>, vector<[8]xf32>, vector<[8]xf32>) -> vector<[8]xf32>
    %1 = "vector.fma"(%arg1, %arg1, %arg1) : (vector<2x[4]xf32>, vector<2x[4]xf32>, vector<2x[4]xf32>) -> vector<2x[4]xf32>
    %2 = "vector.fma"(%arg2, %arg2, %arg2) : (vector<1x1x[1]xf32>, vector<1x1x[1]xf32>, vector<1x1x[1]xf32>) -> vector<1x1x[1]xf32>
    "func.return"(%0, %1, %2) : (vector<[8]xf32>, vector<2x[4]xf32>, vector<1x1x[1]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<i1>, sym_name = "constant_mask_0d_f"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 0>}> : () -> vector<i1>
    "func.return"(%0) : (vector<i1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<i1>, sym_name = "constant_mask_0d_t"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 1>}> : () -> vector<i1>
    "func.return"(%0) : (vector<i1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<8xi1>, sym_name = "constant_mask_1d"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 4>}> : () -> vector<8xi1>
    "func.return"(%0) : (vector<8xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<[8]xi1>, sym_name = "constant_mask_1d_scalable_all_false"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 0>}> : () -> vector<[8]xi1>
    "func.return"(%0) : (vector<[8]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<[8]xi1>, sym_name = "constant_mask_1d_scalable_all_true"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 8>}> : () -> vector<[8]xi1>
    "func.return"(%0) : (vector<[8]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4x4xi1>, sym_name = "constant_mask_2d"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 2>}> : () -> vector<4x4xi1>
    "func.return"(%0) : (vector<4x4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4x[4]xi1>, sym_name = "constant_mask_2d_trailing_scalable"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 4>}> : () -> vector<4x[4]xi1>
    "func.return"(%0) : (vector<4x[4]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<[4]x4xi1>, sym_name = "negative_constant_mask_2d_leading_scalable"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 4, 2>}> : () -> vector<[4]x4xi1>
    "func.return"(%0) : (vector<[4]x4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<i1>, sym_name = "create_mask_0d"}> ({
  ^bb0(%arg0: index):
    %0 = "vector.create_mask"(%arg0) : (index) -> vector<i1>
    "func.return"(%0) : (vector<i1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<4xi1>, sym_name = "create_mask_1d"}> ({
  ^bb0(%arg0: index):
    %0 = "vector.create_mask"(%arg0) : (index) -> vector<4xi1>
    "func.return"(%0) : (vector<4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<[4]xi1>, sym_name = "create_mask_1d_scalable"}> ({
  ^bb0(%arg0: index):
    %0 = "vector.create_mask"(%arg0) : (index) -> vector<[4]xi1>
    "func.return"(%0) : (vector<[4]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<2x3xi32>, vector<2x3xf32>) -> vector<2x3xf32>, sym_name = "gather_with_mask"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<2x3xi32>, %arg2: vector<2x3xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 2>}> : () -> vector<2x3xi1>
    %2 = "vector.gather"(%arg0, %0, %arg1, %1, %arg2) : (memref<?xf32>, index, vector<2x3xi32>, vector<2x3xi1>, vector<2x3xf32>) -> vector<2x3xf32>
    "func.return"(%2) : (vector<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<2x[3]xi32>, vector<2x[3]xf32>) -> vector<2x[3]xf32>, sym_name = "gather_with_mask_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<2x[3]xi32>, %arg2: vector<2x[3]xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 3>}> : () -> vector<2x[3]xi1>
    %2 = "vector.gather"(%arg0, %0, %arg1, %1, %arg2) : (memref<?xf32>, index, vector<2x[3]xi32>, vector<2x[3]xi1>, vector<2x[3]xf32>) -> vector<2x[3]xf32>
    "func.return"(%2) : (vector<2x[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<2x3xi32>, vector<2x3xf32>) -> vector<2x3xf32>, sym_name = "gather_with_zero_mask"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<2x3xi32>, %arg2: vector<2x3xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 0, 0>}> : () -> vector<2x3xi1>
    %2 = "vector.gather"(%arg0, %0, %arg1, %1, %arg2) : (memref<?xf32>, index, vector<2x3xi32>, vector<2x3xi1>, vector<2x3xf32>) -> vector<2x3xf32>
    "func.return"(%2) : (vector<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<2x[3]xi32>, vector<2x[3]xf32>) -> vector<2x[3]xf32>, sym_name = "gather_with_zero_mask_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<2x[3]xi32>, %arg2: vector<2x[3]xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 0, 0>}> : () -> vector<2x[3]xi1>
    %2 = "vector.gather"(%arg0, %0, %arg1, %1, %arg2) : (memref<?xf32>, index, vector<2x[3]xi32>, vector<2x[3]xi1>, vector<2x[3]xf32>) -> vector<2x[3]xf32>
    "func.return"(%2) : (vector<2x[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<2x3xi32>, vector<2x3xf32>) -> (), sym_name = "scatter_with_mask"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<2x3xi32>, %arg2: vector<2x3xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 2>}> : () -> vector<2x3xi1>
    "vector.scatter"(%arg0, %0, %arg1, %1, %arg2) : (memref<?xf32>, index, vector<2x3xi32>, vector<2x3xi1>, vector<2x3xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<2x[3]xi32>, vector<2x[3]xf32>) -> (), sym_name = "scatter_with_mask_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<2x[3]xi32>, %arg2: vector<2x[3]xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 3>}> : () -> vector<2x[3]xi1>
    "vector.scatter"(%arg0, %0, %arg1, %1, %arg2) : (memref<?xf32>, index, vector<2x[3]xi32>, vector<2x[3]xi1>, vector<2x[3]xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x3xi8>, vector<2x3xi8>) -> vector<2x6xi8>, sym_name = "interleave_2d"}> ({
  ^bb0(%arg0: vector<2x3xi8>, %arg1: vector<2x3xi8>):
    %0 = "vector.interleave"(%arg0, %arg1) : (vector<2x3xi8>, vector<2x3xi8>) -> vector<2x6xi8>
    "func.return"(%0) : (vector<2x6xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x[8]xi16>, vector<2x[8]xi16>) -> vector<2x[16]xi16>, sym_name = "interleave_2d_scalable"}> ({
  ^bb0(%arg0: vector<2x[8]xi16>, %arg1: vector<2x[8]xi16>):
    %0 = "vector.interleave"(%arg0, %arg1) : (vector<2x[8]xi16>, vector<2x[8]xi16>) -> vector<2x[16]xi16>
    "func.return"(%0) : (vector<2x[16]xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x8xf32>) -> (vector<2x4xf32>, vector<2x4xf32>), sym_name = "deinterleave_2d"}> ({
  ^bb0(%arg0: vector<2x8xf32>):
    %0:2 = "vector.deinterleave"(%arg0) : (vector<2x8xf32>) -> (vector<2x4xf32>, vector<2x4xf32>)
    "func.return"(%0#0, %0#1) : (vector<2x4xf32>, vector<2x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x[8]xf32>) -> (vector<2x[4]xf32>, vector<2x[4]xf32>), sym_name = "deinterleave_2d_scalable"}> ({
  ^bb0(%arg0: vector<2x[8]xf32>):
    %0:2 = "vector.deinterleave"(%arg0) : (vector<2x[8]xf32>) -> (vector<2x[4]xf32>, vector<2x[4]xf32>)
    "func.return"(%0#0, %0#1) : (vector<2x[4]xf32>, vector<2x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xindex>, sym_name = "step"}> ({
    %0 = "vector.step"() : () -> vector<4xindex>
    "func.return"(%0) : (vector<4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, f32, f32) -> vector<2x1x2xf32>, sym_name = "from_elements_3d"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32):
    %0 = "vector.from_elements"(%arg0, %arg1, %arg2, %arg3) : (f32, f32, f32, f32) -> vector<2x1x2xf32>
    "func.return"(%0) : (vector<2x1x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> (f32, f32), sym_name = "to_elements_1d"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0:2 = "vector.to_elements"(%arg0) : (vector<2xf32>) -> (f32, f32)
    "func.return"(%0#0, %0#1) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>) -> (f32, f32, f32, f32), sym_name = "to_elements_2d"}> ({
  ^bb0(%arg0: vector<2x2xf32>):
    %0:4 = "vector.to_elements"(%arg0) : (vector<2x2xf32>) -> (f32, f32, f32, f32)
    "func.return"(%0#0, %0#1, %0#2, %0#3) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()


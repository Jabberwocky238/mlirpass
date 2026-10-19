#map = affine_map<() -> ()>
module {
  func.func @test_abs_scalar(%arg0: tensor<f32>) -> tensor<f32> {
    %0 = tensor.empty() : tensor<f32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%arg0 : tensor<f32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = math.absf %in : f32
      linalg.yield %2 : f32
    } -> tensor<f32>
    return %1 : tensor<f32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_abs_1d_cast_static_to_dynamic(%arg0: tensor<5xf32>) -> tensor<?xf32> {
    %0 = tensor.empty() : tensor<5xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<5xf32>) outs(%0 : tensor<5xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = math.absf %in : f32
      linalg.yield %2 : f32
    } -> tensor<5xf32>
    %cast = tensor.cast %1 : tensor<5xf32> to tensor<?xf32>
    return %cast : tensor<?xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_abs_1d_cast_dynamic_to_static(%arg0: tensor<?xf32>) -> tensor<5xf32> {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xf32>
    %0 = tensor.empty(%dim) : tensor<?xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<?xf32>) outs(%0 : tensor<?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = math.absf %in : f32
      linalg.yield %2 : f32
    } -> tensor<?xf32>
    %cast = tensor.cast %1 : tensor<?xf32> to tensor<5xf32>
    return %cast : tensor<5xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_abs_1d_dynamic(%arg0: tensor<?xf32>) -> tensor<?xf32> {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xf32>
    %0 = tensor.empty(%dim) : tensor<?xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<?xf32>) outs(%0 : tensor<?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = math.absf %in : f32
      linalg.yield %2 : f32
    } -> tensor<?xf32>
    return %1 : tensor<?xf32>
  }
}

// -----
#map = affine_map<() -> ()>
module {
  func.func @test_add_0d(%arg0: tensor<f32>, %arg1: tensor<f32>) -> tensor<f32> {
    %0 = tensor.empty() : tensor<f32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = []} ins(%arg0, %arg1 : tensor<f32>, tensor<f32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.addf %in, %in_0 : f32
      linalg.yield %2 : f32
    } -> tensor<f32>
    return %1 : tensor<f32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (0, d1)>
module {
  func.func @test_add_2d_broadcast(%arg0: tensor<2x1xf32>, %arg1: tensor<1x1xf32>) -> tensor<2x1xf32> {
    %0 = tensor.empty() : tensor<2x1xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<2x1xf32>, tensor<1x1xf32>) outs(%0 : tensor<2x1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.addf %in, %in_0 : f32
      linalg.yield %2 : f32
    } -> tensor<2x1xf32>
    return %1 : tensor<2x1xf32>
  }
}

// -----
#map = affine_map<(d0) -> (0)>
#map1 = affine_map<(d0) -> (d0)>
module {
  func.func @test_add_1d_all_dynamic(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>) -> tensor<?xf32> {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xf32>
    %dim_0 = tensor.dim %arg1, %c0 : tensor<?xf32>
    %0 = arith.maxui %dim, %dim_0 : index
    %c1 = arith.constant 1 : index
    %dim_1 = tensor.dim %arg0, %c0 : tensor<?xf32>
    %1 = arith.cmpi eq, %dim_1, %c1 : index
    %2 = scf.if %1 -> (tensor<?xf32>) {
      %7 = tensor.empty(%0) : tensor<?xf32>
      %8 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel"]} ins(%arg0 : tensor<?xf32>) outs(%7 : tensor<?xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?xf32>
      scf.yield %8 : tensor<?xf32>
    } else {
      scf.yield %arg0 : tensor<?xf32>
    }
    %dim_2 = tensor.dim %arg1, %c0 : tensor<?xf32>
    %3 = arith.cmpi eq, %dim_2, %c1 : index
    %4 = scf.if %3 -> (tensor<?xf32>) {
      %7 = tensor.empty(%0) : tensor<?xf32>
      %8 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel"]} ins(%arg1 : tensor<?xf32>) outs(%7 : tensor<?xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?xf32>
      scf.yield %8 : tensor<?xf32>
    } else {
      scf.yield %arg1 : tensor<?xf32>
    }
    %5 = tensor.empty(%0) : tensor<?xf32>
    %6 = linalg.generic {indexing_maps = [#map1, #map1, #map1], iterator_types = ["parallel"]} ins(%2, %4 : tensor<?xf32>, tensor<?xf32>) outs(%5 : tensor<?xf32>) {
    ^bb0(%in: f32, %in_3: f32, %out: f32):
      %7 = arith.addf %in, %in_3 : f32
      linalg.yield %7 : f32
    } -> tensor<?xf32>
    return %6 : tensor<?xf32>
  }
}

// -----
#map = affine_map<(d0) -> (0)>
#map1 = affine_map<(d0) -> (d0)>
module {
  func.func @test_add_1d_broadcast_dynamic_to_static(%arg0: tensor<5xf32>, %arg1: tensor<?xf32>) -> tensor<5xf32> {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg1, %c0 : tensor<?xf32>
    %0 = arith.cmpi eq, %dim, %c1 : index
    %1 = scf.if %0 -> (tensor<?xf32>) {
      %4 = tensor.empty() : tensor<5xf32>
      %5 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel"]} ins(%arg1 : tensor<?xf32>) outs(%4 : tensor<5xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<5xf32>
      %cast = tensor.cast %5 : tensor<5xf32> to tensor<?xf32>
      scf.yield %cast : tensor<?xf32>
    } else {
      scf.yield %arg1 : tensor<?xf32>
    }
    %2 = tensor.empty() : tensor<5xf32>
    %3 = linalg.generic {indexing_maps = [#map1, #map1, #map1], iterator_types = ["parallel"]} ins(%arg0, %1 : tensor<5xf32>, tensor<?xf32>) outs(%2 : tensor<5xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %4 = arith.addf %in, %in_0 : f32
      linalg.yield %4 : f32
    } -> tensor<5xf32>
    return %3 : tensor<5xf32>
  }
}

// -----
#map = affine_map<(d0) -> (0)>
#map1 = affine_map<(d0) -> (d0)>
module {
  func.func @test_add_1d_broadcast_static_to_dynamic(%arg0: tensor<1xf32>, %arg1: tensor<?xf32>) -> tensor<?xf32> {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg1, %c0 : tensor<?xf32>
    %0 = tensor.empty(%dim) : tensor<?xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel"]} ins(%arg0, %arg1 : tensor<1xf32>, tensor<?xf32>) outs(%0 : tensor<?xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.addf %in, %in_0 : f32
      linalg.yield %2 : f32
    } -> tensor<?xf32>
    return %1 : tensor<?xf32>
  }
}

// -----
#map = affine_map<(d0) -> (0)>
#map1 = affine_map<(d0) -> (d0)>
module {
  func.func @test_add_1d_broadcast_static_to_static(%arg0: tensor<1xf32>, %arg1: tensor<3xf32>) -> tensor<3xf32> {
    %0 = tensor.empty() : tensor<3xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel"]} ins(%arg0, %arg1 : tensor<1xf32>, tensor<3xf32>) outs(%0 : tensor<3xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.addf %in, %in_0 : f32
      linalg.yield %2 : f32
    } -> tensor<3xf32>
    return %1 : tensor<3xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_add_1d_matching_no_broadcast(%arg0: tensor<1xf32>, %arg1: tensor<1xf32>) -> tensor<1xf32> {
    %0 = tensor.empty() : tensor<1xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1 : tensor<1xf32>, tensor<1xf32>) outs(%0 : tensor<1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.addf %in, %in_0 : f32
      linalg.yield %2 : f32
    } -> tensor<1xf32>
    return %1 : tensor<1xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_add_1d_matching_static(%arg0: tensor<3xf32>, %arg1: tensor<3xf32>) -> tensor<3xf32> {
    %0 = tensor.empty() : tensor<3xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1 : tensor<3xf32>, tensor<3xf32>) outs(%0 : tensor<3xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.addf %in, %in_0 : f32
      linalg.yield %2 : f32
    } -> tensor<3xf32>
    return %1 : tensor<3xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (0, d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1) -> (d0, 0)>
module {
  func.func @test_add_2d_all_dynamic(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_0 = tensor.dim %arg1, %c0 : tensor<?x?xf32>
    %0 = arith.maxui %dim, %dim_0 : index
    %c1 = arith.constant 1 : index
    %dim_1 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %dim_2 = tensor.dim %arg1, %c1 : tensor<?x?xf32>
    %1 = arith.maxui %dim_1, %dim_2 : index
    %dim_3 = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %2 = arith.cmpi eq, %dim_3, %c1 : index
    %3 = scf.if %2 -> (tensor<?x?xf32>) {
      %c1_7 = arith.constant 1 : index
      %dim_8 = tensor.dim %arg0, %c1_7 : tensor<?x?xf32>
      %12 = tensor.empty(%0, %dim_8) : tensor<?x?xf32>
      %13 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<?x?xf32>) outs(%12 : tensor<?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x?xf32>
      scf.yield %13 : tensor<?x?xf32>
    } else {
      scf.yield %arg0 : tensor<?x?xf32>
    }
    %dim_4 = tensor.dim %3, %c1 : tensor<?x?xf32>
    %4 = arith.cmpi eq, %dim_4, %c1 : index
    %5 = scf.if %4 -> (tensor<?x?xf32>) {
      %c0_7 = arith.constant 0 : index
      %dim_8 = tensor.dim %3, %c0_7 : tensor<?x?xf32>
      %12 = tensor.empty(%dim_8, %1) : tensor<?x?xf32>
      %13 = linalg.generic {indexing_maps = [#map2, #map1], iterator_types = ["parallel", "parallel"]} ins(%3 : tensor<?x?xf32>) outs(%12 : tensor<?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x?xf32>
      scf.yield %13 : tensor<?x?xf32>
    } else {
      scf.yield %3 : tensor<?x?xf32>
    }
    %dim_5 = tensor.dim %arg1, %c0 : tensor<?x?xf32>
    %6 = arith.cmpi eq, %dim_5, %c1 : index
    %7 = scf.if %6 -> (tensor<?x?xf32>) {
      %c1_7 = arith.constant 1 : index
      %dim_8 = tensor.dim %arg1, %c1_7 : tensor<?x?xf32>
      %12 = tensor.empty(%0, %dim_8) : tensor<?x?xf32>
      %13 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg1 : tensor<?x?xf32>) outs(%12 : tensor<?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x?xf32>
      scf.yield %13 : tensor<?x?xf32>
    } else {
      scf.yield %arg1 : tensor<?x?xf32>
    }
    %dim_6 = tensor.dim %7, %c1 : tensor<?x?xf32>
    %8 = arith.cmpi eq, %dim_6, %c1 : index
    %9 = scf.if %8 -> (tensor<?x?xf32>) {
      %c0_7 = arith.constant 0 : index
      %dim_8 = tensor.dim %7, %c0_7 : tensor<?x?xf32>
      %12 = tensor.empty(%dim_8, %1) : tensor<?x?xf32>
      %13 = linalg.generic {indexing_maps = [#map2, #map1], iterator_types = ["parallel", "parallel"]} ins(%7 : tensor<?x?xf32>) outs(%12 : tensor<?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x?xf32>
      scf.yield %13 : tensor<?x?xf32>
    } else {
      scf.yield %7 : tensor<?x?xf32>
    }
    %10 = tensor.empty(%0, %1) : tensor<?x?xf32>
    %11 = linalg.generic {indexing_maps = [#map1, #map1, #map1], iterator_types = ["parallel", "parallel"]} ins(%5, %9 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%10 : tensor<?x?xf32>) {
    ^bb0(%in: f32, %in_7: f32, %out: f32):
      %12 = arith.addf %in, %in_7 : f32
      linalg.yield %12 : f32
    } -> tensor<?x?xf32>
    return %11 : tensor<?x?xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, 0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @test_select_2d_one_dynamic(%arg0: tensor<2x?xi1>, %arg1: tensor<2x?xf32>, %arg2: tensor<2x?xf32>) -> tensor<2x?xf32> {
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<2x?xi1>
    %dim_0 = tensor.dim %arg1, %c1 : tensor<2x?xf32>
    %0 = arith.maxui %dim, %dim_0 : index
    %dim_1 = tensor.dim %arg2, %c1 : tensor<2x?xf32>
    %1 = arith.maxui %0, %dim_1 : index
    %dim_2 = tensor.dim %arg0, %c1 : tensor<2x?xi1>
    %2 = arith.cmpi eq, %dim_2, %c1 : index
    %3 = scf.if %2 -> (tensor<2x?xi1>) {
      %10 = tensor.empty(%1) : tensor<2x?xi1>
      %11 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<2x?xi1>) outs(%10 : tensor<2x?xi1>) {
      ^bb0(%in: i1, %out: i1):
        linalg.yield %in : i1
      } -> tensor<2x?xi1>
      scf.yield %11 : tensor<2x?xi1>
    } else {
      scf.yield %arg0 : tensor<2x?xi1>
    }
    %dim_3 = tensor.dim %arg1, %c1 : tensor<2x?xf32>
    %4 = arith.cmpi eq, %dim_3, %c1 : index
    %5 = scf.if %4 -> (tensor<2x?xf32>) {
      %10 = tensor.empty(%1) : tensor<2x?xf32>
      %11 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg1 : tensor<2x?xf32>) outs(%10 : tensor<2x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<2x?xf32>
      scf.yield %11 : tensor<2x?xf32>
    } else {
      scf.yield %arg1 : tensor<2x?xf32>
    }
    %dim_4 = tensor.dim %arg2, %c1 : tensor<2x?xf32>
    %6 = arith.cmpi eq, %dim_4, %c1 : index
    %7 = scf.if %6 -> (tensor<2x?xf32>) {
      %10 = tensor.empty(%1) : tensor<2x?xf32>
      %11 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg2 : tensor<2x?xf32>) outs(%10 : tensor<2x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<2x?xf32>
      scf.yield %11 : tensor<2x?xf32>
    } else {
      scf.yield %arg2 : tensor<2x?xf32>
    }
    %8 = tensor.empty(%1) : tensor<2x?xf32>
    %9 = linalg.generic {indexing_maps = [#map1, #map1, #map1, #map1], iterator_types = ["parallel", "parallel"]} ins(%3, %5, %7 : tensor<2x?xi1>, tensor<2x?xf32>, tensor<2x?xf32>) outs(%8 : tensor<2x?xf32>) {
    ^bb0(%in: i1, %in_5: f32, %in_6: f32, %out: f32):
      %10 = arith.select %in, %in_5, %in_6 : f32
      linalg.yield %10 : f32
    } -> tensor<2x?xf32>
    return %9 : tensor<2x?xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_simple_f32(%arg0: tensor<1xf32>) {
    %0 = tensor.empty() : tensor<1xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xf32>) outs(%0 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %57 = math.tanh %in : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %2 = tensor.empty() : tensor<1xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xf32>) outs(%2 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %57 = math.absf %in : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %4 = tensor.empty() : tensor<1xf32>
    %5 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%1, %1 : tensor<1xf32>, tensor<1xf32>) outs(%4 : tensor<1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %57 = arith.addf %in, %in_0 : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %6 = tensor.empty() : tensor<1xf32>
    %7 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%1, %3 : tensor<1xf32>, tensor<1xf32>) outs(%6 : tensor<1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %57 = arith.subf %in, %in_0 : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %8 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %9 = tensor.empty() : tensor<1xf32>
    %10 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%1, %3 : tensor<1xf32>, tensor<1xf32>) outs(%9 : tensor<1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %57 = arith.mulf %in, %in_0 : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %11 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %12 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %13 = tensor.empty() : tensor<1xf32>
    %14 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%1 : tensor<1xf32>) outs(%13 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %57 = arith.negf %in : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %15 = tensor.empty() : tensor<1xf32>
    %16 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%3, %5 : tensor<1xf32>, tensor<1xf32>) outs(%15 : tensor<1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %57 = math.powf %in, %in_0 : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %17 = tensor.empty() : tensor<1xf32>
    %18 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%3 : tensor<1xf32>) outs(%17 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %57 = math.rsqrt %in : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %19 = tensor.empty() : tensor<1xf32>
    %20 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xf32>) outs(%19 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %57 = math.log %in : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %21 = tensor.empty() : tensor<1xf32>
    %22 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xf32>) outs(%21 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %57 = math.exp %in : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %23 = tensor.empty() : tensor<1xi1>
    %24 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%1, %3 : tensor<1xf32>, tensor<1xf32>) outs(%23 : tensor<1xi1>) {
    ^bb0(%in: f32, %in_0: f32, %out: i1):
      %57 = arith.cmpf ogt, %in, %in_0 : f32
      linalg.yield %57 : i1
    } -> tensor<1xi1>
    %25 = tensor.empty() : tensor<1xi1>
    %26 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%1, %3 : tensor<1xf32>, tensor<1xf32>) outs(%25 : tensor<1xi1>) {
    ^bb0(%in: f32, %in_0: f32, %out: i1):
      %57 = arith.cmpf oge, %in, %in_0 : f32
      linalg.yield %57 : i1
    } -> tensor<1xi1>
    %27 = tensor.empty() : tensor<1xi1>
    %28 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%1, %3 : tensor<1xf32>, tensor<1xf32>) outs(%27 : tensor<1xi1>) {
    ^bb0(%in: f32, %in_0: f32, %out: i1):
      %57 = arith.cmpf oeq, %in, %in_0 : f32
      linalg.yield %57 : i1
    } -> tensor<1xi1>
    %29 = tensor.empty() : tensor<1xf32>
    %30 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel"]} ins(%24, %1, %3 : tensor<1xi1>, tensor<1xf32>, tensor<1xf32>) outs(%29 : tensor<1xf32>) {
    ^bb0(%in: i1, %in_0: f32, %in_1: f32, %out: f32):
      %57 = arith.select %in, %in_0, %in_1 : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %31 = tensor.empty() : tensor<1xf32>
    %32 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%1, %3 : tensor<1xf32>, tensor<1xf32>) outs(%31 : tensor<1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %57 = arith.maximumf %in, %in_0 : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %33 = tensor.empty() : tensor<1xf32>
    %34 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%1, %3 : tensor<1xf32>, tensor<1xf32>) outs(%33 : tensor<1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %57 = arith.minimumf %in, %in_0 : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %35 = tensor.empty() : tensor<1xf32>
    %36 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%1 : tensor<1xf32>) outs(%35 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %57 = math.ceil %in : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %37 = tensor.empty() : tensor<1xf32>
    %38 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%1 : tensor<1xf32>) outs(%37 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %57 = math.floor %in : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %39 = tensor.empty() : tensor<1xf32>
    %40 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%1 : tensor<1xf32>) outs(%39 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %cst = arith.constant 1.000000e+00 : f32
      %cst_0 = arith.constant 5.000000e+00 : f32
      %57 = arith.minimumf %in, %cst_0 : f32
      %58 = arith.maximumf %57, %cst : f32
      linalg.yield %58 : f32
    } -> tensor<1xf32>
    %41 = tensor.empty() : tensor<1xf32>
    %42 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%1 : tensor<1xf32>) outs(%41 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %cst = arith.constant 1.000000e+00 : f32
      %57 = arith.negf %in : f32
      %58 = math.exp %57 : f32
      %59 = arith.addf %58, %cst : f32
      %60 = arith.divf %cst, %59 : f32
      linalg.yield %60 : f32
    } -> tensor<1xf32>
    %43 = tensor.empty() : tensor<1xi32>
    %44 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%1 : tensor<1xf32>) outs(%43 : tensor<1xi32>) {
    ^bb0(%in: f32, %out: i32):
      %57 = math.roundeven %in : f32
      %cst = arith.constant -2.14748365E+9 : f32
      %cst_0 = arith.constant 2.14748365E+9 : f32
      %c2147483647_i32 = arith.constant 2147483647 : i32
      %58 = arith.maximumf %57, %cst : f32
      %59 = arith.fptosi %58 : f32 to i32
      %60 = arith.cmpf uge, %57, %cst_0 : f32
      %61 = arith.select %60, %c2147483647_i32, %59 : i32
      linalg.yield %61 : i32
    } -> tensor<1xi32>
    %45 = tensor.empty() : tensor<1xi1>
    %46 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%1 : tensor<1xf32>) outs(%45 : tensor<1xi1>) {
    ^bb0(%in: f32, %out: i1):
      %cst = arith.constant 0.000000e+00 : f32
      %57 = arith.cmpf une, %in, %cst : f32
      linalg.yield %57 : i1
    } -> tensor<1xi1>
    %47 = tensor.empty() : tensor<1xf16>
    %48 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%1 : tensor<1xf32>) outs(%47 : tensor<1xf16>) {
    ^bb0(%in: f32, %out: f16):
      %57 = arith.truncf %in : f32 to f16
      linalg.yield %57 : f16
    } -> tensor<1xf16>
    %49 = tensor.empty() : tensor<1xf32>
    %50 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%1 : tensor<1xf32>) outs(%49 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %cst = arith.constant 1.000000e+00 : f32
      %57 = arith.divf %cst, %in : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %51 = tensor.empty() : tensor<1xf32>
    %52 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%1 : tensor<1xf32>) outs(%51 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %57 = math.erf %in : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %53 = tensor.empty() : tensor<1xf32>
    %54 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xf32>) outs(%53 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %57 = math.sin %in : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %55 = tensor.empty() : tensor<1xf32>
    %56 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xf32>) outs(%55 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %57 = math.cos %in : f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_simple_f16(%arg0: tensor<1xf16>) {
    %0 = tensor.empty() : tensor<1xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xf16>) outs(%0 : tensor<1xf32>) {
    ^bb0(%in: f16, %out: f32):
      %6 = arith.extf %in : f16 to f32
      linalg.yield %6 : f32
    } -> tensor<1xf32>
    %2 = tensor.empty() : tensor<1xi8>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xf16>) outs(%2 : tensor<1xi8>) {
    ^bb0(%in: f16, %out: i8):
      %6 = math.roundeven %in : f16
      %cst = arith.constant -1.280000e+02 : f16
      %cst_0 = arith.constant 1.270000e+02 : f16
      %7 = arith.minimumf %6, %cst_0 : f16
      %8 = arith.maximumf %7, %cst : f16
      %9 = arith.fptosi %8 : f16 to i8
      linalg.yield %9 : i8
    } -> tensor<1xi8>
    %4 = tensor.empty() : tensor<1xi32>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xf16>) outs(%4 : tensor<1xi32>) {
    ^bb0(%in: f16, %out: i32):
      %6 = math.roundeven %in : f16
      %7 = arith.fptosi %6 : f16 to i32
      %cst = arith.constant 0x7C00 : f16
      %cst_0 = arith.constant 0xFC00 : f16
      %8 = arith.cmpf ueq, %6, %cst : f16
      %9 = arith.cmpf ueq, %6, %cst_0 : f16
      %c-2147483648_i32 = arith.constant -2147483648 : i32
      %c2147483647_i32 = arith.constant 2147483647 : i32
      %10 = arith.select %8, %c2147483647_i32, %7 : i32
      %11 = arith.select %9, %c-2147483648_i32, %10 : i32
      linalg.yield %11 : i32
    } -> tensor<1xi32>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_simple_i16(%arg0: tensor<1xi16>) {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = tensor.empty() : tensor<1xi32>
    %2 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<1xi16>, tensor<1xi16>) outs(%1 : tensor<1xi32>) {
    ^bb0(%in: i16, %in_0: i16, %out: i32):
      %3 = arith.extsi %in : i16 to i32
      %4 = arith.extsi %in_0 : i16 to i32
      %5 = arith.muli %3, %4 : i32
      linalg.yield %5 : i32
    } -> tensor<1xi32>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_simple_ui8(%arg0: tensor<1xui8>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : tensor<1xui8> to tensor<1xi8>
    %1 = tensor.empty() : tensor<1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%0 : tensor<1xi8>) outs(%1 : tensor<1xf32>) {
    ^bb0(%in: i8, %out: f32):
      %3 = builtin.unrealized_conversion_cast %in : i8 to i8
      %4 = arith.uitofp %3 : i8 to f32
      linalg.yield %4 : f32
    } -> tensor<1xf32>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_simple_i32(%arg0: tensor<1xi32>, %arg1: tensor<1xui32>, %arg2: tensor<1xui64>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : tensor<1xui32> to tensor<1xi32>
    %1 = tensor.empty() : tensor<1xi32>
    %2 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<1xi32>, tensor<1xi32>) outs(%1 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %57 = arith.addi %in, %in_0 : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %3 = tensor.empty() : tensor<1xi32>
    %4 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<1xi32>, tensor<1xi32>) outs(%3 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %57 = arith.subi %in, %in_0 : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %6 = tensor.empty() : tensor<1xi32>
    %7 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<1xi32>, tensor<1xi32>) outs(%6 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %57 = arith.muli %in, %in_0 : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %8 = "tosa.const"() <{values = dense<2> : tensor<1xi8>}> : () -> tensor<1xi8>
    %9 = tensor.empty() : tensor<1xi32>
    %10 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<1xi32>, tensor<1xi32>) outs(%9 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %c2_i8 = arith.constant 2 : i8
      %57 = tosa.apply_scale %in, %in_0, %c2_i8 {rounding_mode = SINGLE_ROUND} : (i32, i32, i8) -> i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %11 = tensor.empty() : tensor<1xi32>
    %12 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<1xi32>, tensor<1xi32>) outs(%11 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %57 = arith.divsi %in, %in_0 : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %13 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %14 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %15 = tensor.empty() : tensor<1xi32>
    %16 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xi32>) outs(%15 : tensor<1xi32>) {
    ^bb0(%in: i32, %out: i32):
      %c0_i64 = arith.constant 0 : i64
      %57 = arith.extsi %in : i32 to i64
      %58 = arith.subi %c0_i64, %57 : i64
      %c-2147483648_i64 = arith.constant -2147483648 : i64
      %c2147483647_i64 = arith.constant 2147483647 : i64
      %59 = arith.maxsi %c-2147483648_i64, %58 : i64
      %60 = arith.minsi %c2147483647_i64, %59 : i64
      %61 = arith.trunci %60 : i64 to i32
      linalg.yield %61 : i32
    } -> tensor<1xi32>
    %17 = tensor.empty() : tensor<1xi32>
    %18 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<1xi32>, tensor<1xi32>) outs(%17 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %57 = arith.andi %in, %in_0 : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %19 = tensor.empty() : tensor<1xi32>
    %20 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<1xi32>, tensor<1xi32>) outs(%19 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %57 = arith.ori %in, %in_0 : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %21 = tensor.empty() : tensor<1xi32>
    %22 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<1xi32>, tensor<1xi32>) outs(%21 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %57 = arith.xori %in, %in_0 : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %23 = tensor.empty() : tensor<1xi32>
    %24 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<1xi32>, tensor<1xi32>) outs(%23 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %57 = arith.shli %in, %in_0 : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %25 = tensor.empty() : tensor<1xi32>
    %26 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<1xi32>, tensor<1xi32>) outs(%25 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %57 = arith.shrui %in, %in_0 : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %27 = tensor.empty() : tensor<1xi32>
    %28 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<1xi32>, tensor<1xi32>) outs(%27 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %57 = arith.shrsi %in, %in_0 : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %29 = tensor.empty() : tensor<1xi32>
    %30 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<1xi32>, tensor<1xi32>) outs(%29 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %57 = arith.shrsi %in, %in_0 : i32
      %c1_i32 = arith.constant 1 : i32
      %c0_i32 = arith.constant 0 : i32
      %false = arith.constant false
      %true = arith.constant true
      %58 = arith.cmpi sgt, %in_0, %c0_i32 : i32
      %59 = arith.subi %in_0, %c1_i32 : i32
      %60 = arith.shrsi %in, %59 : i32
      %61 = arith.trunci %60 : i32 to i1
      %62 = arith.andi %61, %true : i1
      %63 = arith.select %58, %62, %false : i1
      %64 = arith.extui %63 : i1 to i32
      %65 = arith.addi %57, %64 : i32
      linalg.yield %65 : i32
    } -> tensor<1xi32>
    %31 = tensor.empty() : tensor<1xi32>
    %32 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xi32>) outs(%31 : tensor<1xi32>) {
    ^bb0(%in: i32, %out: i32):
      %57 = math.ctlz %in : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %33 = tensor.empty() : tensor<1xi1>
    %34 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%2, %4 : tensor<1xi32>, tensor<1xi32>) outs(%33 : tensor<1xi1>) {
    ^bb0(%in: i32, %in_0: i32, %out: i1):
      %57 = arith.cmpi sgt, %in, %in_0 : i32
      linalg.yield %57 : i1
    } -> tensor<1xi1>
    %35 = tensor.empty() : tensor<1xi1>
    %36 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%2, %4 : tensor<1xi32>, tensor<1xi32>) outs(%35 : tensor<1xi1>) {
    ^bb0(%in: i32, %in_0: i32, %out: i1):
      %57 = arith.cmpi sge, %in, %in_0 : i32
      linalg.yield %57 : i1
    } -> tensor<1xi1>
    %37 = tensor.empty() : tensor<1xi32>
    %38 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel"]} ins(%34, %2, %4 : tensor<1xi1>, tensor<1xi32>, tensor<1xi32>) outs(%37 : tensor<1xi32>) {
    ^bb0(%in: i1, %in_0: i32, %in_1: i32, %out: i32):
      %57 = arith.select %in, %in_0, %in_1 : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %39 = tensor.empty() : tensor<1xi32>
    %40 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%2, %4 : tensor<1xi32>, tensor<1xi32>) outs(%39 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %57 = arith.maxsi %in, %in_0 : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %41 = tensor.empty() : tensor<1xi32>
    %42 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%2, %4 : tensor<1xi32>, tensor<1xi32>) outs(%41 : tensor<1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %57 = arith.minsi %in, %in_0 : i32
      linalg.yield %57 : i32
    } -> tensor<1xi32>
    %43 = tensor.empty() : tensor<1xi32>
    %44 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%2 : tensor<1xi32>) outs(%43 : tensor<1xi32>) {
    ^bb0(%in: i32, %out: i32):
      %c1_i32 = arith.constant 1 : i32
      %c5_i32 = arith.constant 5 : i32
      %57 = arith.maxsi %c1_i32, %in : i32
      %58 = arith.minsi %c5_i32, %57 : i32
      linalg.yield %58 : i32
    } -> tensor<1xi32>
    %45 = tensor.empty() : tensor<1xi32>
    %46 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%0 : tensor<1xi32>) outs(%45 : tensor<1xi32>) {
    ^bb0(%in: i32, %out: i32):
      %c4_i32 = arith.constant 4 : i32
      %c32_i32 = arith.constant 32 : i32
      %57 = arith.maxui %c4_i32, %in : i32
      %58 = arith.minui %c32_i32, %57 : i32
      linalg.yield %58 : i32
    } -> tensor<1xi32>
    %47 = tensor.empty() : tensor<1xi16>
    %48 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%2 : tensor<1xi32>) outs(%47 : tensor<1xi16>) {
    ^bb0(%in: i32, %out: i16):
      %57 = arith.trunci %in : i32 to i16
      linalg.yield %57 : i16
    } -> tensor<1xi16>
    %49 = tensor.empty() : tensor<1xi64>
    %50 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%2 : tensor<1xi32>) outs(%49 : tensor<1xi64>) {
    ^bb0(%in: i32, %out: i64):
      %57 = arith.extsi %in : i32 to i64
      linalg.yield %57 : i64
    } -> tensor<1xi64>
    %51 = tensor.empty() : tensor<1xi1>
    %52 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%2 : tensor<1xi32>) outs(%51 : tensor<1xi1>) {
    ^bb0(%in: i32, %out: i1):
      %c0_i32 = arith.constant 0 : i32
      %57 = arith.cmpi ne, %in, %c0_i32 : i32
      linalg.yield %57 : i1
    } -> tensor<1xi1>
    %53 = tensor.empty() : tensor<1xf32>
    %54 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%2 : tensor<1xi32>) outs(%53 : tensor<1xf32>) {
    ^bb0(%in: i32, %out: f32):
      %57 = arith.sitofp %in : i32 to f32
      linalg.yield %57 : f32
    } -> tensor<1xf32>
    %55 = tensor.empty() : tensor<1xi32>
    %56 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xi32>) outs(%55 : tensor<1xi32>) {
    ^bb0(%in: i32, %out: i32):
      %c0_i32 = arith.constant 0 : i32
      %57 = arith.subi %c0_i32, %in : i32
      %58 = arith.maxsi %in, %57 : i32
      linalg.yield %58 : i32
    } -> tensor<1xi32>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_simple_ui8(%arg0: tensor<1xi8>) {
    %0 = tensor.empty() : tensor<1xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xi8>) outs(%0 : tensor<1xf32>) {
    ^bb0(%in: i8, %out: f32):
      %2 = arith.sitofp %in : i8 to f32
      linalg.yield %2 : f32
    } -> tensor<1xf32>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_i8(%arg0: tensor<1xi8>) {
    %0 = tensor.empty() : tensor<1xi8>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xi8>) outs(%0 : tensor<1xi8>) {
    ^bb0(%in: i8, %out: i8):
      %c-127_i8 = arith.constant -127 : i8
      %c126_i8 = arith.constant 126 : i8
      %2 = arith.maxsi %c-127_i8, %in : i8
      %3 = arith.minsi %c126_i8, %2 : i8
      linalg.yield %3 : i8
    } -> tensor<1xi8>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_i64(%arg0: tensor<1xi64>) {
    %0 = tensor.empty() : tensor<1xi64>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xi64>) outs(%0 : tensor<1xi64>) {
    ^bb0(%in: i64, %out: i64):
      %c-9223372036854775808_i64 = arith.constant -9223372036854775808 : i64
      %c9223372036854775807_i64 = arith.constant 9223372036854775807 : i64
      %2 = arith.maxsi %c-9223372036854775808_i64, %in : i64
      %3 = arith.minsi %c9223372036854775807_i64, %2 : i64
      linalg.yield %3 : i64
    } -> tensor<1xi64>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_clamp_f16(%arg0: tensor<1xf16>) {
    %0 = tensor.empty() : tensor<1xf16>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xf16>) outs(%0 : tensor<1xf16>) {
    ^bb0(%in: f16, %out: f16):
      %cst = arith.constant 0.000000e+00 : f16
      %cst_0 = arith.constant 6.000000e+00 : f16
      %2 = arith.minimumf %in, %cst_0 : f16
      %3 = arith.maximumf %2, %cst : f16
      linalg.yield %3 : f16
    } -> tensor<1xf16>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_bool(%arg0: tensor<1xi1>, %arg1: tensor<1xi1>) {
    %0 = tensor.empty() : tensor<1xi1>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1 : tensor<1xi1>, tensor<1xi1>) outs(%0 : tensor<1xi1>) {
    ^bb0(%in: i1, %in_0: i1, %out: i1):
      %8 = arith.andi %in, %in_0 : i1
      linalg.yield %8 : i1
    } -> tensor<1xi1>
    %2 = tensor.empty() : tensor<1xi1>
    %3 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1 : tensor<1xi1>, tensor<1xi1>) outs(%2 : tensor<1xi1>) {
    ^bb0(%in: i1, %in_0: i1, %out: i1):
      %8 = arith.ori %in, %in_0 : i1
      linalg.yield %8 : i1
    } -> tensor<1xi1>
    %4 = tensor.empty() : tensor<1xi1>
    %5 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1 : tensor<1xi1>, tensor<1xi1>) outs(%4 : tensor<1xi1>) {
    ^bb0(%in: i1, %in_0: i1, %out: i1):
      %8 = arith.xori %in, %in_0 : i1
      linalg.yield %8 : i1
    } -> tensor<1xi1>
    %6 = tensor.empty() : tensor<1xi1>
    %7 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xi1>) outs(%6 : tensor<1xi1>) {
    ^bb0(%in: i1, %out: i1):
      %true = arith.constant true
      %8 = arith.xori %in, %true : i1
      linalg.yield %8 : i1
    } -> tensor<1xi1>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_negate_quantized(%arg0: tensor<1xi8>) {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<7> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tensor.empty() : tensor<1xi8>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xi8>) outs(%2 : tensor<1xi8>) {
    ^bb0(%in: i8, %out: i8):
      %c7_i16 = arith.constant 7 : i16
      %12 = arith.extsi %in : i8 to i16
      %13 = arith.subi %c7_i16, %12 : i16
      %c-128_i16 = arith.constant -128 : i16
      %c127_i16 = arith.constant 127 : i16
      %14 = arith.maxsi %c-128_i16, %13 : i16
      %15 = arith.minsi %c127_i16, %14 : i16
      %16 = arith.trunci %15 : i16 to i8
      linalg.yield %16 : i8
    } -> tensor<1xi8>
    %4 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %6 = tensor.empty() : tensor<1xi8>
    %7 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xi8>) outs(%6 : tensor<1xi8>) {
    ^bb0(%in: i8, %out: i8):
      %c-128_i16 = arith.constant -128 : i16
      %12 = arith.extsi %in : i8 to i16
      %13 = arith.subi %c-128_i16, %12 : i16
      %c-128_i16_0 = arith.constant -128 : i16
      %c127_i16 = arith.constant 127 : i16
      %14 = arith.maxsi %c-128_i16_0, %13 : i16
      %15 = arith.minsi %c127_i16, %14 : i16
      %16 = arith.trunci %15 : i16 to i8
      linalg.yield %16 : i8
    } -> tensor<1xi8>
    %8 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %9 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %10 = tensor.empty() : tensor<1xi8>
    %11 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xi8>) outs(%10 : tensor<1xi8>) {
    ^bb0(%in: i8, %out: i8):
      %c0_i16 = arith.constant 0 : i16
      %12 = arith.extsi %in : i8 to i16
      %13 = arith.subi %c0_i16, %12 : i16
      %c-128_i16 = arith.constant -128 : i16
      %c127_i16 = arith.constant 127 : i16
      %14 = arith.maxsi %c-128_i16, %13 : i16
      %15 = arith.minsi %c127_i16, %14 : i16
      %16 = arith.trunci %15 : i16 to i8
      linalg.yield %16 : i8
    } -> tensor<1xi8>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (0)>
module {
  func.func @test_negate_no_const_1(%arg0: tensor<50x42xf16>, %arg1: tensor<1xf16>, %arg2: tensor<1xf16>) -> tensor<*xf16> {
    %0 = tensor.empty() : tensor<50x42xf16>
    %1 = linalg.generic {indexing_maps = [#map, #map1, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1, %arg2 : tensor<50x42xf16>, tensor<1xf16>, tensor<1xf16>) outs(%0 : tensor<50x42xf16>) {
    ^bb0(%in: f16, %in_0: f16, %in_1: f16, %out: f16):
      %2 = arith.negf %in : f16
      linalg.yield %2 : f16
    } -> tensor<50x42xf16>
    %cast = tensor.cast %1 : tensor<50x42xf16> to tensor<*xf16>
    return %cast : tensor<*xf16>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (0)>
module {
  func.func @test_negate_no_const_2(%arg0: tensor<50x42xi16>, %arg1: tensor<1xi16>, %arg2: tensor<1xi16>) -> tensor<*xi16> {
    %0 = tensor.empty() : tensor<50x42xi16>
    %1 = linalg.generic {indexing_maps = [#map, #map1, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1, %arg2 : tensor<50x42xi16>, tensor<1xi16>, tensor<1xi16>) outs(%0 : tensor<50x42xi16>) {
    ^bb0(%in: i16, %in_0: i16, %in_1: i16, %out: i16):
      %2 = arith.extsi %in_0 : i16 to i64
      %3 = arith.extsi %in_1 : i16 to i64
      %4 = arith.addi %2, %3 : i64
      %5 = arith.extsi %in : i16 to i64
      %6 = arith.subi %4, %5 : i64
      %c-32768_i64 = arith.constant -32768 : i64
      %c32767_i64 = arith.constant 32767 : i64
      %7 = arith.maxsi %c-32768_i64, %6 : i64
      %8 = arith.minsi %c32767_i64, %7 : i64
      %9 = arith.trunci %8 : i64 to i16
      linalg.yield %9 : i16
    } -> tensor<50x42xi16>
    %cast = tensor.cast %1 : tensor<50x42xi16> to tensor<*xi16>
    return %cast : tensor<*xi16>
  }
}

// -----
module {
  func.func @test_identity(%arg0: tensor<1xf32>, %arg1: tensor<1xi32>) -> (tensor<1xf32>, tensor<1xi32>) {
    return %arg0, %arg1 : tensor<1xf32>, tensor<1xi32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @reduce_bf16(%arg0: tensor<5x4xbf16>) {
    %0 = tensor.empty() : tensor<4xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<4xf32>) -> tensor<4xf32>
    %reduced = linalg.reduce ins(%arg0 : tensor<5x4xbf16>) outs(%1 : tensor<4xf32>) dimensions = [0] 
      (%in: bf16, %init: f32) {
        %4 = arith.extf %in : bf16 to f32
        %5 = arith.addf %4, %init : f32
        linalg.yield %5 : f32
      }
    %2 = tensor.empty() : tensor<4xbf16>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%reduced : tensor<4xf32>) outs(%2 : tensor<4xbf16>) {
    ^bb0(%in: f32, %out: bf16):
      %4 = arith.truncf %in : f32 to bf16
      linalg.yield %4 : bf16
    } -> tensor<4xbf16>
    %expanded = tensor.expand_shape %3 [[0, 1]] output_shape [1, 4] : tensor<4xbf16> into tensor<1x4xbf16>
    return
  }
}

// -----
module {
  func.func @reduce_float(%arg0: tensor<5x4xf32>) {
    %0 = tensor.empty() : tensor<4xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<4xf32>) -> tensor<4xf32>
    %reduced = linalg.reduce ins(%arg0 : tensor<5x4xf32>) outs(%1 : tensor<4xf32>) dimensions = [0] 
      (%in: f32, %init: f32) {
        %10 = arith.addf %in, %init : f32
        linalg.yield %10 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [1, 4] : tensor<4xf32> into tensor<1x4xf32>
    %2 = tensor.empty() : tensor<5xf32>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %3 = linalg.fill ins(%cst_0 : f32) outs(%2 : tensor<5xf32>) -> tensor<5xf32>
    %reduced_1 = linalg.reduce ins(%arg0 : tensor<5x4xf32>) outs(%3 : tensor<5xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %10 = arith.addf %in, %init : f32
        linalg.yield %10 : f32
      }
    %expanded_2 = tensor.expand_shape %reduced_1 [[0, 1]] output_shape [5, 1] : tensor<5xf32> into tensor<5x1xf32>
    %4 = tensor.empty() : tensor<4xf32>
    %cst_3 = arith.constant 1.000000e+00 : f32
    %5 = linalg.fill ins(%cst_3 : f32) outs(%4 : tensor<4xf32>) -> tensor<4xf32>
    %reduced_4 = linalg.reduce ins(%arg0 : tensor<5x4xf32>) outs(%5 : tensor<4xf32>) dimensions = [0] 
      (%in: f32, %init: f32) {
        %10 = arith.mulf %in, %init : f32
        linalg.yield %10 : f32
      }
    %expanded_5 = tensor.expand_shape %reduced_4 [[0, 1]] output_shape [1, 4] : tensor<4xf32> into tensor<1x4xf32>
    %6 = tensor.empty() : tensor<4xf32>
    %cst_6 = arith.constant 3.40282347E+38 : f32
    %7 = linalg.fill ins(%cst_6 : f32) outs(%6 : tensor<4xf32>) -> tensor<4xf32>
    %reduced_7 = linalg.reduce ins(%arg0 : tensor<5x4xf32>) outs(%7 : tensor<4xf32>) dimensions = [0] 
      (%in: f32, %init: f32) {
        %10 = arith.minimumf %in, %init : f32
        linalg.yield %10 : f32
      }
    %expanded_8 = tensor.expand_shape %reduced_7 [[0, 1]] output_shape [1, 4] : tensor<4xf32> into tensor<1x4xf32>
    %8 = tensor.empty() : tensor<4xf32>
    %cst_9 = arith.constant -3.40282347E+38 : f32
    %9 = linalg.fill ins(%cst_9 : f32) outs(%8 : tensor<4xf32>) -> tensor<4xf32>
    %reduced_10 = linalg.reduce ins(%arg0 : tensor<5x4xf32>) outs(%9 : tensor<4xf32>) dimensions = [0] 
      (%in: f32, %init: f32) {
        %10 = arith.maximumf %in, %init : f32
        linalg.yield %10 : f32
      }
    %expanded_11 = tensor.expand_shape %reduced_10 [[0, 1]] output_shape [1, 4] : tensor<4xf32> into tensor<1x4xf32>
    return
  }
}

// -----
module {
  func.func @reduce_float_dyn(%arg0: tensor<?x5x4xf32>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x5x4xf32>
    %0 = tensor.empty(%dim) : tensor<?x4xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<?x4xf32>) -> tensor<?x4xf32>
    %reduced = linalg.reduce ins(%arg0 : tensor<?x5x4xf32>) outs(%1 : tensor<?x4xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %2 = arith.addf %in, %init : f32
        linalg.yield %2 : f32
      }
    %c0_0 = arith.constant 0 : index
    %dim_1 = tensor.dim %reduced, %c0_0 : tensor<?x4xf32>
    %c1 = arith.constant 1 : index
    %expanded = tensor.expand_shape %reduced [[0], [1, 2]] output_shape [%dim_1, 1, 4] : tensor<?x4xf32> into tensor<?x1x4xf32>
    return
  }
}

// -----
module {
  func.func @reduce_float_dyn_rank_1(%arg0: tensor<?xf32>) {
    %0 = tensor.empty() : tensor<f32>
    %cst = arith.constant 0.000000e+00 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<f32>) -> tensor<f32>
    %reduced = linalg.reduce ins(%arg0 : tensor<?xf32>) outs(%1 : tensor<f32>) dimensions = [0] 
      (%in: f32, %init: f32) {
        %2 = arith.addf %in, %init : f32
        linalg.yield %2 : f32
      }
    %expanded = tensor.expand_shape %reduced [] output_shape [1] : tensor<f32> into tensor<1xf32>
    return
  }
}

// -----
module {
  func.func @reduce_float_dyn_nonzero_batch(%arg0: tensor<5x?x4xf32>) {
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<5x?x4xf32>
    %0 = tensor.empty(%dim) : tensor<5x?xf32>
    %cst = arith.constant 1.000000e+00 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<5x?xf32>) -> tensor<5x?xf32>
    %reduced = linalg.reduce ins(%arg0 : tensor<5x?x4xf32>) outs(%1 : tensor<5x?xf32>) dimensions = [2] 
      (%in: f32, %init: f32) {
        %2 = arith.mulf %in, %init : f32
        linalg.yield %2 : f32
      }
    %c1_0 = arith.constant 1 : index
    %dim_1 = tensor.dim %reduced, %c1_0 : tensor<5x?xf32>
    %c1_2 = arith.constant 1 : index
    %expanded = tensor.expand_shape %reduced [[0], [1, 2]] output_shape [5, %dim_1, 1] : tensor<5x?xf32> into tensor<5x?x1xf32>
    return
  }
}

// -----
module {
  func.func @reduce_float_dyn_multiple(%arg0: tensor<?x?xf32>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %0 = tensor.empty(%dim) : tensor<?xf32>
    %cst = arith.constant -3.40282347E+38 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<?xf32>) -> tensor<?xf32>
    %reduced = linalg.reduce ins(%arg0 : tensor<?x?xf32>) outs(%1 : tensor<?xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %2 = arith.maximumf %in, %init : f32
        linalg.yield %2 : f32
      }
    %c0_0 = arith.constant 0 : index
    %dim_1 = tensor.dim %reduced, %c0_0 : tensor<?xf32>
    %c1 = arith.constant 1 : index
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [%dim_1, 1] : tensor<?xf32> into tensor<?x1xf32>
    return
  }
}

// -----
module {
  func.func @reduce_int(%arg0: tensor<5x4xi32>) {
    %0 = tensor.empty() : tensor<4xi32>
    %c0_i32 = arith.constant 0 : i32
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%0 : tensor<4xi32>) -> tensor<4xi32>
    %reduced = linalg.reduce ins(%arg0 : tensor<5x4xi32>) outs(%1 : tensor<4xi32>) dimensions = [0] 
      (%in: i32, %init: i32) {
        %10 = arith.addi %in, %init : i32
        linalg.yield %10 : i32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [1, 4] : tensor<4xi32> into tensor<1x4xi32>
    %2 = tensor.empty() : tensor<5xi32>
    %c0_i32_0 = arith.constant 0 : i32
    %3 = linalg.fill ins(%c0_i32_0 : i32) outs(%2 : tensor<5xi32>) -> tensor<5xi32>
    %reduced_1 = linalg.reduce ins(%arg0 : tensor<5x4xi32>) outs(%3 : tensor<5xi32>) dimensions = [1] 
      (%in: i32, %init: i32) {
        %10 = arith.addi %in, %init : i32
        linalg.yield %10 : i32
      }
    %expanded_2 = tensor.expand_shape %reduced_1 [[0, 1]] output_shape [5, 1] : tensor<5xi32> into tensor<5x1xi32>
    %4 = tensor.empty() : tensor<4xi32>
    %c1_i32 = arith.constant 1 : i32
    %5 = linalg.fill ins(%c1_i32 : i32) outs(%4 : tensor<4xi32>) -> tensor<4xi32>
    %reduced_3 = linalg.reduce ins(%arg0 : tensor<5x4xi32>) outs(%5 : tensor<4xi32>) dimensions = [0] 
      (%in: i32, %init: i32) {
        %10 = arith.muli %in, %init : i32
        linalg.yield %10 : i32
      }
    %expanded_4 = tensor.expand_shape %reduced_3 [[0, 1]] output_shape [1, 4] : tensor<4xi32> into tensor<1x4xi32>
    %6 = tensor.empty() : tensor<4xi32>
    %c2147483647_i32 = arith.constant 2147483647 : i32
    %7 = linalg.fill ins(%c2147483647_i32 : i32) outs(%6 : tensor<4xi32>) -> tensor<4xi32>
    %reduced_5 = linalg.reduce ins(%arg0 : tensor<5x4xi32>) outs(%7 : tensor<4xi32>) dimensions = [0] 
      (%in: i32, %init: i32) {
        %10 = arith.minsi %in, %init : i32
        linalg.yield %10 : i32
      }
    %expanded_6 = tensor.expand_shape %reduced_5 [[0, 1]] output_shape [1, 4] : tensor<4xi32> into tensor<1x4xi32>
    %8 = tensor.empty() : tensor<4xi32>
    %c-2147483648_i32 = arith.constant -2147483648 : i32
    %9 = linalg.fill ins(%c-2147483648_i32 : i32) outs(%8 : tensor<4xi32>) -> tensor<4xi32>
    %reduced_7 = linalg.reduce ins(%arg0 : tensor<5x4xi32>) outs(%9 : tensor<4xi32>) dimensions = [0] 
      (%in: i32, %init: i32) {
        %10 = arith.maxsi %in, %init : i32
        linalg.yield %10 : i32
      }
    %expanded_8 = tensor.expand_shape %reduced_7 [[0, 1]] output_shape [1, 4] : tensor<4xi32> into tensor<1x4xi32>
    return
  }
}

// -----
module {
  func.func @reduce_bool(%arg0: tensor<5x4xi1>) {
    %0 = tensor.empty() : tensor<4xi1>
    %true = arith.constant true
    %1 = linalg.fill ins(%true : i1) outs(%0 : tensor<4xi1>) -> tensor<4xi1>
    %reduced = linalg.reduce ins(%arg0 : tensor<5x4xi1>) outs(%1 : tensor<4xi1>) dimensions = [0] 
      (%in: i1, %init: i1) {
        %4 = arith.andi %in, %init : i1
        linalg.yield %4 : i1
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [1, 4] : tensor<4xi1> into tensor<1x4xi1>
    %2 = tensor.empty() : tensor<4xi1>
    %false = arith.constant false
    %3 = linalg.fill ins(%false : i1) outs(%2 : tensor<4xi1>) -> tensor<4xi1>
    %reduced_0 = linalg.reduce ins(%arg0 : tensor<5x4xi1>) outs(%3 : tensor<4xi1>) dimensions = [0] 
      (%in: i1, %init: i1) {
        %4 = arith.ori %in, %init : i1
        linalg.yield %4 : i1
      }
    %expanded_1 = tensor.expand_shape %reduced_0 [[0, 1]] output_shape [1, 4] : tensor<4xi1> into tensor<1x4xi1>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @rescale_i8(%arg0: tensor<2xi8>) {
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c19689_i32 = arith.constant 19689 : i32
    %c15_i8 = arith.constant 15 : i8
    %4 = tensor.empty() : tensor<2xi8>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<2xi8>) outs(%4 : tensor<2xi8>) {
    ^bb0(%in: i8, %out: i8):
      %c17_i32 = arith.constant 17 : i32
      %c22_i32 = arith.constant 22 : i32
      %6 = arith.extsi %in : i8 to i32
      %7 = arith.subi %6, %c17_i32 : i32
      %8 = tosa.apply_scale %7, %c19689_i32, %c15_i8 {rounding_mode = SINGLE_ROUND} : (i32, i32, i8) -> i32
      %9 = arith.addi %8, %c22_i32 : i32
      %c-128_i32 = arith.constant -128 : i32
      %c127_i32 = arith.constant 127 : i32
      %10 = arith.maxsi %c-128_i32, %9 : i32
      %11 = arith.minsi %c127_i32, %10 : i32
      %12 = arith.trunci %11 : i32 to i8
      linalg.yield %12 : i8
    } -> tensor<2xi8>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @rescale_i8_unsigned_output_explicit(%arg0: tensor<2xi8>) {
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<-22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c19689_i32 = arith.constant 19689 : i32
    %c15_i8 = arith.constant 15 : i8
    %4 = tensor.empty() : tensor<2xui8>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<2xi8>) outs(%4 : tensor<2xui8>) {
    ^bb0(%in: i8, %out: ui8):
      %c17_i32 = arith.constant 17 : i32
      %c234_i32 = arith.constant 234 : i32
      %6 = arith.extsi %in : i8 to i32
      %7 = arith.subi %6, %c17_i32 : i32
      %8 = tosa.apply_scale %7, %c19689_i32, %c15_i8 {rounding_mode = SINGLE_ROUND} : (i32, i32, i8) -> i32
      %9 = arith.addi %8, %c234_i32 : i32
      %c0_i32 = arith.constant 0 : i32
      %c255_i32 = arith.constant 255 : i32
      %10 = arith.maxsi %c0_i32, %9 : i32
      %11 = arith.minsi %c255_i32, %10 : i32
      %12 = arith.trunci %11 : i32 to i8
      %13 = builtin.unrealized_conversion_cast %12 : i8 to ui8
      linalg.yield %13 : ui8
    } -> tensor<2xui8>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @rescale_i8_unsigned_output_implicit(%arg0: tensor<2xi8>) {
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<-22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c19689_i32 = arith.constant 19689 : i32
    %c15_i8 = arith.constant 15 : i8
    %4 = tensor.empty() : tensor<2xi8>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<2xi8>) outs(%4 : tensor<2xi8>) {
    ^bb0(%in: i8, %out: i8):
      %c17_i32 = arith.constant 17 : i32
      %c234_i32 = arith.constant 234 : i32
      %6 = arith.extsi %in : i8 to i32
      %7 = arith.subi %6, %c17_i32 : i32
      %8 = tosa.apply_scale %7, %c19689_i32, %c15_i8 {rounding_mode = SINGLE_ROUND} : (i32, i32, i8) -> i32
      %9 = arith.addi %8, %c234_i32 : i32
      %c0_i32 = arith.constant 0 : i32
      %c255_i32 = arith.constant 255 : i32
      %10 = arith.maxsi %c0_i32, %9 : i32
      %11 = arith.minsi %c255_i32, %10 : i32
      %12 = arith.trunci %11 : i32 to i8
      linalg.yield %12 : i8
    } -> tensor<2xi8>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @rescale_i48_unsigned_output_implicit(%arg0: tensor<2xi48>) {
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi48>}> : () -> tensor<1xi48>
    %3 = "tosa.const"() <{values = dense<-22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c19689_i32 = arith.constant 19689 : i32
    %c15_i8 = arith.constant 15 : i8
    %4 = tensor.empty() : tensor<2xi8>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<2xi48>) outs(%4 : tensor<2xi8>) {
    ^bb0(%in: i48, %out: i8):
      %c0_i48 = arith.constant 0 : i48
      %c234_i32 = arith.constant 234 : i32
      %6 = arith.subi %in, %c0_i48 : i48
      %7 = tosa.apply_scale %6, %c19689_i32, %c15_i8 {rounding_mode = SINGLE_ROUND} : (i48, i32, i8) -> i32
      %8 = arith.addi %7, %c234_i32 : i32
      %c0_i32 = arith.constant 0 : i32
      %c255_i32 = arith.constant 255 : i32
      %9 = arith.maxsi %c0_i32, %8 : i32
      %10 = arith.minsi %c255_i32, %9 : i32
      %11 = arith.trunci %10 : i32 to i8
      linalg.yield %11 : i8
    } -> tensor<2xi8>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @rescale_i8_dyn_batch(%arg0: tensor<?x2xi8>) {
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x2xi8>
    %c19689_i32 = arith.constant 19689 : i32
    %c15_i8 = arith.constant 15 : i8
    %4 = tensor.empty(%dim) : tensor<?x2xi8>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<?x2xi8>) outs(%4 : tensor<?x2xi8>) {
    ^bb0(%in: i8, %out: i8):
      %c17_i32 = arith.constant 17 : i32
      %c22_i32 = arith.constant 22 : i32
      %8 = arith.extsi %in : i8 to i32
      %9 = arith.subi %8, %c17_i32 : i32
      %10 = tosa.apply_scale %9, %c19689_i32, %c15_i8 {rounding_mode = SINGLE_ROUND} : (i32, i32, i8) -> i32
      %11 = arith.addi %10, %c22_i32 : i32
      %c-128_i32 = arith.constant -128 : i32
      %c127_i32 = arith.constant 127 : i32
      %12 = arith.maxsi %c-128_i32, %11 : i32
      %13 = arith.minsi %c127_i32, %12 : i32
      %14 = arith.trunci %13 : i32 to i8
      linalg.yield %14 : i8
    } -> tensor<?x2xi8>
    %c0_0 = arith.constant 0 : index
    %dim_1 = tensor.dim %arg0, %c0_0 : tensor<?x2xi8>
    %c19689_i32_2 = arith.constant 19689 : i32
    %c15_i8_3 = arith.constant 15 : i8
    %6 = tensor.empty(%dim_1) : tensor<?x2xi8>
    %7 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<?x2xi8>) outs(%6 : tensor<?x2xi8>) {
    ^bb0(%in: i8, %out: i8):
      %c17_i32 = arith.constant 17 : i32
      %c22_i32 = arith.constant 22 : i32
      %8 = arith.extsi %in : i8 to i32
      %9 = arith.subi %8, %c17_i32 : i32
      %10 = tosa.apply_scale %9, %c19689_i32_2, %c15_i8_3 {rounding_mode = SINGLE_ROUND} : (i32, i32, i8) -> i32
      %11 = arith.addi %10, %c22_i32 : i32
      %c0_i32 = arith.constant 0 : i32
      %c255_i32 = arith.constant 255 : i32
      %12 = arith.maxsi %c0_i32, %11 : i32
      %13 = arith.minsi %c255_i32, %12 : i32
      %14 = arith.trunci %13 : i32 to i8
      linalg.yield %14 : i8
    } -> tensor<?x2xi8>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @rescale_dyn(%arg0: tensor<1x?x?x32xi32>) {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<1376784203> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<38> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<1x?x?x32xi32>
    %c2 = arith.constant 2 : index
    %dim_0 = tensor.dim %arg0, %c2 : tensor<1x?x?x32xi32>
    %c1376784203_i32 = arith.constant 1376784203 : i32
    %c38_i8 = arith.constant 38 : i8
    %4 = tensor.empty(%dim, %dim_0) : tensor<1x?x?x32xi8>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0 : tensor<1x?x?x32xi32>) outs(%4 : tensor<1x?x?x32xi8>) {
    ^bb0(%in: i32, %out: i8):
      %c0_i32 = arith.constant 0 : i32
      %c0_i32_1 = arith.constant 0 : i32
      %6 = arith.subi %in, %c0_i32 : i32
      %7 = tosa.apply_scale %6, %c1376784203_i32, %c38_i8 {rounding_mode = DOUBLE_ROUND} : (i32, i32, i8) -> i32
      %8 = arith.addi %7, %c0_i32_1 : i32
      %c-128_i32 = arith.constant -128 : i32
      %c127_i32 = arith.constant 127 : i32
      %9 = arith.maxsi %c-128_i32, %8 : i32
      %10 = arith.minsi %c127_i32, %9 : i32
      %11 = arith.trunci %10 : i32 to i8
      linalg.yield %11 : i8
    } -> tensor<1x?x?x32xi8>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @rescale_i8_unsigned_input_explicit(%arg0: tensor<2xui8>) {
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c19689_i32 = arith.constant 19689 : i32
    %c15_i8 = arith.constant 15 : i8
    %4 = tensor.empty() : tensor<2xi8>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<2xui8>) outs(%4 : tensor<2xi8>) {
    ^bb0(%in: ui8, %out: i8):
      %c17_i32 = arith.constant 17 : i32
      %c22_i32 = arith.constant 22 : i32
      %6 = builtin.unrealized_conversion_cast %in : ui8 to i8
      %7 = arith.extui %6 : i8 to i32
      %8 = arith.subi %7, %c17_i32 : i32
      %9 = tosa.apply_scale %8, %c19689_i32, %c15_i8 {rounding_mode = SINGLE_ROUND} : (i32, i32, i8) -> i32
      %10 = arith.addi %9, %c22_i32 : i32
      %c-128_i32 = arith.constant -128 : i32
      %c127_i32 = arith.constant 127 : i32
      %11 = arith.maxsi %c-128_i32, %10 : i32
      %12 = arith.minsi %c127_i32, %11 : i32
      %13 = arith.trunci %12 : i32 to i8
      linalg.yield %13 : i8
    } -> tensor<2xi8>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @rescale_i8_unsigned_input_implicit(%arg0: tensor<2xi8>) {
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c19689_i32 = arith.constant 19689 : i32
    %c15_i8 = arith.constant 15 : i8
    %4 = tensor.empty() : tensor<2xi8>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<2xi8>) outs(%4 : tensor<2xi8>) {
    ^bb0(%in: i8, %out: i8):
      %c128_i32 = arith.constant 128 : i32
      %c22_i32 = arith.constant 22 : i32
      %6 = arith.extui %in : i8 to i32
      %7 = arith.subi %6, %c128_i32 : i32
      %8 = tosa.apply_scale %7, %c19689_i32, %c15_i8 {rounding_mode = SINGLE_ROUND} : (i32, i32, i8) -> i32
      %9 = arith.addi %8, %c22_i32 : i32
      %c-128_i32 = arith.constant -128 : i32
      %c127_i32 = arith.constant 127 : i32
      %10 = arith.maxsi %c-128_i32, %9 : i32
      %11 = arith.minsi %c127_i32, %10 : i32
      %12 = arith.trunci %11 : i32 to i8
      linalg.yield %12 : i8
    } -> tensor<2xi8>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @rescale_i8_unsigned_input_output_explicit(%arg0: tensor<2xui8>) {
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c19689_i32 = arith.constant 19689 : i32
    %c15_i8 = arith.constant 15 : i8
    %4 = tensor.empty() : tensor<2xui8>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<2xui8>) outs(%4 : tensor<2xui8>) {
    ^bb0(%in: ui8, %out: ui8):
      %c17_i32 = arith.constant 17 : i32
      %c22_i32 = arith.constant 22 : i32
      %6 = builtin.unrealized_conversion_cast %in : ui8 to i8
      %7 = arith.extui %6 : i8 to i32
      %8 = arith.subi %7, %c17_i32 : i32
      %9 = tosa.apply_scale %8, %c19689_i32, %c15_i8 {rounding_mode = SINGLE_ROUND} : (i32, i32, i8) -> i32
      %10 = arith.addi %9, %c22_i32 : i32
      %c-128_i32 = arith.constant -128 : i32
      %c127_i32 = arith.constant 127 : i32
      %11 = arith.maxsi %c-128_i32, %10 : i32
      %12 = arith.minsi %c127_i32, %11 : i32
      %13 = arith.trunci %12 : i32 to i8
      %14 = builtin.unrealized_conversion_cast %13 : i8 to ui8
      linalg.yield %14 : ui8
    } -> tensor<2xui8>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @rescale_per_channel(%arg0: tensor<3xi8>) -> tensor<3xi8> {
    %0 = "tosa.const"() <{values = dense<[42, 43, 44]> : tensor<3xi16>}> : () -> tensor<3xi16>
    %1 = "tosa.const"() <{values = dense<[14, 15, 64]> : tensor<3xi8>}> : () -> tensor<3xi8>
    %2 = "tosa.const"() <{values = dense<43> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<52> : tensor<1xi8>}> : () -> tensor<1xi8>
    %cst = arith.constant dense<[42, 43, 0]> : tensor<3xi32>
    %cst_0 = arith.constant dense<[14, 15, 0]> : tensor<3xi8>
    %4 = tensor.empty() : tensor<3xi8>
    %5 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %cst, %cst_0 : tensor<3xi8>, tensor<3xi32>, tensor<3xi8>) outs(%4 : tensor<3xi8>) {
    ^bb0(%in: i8, %in_1: i32, %in_2: i8, %out: i8):
      %c43_i32 = arith.constant 43 : i32
      %c52_i32 = arith.constant 52 : i32
      %6 = arith.extsi %in : i8 to i32
      %7 = arith.subi %6, %c43_i32 : i32
      %8 = tosa.apply_scale %7, %in_1, %in_2 {rounding_mode = SINGLE_ROUND} : (i32, i32, i8) -> i32
      %9 = arith.addi %8, %c52_i32 : i32
      %c-128_i32 = arith.constant -128 : i32
      %c127_i32 = arith.constant 127 : i32
      %10 = arith.maxsi %c-128_i32, %9 : i32
      %11 = arith.minsi %c127_i32, %10 : i32
      %12 = arith.trunci %11 : i32 to i8
      linalg.yield %12 : i8
    } -> tensor<3xi8>
    return %5 : tensor<3xi8>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @rescaleDoubleRound(%arg0: tensor<2xi8>) -> tensor<2xi8> {
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<33> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<43> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<52> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c19689_i32 = arith.constant 19689 : i32
    %c33_i8 = arith.constant 33 : i8
    %4 = tensor.empty() : tensor<2xi8>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<2xi8>) outs(%4 : tensor<2xi8>) {
    ^bb0(%in: i8, %out: i8):
      %c43_i32 = arith.constant 43 : i32
      %c52_i32 = arith.constant 52 : i32
      %6 = arith.extsi %in : i8 to i32
      %7 = arith.subi %6, %c43_i32 : i32
      %8 = tosa.apply_scale %7, %c19689_i32, %c33_i8 {rounding_mode = DOUBLE_ROUND} : (i32, i32, i8) -> i32
      %9 = arith.addi %8, %c52_i32 : i32
      %c-128_i32 = arith.constant -128 : i32
      %c127_i32 = arith.constant 127 : i32
      %10 = arith.maxsi %c-128_i32, %9 : i32
      %11 = arith.minsi %c127_i32, %10 : i32
      %12 = arith.trunci %11 : i32 to i8
      linalg.yield %12 : i8
    } -> tensor<2xi8>
    return %5 : tensor<2xi8>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @rescaleUnnecessaryDoubleRound(%arg0: tensor<2xi8>) -> tensor<2xi8> {
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<43> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<52> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c19689_i32 = arith.constant 19689 : i32
    %c15_i8 = arith.constant 15 : i8
    %4 = tensor.empty() : tensor<2xi8>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<2xi8>) outs(%4 : tensor<2xi8>) {
    ^bb0(%in: i8, %out: i8):
      %c43_i32 = arith.constant 43 : i32
      %c52_i32 = arith.constant 52 : i32
      %6 = arith.extsi %in : i8 to i32
      %7 = arith.subi %6, %c43_i32 : i32
      %8 = tosa.apply_scale %7, %c19689_i32, %c15_i8 {rounding_mode = SINGLE_ROUND} : (i32, i32, i8) -> i32
      %9 = arith.addi %8, %c52_i32 : i32
      %c-128_i32 = arith.constant -128 : i32
      %c127_i32 = arith.constant 127 : i32
      %10 = arith.maxsi %c-128_i32, %9 : i32
      %11 = arith.minsi %c127_i32, %10 : i32
      %12 = arith.trunci %11 : i32 to i8
      linalg.yield %12 : i8
    } -> tensor<2xi8>
    return %5 : tensor<2xi8>
  }
}

// -----
// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
module {
  func.func @rescale_no_const(%arg0: tensor<2xi8>, %arg1: tensor<1xi32>, %arg2: tensor<1xi8>, %arg3: tensor<1xi8>, %arg4: tensor<1xi8>) -> tensor<2xi8> {
    %collapsed = tensor.collapse_shape %arg1 [] : tensor<1xi32> into tensor<i32>
    %collapsed_0 = tensor.collapse_shape %arg2 [] : tensor<1xi8> into tensor<i8>
    %collapsed_1 = tensor.collapse_shape %arg3 [] : tensor<1xi8> into tensor<i8>
    %collapsed_2 = tensor.collapse_shape %arg4 [] : tensor<1xi8> into tensor<i8>
    %0 = tensor.empty() : tensor<2xi8>
    %1 = linalg.generic {indexing_maps = [#map, #map1, #map1, #map1, #map1, #map], iterator_types = ["parallel"]} ins(%arg0, %collapsed, %collapsed_0, %collapsed_1, %collapsed_2 : tensor<2xi8>, tensor<i32>, tensor<i8>, tensor<i8>, tensor<i8>) outs(%0 : tensor<2xi8>) {
    ^bb0(%in: i8, %in_3: i32, %in_4: i8, %in_5: i8, %in_6: i8, %out: i8):
      %2 = arith.extsi %in_5 : i8 to i32
      %3 = arith.extsi %in_6 : i8 to i32
      %4 = arith.extsi %in : i8 to i32
      %5 = arith.subi %4, %2 : i32
      %6 = tosa.apply_scale %5, %in_3, %in_4 {rounding_mode = DOUBLE_ROUND} : (i32, i32, i8) -> i32
      %7 = arith.addi %6, %3 : i32
      %c-128_i32 = arith.constant -128 : i32
      %c127_i32 = arith.constant 127 : i32
      %8 = arith.maxsi %c-128_i32, %7 : i32
      %9 = arith.minsi %c127_i32, %8 : i32
      %10 = arith.trunci %9 : i32 to i8
      linalg.yield %10 : i8
    } -> tensor<2xi8>
    return %1 : tensor<2xi8>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
module {
  func.func @rescale_no_const_per_channel(%arg0: tensor<2xi8>, %arg1: tensor<2xi32>, %arg2: tensor<2xi8>, %arg3: tensor<1xi8>, %arg4: tensor<1xi8>) -> tensor<2xi8> {
    %collapsed = tensor.collapse_shape %arg3 [] : tensor<1xi8> into tensor<i8>
    %collapsed_0 = tensor.collapse_shape %arg4 [] : tensor<1xi8> into tensor<i8>
    %0 = tensor.empty() : tensor<2xi8>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map, #map1, #map1, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1, %arg2, %collapsed, %collapsed_0 : tensor<2xi8>, tensor<2xi32>, tensor<2xi8>, tensor<i8>, tensor<i8>) outs(%0 : tensor<2xi8>) {
    ^bb0(%in: i8, %in_1: i32, %in_2: i8, %in_3: i8, %in_4: i8, %out: i8):
      %2 = arith.extsi %in_3 : i8 to i32
      %3 = arith.extsi %in_4 : i8 to i32
      %4 = arith.extsi %in : i8 to i32
      %5 = arith.subi %4, %2 : i32
      %6 = tosa.apply_scale %5, %in_1, %in_2 {rounding_mode = DOUBLE_ROUND} : (i32, i32, i8) -> i32
      %7 = arith.addi %6, %3 : i32
      %c-128_i32 = arith.constant -128 : i32
      %c127_i32 = arith.constant 127 : i32
      %8 = arith.maxsi %c-128_i32, %7 : i32
      %9 = arith.minsi %c127_i32, %8 : i32
      %10 = arith.trunci %9 : i32 to i8
      linalg.yield %10 : i8
    } -> tensor<2xi8>
    return %1 : tensor<2xi8>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
module {
  func.func @rescale_no_const_per_channel_input_output_zp_ui8(%arg0: tensor<2xi8>, %arg1: tensor<2xi32>, %arg2: tensor<2xi8>, %arg3: tensor<1xui8>, %arg4: tensor<1xui8>) -> tensor<2xui8> {
    %collapsed = tensor.collapse_shape %arg3 [] : tensor<1xui8> into tensor<ui8>
    %collapsed_0 = tensor.collapse_shape %arg4 [] : tensor<1xui8> into tensor<ui8>
    %0 = tensor.empty() : tensor<2xui8>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map, #map1, #map1, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1, %arg2, %collapsed, %collapsed_0 : tensor<2xi8>, tensor<2xi32>, tensor<2xi8>, tensor<ui8>, tensor<ui8>) outs(%0 : tensor<2xui8>) {
    ^bb0(%in: i8, %in_1: i32, %in_2: i8, %in_3: ui8, %in_4: ui8, %out: ui8):
      %2 = builtin.unrealized_conversion_cast %in_3 : ui8 to i8
      %3 = arith.extui %2 : i8 to i32
      %4 = builtin.unrealized_conversion_cast %in_4 : ui8 to i8
      %5 = arith.extui %4 : i8 to i32
      %6 = arith.extsi %in : i8 to i32
      %7 = arith.subi %6, %3 : i32
      %8 = tosa.apply_scale %7, %in_1, %in_2 {rounding_mode = DOUBLE_ROUND} : (i32, i32, i8) -> i32
      %9 = arith.addi %8, %5 : i32
      %c0_i32 = arith.constant 0 : i32
      %c255_i32 = arith.constant 255 : i32
      %10 = arith.maxsi %c0_i32, %9 : i32
      %11 = arith.minsi %c255_i32, %10 : i32
      %12 = arith.trunci %11 : i32 to i8
      %13 = builtin.unrealized_conversion_cast %12 : i8 to ui8
      linalg.yield %13 : ui8
    } -> tensor<2xui8>
    return %1 : tensor<2xui8>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @reverse(%arg0: tensor<5x4xi32>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<5x4xi32>
    %0 = tensor.empty() : tensor<5x4xi32>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel"]} outs(%0 : tensor<5x4xi32>) {
    ^bb0(%out: i32):
      %4 = linalg.index 0 : index
      %c1_1 = arith.constant 1 : index
      %5 = arith.subi %dim, %c1_1 : index
      %6 = arith.subi %5, %4 : index
      %7 = linalg.index 1 : index
      %extracted = tensor.extract %arg0[%6, %7] : tensor<5x4xi32>
      linalg.yield %extracted : i32
    } -> tensor<5x4xi32>
    %c1 = arith.constant 1 : index
    %dim_0 = tensor.dim %arg0, %c1 : tensor<5x4xi32>
    %2 = tensor.empty() : tensor<5x4xi32>
    %3 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel"]} outs(%2 : tensor<5x4xi32>) {
    ^bb0(%out: i32):
      %4 = linalg.index 0 : index
      %5 = linalg.index 1 : index
      %c1_1 = arith.constant 1 : index
      %6 = arith.subi %dim_0, %c1_1 : index
      %7 = arith.subi %6, %5 : index
      %extracted = tensor.extract %arg0[%4, %7] : tensor<5x4xi32>
      linalg.yield %extracted : i32
    } -> tensor<5x4xi32>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @reverse_dyn(%arg0: tensor<?xi32>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xi32>
    %c0_0 = arith.constant 0 : index
    %dim_1 = tensor.dim %arg0, %c0_0 : tensor<?xi32>
    %0 = tensor.empty(%dim) : tensor<?xi32>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%0 : tensor<?xi32>) {
    ^bb0(%out: i32):
      %2 = linalg.index 0 : index
      %c1 = arith.constant 1 : index
      %3 = arith.subi %dim_1, %c1 : index
      %4 = arith.subi %3, %2 : index
      %extracted = tensor.extract %arg0[%4] : tensor<?xi32>
      linalg.yield %extracted : i32
    } -> tensor<?xi32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @tile(%arg0: tensor<2x3xi8>) {
    %0 = tosa.const_shape  {values = dense<[2, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %1 = tensor.empty() : tensor<2x2x1x3xi8>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0 : tensor<2x3xi8>) outs(%1 : tensor<2x2x1x3xi8>) {
    ^bb0(%in: i8, %out: i8):
      linalg.yield %in : i8
    } -> tensor<2x2x1x3xi8>
    %3 = tosa.const_shape  {values = dense<[4, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.reshape %2, %3 : (tensor<2x2x1x3xi8>, !tosa.shape<2>) -> tensor<4x3xi8>
    %5 = tosa.const_shape  {values = dense<[1, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %6 = tensor.empty() : tensor<1x2x2x3xi8>
    %7 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0 : tensor<2x3xi8>) outs(%6 : tensor<1x2x2x3xi8>) {
    ^bb0(%in: i8, %out: i8):
      linalg.yield %in : i8
    } -> tensor<1x2x2x3xi8>
    %8 = tosa.const_shape  {values = dense<[2, 6]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %9 = tosa.reshape %7, %8 : (tensor<1x2x2x3xi8>, !tosa.shape<2>) -> tensor<2x6xi8>
    %10 = tosa.const_shape  {values = dense<[5, 7]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %11 = tensor.empty() : tensor<5x2x7x3xi8>
    %12 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0 : tensor<2x3xi8>) outs(%11 : tensor<5x2x7x3xi8>) {
    ^bb0(%in: i8, %out: i8):
      linalg.yield %in : i8
    } -> tensor<5x2x7x3xi8>
    %13 = tosa.const_shape  {values = dense<[10, 21]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %14 = tosa.reshape %12, %13 : (tensor<5x2x7x3xi8>, !tosa.shape<2>) -> tensor<10x21xi8>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @tile_dyn_input(%arg0: tensor<?x3xi8>) {
    %0 = tosa.const_shape  {values = dense<[2, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x3xi8>
    %1 = tensor.empty(%dim) : tensor<2x?x1x3xi8>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0 : tensor<?x3xi8>) outs(%1 : tensor<2x?x1x3xi8>) {
    ^bb0(%in: i8, %out: i8):
      linalg.yield %in : i8
    } -> tensor<2x?x1x3xi8>
    %3 = tosa.const_shape  {values = dense<[-1, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.reshape %2, %3 : (tensor<2x?x1x3xi8>, !tosa.shape<2>) -> tensor<?x3xi8>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @tile_dyn_multiples(%arg0: tensor<2x3xi8>) {
    %0 = tosa.const_shape  {values = dense<[2, -1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<2x3xi8>
    %1 = tensor.empty(%dim) : tensor<2x2x?x3xi8>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0 : tensor<2x3xi8>) outs(%1 : tensor<2x2x?x3xi8>) {
    ^bb0(%in: i8, %out: i8):
      linalg.yield %in : i8
    } -> tensor<2x2x?x3xi8>
    %3 = tosa.const_shape  {values = dense<[2, -1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.reshape %2, %3 : (tensor<2x2x?x3xi8>, !tosa.shape<2>) -> tensor<2x?xi8>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
#map2 = affine_map<(d0, d1) -> (d0)>
#map3 = affine_map<(d0) -> (d0)>
#map4 = affine_map<(d0) -> ()>
module {
  func.func @argmax(%arg0: tensor<3x2xi32>, %arg1: tensor<6xf32>) {
    %0 = tensor.empty() : tensor<2xi32>
    %c0_i32 = arith.constant 0 : i32
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%0 : tensor<2xi32>) -> tensor<2xi32>
    %2 = tensor.empty() : tensor<2xi32>
    %c-2147483648_i32 = arith.constant -2147483648 : i32
    %3 = linalg.fill ins(%c-2147483648_i32 : i32) outs(%2 : tensor<2xi32>) -> tensor<2xi32>
    %4:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["reduction", "parallel"]} ins(%arg0 : tensor<3x2xi32>) outs(%1, %3 : tensor<2xi32>, tensor<2xi32>) {
    ^bb0(%in: i32, %out: i32, %out_3: i32):
      %15 = linalg.index 0 : index
      %16 = arith.index_cast %15 : index to i32
      %17 = arith.cmpi sgt, %in, %out_3 : i32
      %18 = arith.select %17, %in, %out_3 : i32
      %19 = arith.select %17, %16, %out : i32
      linalg.yield %19, %18 : i32, i32
    } -> (tensor<2xi32>, tensor<2xi32>)
    %5 = tensor.empty() : tensor<3xi32>
    %c0_i32_0 = arith.constant 0 : i32
    %6 = linalg.fill ins(%c0_i32_0 : i32) outs(%5 : tensor<3xi32>) -> tensor<3xi32>
    %7 = tensor.empty() : tensor<3xi32>
    %c-2147483648_i32_1 = arith.constant -2147483648 : i32
    %8 = linalg.fill ins(%c-2147483648_i32_1 : i32) outs(%7 : tensor<3xi32>) -> tensor<3xi32>
    %9:2 = linalg.generic {indexing_maps = [#map, #map2, #map2], iterator_types = ["parallel", "reduction"]} ins(%arg0 : tensor<3x2xi32>) outs(%6, %8 : tensor<3xi32>, tensor<3xi32>) {
    ^bb0(%in: i32, %out: i32, %out_3: i32):
      %15 = linalg.index 1 : index
      %16 = arith.index_cast %15 : index to i32
      %17 = arith.cmpi sgt, %in, %out_3 : i32
      %18 = arith.select %17, %in, %out_3 : i32
      %19 = arith.select %17, %16, %out : i32
      linalg.yield %19, %18 : i32, i32
    } -> (tensor<3xi32>, tensor<3xi32>)
    %10 = tensor.empty() : tensor<i32>
    %c0_i32_2 = arith.constant 0 : i32
    %11 = linalg.fill ins(%c0_i32_2 : i32) outs(%10 : tensor<i32>) -> tensor<i32>
    %12 = tensor.empty() : tensor<f32>
    %cst = arith.constant -3.40282347E+38 : f32
    %13 = linalg.fill ins(%cst : f32) outs(%12 : tensor<f32>) -> tensor<f32>
    %14:2 = linalg.generic {indexing_maps = [#map3, #map4, #map4], iterator_types = ["reduction"]} ins(%arg1 : tensor<6xf32>) outs(%11, %13 : tensor<i32>, tensor<f32>) {
    ^bb0(%in: f32, %out: i32, %out_3: f32):
      %15 = linalg.index 0 : index
      %16 = arith.index_cast %15 : index to i32
      %17 = arith.cmpf ugt, %in, %out_3 : f32
      %18 = arith.cmpf ord, %out_3, %out_3 : f32
      %19 = arith.andi %17, %18 : i1
      %20 = arith.select %19, %in, %out_3 : f32
      %21 = arith.select %19, %16, %out : i32
      linalg.yield %21, %20 : i32, f32
    } -> (tensor<i32>, tensor<f32>)
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
module {
  func.func @argmax_dyn_non_axis(%arg0: tensor<3x?xi32>) {
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<3x?xi32>
    %0 = tensor.empty(%dim) : tensor<?xi32>
    %c0_i32 = arith.constant 0 : i32
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%0 : tensor<?xi32>) -> tensor<?xi32>
    %2 = tensor.empty(%dim) : tensor<?xi32>
    %c-2147483648_i32 = arith.constant -2147483648 : i32
    %3 = linalg.fill ins(%c-2147483648_i32 : i32) outs(%2 : tensor<?xi32>) -> tensor<?xi32>
    %4:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["reduction", "parallel"]} ins(%arg0 : tensor<3x?xi32>) outs(%1, %3 : tensor<?xi32>, tensor<?xi32>) {
    ^bb0(%in: i32, %out: i32, %out_0: i32):
      %5 = linalg.index 0 : index
      %6 = arith.index_cast %5 : index to i32
      %7 = arith.cmpi sgt, %in, %out_0 : i32
      %8 = arith.select %7, %in, %out_0 : i32
      %9 = arith.select %7, %6, %out : i32
      linalg.yield %9, %8 : i32, i32
    } -> (tensor<?xi32>, tensor<?xi32>)
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
module {
  func.func @argmax_dyn_axis(%arg0: tensor<3x?xi32>) {
    %0 = tensor.empty() : tensor<3xi32>
    %c0_i32 = arith.constant 0 : i32
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%0 : tensor<3xi32>) -> tensor<3xi32>
    %2 = tensor.empty() : tensor<3xi32>
    %c-2147483648_i32 = arith.constant -2147483648 : i32
    %3 = linalg.fill ins(%c-2147483648_i32 : i32) outs(%2 : tensor<3xi32>) -> tensor<3xi32>
    %4:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "reduction"]} ins(%arg0 : tensor<3x?xi32>) outs(%1, %3 : tensor<3xi32>, tensor<3xi32>) {
    ^bb0(%in: i32, %out: i32, %out_0: i32):
      %5 = linalg.index 1 : index
      %6 = arith.index_cast %5 : index to i32
      %7 = arith.cmpi sgt, %in, %out_0 : i32
      %8 = arith.select %7, %in, %out_0 : i32
      %9 = arith.select %7, %6, %out : i32
      linalg.yield %9, %8 : i32, i32
    } -> (tensor<3xi32>, tensor<3xi32>)
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @gather_float(%arg0: tensor<2x3x2xf32>, %arg1: tensor<2x3xi32>) {
    %0 = tensor.empty() : tensor<2x3x2xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg1 : tensor<2x3xi32>) outs(%0 : tensor<2x3x2xf32>) {
    ^bb0(%in: i32, %out: f32):
      %2 = linalg.index 0 : index
      %3 = arith.index_cast %in : i32 to index
      %4 = linalg.index 2 : index
      %extracted = tensor.extract %arg0[%2, %3, %4] : tensor<2x3x2xf32>
      linalg.yield %extracted : f32
    } -> tensor<2x3x2xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @gather_float_dyn(%arg0: tensor<?x3x2xf32>, %arg1: tensor<?x3xi32>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x3x2xf32>
    %0 = tensor.empty(%dim) : tensor<?x3x2xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg1 : tensor<?x3xi32>) outs(%0 : tensor<?x3x2xf32>) {
    ^bb0(%in: i32, %out: f32):
      %2 = linalg.index 0 : index
      %3 = arith.index_cast %in : i32 to index
      %4 = linalg.index 2 : index
      %extracted = tensor.extract %arg0[%2, %3, %4] : tensor<?x3x2xf32>
      linalg.yield %extracted : f32
    } -> tensor<?x3x2xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @gather_float_all_dynamic(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?xi32>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = tensor.dim %arg1, %c1 : tensor<?x?xi32>
    %c2 = arith.constant 2 : index
    %dim_1 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %0 = tensor.empty(%dim, %dim_0, %dim_1) : tensor<?x?x?xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg1 : tensor<?x?xi32>) outs(%0 : tensor<?x?x?xf32>) {
    ^bb0(%in: i32, %out: f32):
      %2 = linalg.index 0 : index
      %3 = arith.index_cast %in : i32 to index
      %4 = linalg.index 2 : index
      %extracted = tensor.extract %arg0[%2, %3, %4] : tensor<?x?x?xf32>
      linalg.yield %extracted : f32
    } -> tensor<?x?x?xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @gather_int(%arg0: tensor<2x3x2xi32>, %arg1: tensor<2x3xi32>) {
    %0 = tensor.empty() : tensor<2x3x2xi32>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg1 : tensor<2x3xi32>) outs(%0 : tensor<2x3x2xi32>) {
    ^bb0(%in: i32, %out: i32):
      %2 = linalg.index 0 : index
      %3 = arith.index_cast %in : i32 to index
      %4 = linalg.index 2 : index
      %extracted = tensor.extract %arg0[%2, %3, %4] : tensor<2x3x2xi32>
      linalg.yield %extracted : i32
    } -> tensor<2x3x2xi32>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @table8(%arg0: tensor<6xi8>, %arg1: tensor<512xi8>) {
    %0 = tensor.empty() : tensor<6xi8>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<6xi8>) outs(%0 : tensor<6xi8>) {
    ^bb0(%in: i8, %out: i8):
      %2 = arith.index_cast %in : i8 to index
      %c128 = arith.constant 128 : index
      %3 = arith.addi %2, %c128 : index
      %extracted = tensor.extract %arg1[%3] : tensor<512xi8>
      linalg.yield %extracted : i8
    } -> tensor<6xi8>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @table16(%arg0: tensor<6xi16>, %arg1: tensor<513xi16>) {
    %0 = tensor.empty() : tensor<6xi32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<6xi16>) outs(%0 : tensor<6xi32>) {
    ^bb0(%in: i16, %out: i32):
      %2 = arith.extsi %in : i16 to i32
      %c32768_i32 = arith.constant 32768 : i32
      %c7_i32 = arith.constant 7 : i32
      %c1_i32 = arith.constant 1 : i32
      %c127_i32 = arith.constant 127 : i32
      %3 = arith.addi %2, %c32768_i32 : i32
      %4 = arith.shrui %3, %c7_i32 : i32
      %5 = arith.andi %3, %c127_i32 : i32
      %6 = arith.addi %4, %c1_i32 : i32
      %7 = arith.index_cast %4 : i32 to index
      %8 = arith.index_cast %6 : i32 to index
      %extracted = tensor.extract %arg1[%7] : tensor<513xi16>
      %extracted_0 = tensor.extract %arg1[%8] : tensor<513xi16>
      %9 = arith.extsi %extracted : i16 to i32
      %10 = arith.extsi %extracted_0 : i16 to i32
      %11 = arith.shli %9, %c7_i32 : i32
      %12 = arith.subi %10, %9 : i32
      %13 = arith.muli %12, %5 : i32
      %14 = arith.addi %11, %13 : i32
      linalg.yield %14 : i32
    } -> tensor<6xi32>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @table8_dyn(%arg0: tensor<?xi8>, %arg1: tensor<512xi8>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xi8>
    %0 = tensor.empty(%dim) : tensor<?xi8>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<?xi8>) outs(%0 : tensor<?xi8>) {
    ^bb0(%in: i8, %out: i8):
      %2 = arith.index_cast %in : i8 to index
      %c128 = arith.constant 128 : index
      %3 = arith.addi %2, %c128 : index
      %extracted = tensor.extract %arg1[%3] : tensor<512xi8>
      linalg.yield %extracted : i8
    } -> tensor<?xi8>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @table8_dyn_table(%arg0: tensor<6xi8>, %arg1: tensor<?xi8>) {
    %0 = tensor.empty() : tensor<6xi8>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<6xi8>) outs(%0 : tensor<6xi8>) {
    ^bb0(%in: i8, %out: i8):
      %2 = arith.index_cast %in : i8 to index
      %c128 = arith.constant 128 : index
      %3 = arith.addi %2, %c128 : index
      %extracted = tensor.extract %arg1[%3] : tensor<?xi8>
      linalg.yield %extracted : i8
    } -> tensor<6xi8>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d3, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2)>
module {
  func.func @test_static_rfft2d(%arg0: tensor<5x4x8xf32>) -> (tensor<5x4x5xf32>, tensor<5x4x5xf32>) {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c8 = arith.constant 8 : index
    %c4 = arith.constant 4 : index
    %c5 = arith.constant 5 : index
    %0 = tensor.empty() : tensor<5x4x5xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<5x4x5xf32>) -> tensor<5x4x5xf32>
    %2 = tensor.empty() : tensor<5x4x5xf32>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %3 = linalg.fill ins(%cst_0 : f32) outs(%2 : tensor<5x4x5xf32>) -> tensor<5x4x5xf32>
    %c1_1 = arith.constant 1 : index
    %c4_2 = arith.constant 4 : index
    %c2_3 = arith.constant 2 : index
    %c8_4 = arith.constant 8 : index
    %cst_5 = arith.constant 6.28318548 : f32
    %4 = arith.index_castui %c4_2 : index to i32
    %5 = arith.uitofp %4 : i32 to f32
    %6 = arith.index_castui %c8_4 : index to i32
    %7 = arith.uitofp %6 : i32 to f32
    %8:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel", "reduction", "reduction"]} ins(%arg0 : tensor<5x4x8xf32>) outs(%1, %3 : tensor<5x4x5xf32>, tensor<5x4x5xf32>) {
    ^bb0(%in: f32, %out: f32, %out_6: f32):
      %9 = linalg.index 1 : index
      %10 = linalg.index 2 : index
      %11 = linalg.index 3 : index
      %12 = linalg.index 4 : index
      %13 = index.mul %11, %9
      %14 = index.mul %12, %10
      %15 = index.remu %13, %c4_2
      %16 = index.remu %14, %c8_4
      %17 = arith.index_castui %15 : index to i32
      %18 = arith.uitofp %17 : i32 to f32
      %19 = arith.index_castui %16 : index to i32
      %20 = arith.uitofp %19 : i32 to f32
      %21 = arith.divf %18, %5 : f32
      %22 = arith.divf %20, %7 : f32
      %23 = arith.addf %21, %22 : f32
      %24 = arith.mulf %cst_5, %23 : f32
      %25 = math.cos %24 : f32
      %26 = math.sin %24 : f32
      %27 = arith.mulf %in, %25 : f32
      %28 = arith.mulf %in, %26 : f32
      %29 = arith.addf %out, %27 : f32
      %30 = arith.subf %out_6, %28 : f32
      linalg.yield %29, %30 : f32, f32
    } -> (tensor<5x4x5xf32>, tensor<5x4x5xf32>)
    return %8#0, %8#1 : tensor<5x4x5xf32>, tensor<5x4x5xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d3, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2)>
module {
  func.func @test_dynamic_rfft2d(%arg0: tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %c2 = arith.constant 2 : index
    %dim_1 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %c1_2 = arith.constant 1 : index
    %c2_3 = arith.constant 2 : index
    %0 = arith.divui %dim_1, %c2_3 : index
    %1 = arith.addi %0, %c1_2 : index
    %2 = tensor.empty(%dim, %dim_0, %1) : tensor<?x?x?xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %4 = tensor.empty(%dim, %dim_0, %1) : tensor<?x?x?xf32>
    %cst_4 = arith.constant 0.000000e+00 : f32
    %5 = linalg.fill ins(%cst_4 : f32) outs(%4 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %c1_5 = arith.constant 1 : index
    %dim_6 = tensor.dim %arg0, %c1_5 : tensor<?x?x?xf32>
    %c2_7 = arith.constant 2 : index
    %dim_8 = tensor.dim %arg0, %c2_7 : tensor<?x?x?xf32>
    %cst_9 = arith.constant 6.28318548 : f32
    %6 = arith.index_castui %dim_6 : index to i32
    %7 = arith.uitofp %6 : i32 to f32
    %8 = arith.index_castui %dim_8 : index to i32
    %9 = arith.uitofp %8 : i32 to f32
    %10:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel", "reduction", "reduction"]} ins(%arg0 : tensor<?x?x?xf32>) outs(%3, %5 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %out: f32, %out_10: f32):
      %11 = linalg.index 1 : index
      %12 = linalg.index 2 : index
      %13 = linalg.index 3 : index
      %14 = linalg.index 4 : index
      %15 = index.mul %13, %11
      %16 = index.mul %14, %12
      %17 = index.remu %15, %dim_6
      %18 = index.remu %16, %dim_8
      %19 = arith.index_castui %17 : index to i32
      %20 = arith.uitofp %19 : i32 to f32
      %21 = arith.index_castui %18 : index to i32
      %22 = arith.uitofp %21 : i32 to f32
      %23 = arith.divf %20, %7 : f32
      %24 = arith.divf %22, %9 : f32
      %25 = arith.addf %23, %24 : f32
      %26 = arith.mulf %cst_9, %25 : f32
      %27 = math.cos %26 : f32
      %28 = math.sin %26 : f32
      %29 = arith.mulf %in, %27 : f32
      %30 = arith.mulf %in, %28 : f32
      %31 = arith.addf %out, %29 : f32
      %32 = arith.subf %out_10, %30 : f32
      linalg.yield %31, %32 : f32, f32
    } -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>)
    return %10#0, %10#1 : tensor<?x?x?xf32>, tensor<?x?x?xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d3, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2)>
module {
  func.func @test_static_fft2d(%arg0: tensor<8x8x8xf32>, %arg1: tensor<8x8x8xf32>) -> (tensor<8x8x8xf32>, tensor<8x8x8xf32>) {
    %0 = tensor.empty() : tensor<8x8x8xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<8x8x8xf32>) -> tensor<8x8x8xf32>
    %2 = tensor.empty() : tensor<8x8x8xf32>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %3 = linalg.fill ins(%cst_0 : f32) outs(%2 : tensor<8x8x8xf32>) -> tensor<8x8x8xf32>
    %c1 = arith.constant 1 : index
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c8_1 = arith.constant 8 : index
    %cst_2 = arith.constant 6.28318548 : f32
    %4 = arith.index_castui %c8 : index to i32
    %5 = arith.uitofp %4 : i32 to f32
    %6 = arith.index_castui %c8_1 : index to i32
    %7 = arith.uitofp %6 : i32 to f32
    %8:2 = linalg.generic {indexing_maps = [#map, #map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel", "reduction", "reduction"]} ins(%arg0, %arg1 : tensor<8x8x8xf32>, tensor<8x8x8xf32>) outs(%1, %3 : tensor<8x8x8xf32>, tensor<8x8x8xf32>) {
    ^bb0(%in: f32, %in_3: f32, %out: f32, %out_4: f32):
      %9 = linalg.index 1 : index
      %10 = linalg.index 2 : index
      %11 = linalg.index 3 : index
      %12 = linalg.index 4 : index
      %13 = index.mul %11, %9
      %14 = index.mul %12, %10
      %15 = index.remu %13, %c8
      %16 = index.remu %14, %c8_1
      %17 = arith.index_castui %15 : index to i32
      %18 = arith.uitofp %17 : i32 to f32
      %19 = arith.index_castui %16 : index to i32
      %20 = arith.uitofp %19 : i32 to f32
      %21 = arith.divf %18, %5 : f32
      %22 = arith.divf %20, %7 : f32
      %23 = arith.addf %21, %22 : f32
      %24 = arith.mulf %cst_2, %23 : f32
      %25 = math.cos %24 : f32
      %26 = math.sin %24 : f32
      %27 = arith.mulf %in, %25 : f32
      %28 = arith.mulf %in_3, %26 : f32
      %29 = arith.addf %27, %28 : f32
      %30 = arith.mulf %in_3, %25 : f32
      %31 = arith.mulf %in, %26 : f32
      %32 = arith.subf %30, %31 : f32
      %33 = arith.addf %out, %29 : f32
      %34 = arith.addf %out_4, %32 : f32
      linalg.yield %33, %34 : f32, f32
    } -> (tensor<8x8x8xf32>, tensor<8x8x8xf32>)
    return %8#0, %8#1 : tensor<8x8x8xf32>, tensor<8x8x8xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d3, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2)>
module {
  func.func @test_dynamic_fft2d(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %c2 = arith.constant 2 : index
    %dim_1 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %0 = tensor.empty(%dim, %dim_0, %dim_1) : tensor<?x?x?xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %2 = tensor.empty(%dim, %dim_0, %dim_1) : tensor<?x?x?xf32>
    %cst_2 = arith.constant 0.000000e+00 : f32
    %3 = linalg.fill ins(%cst_2 : f32) outs(%2 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %c1_3 = arith.constant 1 : index
    %dim_4 = tensor.dim %arg0, %c1_3 : tensor<?x?x?xf32>
    %c2_5 = arith.constant 2 : index
    %dim_6 = tensor.dim %arg0, %c2_5 : tensor<?x?x?xf32>
    %cst_7 = arith.constant 6.28318548 : f32
    %4 = arith.index_castui %dim_4 : index to i32
    %5 = arith.uitofp %4 : i32 to f32
    %6 = arith.index_castui %dim_6 : index to i32
    %7 = arith.uitofp %6 : i32 to f32
    %8:2 = linalg.generic {indexing_maps = [#map, #map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel", "reduction", "reduction"]} ins(%arg0, %arg1 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%1, %3 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_8: f32, %out: f32, %out_9: f32):
      %9 = linalg.index 1 : index
      %10 = linalg.index 2 : index
      %11 = linalg.index 3 : index
      %12 = linalg.index 4 : index
      %13 = index.mul %11, %9
      %14 = index.mul %12, %10
      %15 = index.remu %13, %dim_4
      %16 = index.remu %14, %dim_6
      %17 = arith.index_castui %15 : index to i32
      %18 = arith.uitofp %17 : i32 to f32
      %19 = arith.index_castui %16 : index to i32
      %20 = arith.uitofp %19 : i32 to f32
      %21 = arith.divf %18, %5 : f32
      %22 = arith.divf %20, %7 : f32
      %23 = arith.addf %21, %22 : f32
      %24 = arith.mulf %cst_7, %23 : f32
      %cst_10 = arith.constant -1.000000e+00 : f32
      %25 = arith.mulf %24, %cst_10 : f32
      %26 = math.cos %25 : f32
      %27 = math.sin %25 : f32
      %28 = arith.mulf %in, %26 : f32
      %29 = arith.mulf %in_8, %27 : f32
      %30 = arith.addf %28, %29 : f32
      %31 = arith.mulf %in_8, %26 : f32
      %32 = arith.mulf %in, %27 : f32
      %33 = arith.subf %31, %32 : f32
      %34 = arith.addf %out, %30 : f32
      %35 = arith.addf %out_9, %33 : f32
      linalg.yield %34, %35 : f32, f32
    } -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>)
    return %8#0, %8#1 : tensor<?x?x?xf32>, tensor<?x?x?xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @test_cast_fp32_i64(%arg0: tensor<1xf32>) -> tensor<1xi64> {
    %0 = tensor.empty() : tensor<1xi64>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<1xf32>) outs(%0 : tensor<1xi64>) {
    ^bb0(%in: f32, %out: i64):
      %2 = math.roundeven %in : f32
      %cst = arith.constant -9.22337203E+18 : f32
      %cst_0 = arith.constant 9.22337203E+18 : f32
      %c9223372036854775807_i64 = arith.constant 9223372036854775807 : i64
      %3 = arith.maximumf %2, %cst : f32
      %4 = arith.fptosi %3 : f32 to i64
      %5 = arith.cmpf uge, %2, %cst_0 : f32
      %6 = arith.select %5, %c9223372036854775807_i64, %4 : i64
      linalg.yield %6 : i64
    } -> tensor<1xi64>
    return %1 : tensor<1xi64>
  }
}

// -----
module {
  func.func @reduce_min_nan_propagate(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>) {
    %0 = tensor.empty() : tensor<4xf32>
    %cst = arith.constant 3.40282347E+38 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<4xf32>) -> tensor<4xf32>
    %reduced = linalg.reduce ins(%arg0 : tensor<5x4xf32>) outs(%1 : tensor<4xf32>) dimensions = [0] 
      (%in: f32, %init: f32) {
        %2 = arith.minimumf %in, %init : f32
        linalg.yield %2 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [1, 4] : tensor<4xf32> into tensor<1x4xf32>
    return
  }
}

// -----
module {
  func.func @reduce_max_nan_propagate(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>) {
    %0 = tensor.empty() : tensor<4xf32>
    %cst = arith.constant -3.40282347E+38 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<4xf32>) -> tensor<4xf32>
    %reduced = linalg.reduce ins(%arg0 : tensor<5x4xf32>) outs(%1 : tensor<4xf32>) dimensions = [0] 
      (%in: f32, %init: f32) {
        %2 = arith.maximumf %in, %init : f32
        linalg.yield %2 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [1, 4] : tensor<4xf32> into tensor<1x4xf32>
    return
  }
}

// -----
module {
  func.func @reduce_min_nan_ignore_int(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>) {
    %0 = tensor.empty() : tensor<4xi8>
    %c127_i8 = arith.constant 127 : i8
    %1 = linalg.fill ins(%c127_i8 : i8) outs(%0 : tensor<4xi8>) -> tensor<4xi8>
    %reduced = linalg.reduce ins(%arg0 : tensor<5x4xi8>) outs(%1 : tensor<4xi8>) dimensions = [0] 
      (%in: i8, %init: i8) {
        %2 = arith.minsi %in, %init : i8
        linalg.yield %2 : i8
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [1, 4] : tensor<4xi8> into tensor<1x4xi8>
    return
  }
}

// -----
module {
  func.func @reduce_max_nan_ignore_int(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>) {
    %0 = tensor.empty() : tensor<4xi8>
    %c-128_i8 = arith.constant -128 : i8
    %1 = linalg.fill ins(%c-128_i8 : i8) outs(%0 : tensor<4xi8>) -> tensor<4xi8>
    %reduced = linalg.reduce ins(%arg0 : tensor<5x4xi8>) outs(%1 : tensor<4xi8>) dimensions = [0] 
      (%in: i8, %init: i8) {
        %2 = arith.maxsi %in, %init : i8
        linalg.yield %2 : i8
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [1, 4] : tensor<4xi8> into tensor<1x4xi8>
    return
  }
}

// -----
module {
  func.func @reduce_min_nan_ignore(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>) {
    %0 = tensor.empty() : tensor<4xf32>
    %cst = arith.constant 3.40282347E+38 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<4xf32>) -> tensor<4xf32>
    %true = arith.constant true
    %2 = tensor.empty() : tensor<4xi1>
    %3 = linalg.fill ins(%true : i1) outs(%2 : tensor<4xi1>) -> tensor<4xi1>
    %reduced:2 = linalg.reduce ins(%arg0, %arg0 : tensor<5x4xf32>, tensor<5x4xf32>) outs(%1, %3 : tensor<4xf32>, tensor<4xi1>) dimensions = [0] 
      (%in: f32, %in_1: f32, %init: f32, %init_2: i1) {
        %8 = arith.minimumf %in, %init : f32
        %9 = arith.cmpf uno, %in, %in : f32
        %10 = arith.select %9, %init, %8 : f32
        %11 = arith.andi %init_2, %9 : i1
        linalg.yield %10, %11 : f32, i1
      }
    %cst_0 = arith.constant 0x7FC00000 : f32
    %4 = tensor.empty() : tensor<4xf32>
    %5 = linalg.fill ins(%cst_0 : f32) outs(%4 : tensor<4xf32>) -> tensor<4xf32>
    %6 = tensor.empty() : tensor<4xf32>
    %7 = linalg.select ins(%reduced#1, %5, %reduced#0 : tensor<4xi1>, tensor<4xf32>, tensor<4xf32>) outs(%6 : tensor<4xf32>) -> tensor<4xf32>
    %expanded = tensor.expand_shape %7 [[0, 1]] output_shape [1, 4] : tensor<4xf32> into tensor<1x4xf32>
    return
  }
}

// -----
module {
  func.func @reduce_max_nan_ignore(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>) {
    %0 = tensor.empty() : tensor<4xf32>
    %cst = arith.constant -3.40282347E+38 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<4xf32>) -> tensor<4xf32>
    %true = arith.constant true
    %2 = tensor.empty() : tensor<4xi1>
    %3 = linalg.fill ins(%true : i1) outs(%2 : tensor<4xi1>) -> tensor<4xi1>
    %reduced:2 = linalg.reduce ins(%arg0, %arg0 : tensor<5x4xf32>, tensor<5x4xf32>) outs(%1, %3 : tensor<4xf32>, tensor<4xi1>) dimensions = [0] 
      (%in: f32, %in_1: f32, %init: f32, %init_2: i1) {
        %8 = arith.maximumf %in, %init : f32
        %9 = arith.cmpf uno, %in, %in : f32
        %10 = arith.select %9, %init, %8 : f32
        %11 = arith.andi %init_2, %9 : i1
        linalg.yield %10, %11 : f32, i1
      }
    %cst_0 = arith.constant 0x7FC00000 : f32
    %4 = tensor.empty() : tensor<4xf32>
    %5 = linalg.fill ins(%cst_0 : f32) outs(%4 : tensor<4xf32>) -> tensor<4xf32>
    %6 = tensor.empty() : tensor<4xf32>
    %7 = linalg.select ins(%reduced#1, %5, %reduced#0 : tensor<4xi1>, tensor<4xf32>, tensor<4xf32>) outs(%6 : tensor<4xf32>) -> tensor<4xf32>
    %expanded = tensor.expand_shape %7 [[0, 1]] output_shape [1, 4] : tensor<4xf32> into tensor<1x4xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @minimum_nan_propagate(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>) {
    %0 = tensor.empty() : tensor<5x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<5x4xf32>, tensor<5x4xf32>) outs(%0 : tensor<5x4xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.minimumf %in, %in_0 : f32
      linalg.yield %2 : f32
    } -> tensor<5x4xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @maximum_nan_propagate(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>) {
    %0 = tensor.empty() : tensor<5x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<5x4xf32>, tensor<5x4xf32>) outs(%0 : tensor<5x4xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.maximumf %in, %in_0 : f32
      linalg.yield %2 : f32
    } -> tensor<5x4xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @minimum_nan_ignore_int(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>) {
    %0 = tensor.empty() : tensor<5x4xi8>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<5x4xi8>, tensor<5x4xi8>) outs(%0 : tensor<5x4xi8>) {
    ^bb0(%in: i8, %in_0: i8, %out: i8):
      %2 = arith.minsi %in, %in_0 : i8
      linalg.yield %2 : i8
    } -> tensor<5x4xi8>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @maximum_nan_ignore_int(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>) {
    %0 = tensor.empty() : tensor<5x4xi8>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<5x4xi8>, tensor<5x4xi8>) outs(%0 : tensor<5x4xi8>) {
    ^bb0(%in: i8, %in_0: i8, %out: i8):
      %2 = arith.maxsi %in, %in_0 : i8
      linalg.yield %2 : i8
    } -> tensor<5x4xi8>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @minimum_nan_ignore(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>) {
    %0 = tensor.empty() : tensor<5x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<5x4xf32>, tensor<5x4xf32>) outs(%0 : tensor<5x4xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.minimumf %in, %in_0 : f32
      %3 = arith.cmpf uno, %in, %in : f32
      %4 = arith.cmpf uno, %in_0, %in_0 : f32
      %5 = arith.select %3, %in_0, %2 : f32
      %6 = arith.select %4, %in, %5 : f32
      linalg.yield %6 : f32
    } -> tensor<5x4xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @maximum_nan_ignore(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>) {
    %0 = tensor.empty() : tensor<5x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<5x4xf32>, tensor<5x4xf32>) outs(%0 : tensor<5x4xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.maximumf %in, %in_0 : f32
      %3 = arith.cmpf uno, %in, %in : f32
      %4 = arith.cmpf uno, %in_0, %in_0 : f32
      %5 = arith.select %3, %in_0, %2 : f32
      %6 = arith.select %4, %in, %5 : f32
      linalg.yield %6 : f32
    } -> tensor<5x4xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
module {
  func.func @argmax_nan_propagate(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>) {
    %0 = tensor.empty() : tensor<4xi32>
    %c0_i32 = arith.constant 0 : i32
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%0 : tensor<4xi32>) -> tensor<4xi32>
    %2 = tensor.empty() : tensor<4xf32>
    %cst = arith.constant -3.40282347E+38 : f32
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<4xf32>) -> tensor<4xf32>
    %4:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["reduction", "parallel"]} ins(%arg0 : tensor<5x4xf32>) outs(%1, %3 : tensor<4xi32>, tensor<4xf32>) {
    ^bb0(%in: f32, %out: i32, %out_0: f32):
      %5 = linalg.index 0 : index
      %6 = arith.index_cast %5 : index to i32
      %7 = arith.cmpf ugt, %in, %out_0 : f32
      %8 = arith.cmpf ord, %out_0, %out_0 : f32
      %9 = arith.andi %7, %8 : i1
      %10 = arith.select %9, %in, %out_0 : f32
      %11 = arith.select %9, %6, %out : i32
      linalg.yield %11, %10 : i32, f32
    } -> (tensor<4xi32>, tensor<4xf32>)
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
module {
  func.func @argmax_nan_ignore_int(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>) {
    %0 = tensor.empty() : tensor<4xi32>
    %c0_i32 = arith.constant 0 : i32
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%0 : tensor<4xi32>) -> tensor<4xi32>
    %2 = tensor.empty() : tensor<4xi8>
    %c-128_i8 = arith.constant -128 : i8
    %3 = linalg.fill ins(%c-128_i8 : i8) outs(%2 : tensor<4xi8>) -> tensor<4xi8>
    %4:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["reduction", "parallel"]} ins(%arg0 : tensor<5x4xi8>) outs(%1, %3 : tensor<4xi32>, tensor<4xi8>) {
    ^bb0(%in: i8, %out: i32, %out_0: i8):
      %5 = linalg.index 0 : index
      %6 = arith.index_cast %5 : index to i32
      %7 = arith.cmpi sgt, %in, %out_0 : i8
      %8 = arith.select %7, %in, %out_0 : i8
      %9 = arith.select %7, %6, %out : i32
      linalg.yield %9, %8 : i32, i8
    } -> (tensor<4xi32>, tensor<4xi8>)
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
module {
  func.func @argmax_nan_ignore(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>) {
    %0 = tensor.empty() : tensor<4xi32>
    %c0_i32 = arith.constant 0 : i32
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%0 : tensor<4xi32>) -> tensor<4xi32>
    %2 = tensor.empty() : tensor<4xf32>
    %cst = arith.constant -3.40282347E+38 : f32
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<4xf32>) -> tensor<4xf32>
    %4:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["reduction", "parallel"]} ins(%arg0 : tensor<5x4xf32>) outs(%1, %3 : tensor<4xi32>, tensor<4xf32>) {
    ^bb0(%in: f32, %out: i32, %out_0: f32):
      %5 = linalg.index 0 : index
      %6 = arith.index_cast %5 : index to i32
      %7 = arith.cmpf ogt, %in, %out_0 : f32
      %8 = arith.select %7, %in, %out_0 : f32
      %9 = arith.select %7, %6, %out : i32
      linalg.yield %9, %8 : i32, f32
    } -> (tensor<4xi32>, tensor<4xf32>)
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @clamp_nan_propagate(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>) {
    %0 = tensor.empty() : tensor<5x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<5x4xf32>) outs(%0 : tensor<5x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      %cst = arith.constant 1.000000e+00 : f32
      %cst_0 = arith.constant 5.000000e+00 : f32
      %2 = arith.minimumf %in, %cst_0 : f32
      %3 = arith.maximumf %2, %cst : f32
      linalg.yield %3 : f32
    } -> tensor<5x4xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @clamp_nan_ignore_int(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>) {
    %0 = tensor.empty() : tensor<5x4xi8>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<5x4xi8>) outs(%0 : tensor<5x4xi8>) {
    ^bb0(%in: i8, %out: i8):
      %c1_i8 = arith.constant 1 : i8
      %c5_i8 = arith.constant 5 : i8
      %2 = arith.maxsi %c1_i8, %in : i8
      %3 = arith.minsi %c5_i8, %2 : i8
      linalg.yield %3 : i8
    } -> tensor<5x4xi8>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @clamp_nan_ignore(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>) {
    %0 = tensor.empty() : tensor<5x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<5x4xf32>) outs(%0 : tensor<5x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      %cst = arith.constant 1.000000e+00 : f32
      %cst_0 = arith.constant 5.000000e+00 : f32
      %2 = arith.minimumf %in, %cst_0 : f32
      %3 = arith.maximumf %2, %cst : f32
      %4 = arith.cmpf uno, %in, %in : f32
      %5 = arith.select %4, %cst, %3 : f32
      linalg.yield %5 : f32
    } -> tensor<5x4xf32>
    return
  }
}

// -----
#map = affine_map<() -> ()>
module {
  func.func @test_0d_input(%arg0: tensor<i32>) {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = tensor.empty() : tensor<i32>
    %2 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = []} ins(%arg0, %arg0 : tensor<i32>, tensor<i32>) outs(%1 : tensor<i32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %7 = arith.muli %in, %in_0 : i32
      linalg.yield %7 : i32
    } -> tensor<i32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = tensor.empty() : tensor<i32>
    %6 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%arg0 : tensor<i32>) outs(%5 : tensor<i32>) {
    ^bb0(%in: i32, %out: i32):
      %c0_i64 = arith.constant 0 : i64
      %7 = arith.extsi %in : i32 to i64
      %8 = arith.subi %c0_i64, %7 : i64
      %c-2147483648_i64 = arith.constant -2147483648 : i64
      %c2147483647_i64 = arith.constant 2147483647 : i64
      %9 = arith.maxsi %c-2147483648_i64, %8 : i64
      %10 = arith.minsi %c2147483647_i64, %9 : i64
      %11 = arith.trunci %10 : i64 to i32
      linalg.yield %11 : i32
    } -> tensor<i32>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (0)>
module {
  func.func @mul_no_const_shift(%arg0: tensor<2x3xi32>, %arg1: tensor<2x3xi32>, %arg2: tensor<1xi8>) -> tensor<2x3xi32> {
    %0 = tensor.empty() : tensor<2x3xi32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1, %arg2 : tensor<2x3xi32>, tensor<2x3xi32>, tensor<1xi8>) outs(%0 : tensor<2x3xi32>) {
    ^bb0(%in: i32, %in_0: i32, %in_1: i8, %out: i32):
      %2 = tosa.apply_scale %in, %in_0, %in_1 {rounding_mode = SINGLE_ROUND} : (i32, i32, i8) -> i32
      linalg.yield %2 : i32
    } -> tensor<2x3xi32>
    return %1 : tensor<2x3xi32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (0)>
module {
  func.func @negate_i64_no_noop_cast(%arg0: tensor<4xi64>, %arg1: tensor<1xi64>, %arg2: tensor<1xi64>) -> tensor<4xi64> {
    %0 = tensor.empty() : tensor<4xi64>
    %1 = linalg.generic {indexing_maps = [#map, #map1, #map1, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1, %arg2 : tensor<4xi64>, tensor<1xi64>, tensor<1xi64>) outs(%0 : tensor<4xi64>) {
    ^bb0(%in: i64, %in_0: i64, %in_1: i64, %out: i64):
      %2 = arith.addi %in_0, %in_1 : i64
      %3 = arith.subi %2, %in : i64
      %c-9223372036854775808_i64 = arith.constant -9223372036854775808 : i64
      %c9223372036854775807_i64 = arith.constant 9223372036854775807 : i64
      %4 = arith.maxsi %c-9223372036854775808_i64, %3 : i64
      %5 = arith.minsi %c9223372036854775807_i64, %4 : i64
      linalg.yield %5 : i64
    } -> tensor<4xi64>
    return %1 : tensor<4xi64>
  }
}


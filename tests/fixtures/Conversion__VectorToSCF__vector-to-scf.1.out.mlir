module {
  func.func @vector_transfer_ops_0d(%arg0: memref<f32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[], %cst : memref<f32>, vector<f32>
    vector.transfer_write %0, %arg0[] : vector<f32>, memref<f32>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0 + d1)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
module {
  func.func @materialize_read_1d() {
    %c7 = arith.constant 7 : index
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<7x42xf32>
    affine.for %arg0 = 0 to 7 step 4 {
      affine.for %arg1 = 0 to 42 step 4 {
        %0 = scf.for %arg2 = %c0 to %c4 step %c1 iter_args(%arg3 = %cst) -> (vector<4xf32>) {
          %7 = affine.apply #map(%arg0, %arg2)
          %8 = affine.apply #map(%arg0, %arg2)
          %9 = arith.cmpi slt, %8, %c7 : index
          %10 = scf.if %9 -> (vector<4xf32>) {
            %11 = memref.load %alloc[%7, %arg1] : memref<7x42xf32>
            %12 = vector.insert %11, %arg3 [%arg2] : f32 into vector<4xf32>
            scf.yield %12 : vector<4xf32>
          } else {
            scf.yield %arg3 : vector<4xf32>
          }
          scf.yield %10 : vector<4xf32>
        }
        %1 = affine.apply #map1(%arg1)
        %2 = scf.for %arg2 = %c0 to %c4 step %c1 iter_args(%arg3 = %cst) -> (vector<4xf32>) {
          %7 = affine.apply #map(%arg0, %arg2)
          %8 = affine.apply #map(%arg0, %arg2)
          %9 = arith.cmpi slt, %8, %c7 : index
          %10 = scf.if %9 -> (vector<4xf32>) {
            %11 = memref.load %alloc[%7, %1] : memref<7x42xf32>
            %12 = vector.insert %11, %arg3 [%arg2] : f32 into vector<4xf32>
            scf.yield %12 : vector<4xf32>
          } else {
            scf.yield %arg3 : vector<4xf32>
          }
          scf.yield %10 : vector<4xf32>
        }
        %3 = affine.apply #map2(%arg1)
        %4 = scf.for %arg2 = %c0 to %c4 step %c1 iter_args(%arg3 = %cst) -> (vector<4xf32>) {
          %7 = affine.apply #map(%arg0, %arg2)
          %8 = affine.apply #map(%arg0, %arg2)
          %9 = arith.cmpi slt, %8, %c7 : index
          %10 = scf.if %9 -> (vector<4xf32>) {
            %11 = memref.load %alloc[%7, %3] : memref<7x42xf32>
            %12 = vector.insert %11, %arg3 [%arg2] : f32 into vector<4xf32>
            scf.yield %12 : vector<4xf32>
          } else {
            scf.yield %arg3 : vector<4xf32>
          }
          scf.yield %10 : vector<4xf32>
        }
        %5 = affine.apply #map3(%arg1)
        %6 = scf.for %arg2 = %c0 to %c4 step %c1 iter_args(%arg3 = %cst) -> (vector<4xf32>) {
          %7 = affine.apply #map(%arg0, %arg2)
          %8 = affine.apply #map(%arg0, %arg2)
          %9 = arith.cmpi slt, %8, %c7 : index
          %10 = scf.if %9 -> (vector<4xf32>) {
            %11 = memref.load %alloc[%7, %5] : memref<7x42xf32>
            %12 = vector.insert %11, %arg3 [%arg2] : f32 into vector<4xf32>
            scf.yield %12 : vector<4xf32>
          } else {
            scf.yield %arg3 : vector<4xf32>
          }
          scf.yield %10 : vector<4xf32>
        }
        "dummy_use"(%0, %2, %4, %6) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> ()
      }
    }
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0 + d1)>
#map1 = affine_map<(d0, d1) -> (d0 + d1 + 1)>
module {
  func.func @materialize_read_1d_partially_specialized(%arg0: index, %arg1: index, %arg2: index) {
    %c42 = arith.constant 42 : index
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc(%arg0, %arg1, %arg2) : memref<7x?x?x42x?xf32>
    affine.for %arg3 = 0 to 7 {
      affine.for %arg4 = 0 to %arg0 {
        affine.for %arg5 = 0 to %arg1 {
          affine.for %arg6 = 0 to 42 step 2 {
            affine.for %arg7 = 0 to %arg2 {
              %0 = scf.for %arg8 = %c0 to %c4 step %c1 iter_args(%arg9 = %cst) -> (vector<4xf32>) {
                %2 = affine.apply #map(%arg6, %arg8)
                %3 = affine.apply #map(%arg6, %arg8)
                %4 = arith.cmpi slt, %3, %c42 : index
                %5 = scf.if %4 -> (vector<4xf32>) {
                  %6 = memref.load %alloc[%arg3, %arg4, %arg5, %2, %arg7] : memref<7x?x?x42x?xf32>
                  %7 = vector.insert %6, %arg9 [%arg8] : f32 into vector<4xf32>
                  scf.yield %7 : vector<4xf32>
                } else {
                  scf.yield %arg9 : vector<4xf32>
                }
                scf.yield %5 : vector<4xf32>
              }
              %1 = scf.for %arg8 = %c0 to %c4 step %c1 iter_args(%arg9 = %cst) -> (vector<4xf32>) {
                %2 = affine.apply #map1(%arg8, %arg6)
                %3 = affine.apply #map1(%arg8, %arg6)
                %4 = arith.cmpi slt, %3, %c42 : index
                %5 = scf.if %4 -> (vector<4xf32>) {
                  %6 = memref.load %alloc[%arg3, %arg4, %arg5, %2, %arg7] : memref<7x?x?x42x?xf32>
                  %7 = vector.insert %6, %arg9 [%arg8] : f32 into vector<4xf32>
                  scf.yield %7 : vector<4xf32>
                } else {
                  scf.yield %arg9 : vector<4xf32>
                }
                scf.yield %5 : vector<4xf32>
              }
              "dummy_use"(%0, %1) : (vector<4xf32>, vector<4xf32>) -> ()
            }
          }
        }
      }
    }
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0 + d1)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
module {
  func.func @materialize_read(%arg0: index, %arg1: index, %arg2: index, %arg3: index) {
    %cst = arith.constant dense<0.000000e+00> : vector<3xf32>
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant dense<0.000000e+00> : vector<5x4x3xf32>
    %alloc = memref.alloc(%arg0, %arg1, %arg2, %arg3) : memref<?x?x?x?xf32>
    affine.for %arg4 = 0 to %arg0 step 3 {
      affine.for %arg5 = 0 to %arg1 {
        affine.for %arg6 = 0 to %arg2 {
          affine.for %arg7 = 0 to %arg3 step 5 {
            %0 = arith.cmpi sgt, %arg3, %arg7 : index
            %1 = scf.if %0 -> (vector<5x4x3xf32>) {
              %14 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %22 = affine.apply #map(%arg4, %arg8)
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = arith.cmpi sgt, %arg0, %23 : index
                %25 = scf.if %24 -> (vector<3xf32>) {
                  %26 = memref.load %alloc[%22, %arg5, %arg6, %arg7] : memref<?x?x?x?xf32>
                  %27 = vector.insert %26, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %27 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %25 : vector<3xf32>
              }
              %15 = vector.insert %14, %cst_0 [0, 0] : vector<3xf32> into vector<5x4x3xf32>
              %16 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %22 = affine.apply #map(%arg4, %arg8)
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = arith.cmpi sgt, %arg0, %23 : index
                %25 = scf.if %24 -> (vector<3xf32>) {
                  %26 = memref.load %alloc[%22, %arg5, %arg6, %arg7] : memref<?x?x?x?xf32>
                  %27 = vector.insert %26, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %27 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %25 : vector<3xf32>
              }
              %17 = vector.insert %16, %15 [0, 1] : vector<3xf32> into vector<5x4x3xf32>
              %18 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %22 = affine.apply #map(%arg4, %arg8)
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = arith.cmpi sgt, %arg0, %23 : index
                %25 = scf.if %24 -> (vector<3xf32>) {
                  %26 = memref.load %alloc[%22, %arg5, %arg6, %arg7] : memref<?x?x?x?xf32>
                  %27 = vector.insert %26, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %27 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %25 : vector<3xf32>
              }
              %19 = vector.insert %18, %17 [0, 2] : vector<3xf32> into vector<5x4x3xf32>
              %20 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %22 = affine.apply #map(%arg4, %arg8)
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = arith.cmpi sgt, %arg0, %23 : index
                %25 = scf.if %24 -> (vector<3xf32>) {
                  %26 = memref.load %alloc[%22, %arg5, %arg6, %arg7] : memref<?x?x?x?xf32>
                  %27 = vector.insert %26, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %27 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %25 : vector<3xf32>
              }
              %21 = vector.insert %20, %19 [0, 3] : vector<3xf32> into vector<5x4x3xf32>
              scf.yield %21 : vector<5x4x3xf32>
            } else {
              scf.yield %cst_0 : vector<5x4x3xf32>
            }
            %2 = affine.apply #map1(%arg7)
            %3 = arith.cmpi sgt, %arg3, %2 : index
            %4 = scf.if %3 -> (vector<5x4x3xf32>) {
              %14 = affine.apply #map1(%arg7)
              %15 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %16 = vector.insert %15, %1 [1, 0] : vector<3xf32> into vector<5x4x3xf32>
              %17 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %18 = vector.insert %17, %16 [1, 1] : vector<3xf32> into vector<5x4x3xf32>
              %19 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %20 = vector.insert %19, %18 [1, 2] : vector<3xf32> into vector<5x4x3xf32>
              %21 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %22 = vector.insert %21, %20 [1, 3] : vector<3xf32> into vector<5x4x3xf32>
              scf.yield %22 : vector<5x4x3xf32>
            } else {
              scf.yield %1 : vector<5x4x3xf32>
            }
            %5 = affine.apply #map2(%arg7)
            %6 = arith.cmpi sgt, %arg3, %5 : index
            %7 = scf.if %6 -> (vector<5x4x3xf32>) {
              %14 = affine.apply #map2(%arg7)
              %15 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %16 = vector.insert %15, %4 [2, 0] : vector<3xf32> into vector<5x4x3xf32>
              %17 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %18 = vector.insert %17, %16 [2, 1] : vector<3xf32> into vector<5x4x3xf32>
              %19 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %20 = vector.insert %19, %18 [2, 2] : vector<3xf32> into vector<5x4x3xf32>
              %21 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %22 = vector.insert %21, %20 [2, 3] : vector<3xf32> into vector<5x4x3xf32>
              scf.yield %22 : vector<5x4x3xf32>
            } else {
              scf.yield %4 : vector<5x4x3xf32>
            }
            %8 = affine.apply #map3(%arg7)
            %9 = arith.cmpi sgt, %arg3, %8 : index
            %10 = scf.if %9 -> (vector<5x4x3xf32>) {
              %14 = affine.apply #map3(%arg7)
              %15 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %16 = vector.insert %15, %7 [3, 0] : vector<3xf32> into vector<5x4x3xf32>
              %17 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %18 = vector.insert %17, %16 [3, 1] : vector<3xf32> into vector<5x4x3xf32>
              %19 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %20 = vector.insert %19, %18 [3, 2] : vector<3xf32> into vector<5x4x3xf32>
              %21 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %22 = vector.insert %21, %20 [3, 3] : vector<3xf32> into vector<5x4x3xf32>
              scf.yield %22 : vector<5x4x3xf32>
            } else {
              scf.yield %7 : vector<5x4x3xf32>
            }
            %11 = affine.apply #map4(%arg7)
            %12 = arith.cmpi sgt, %arg3, %11 : index
            %13 = scf.if %12 -> (vector<5x4x3xf32>) {
              %14 = affine.apply #map4(%arg7)
              %15 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %16 = vector.insert %15, %10 [4, 0] : vector<3xf32> into vector<5x4x3xf32>
              %17 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %18 = vector.insert %17, %16 [4, 1] : vector<3xf32> into vector<5x4x3xf32>
              %19 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %20 = vector.insert %19, %18 [4, 2] : vector<3xf32> into vector<5x4x3xf32>
              %21 = scf.for %arg8 = %c0 to %c3 step %c1 iter_args(%arg9 = %cst) -> (vector<3xf32>) {
                %23 = affine.apply #map(%arg4, %arg8)
                %24 = affine.apply #map(%arg4, %arg8)
                %25 = arith.cmpi sgt, %arg0, %24 : index
                %26 = scf.if %25 -> (vector<3xf32>) {
                  %27 = memref.load %alloc[%23, %arg5, %arg6, %14] : memref<?x?x?x?xf32>
                  %28 = vector.insert %27, %arg9 [%arg8] : f32 into vector<3xf32>
                  scf.yield %28 : vector<3xf32>
                } else {
                  scf.yield %arg9 : vector<3xf32>
                }
                scf.yield %26 : vector<3xf32>
              }
              %22 = vector.insert %21, %20 [4, 3] : vector<3xf32> into vector<5x4x3xf32>
              scf.yield %22 : vector<5x4x3xf32>
            } else {
              scf.yield %10 : vector<5x4x3xf32>
            }
            "dummy_use"(%13) : (vector<5x4x3xf32>) -> ()
          }
        }
      }
    }
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0 + 1)>
#map1 = affine_map<(d0) -> (d0 + 2)>
#map2 = affine_map<(d0) -> (d0 + 3)>
module {
  func.func @materialize_write(%arg0: index, %arg1: index, %arg2: index, %arg3: index) {
    %cst = arith.constant dense<1.000000e+00> : vector<5xf32>
    %alloc = memref.alloc(%arg0, %arg1, %arg2, %arg3) : memref<?x?x?x?xf32>
    affine.for %arg4 = 0 to %arg0 step 3 {
      affine.for %arg5 = 0 to %arg1 step 4 {
        affine.for %arg6 = 0 to %arg2 {
          affine.for %arg7 = 0 to %arg3 step 5 {
            %0 = arith.cmpi sgt, %arg0, %arg4 : index
            scf.if %0 {
              %5 = arith.cmpi sgt, %arg1, %arg5 : index
              scf.if %5 {
                vector.transfer_write %cst, %alloc[%arg4, %arg5, %arg6, %arg7] : vector<5xf32>, memref<?x?x?x?xf32>
              } else {
              }
              %6 = affine.apply #map(%arg5)
              %7 = arith.cmpi sgt, %arg1, %6 : index
              scf.if %7 {
                %12 = affine.apply #map(%arg5)
                vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %arg7] : vector<5xf32>, memref<?x?x?x?xf32>
              } else {
              }
              %8 = affine.apply #map1(%arg5)
              %9 = arith.cmpi sgt, %arg1, %8 : index
              scf.if %9 {
                %12 = affine.apply #map1(%arg5)
                vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %arg7] : vector<5xf32>, memref<?x?x?x?xf32>
              } else {
              }
              %10 = affine.apply #map2(%arg5)
              %11 = arith.cmpi sgt, %arg1, %10 : index
              scf.if %11 {
                %12 = affine.apply #map2(%arg5)
                vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %arg7] : vector<5xf32>, memref<?x?x?x?xf32>
              } else {
              }
            } else {
            }
            %1 = affine.apply #map(%arg4)
            %2 = arith.cmpi sgt, %arg0, %1 : index
            scf.if %2 {
              %5 = affine.apply #map(%arg4)
              %6 = arith.cmpi sgt, %arg1, %arg5 : index
              scf.if %6 {
                vector.transfer_write %cst, %alloc[%5, %arg5, %arg6, %arg7] : vector<5xf32>, memref<?x?x?x?xf32>
              } else {
              }
              %7 = affine.apply #map(%arg5)
              %8 = arith.cmpi sgt, %arg1, %7 : index
              scf.if %8 {
                %13 = affine.apply #map(%arg5)
                vector.transfer_write %cst, %alloc[%5, %13, %arg6, %arg7] : vector<5xf32>, memref<?x?x?x?xf32>
              } else {
              }
              %9 = affine.apply #map1(%arg5)
              %10 = arith.cmpi sgt, %arg1, %9 : index
              scf.if %10 {
                %13 = affine.apply #map1(%arg5)
                vector.transfer_write %cst, %alloc[%5, %13, %arg6, %arg7] : vector<5xf32>, memref<?x?x?x?xf32>
              } else {
              }
              %11 = affine.apply #map2(%arg5)
              %12 = arith.cmpi sgt, %arg1, %11 : index
              scf.if %12 {
                %13 = affine.apply #map2(%arg5)
                vector.transfer_write %cst, %alloc[%5, %13, %arg6, %arg7] : vector<5xf32>, memref<?x?x?x?xf32>
              } else {
              }
            } else {
            }
            %3 = affine.apply #map1(%arg4)
            %4 = arith.cmpi sgt, %arg0, %3 : index
            scf.if %4 {
              %5 = affine.apply #map1(%arg4)
              %6 = arith.cmpi sgt, %arg1, %arg5 : index
              scf.if %6 {
                vector.transfer_write %cst, %alloc[%5, %arg5, %arg6, %arg7] : vector<5xf32>, memref<?x?x?x?xf32>
              } else {
              }
              %7 = affine.apply #map(%arg5)
              %8 = arith.cmpi sgt, %arg1, %7 : index
              scf.if %8 {
                %13 = affine.apply #map(%arg5)
                vector.transfer_write %cst, %alloc[%5, %13, %arg6, %arg7] : vector<5xf32>, memref<?x?x?x?xf32>
              } else {
              }
              %9 = affine.apply #map1(%arg5)
              %10 = arith.cmpi sgt, %arg1, %9 : index
              scf.if %10 {
                %13 = affine.apply #map1(%arg5)
                vector.transfer_write %cst, %alloc[%5, %13, %arg6, %arg7] : vector<5xf32>, memref<?x?x?x?xf32>
              } else {
              }
              %11 = affine.apply #map2(%arg5)
              %12 = arith.cmpi sgt, %arg1, %11 : index
              scf.if %12 {
                %13 = affine.apply #map2(%arg5)
                vector.transfer_write %cst, %alloc[%5, %13, %arg6, %arg7] : vector<5xf32>, memref<?x?x?x?xf32>
              } else {
              }
            } else {
            }
          }
        }
      }
    }
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 1)>
#map1 = affine_map<()[s0] -> (s0 + 2)>
module {
  func.func @transfer_read_progressive(%arg0: memref<?x?xf32>, %arg1: index) -> vector<3x15xf32> {
    %cst = arith.constant 7.000000e+00 : f32
    %cst_0 = arith.constant dense<7.000000e+00> : vector<3x15xf32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?xf32>
    %0 = arith.cmpi sgt, %dim, %arg1 : index
    %1 = scf.if %0 -> (vector<3x15xf32>) {
      %8 = vector.transfer_read %arg0[%arg1, %arg1], %cst : memref<?x?xf32>, vector<15xf32>
      %9 = vector.insert %8, %cst_0 [0] : vector<15xf32> into vector<3x15xf32>
      scf.yield %9 : vector<3x15xf32>
    } else {
      scf.yield %cst_0 : vector<3x15xf32>
    }
    %dim_1 = memref.dim %arg0, %c0 : memref<?x?xf32>
    %2 = affine.apply #map()[%arg1]
    %3 = arith.cmpi sgt, %dim_1, %2 : index
    %4 = scf.if %3 -> (vector<3x15xf32>) {
      %8 = affine.apply #map()[%arg1]
      %9 = vector.transfer_read %arg0[%8, %arg1], %cst : memref<?x?xf32>, vector<15xf32>
      %10 = vector.insert %9, %1 [1] : vector<15xf32> into vector<3x15xf32>
      scf.yield %10 : vector<3x15xf32>
    } else {
      scf.yield %1 : vector<3x15xf32>
    }
    %dim_2 = memref.dim %arg0, %c0 : memref<?x?xf32>
    %5 = affine.apply #map1()[%arg1]
    %6 = arith.cmpi sgt, %dim_2, %5 : index
    %7 = scf.if %6 -> (vector<3x15xf32>) {
      %8 = affine.apply #map1()[%arg1]
      %9 = vector.transfer_read %arg0[%8, %arg1], %cst : memref<?x?xf32>, vector<15xf32>
      %10 = vector.insert %9, %4 [2] : vector<15xf32> into vector<3x15xf32>
      scf.yield %10 : vector<3x15xf32>
    } else {
      scf.yield %4 : vector<3x15xf32>
    }
    return %7 : vector<3x15xf32>
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 1)>
#map1 = affine_map<()[s0] -> (s0 + 2)>
module {
  func.func @transfer_write_progressive(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>) {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?xf32>
    %0 = arith.cmpi sgt, %dim, %arg1 : index
    scf.if %0 {
      %5 = vector.extract %arg2[0] : vector<15xf32> from vector<3x15xf32>
      vector.transfer_write %5, %arg0[%arg1, %arg1] : vector<15xf32>, memref<?x?xf32>
    } else {
    }
    %dim_0 = memref.dim %arg0, %c0 : memref<?x?xf32>
    %1 = affine.apply #map()[%arg1]
    %2 = arith.cmpi sgt, %dim_0, %1 : index
    scf.if %2 {
      %5 = affine.apply #map()[%arg1]
      %6 = vector.extract %arg2[1] : vector<15xf32> from vector<3x15xf32>
      vector.transfer_write %6, %arg0[%5, %arg1] : vector<15xf32>, memref<?x?xf32>
    } else {
    }
    %dim_1 = memref.dim %arg0, %c0 : memref<?x?xf32>
    %3 = affine.apply #map1()[%arg1]
    %4 = arith.cmpi sgt, %dim_1, %3 : index
    scf.if %4 {
      %5 = affine.apply #map1()[%arg1]
      %6 = vector.extract %arg2[2] : vector<15xf32> from vector<3x15xf32>
      vector.transfer_write %6, %arg0[%5, %arg1] : vector<15xf32>, memref<?x?xf32>
    } else {
    }
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 1)>
#map1 = affine_map<()[s0] -> (s0 + 2)>
module {
  func.func @transfer_write_progressive_inbounds(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>) {
    %0 = vector.extract %arg2[0] : vector<15xf32> from vector<3x15xf32>
    vector.transfer_write %0, %arg0[%arg1, %arg1] {in_bounds = [true]} : vector<15xf32>, memref<?x?xf32>
    %1 = affine.apply #map()[%arg1]
    %2 = vector.extract %arg2[1] : vector<15xf32> from vector<3x15xf32>
    vector.transfer_write %2, %arg0[%1, %arg1] {in_bounds = [true]} : vector<15xf32>, memref<?x?xf32>
    %3 = affine.apply #map1()[%arg1]
    %4 = vector.extract %arg2[2] : vector<15xf32> from vector<3x15xf32>
    vector.transfer_write %4, %arg0[%3, %arg1] {in_bounds = [true]} : vector<15xf32>, memref<?x?xf32>
    return
  }
}

// -----
module {
  func.func @transfer_read_simple(%arg0: memref<2x2xf32>) -> vector<2x2xf32> {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant dense<0.000000e+00> : vector<2x2xf32>
    %0 = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [true]} : memref<2x2xf32>, vector<2xf32>
    %1 = vector.insert %0, %cst_0 [0] : vector<2xf32> into vector<2x2xf32>
    %2 = vector.transfer_read %arg0[%c1, %c0], %cst {in_bounds = [true]} : memref<2x2xf32>, vector<2xf32>
    %3 = vector.insert %2, %1 [1] : vector<2xf32> into vector<2x2xf32>
    return %3 : vector<2x2xf32>
  }
  func.func @transfer_read_minor_identity(%arg0: memref<?x?x?x?xf32>) -> vector<3x3xf32> {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant dense<0.000000e+00> : vector<3x3xf32>
    %c2 = arith.constant 2 : index
    %dim = memref.dim %arg0, %c2 : memref<?x?x?x?xf32>
    %0 = arith.cmpi sgt, %dim, %c0 : index
    %1 = scf.if %0 -> (vector<3x3xf32>) {
      %6 = vector.transfer_read %arg0[%c0, %c0, %c0, %c0], %cst : memref<?x?x?x?xf32>, vector<3xf32>
      %7 = vector.insert %6, %cst_0 [0] : vector<3xf32> into vector<3x3xf32>
      scf.yield %7 : vector<3x3xf32>
    } else {
      scf.yield %cst_0 : vector<3x3xf32>
    }
    %dim_1 = memref.dim %arg0, %c2 : memref<?x?x?x?xf32>
    %2 = arith.cmpi sgt, %dim_1, %c1 : index
    %3 = scf.if %2 -> (vector<3x3xf32>) {
      %6 = vector.transfer_read %arg0[%c0, %c0, %c1, %c0], %cst : memref<?x?x?x?xf32>, vector<3xf32>
      %7 = vector.insert %6, %1 [1] : vector<3xf32> into vector<3x3xf32>
      scf.yield %7 : vector<3x3xf32>
    } else {
      scf.yield %1 : vector<3x3xf32>
    }
    %dim_2 = memref.dim %arg0, %c2 : memref<?x?x?x?xf32>
    %4 = arith.cmpi sgt, %dim_2, %c2 : index
    %5 = scf.if %4 -> (vector<3x3xf32>) {
      %6 = vector.transfer_read %arg0[%c0, %c0, %c2, %c0], %cst : memref<?x?x?x?xf32>, vector<3xf32>
      %7 = vector.insert %6, %3 [2] : vector<3xf32> into vector<3x3xf32>
      scf.yield %7 : vector<3x3xf32>
    } else {
      scf.yield %3 : vector<3x3xf32>
    }
    return %5 : vector<3x3xf32>
  }
  func.func @transfer_write_minor_identity(%arg0: vector<3x3xf32>, %arg1: memref<?x?x?x?xf32>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %dim = memref.dim %arg1, %c2 : memref<?x?x?x?xf32>
    %0 = arith.cmpi sgt, %dim, %c0 : index
    scf.if %0 {
      %3 = vector.extract %arg0[0] : vector<3xf32> from vector<3x3xf32>
      vector.transfer_write %3, %arg1[%c0, %c0, %c0, %c0] : vector<3xf32>, memref<?x?x?x?xf32>
    } else {
    }
    %dim_0 = memref.dim %arg1, %c2 : memref<?x?x?x?xf32>
    %1 = arith.cmpi sgt, %dim_0, %c1 : index
    scf.if %1 {
      %3 = vector.extract %arg0[1] : vector<3xf32> from vector<3x3xf32>
      vector.transfer_write %3, %arg1[%c0, %c0, %c1, %c0] : vector<3xf32>, memref<?x?x?x?xf32>
    } else {
    }
    %dim_1 = memref.dim %arg1, %c2 : memref<?x?x?x?xf32>
    %2 = arith.cmpi sgt, %dim_1, %c2 : index
    scf.if %2 {
      %3 = vector.extract %arg0[2] : vector<3xf32> from vector<3x3xf32>
      vector.transfer_write %3, %arg1[%c0, %c0, %c2, %c0] : vector<3xf32>, memref<?x?x?x?xf32>
    } else {
    }
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0 + d1 * 8)>
module {
  func.func @transfer_read_strided(%arg0: memref<8x4xf32, #map>) -> vector<4xf32> {
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %0 = scf.for %arg1 = %c0 to %c4 step %c1 iter_args(%arg2 = %cst) -> (vector<4xf32>) {
      %1 = memref.load %arg0[%c0, %arg1] : memref<8x4xf32, #map>
      %2 = vector.insert %1, %arg2 [%arg1] : f32 into vector<4xf32>
      scf.yield %2 : vector<4xf32>
    }
    return %0 : vector<4xf32>
  }
  func.func @transfer_write_strided(%arg0: vector<4xf32>, %arg1: memref<8x4xf32, #map>) {
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    scf.for %arg2 = %c0 to %c4 step %c1 {
      %0 = vector.extract %arg0[%arg2] : f32 from vector<4xf32>
      memref.store %0, %arg1[%c0, %arg2] : memref<8x4xf32, #map>
    }
    return
  }
}

// -----
module {
  func.func private @fake_side_effecting_fun(vector<2x2xf32>)
  func.func @transfer_read_within_async_execute(%arg0: memref<2x2xf32>) -> !async.token {
    %c1 = arith.constant 1 : index
    %cst = arith.constant dense<0.000000e+00> : vector<2x2xf32>
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant 0.000000e+00 : f32
    %token = async.execute {
      %0 = vector.transfer_read %arg0[%c0, %c0], %cst_0 {in_bounds = [true]} : memref<2x2xf32>, vector<2xf32>
      %1 = vector.insert %0, %cst [0] : vector<2xf32> into vector<2x2xf32>
      %2 = vector.transfer_read %arg0[%c1, %c0], %cst_0 {in_bounds = [true]} : memref<2x2xf32>, vector<2xf32>
      %3 = vector.insert %2, %1 [1] : vector<2xf32> into vector<2x2xf32>
      func.call @fake_side_effecting_fun(%3) : (vector<2x2xf32>) -> ()
      async.yield
    }
    return %token : !async.token
  }
}

// -----
module {
  func.func @transfer_read_with_tensor(%arg0: tensor<f32>) -> vector<1xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[], %cst : tensor<f32>, vector<f32>
    %1 = vector.broadcast %0 : vector<f32> to vector<1xf32>
    return %1 : vector<1xf32>
  }
}

// -----
module {
  func.func @transfer_write_scalable(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: f32) {
    %c1 = arith.constant 1 : index
    %c16 = arith.constant 16 : index
    %0 = llvm.mlir.undef : vector<[16]xf32>
    %1 = llvm.mlir.undef : vector<[16]xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %3 = llvm.intr.stepvector : vector<[16]xi32>
    %4 = arith.index_cast %dim : index to i32
    %5 = llvm.insertelement %4, %1[%2 : i32] : vector<[16]xi32>
    %6 = llvm.shufflevector %5, %1 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[16]xi32> 
    %7 = arith.cmpi slt, %3, %6 : vector<[16]xi32>
    %8 = llvm.insertelement %arg1, %0[%2 : i32] : vector<[16]xf32>
    %9 = llvm.shufflevector %8, %0 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[16]xf32> 
    %vscale = vector.vscale
    %c16_vscale = arith.muli %vscale, %c16 : index
    scf.for %arg2 = %c0 to %c16_vscale step %c1 {
      %10 = vector.extract %7[%arg2] : i1 from vector<[16]xi1>
      scf.if %10 {
        %11 = vector.extract %9[%arg2] : f32 from vector<[16]xf32>
        memref.store %11, %arg0[%arg2] : memref<?xf32, strided<[?], offset: ?>>
      } else {
      }
    }
    return
  }
}

// -----
module {
  func.func @vector_print_vector_0d(%arg0: vector<f32>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    vector.print punctuation <open>
    scf.for %arg1 = %c0 to %c1 step %c1 {
      %0 = vector.extract %arg0[] : f32 from vector<f32>
      vector.print %0 : f32 punctuation <no_punctuation>
      %1 = arith.cmpi ult, %arg1, %c0 : index
      scf.if %1 {
        vector.print punctuation <comma>
      }
    }
    vector.print punctuation <close>
    vector.print
    return
  }
}

// -----
module {
  func.func @vector_print_vector(%arg0: vector<2x2xf32>) {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %0 = vector.shape_cast %arg0 : vector<2x2xf32> to vector<4xf32>
    vector.print punctuation <open>
    scf.for %arg1 = %c0 to %c2 step %c1 {
      vector.print punctuation <open>
      scf.for %arg2 = %c0 to %c2 step %c1 {
        %2 = arith.muli %arg1, %c2 : index
        %3 = arith.addi %arg2, %2 : index
        %4 = vector.extract %0[%3] : f32 from vector<4xf32>
        vector.print %4 : f32 punctuation <no_punctuation>
        %5 = arith.cmpi ult, %arg2, %c1 : index
        scf.if %5 {
          vector.print punctuation <comma>
        }
      }
      vector.print punctuation <close>
      %1 = arith.cmpi ult, %arg1, %c1 : index
      scf.if %1 {
        vector.print punctuation <comma>
      }
    }
    vector.print punctuation <close>
    vector.print
    return
  }
}

// -----
module {
  func.func @vector_print_scalable_vector(%arg0: vector<[4]xi32>) {
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %vscale = vector.vscale
    %c4_vscale = arith.muli %vscale, %c4 : index
    %0 = arith.subi %c4_vscale, %c1 : index
    vector.print punctuation <open>
    scf.for %arg1 = %c0 to %c4_vscale step %c1 {
      %1 = vector.extract %arg0[%arg1] : i32 from vector<[4]xi32>
      vector.print %1 : i32 punctuation <no_punctuation>
      %2 = arith.cmpi ult, %arg1, %0 : index
      scf.if %2 {
        vector.print punctuation <comma>
      }
    }
    vector.print punctuation <close>
    vector.print
    return
  }
}

// -----
module {
  func.func @transfer_read_array_of_scalable(%arg0: memref<3x?xf32>) -> vector<3x[4]xf32> {
    %c2 = arith.constant 2 : index
    %cst = arith.constant dense<0.000000e+00> : vector<3x[4]xf32>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst_0 = arith.constant 0.000000e+00 : f32
    %dim = memref.dim %arg0, %c1 : memref<3x?xf32>
    %0 = vector.create_mask %c1, %dim : vector<3x[4]xi1>
    %1 = vector.extract %0[0] : vector<[4]xi1> from vector<3x[4]xi1>
    %2 = vector.transfer_read %arg0[%c0, %c0], %cst_0, %1 {in_bounds = [true]} : memref<3x?xf32>, vector<[4]xf32>
    %3 = vector.insert %2, %cst [0] : vector<[4]xf32> into vector<3x[4]xf32>
    %4 = vector.extract %0[1] : vector<[4]xi1> from vector<3x[4]xi1>
    %5 = vector.transfer_read %arg0[%c1, %c0], %cst_0, %4 {in_bounds = [true]} : memref<3x?xf32>, vector<[4]xf32>
    %6 = vector.insert %5, %3 [1] : vector<[4]xf32> into vector<3x[4]xf32>
    %7 = vector.extract %0[2] : vector<[4]xi1> from vector<3x[4]xi1>
    %8 = vector.transfer_read %arg0[%c2, %c0], %cst_0, %7 {in_bounds = [true]} : memref<3x?xf32>, vector<[4]xf32>
    %9 = vector.insert %8, %6 [2] : vector<[4]xf32> into vector<3x[4]xf32>
    return %9 : vector<3x[4]xf32>
  }
}

// -----
module {
  func.func @transfer_write_array_of_scalable(%arg0: vector<3x[4]xf32>, %arg1: memref<3x?xf32>) {
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %dim = memref.dim %arg1, %c1 : memref<3x?xf32>
    %0 = vector.create_mask %c1, %dim : vector<3x[4]xi1>
    %1 = vector.extract %arg0[0] : vector<[4]xf32> from vector<3x[4]xf32>
    %2 = vector.extract %0[0] : vector<[4]xi1> from vector<3x[4]xi1>
    vector.transfer_write %1, %arg1[%c0, %c0], %2 {in_bounds = [true]} : vector<[4]xf32>, memref<3x?xf32>
    %3 = vector.extract %arg0[1] : vector<[4]xf32> from vector<3x[4]xf32>
    %4 = vector.extract %0[1] : vector<[4]xi1> from vector<3x[4]xi1>
    vector.transfer_write %3, %arg1[%c1, %c0], %4 {in_bounds = [true]} : vector<[4]xf32>, memref<3x?xf32>
    %5 = vector.extract %arg0[2] : vector<[4]xf32> from vector<3x[4]xf32>
    %6 = vector.extract %0[2] : vector<[4]xi1> from vector<3x[4]xi1>
    vector.transfer_write %5, %arg1[%c2, %c0], %6 {in_bounds = [true]} : vector<[4]xf32>, memref<3x?xf32>
    return
  }
}

// -----
module {
  func.func @cannot_lower_transfer_write_with_leading_scalable(%arg0: vector<[4]x4xf32>, %arg1: memref<?x4xf32>) {
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %dim = memref.dim %arg1, %c0 : memref<?x4xf32>
    %0 = vector.create_mask %dim, %c4 : vector<[4]x4xi1>
    vector.transfer_write %arg0, %arg1[%c0, %c0], %0 {in_bounds = [true, true]} : vector<[4]x4xf32>, memref<?x4xf32>
    return
  }
}

// -----
module {
  func.func @cannot_lower_transfer_read_with_leading_scalable(%arg0: memref<?x4xf32>) -> vector<[4]x4xf32> {
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %cst = arith.constant 0.000000e+00 : f32
    %dim = memref.dim %arg0, %c0 : memref<?x4xf32>
    %0 = vector.create_mask %dim, %c4 : vector<[4]x4xi1>
    %1 = vector.transfer_read %arg0[%c0, %c0], %cst, %0 {in_bounds = [true, true]} : memref<?x4xf32>, vector<[4]x4xf32>
    return %1 : vector<[4]x4xf32>
  }
  func.func @does_not_crash_on_unpack_one_dim(%arg0: memref<1x1x1x1xi32>, %arg1: vector<1x1xi1>) -> vector<1x1x1x1xi32> {
    %c0 = arith.constant 0 : index
    %c0_i32 = arith.constant 0 : i32
    %cst = arith.constant dense<0> : vector<1x1x1x1xi32>
    %0 = vector.extract %arg1[0] : vector<1xi1> from vector<1x1xi1>
    %1 = vector.transfer_read %arg0[%c0, %c0, %c0, %c0], %c0_i32, %0 {in_bounds = [true]} : memref<1x1x1x1xi32>, vector<1xi32>
    %2 = vector.insert %1, %cst [0, 0, 0] : vector<1xi32> into vector<1x1x1x1xi32>
    return %2 : vector<1x1x1x1xi32>
  }
  func.func @add_arrays_of_scalable_vectors(%arg0: memref<1x2x?xf32>, %arg1: memref<1x2x?xf32>) -> vector<1x2x[4]xf32> {
    %c1 = arith.constant 1 : index
    %cst = arith.constant dense<0.000000e+00> : vector<1x2x[4]xf32>
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %cst_0 = arith.constant 0.000000e+00 : f32
    %dim = memref.dim %arg0, %c2 : memref<1x2x?xf32>
    %0 = vector.create_mask %c2, %c2, %dim : vector<1x2x[4]xi1>
    %1 = vector.extract %0[0, 0] : vector<[4]xi1> from vector<1x2x[4]xi1>
    %2 = vector.transfer_read %arg0[%c0, %c0, %c0], %cst_0, %1 {in_bounds = [true]} : memref<1x2x?xf32>, vector<[4]xf32>
    %3 = vector.insert %2, %cst [0, 0] : vector<[4]xf32> into vector<1x2x[4]xf32>
    %4 = vector.extract %0[0, 1] : vector<[4]xi1> from vector<1x2x[4]xi1>
    %5 = vector.transfer_read %arg0[%c0, %c1, %c0], %cst_0, %4 {in_bounds = [true]} : memref<1x2x?xf32>, vector<[4]xf32>
    %6 = vector.insert %5, %3 [0, 1] : vector<[4]xf32> into vector<1x2x[4]xf32>
    return %6 : vector<1x2x[4]xf32>
  }
  func.func @cannot_fully_unroll_transfer_write_of_nd_scalable_vector(%arg0: vector<[4]x[4]xf32>, %arg1: memref<?x?xf32>) {
    %c0 = arith.constant 0 : index
    vector.transfer_write %arg0, %arg1[%c0, %c0] {in_bounds = [true, true]} : vector<[4]x[4]xf32>, memref<?x?xf32>
    return
  }
  func.func @unroll_transfer_write_target_rank_zero(%arg0: vector<2xi32>) {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<4xi32>
    vector.transfer_write %arg0, %alloc[%c0] {in_bounds = [true]} : vector<2xi32>, memref<4xi32>
    return
  }
}

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
module {
  func.func @scalable_transpose_store_unmasked(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index) {
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %0 = vector.extract %arg0[0] : vector<[4]xf32> from vector<4x[4]xf32>
    %1 = vector.extract %arg0[1] : vector<[4]xf32> from vector<4x[4]xf32>
    %2 = vector.extract %arg0[2] : vector<[4]xf32> from vector<4x[4]xf32>
    %3 = vector.extract %arg0[3] : vector<[4]xf32> from vector<4x[4]xf32>
    %vscale = vector.vscale
    %c4_vscale = arith.muli %vscale, %c4 : index
    scf.for %arg4 = %c0 to %c4_vscale step %c1 {
      %4 = affine.apply #map(%arg4)[%arg2]
      %5 = vector.extract %0[%arg4] : f32 from vector<[4]xf32>
      %6 = vector.extract %1[%arg4] : f32 from vector<[4]xf32>
      %7 = vector.extract %2[%arg4] : f32 from vector<[4]xf32>
      %8 = vector.extract %3[%arg4] : f32 from vector<[4]xf32>
      %9 = vector.from_elements %5, %6, %7, %8 : vector<4xf32>
      vector.transfer_write %9, %arg1[%4, %arg3] {in_bounds = [true]} : vector<4xf32>, memref<?x?xf32>
    }
    return
  }
}

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
module {
  func.func @scalable_transpose_store_dynamic_mask(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %0 = vector.extract %arg0[0] : vector<[4]xf32> from vector<4x[4]xf32>
    %1 = vector.extract %arg0[1] : vector<[4]xf32> from vector<4x[4]xf32>
    %2 = vector.extract %arg0[2] : vector<[4]xf32> from vector<4x[4]xf32>
    %3 = vector.extract %arg0[3] : vector<[4]xf32> from vector<4x[4]xf32>
    %4 = vector.create_mask %arg5 : vector<4xi1>
    scf.for %arg6 = %c0 to %arg4 step %c1 {
      %5 = affine.apply #map(%arg6)[%arg2]
      %6 = vector.extract %0[%arg6] : f32 from vector<[4]xf32>
      %7 = vector.extract %1[%arg6] : f32 from vector<[4]xf32>
      %8 = vector.extract %2[%arg6] : f32 from vector<[4]xf32>
      %9 = vector.extract %3[%arg6] : f32 from vector<[4]xf32>
      %10 = vector.from_elements %6, %7, %8, %9 : vector<4xf32>
      vector.transfer_write %10, %arg1[%5, %arg3], %4 {in_bounds = [true]} : vector<4xf32>, memref<?x?xf32>
    }
    return
  }
}

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
module {
  func.func @scalable_transpose_store_constant_mask(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index) {
    %c3 = arith.constant 3 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %vscale = vector.vscale
    %c4_vscale = arith.muli %vscale, %c4 : index
    %0 = vector.extract %arg0[0] : vector<[4]xf32> from vector<4x[4]xf32>
    %1 = vector.extract %arg0[1] : vector<[4]xf32> from vector<4x[4]xf32>
    %2 = vector.extract %arg0[2] : vector<[4]xf32> from vector<4x[4]xf32>
    %3 = vector.extract %arg0[3] : vector<[4]xf32> from vector<4x[4]xf32>
    %4 = vector.create_mask %c3 : vector<4xi1>
    scf.for %arg4 = %c0 to %c4_vscale step %c1 {
      %5 = affine.apply #map(%arg4)[%arg2]
      %6 = vector.extract %0[%arg4] : f32 from vector<[4]xf32>
      %7 = vector.extract %1[%arg4] : f32 from vector<[4]xf32>
      %8 = vector.extract %2[%arg4] : f32 from vector<[4]xf32>
      %9 = vector.extract %3[%arg4] : f32 from vector<[4]xf32>
      %10 = vector.from_elements %6, %7, %8, %9 : vector<4xf32>
      vector.transfer_write %10, %arg1[%5, %arg3], %4 {in_bounds = [true]} : vector<4xf32>, memref<?x?xf32>
    }
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 1)>
#map1 = affine_map<()[s0] -> (s0 + 2)>
#map2 = affine_map<()[s0] -> (s0 + 3)>
module {
  func.func @negative_scalable_transpose_store_0(%arg0: vector<[4]x4xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index) {
    %0 = vector.transpose %arg0, [1, 0] : vector<[4]x4xf32> to vector<4x[4]xf32>
    %1 = vector.extract %0[0] : vector<[4]xf32> from vector<4x[4]xf32>
    vector.transfer_write %1, %arg1[%arg2, %arg3] {in_bounds = [true]} : vector<[4]xf32>, memref<?x?xf32>
    %2 = affine.apply #map()[%arg2]
    %3 = vector.extract %0[1] : vector<[4]xf32> from vector<4x[4]xf32>
    vector.transfer_write %3, %arg1[%2, %arg3] {in_bounds = [true]} : vector<[4]xf32>, memref<?x?xf32>
    %4 = affine.apply #map1()[%arg2]
    %5 = vector.extract %0[2] : vector<[4]xf32> from vector<4x[4]xf32>
    vector.transfer_write %5, %arg1[%4, %arg3] {in_bounds = [true]} : vector<[4]xf32>, memref<?x?xf32>
    %6 = affine.apply #map2()[%arg2]
    %7 = vector.extract %0[3] : vector<[4]xf32> from vector<4x[4]xf32>
    vector.transfer_write %7, %arg1[%6, %arg3] {in_bounds = [true]} : vector<[4]xf32>, memref<?x?xf32>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 1)>
#map1 = affine_map<()[s0] -> (s0 + 2)>
#map2 = affine_map<()[s0] -> (s0 + 3)>
module {
  func.func @negative_scalable_transpose_store_1(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index) {
    %0 = vector.extract %arg0[0] : vector<[4]xf32> from vector<4x[4]xf32>
    vector.transfer_write %0, %arg1[%arg2, %arg3] {in_bounds = [true]} : vector<[4]xf32>, memref<?x?xf32>
    %1 = affine.apply #map()[%arg2]
    %2 = vector.extract %arg0[1] : vector<[4]xf32> from vector<4x[4]xf32>
    vector.transfer_write %2, %arg1[%1, %arg3] {in_bounds = [true]} : vector<[4]xf32>, memref<?x?xf32>
    %3 = affine.apply #map1()[%arg2]
    %4 = vector.extract %arg0[2] : vector<[4]xf32> from vector<4x[4]xf32>
    vector.transfer_write %4, %arg1[%3, %arg3] {in_bounds = [true]} : vector<[4]xf32>, memref<?x?xf32>
    %5 = affine.apply #map2()[%arg2]
    %6 = vector.extract %arg0[3] : vector<[4]xf32> from vector<4x[4]xf32>
    vector.transfer_write %6, %arg1[%5, %arg3] {in_bounds = [true]} : vector<[4]xf32>, memref<?x?xf32>
    return
  }
}

// -----
module {
  func.func @negative_scalable_transpose_store_2(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index) {
    %0 = vector.transpose %arg0, [1, 0] : vector<4x[4]xf32> to vector<[4]x4xf32>
    vector.transfer_write %0, %arg1[%arg2, %arg3] {in_bounds = [false, true]} : vector<[4]x4xf32>, memref<?x?xf32>
    return
  }
}

// -----
module {
  func.func @negative_scalable_transpose_store_3(%arg0: vector<[4]x4xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index) {
    vector.transfer_write %arg0, %arg1[%arg2, %arg3] {in_bounds = [true, true]} : vector<[4]x4xf32>, memref<?x?xf32>
    return
  }
}


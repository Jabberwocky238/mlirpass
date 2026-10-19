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
module {
  func.func @materialize_read(%arg0: index, %arg1: index, %arg2: index, %arg3: index) {
    %cst = arith.constant dense<0.000000e+00> : vector<3xf32>
    %c3 = arith.constant 3 : index
    %cst_0 = arith.constant dense<0.000000e+00> : vector<4x3xf32>
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %c5 = arith.constant 5 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc(%arg0, %arg1, %arg2, %arg3) : memref<?x?x?x?xf32>
    affine.for %arg4 = 0 to %arg0 step 3 {
      affine.for %arg5 = 0 to %arg1 {
        affine.for %arg6 = 0 to %arg2 {
          affine.for %arg7 = 0 to %arg3 step 5 {
            %alloca = memref.alloca() : memref<vector<5x4x3xf32>>
            %0 = vector.type_cast %alloca : memref<vector<5x4x3xf32>> to memref<5xvector<4x3xf32>>
            scf.for %arg8 = %c0 to %c5 step %c1 {
              %2 = affine.apply #map(%arg7, %arg8)
              %3 = arith.cmpi sgt, %arg3, %2 : index
              scf.if %3 {
                %4 = affine.apply #map(%arg7, %arg8)
                %5 = vector.type_cast %0 : memref<5xvector<4x3xf32>> to memref<5x4xvector<3xf32>>
                scf.for %arg9 = %c0 to %c4 step %c1 {
                  %6 = scf.for %arg10 = %c0 to %c3 step %c1 iter_args(%arg11 = %cst) -> (vector<3xf32>) {
                    %7 = affine.apply #map(%arg4, %arg10)
                    %8 = affine.apply #map(%arg4, %arg10)
                    %9 = arith.cmpi sgt, %arg0, %8 : index
                    %10 = scf.if %9 -> (vector<3xf32>) {
                      %11 = memref.load %alloc[%7, %arg5, %arg6, %4] : memref<?x?x?x?xf32>
                      %12 = vector.insert %11, %arg11 [%arg10] : f32 into vector<3xf32>
                      scf.yield %12 : vector<3xf32>
                    } else {
                      scf.yield %arg11 : vector<3xf32>
                    }
                    scf.yield %10 : vector<3xf32>
                  }
                  memref.store %6, %5[%arg8, %arg9] : memref<5x4xvector<3xf32>>
                }
              } else {
                memref.store %cst_0, %0[%arg8] : memref<5xvector<4x3xf32>>
              }
            }
            %1 = memref.load %alloca[] : memref<vector<5x4x3xf32>>
            "dummy_use"(%1) : (vector<5x4x3xf32>) -> ()
          }
        }
      }
    }
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0 + d1)>
module {
  func.func @materialize_write(%arg0: index, %arg1: index, %arg2: index, %arg3: index) {
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<1.000000e+00> : vector<3x4x1x5xf32>
    %alloc = memref.alloc(%arg0, %arg1, %arg2, %arg3) : memref<?x?x?x?xf32>
    affine.for %arg4 = 0 to %arg0 step 3 {
      affine.for %arg5 = 0 to %arg1 step 4 {
        affine.for %arg6 = 0 to %arg2 {
          affine.for %arg7 = 0 to %arg3 step 5 {
            %alloca = memref.alloca() : memref<vector<3x4x1x5xf32>>
            memref.store %cst, %alloca[] : memref<vector<3x4x1x5xf32>>
            %0 = vector.type_cast %alloca : memref<vector<3x4x1x5xf32>> to memref<3xvector<4x1x5xf32>>
            scf.for %arg8 = %c0 to %c3 step %c1 {
              %1 = affine.apply #map(%arg4, %arg8)
              %2 = arith.cmpi sgt, %arg0, %1 : index
              scf.if %2 {
                %3 = affine.apply #map(%arg4, %arg8)
                %4 = vector.type_cast %0 : memref<3xvector<4x1x5xf32>> to memref<3x4xvector<1x5xf32>>
                scf.for %arg9 = %c0 to %c4 step %c1 {
                  %5 = affine.apply #map(%arg5, %arg9)
                  %6 = arith.cmpi sgt, %arg1, %5 : index
                  scf.if %6 {
                    %7 = affine.apply #map(%arg5, %arg9)
                    %8 = vector.type_cast %4 : memref<3x4xvector<1x5xf32>> to memref<3x4x1xvector<5xf32>>
                    scf.for %arg10 = %c0 to %c1 step %c1 {
                      %9 = affine.apply #map(%arg6, %arg10)
                      %10 = memref.load %8[%arg8, %arg9, %arg10] : memref<3x4x1xvector<5xf32>>
                      vector.transfer_write %10, %alloc[%3, %7, %9, %arg7] : vector<5xf32>, memref<?x?x?x?xf32>
                    }
                  } else {
                  }
                }
              } else {
              }
            }
          }
        }
      }
    }
    return
  }
}

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
module {
  func.func @transfer_read_progressive(%arg0: memref<?x?xf32>, %arg1: index) -> vector<3x15xf32> {
    %cst = arith.constant dense<7.000000e+00> : vector<15xf32>
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant 7.000000e+00 : f32
    %alloca = memref.alloca() : memref<vector<3x15xf32>>
    %0 = vector.type_cast %alloca : memref<vector<3x15xf32>> to memref<3xvector<15xf32>>
    scf.for %arg2 = %c0 to %c3 step %c1 {
      %dim = memref.dim %arg0, %c0 : memref<?x?xf32>
      %2 = affine.apply #map(%arg2)[%arg1]
      %3 = arith.cmpi sgt, %dim, %2 : index
      scf.if %3 {
        %4 = affine.apply #map(%arg2)[%arg1]
        %5 = vector.transfer_read %arg0[%4, %arg1], %cst_0 : memref<?x?xf32>, vector<15xf32>
        memref.store %5, %0[%arg2] : memref<3xvector<15xf32>>
      } else {
        memref.store %cst, %0[%arg2] : memref<3xvector<15xf32>>
      }
    }
    %1 = memref.load %alloca[] : memref<vector<3x15xf32>>
    return %1 : vector<3x15xf32>
  }
}

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
module {
  func.func @transfer_write_progressive(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>) {
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<vector<3x15xf32>>
    memref.store %arg2, %alloca[] : memref<vector<3x15xf32>>
    %0 = vector.type_cast %alloca : memref<vector<3x15xf32>> to memref<3xvector<15xf32>>
    scf.for %arg3 = %c0 to %c3 step %c1 {
      %dim = memref.dim %arg0, %c0 : memref<?x?xf32>
      %1 = affine.apply #map(%arg3)[%arg1]
      %2 = arith.cmpi sgt, %dim, %1 : index
      scf.if %2 {
        %3 = affine.apply #map(%arg3)[%arg1]
        %4 = memref.load %0[%arg3] : memref<3xvector<15xf32>>
        vector.transfer_write %4, %arg0[%3, %arg1] : vector<15xf32>, memref<?x?xf32>
      } else {
      }
    }
    return
  }
}

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
module {
  func.func @transfer_write_progressive_inbounds(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>) {
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<vector<3x15xf32>>
    memref.store %arg2, %alloca[] : memref<vector<3x15xf32>>
    %0 = vector.type_cast %alloca : memref<vector<3x15xf32>> to memref<3xvector<15xf32>>
    scf.for %arg3 = %c0 to %c3 step %c1 {
      %1 = affine.apply #map(%arg3)[%arg1]
      %2 = memref.load %0[%arg3] : memref<3xvector<15xf32>>
      vector.transfer_write %2, %arg0[%1, %arg1] {in_bounds = [true]} : vector<15xf32>, memref<?x?xf32>
    }
    return
  }
}

// -----
module {
  func.func @transfer_read_simple(%arg0: memref<2x2xf32>) -> vector<2x2xf32> {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<vector<2x2xf32>>
    %0 = vector.type_cast %alloca : memref<vector<2x2xf32>> to memref<2xvector<2xf32>>
    scf.for %arg1 = %c0 to %c2 step %c1 {
      %2 = vector.transfer_read %arg0[%arg1, %c0], %cst {in_bounds = [true]} : memref<2x2xf32>, vector<2xf32>
      memref.store %2, %0[%arg1] : memref<2xvector<2xf32>>
    }
    %1 = memref.load %alloca[] : memref<vector<2x2xf32>>
    return %1 : vector<2x2xf32>
  }
  func.func @transfer_read_minor_identity(%arg0: memref<?x?x?x?xf32>) -> vector<3x3xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<3xf32>
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %cst_0 = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<vector<3x3xf32>>
    %0 = vector.type_cast %alloca : memref<vector<3x3xf32>> to memref<3xvector<3xf32>>
    scf.for %arg1 = %c0 to %c3 step %c1 {
      %dim = memref.dim %arg0, %c2 : memref<?x?x?x?xf32>
      %2 = arith.cmpi sgt, %dim, %arg1 : index
      scf.if %2 {
        %3 = vector.transfer_read %arg0[%c0, %c0, %arg1, %c0], %cst_0 : memref<?x?x?x?xf32>, vector<3xf32>
        memref.store %3, %0[%arg1] : memref<3xvector<3xf32>>
      } else {
        memref.store %cst, %0[%arg1] : memref<3xvector<3xf32>>
      }
    }
    %1 = memref.load %alloca[] : memref<vector<3x3xf32>>
    return %1 : vector<3x3xf32>
  }
  func.func @transfer_write_minor_identity(%arg0: vector<3x3xf32>, %arg1: memref<?x?x?x?xf32>) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<vector<3x3xf32>>
    memref.store %arg0, %alloca[] : memref<vector<3x3xf32>>
    %0 = vector.type_cast %alloca : memref<vector<3x3xf32>> to memref<3xvector<3xf32>>
    scf.for %arg2 = %c0 to %c3 step %c1 {
      %dim = memref.dim %arg1, %c2 : memref<?x?x?x?xf32>
      %1 = arith.cmpi sgt, %dim, %arg2 : index
      scf.if %1 {
        %2 = memref.load %0[%arg2] : memref<3xvector<3xf32>>
        vector.transfer_write %2, %arg1[%c0, %c0, %arg2, %c0] : vector<3xf32>, memref<?x?x?x?xf32>
      } else {
      }
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
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %token = async.execute {
      %alloca = memref.alloca() : memref<vector<2x2xf32>>
      %0 = vector.type_cast %alloca : memref<vector<2x2xf32>> to memref<2xvector<2xf32>>
      scf.for %arg1 = %c0 to %c2 step %c1 {
        %2 = vector.transfer_read %arg0[%arg1, %c0], %cst {in_bounds = [true]} : memref<2x2xf32>, vector<2xf32>
        memref.store %2, %0[%arg1] : memref<2xvector<2xf32>>
      }
      %1 = memref.load %alloca[] : memref<vector<2x2xf32>>
      func.call @fake_side_effecting_fun(%1) : (vector<2x2xf32>) -> ()
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
    %c3 = arith.constant 3 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<vector<3x[4]xf32>>
    %alloca_0 = memref.alloca() : memref<vector<3x[4]xi1>>
    %dim = memref.dim %arg0, %c1 : memref<3x?xf32>
    %0 = vector.create_mask %c1, %dim : vector<3x[4]xi1>
    memref.store %0, %alloca_0[] : memref<vector<3x[4]xi1>>
    %1 = vector.type_cast %alloca : memref<vector<3x[4]xf32>> to memref<3xvector<[4]xf32>>
    %2 = vector.type_cast %alloca_0 : memref<vector<3x[4]xi1>> to memref<3xvector<[4]xi1>>
    scf.for %arg1 = %c0 to %c3 step %c1 {
      %4 = memref.load %2[%arg1] : memref<3xvector<[4]xi1>>
      %5 = vector.transfer_read %arg0[%arg1, %c0], %cst, %4 {in_bounds = [true]} : memref<3x?xf32>, vector<[4]xf32>
      memref.store %5, %1[%arg1] : memref<3xvector<[4]xf32>>
    }
    %3 = memref.load %alloca[] : memref<vector<3x[4]xf32>>
    return %3 : vector<3x[4]xf32>
  }
}

// -----
module {
  func.func @transfer_write_array_of_scalable(%arg0: vector<3x[4]xf32>, %arg1: memref<3x?xf32>) {
    %c3 = arith.constant 3 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<vector<3x[4]xf32>>
    %alloca_0 = memref.alloca() : memref<vector<3x[4]xi1>>
    %dim = memref.dim %arg1, %c1 : memref<3x?xf32>
    %0 = vector.create_mask %c1, %dim : vector<3x[4]xi1>
    memref.store %0, %alloca_0[] : memref<vector<3x[4]xi1>>
    memref.store %arg0, %alloca[] : memref<vector<3x[4]xf32>>
    %1 = vector.type_cast %alloca : memref<vector<3x[4]xf32>> to memref<3xvector<[4]xf32>>
    %2 = vector.type_cast %alloca_0 : memref<vector<3x[4]xi1>> to memref<3xvector<[4]xi1>>
    scf.for %arg2 = %c0 to %c3 step %c1 {
      %3 = memref.load %1[%arg2] : memref<3xvector<[4]xf32>>
      %4 = memref.load %2[%arg2] : memref<3xvector<[4]xi1>>
      vector.transfer_write %3, %arg1[%arg2, %c0], %4 {in_bounds = [true]} : vector<[4]xf32>, memref<3x?xf32>
    }
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
    %c1 = arith.constant 1 : index
    %c0_i32 = arith.constant 0 : i32
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<vector<1x1x1x1xi32>>
    %alloca_0 = memref.alloca() : memref<vector<1x1xi1>>
    memref.store %arg1, %alloca_0[] : memref<vector<1x1xi1>>
    %0 = vector.type_cast %alloca : memref<vector<1x1x1x1xi32>> to memref<1xvector<1x1x1xi32>>
    %1 = vector.type_cast %alloca_0 : memref<vector<1x1xi1>> to memref<1xvector<1xi1>>
    scf.for %arg2 = %c0 to %c1 step %c1 {
      %3 = vector.type_cast %0 : memref<1xvector<1x1x1xi32>> to memref<1x1xvector<1x1xi32>>
      scf.for %arg3 = %c0 to %c1 step %c1 {
        %4 = vector.type_cast %3 : memref<1x1xvector<1x1xi32>> to memref<1x1x1xvector<1xi32>>
        scf.for %arg4 = %c0 to %c1 step %c1 {
          %5 = memref.load %1[%arg2] : memref<1xvector<1xi1>>
          %6 = vector.transfer_read %arg0[%arg2, %c0, %c0, %c0], %c0_i32, %5 {in_bounds = [true]} : memref<1x1x1x1xi32>, vector<1xi32>
          memref.store %6, %4[%arg2, %arg3, %arg4] : memref<1x1x1xvector<1xi32>>
        }
      }
    }
    %2 = memref.load %alloca[] : memref<vector<1x1x1x1xi32>>
    return %2 : vector<1x1x1x1xi32>
  }
  func.func @add_arrays_of_scalable_vectors(%arg0: memref<1x2x?xf32>, %arg1: memref<1x2x?xf32>) -> vector<1x2x[4]xf32> {
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<vector<1x2x[4]xf32>>
    %alloca_0 = memref.alloca() : memref<vector<1x2x[4]xi1>>
    %dim = memref.dim %arg0, %c2 : memref<1x2x?xf32>
    %0 = vector.create_mask %c2, %c2, %dim : vector<1x2x[4]xi1>
    memref.store %0, %alloca_0[] : memref<vector<1x2x[4]xi1>>
    %1 = vector.type_cast %alloca : memref<vector<1x2x[4]xf32>> to memref<1xvector<2x[4]xf32>>
    %2 = vector.type_cast %alloca_0 : memref<vector<1x2x[4]xi1>> to memref<1xvector<2x[4]xi1>>
    scf.for %arg2 = %c0 to %c1 step %c1 {
      %4 = vector.type_cast %1 : memref<1xvector<2x[4]xf32>> to memref<1x2xvector<[4]xf32>>
      %5 = vector.type_cast %2 : memref<1xvector<2x[4]xi1>> to memref<1x2xvector<[4]xi1>>
      scf.for %arg3 = %c0 to %c2 step %c1 {
        %6 = memref.load %5[%arg2, %arg3] : memref<1x2xvector<[4]xi1>>
        %7 = vector.transfer_read %arg0[%arg2, %arg3, %c0], %cst, %6 {in_bounds = [true]} : memref<1x2x?xf32>, vector<[4]xf32>
        memref.store %7, %4[%arg2, %arg3] : memref<1x2xvector<[4]xf32>>
      }
    }
    %3 = memref.load %alloca[] : memref<vector<1x2x[4]xf32>>
    return %3 : vector<1x2x[4]xf32>
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
module {
  func.func @scalable_transpose_store_unmasked(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index) {
    %0 = vector.transpose %arg0, [1, 0] : vector<4x[4]xf32> to vector<[4]x4xf32>
    vector.transfer_write %0, %arg1[%arg2, %arg3] {in_bounds = [true, true]} : vector<[4]x4xf32>, memref<?x?xf32>
    return
  }
}

// -----
module {
  func.func @scalable_transpose_store_dynamic_mask(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index) {
    %0 = vector.transpose %arg0, [1, 0] : vector<4x[4]xf32> to vector<[4]x4xf32>
    %1 = vector.create_mask %arg4, %arg5 : vector<[4]x4xi1>
    vector.transfer_write %0, %arg1[%arg2, %arg3], %1 {in_bounds = [true, true]} : vector<[4]x4xf32>, memref<?x?xf32>
    return
  }
}

// -----
module {
  func.func @scalable_transpose_store_constant_mask(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index) {
    %0 = vector.transpose %arg0, [1, 0] : vector<4x[4]xf32> to vector<[4]x4xf32>
    %1 = vector.constant_mask [4, 3] : vector<[4]x4xi1>
    vector.transfer_write %0, %arg1[%arg2, %arg3], %1 {in_bounds = [true, true]} : vector<[4]x4xf32>, memref<?x?xf32>
    return
  }
}

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
module {
  func.func @negative_scalable_transpose_store_0(%arg0: vector<[4]x4xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index) {
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<vector<4x[4]xf32>>
    %0 = vector.transpose %arg0, [1, 0] : vector<[4]x4xf32> to vector<4x[4]xf32>
    memref.store %0, %alloca[] : memref<vector<4x[4]xf32>>
    %1 = vector.type_cast %alloca : memref<vector<4x[4]xf32>> to memref<4xvector<[4]xf32>>
    scf.for %arg4 = %c0 to %c4 step %c1 {
      %2 = affine.apply #map(%arg4)[%arg2]
      %3 = memref.load %1[%arg4] : memref<4xvector<[4]xf32>>
      vector.transfer_write %3, %arg1[%2, %arg3] {in_bounds = [true]} : vector<[4]xf32>, memref<?x?xf32>
    }
    return
  }
}

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
module {
  func.func @negative_scalable_transpose_store_1(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index) {
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<vector<4x[4]xf32>>
    %0 = vector.transpose %arg0, [1, 0] : vector<4x[4]xf32> to vector<[4]x4xf32>
    %1 = vector.transpose %0, [1, 0] : vector<[4]x4xf32> to vector<4x[4]xf32>
    memref.store %1, %alloca[] : memref<vector<4x[4]xf32>>
    %2 = vector.type_cast %alloca : memref<vector<4x[4]xf32>> to memref<4xvector<[4]xf32>>
    scf.for %arg4 = %c0 to %c4 step %c1 {
      %3 = affine.apply #map(%arg4)[%arg2]
      %4 = memref.load %2[%arg4] : memref<4xvector<[4]xf32>>
      vector.transfer_write %4, %arg1[%3, %arg3] {in_bounds = [true]} : vector<[4]xf32>, memref<?x?xf32>
    }
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


module {
  func.func @vector_transfer_ops_0d(%arg0: memref<f32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[], %cst : memref<f32>, vector<f32>
    vector.transfer_write %0, %arg0[] : vector<f32>, memref<f32>
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0 + 1)>
#map1 = affine_map<(d0) -> (d0 + 2)>
#map2 = affine_map<(d0) -> (d0 + 3)>
module {
  func.func @materialize_read_1d() {
    %c7 = arith.constant 7 : index
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %alloc = memref.alloc() : memref<7x42xf32>
    affine.for %arg0 = 0 to 7 step 4 {
      affine.for %arg1 = 0 to 42 step 4 {
        %0 = arith.cmpi slt, %arg0, %c7 : index
        %1 = scf.if %0 -> (vector<4xf32>) {
          %47 = vector.transfer_read %alloc[%arg0, %arg1], %cst_0 : memref<7x42xf32>, vector<f32>
          %48 = vector.extract %47[] : f32 from vector<f32>
          %49 = vector.insert %48, %cst [0] : f32 into vector<4xf32>
          scf.yield %49 : vector<4xf32>
        } else {
          scf.yield %cst : vector<4xf32>
        }
        %2 = affine.apply #map(%arg0)
        %3 = arith.cmpi slt, %2, %c7 : index
        %4 = scf.if %3 -> (vector<4xf32>) {
          %47 = affine.apply #map(%arg0)
          %48 = vector.transfer_read %alloc[%47, %arg1], %cst_0 : memref<7x42xf32>, vector<f32>
          %49 = vector.extract %48[] : f32 from vector<f32>
          %50 = vector.insert %49, %1 [1] : f32 into vector<4xf32>
          scf.yield %50 : vector<4xf32>
        } else {
          scf.yield %1 : vector<4xf32>
        }
        %5 = affine.apply #map1(%arg0)
        %6 = arith.cmpi slt, %5, %c7 : index
        %7 = scf.if %6 -> (vector<4xf32>) {
          %47 = affine.apply #map1(%arg0)
          %48 = vector.transfer_read %alloc[%47, %arg1], %cst_0 : memref<7x42xf32>, vector<f32>
          %49 = vector.extract %48[] : f32 from vector<f32>
          %50 = vector.insert %49, %4 [2] : f32 into vector<4xf32>
          scf.yield %50 : vector<4xf32>
        } else {
          scf.yield %4 : vector<4xf32>
        }
        %8 = affine.apply #map2(%arg0)
        %9 = arith.cmpi slt, %8, %c7 : index
        %10 = scf.if %9 -> (vector<4xf32>) {
          %47 = affine.apply #map2(%arg0)
          %48 = vector.transfer_read %alloc[%47, %arg1], %cst_0 : memref<7x42xf32>, vector<f32>
          %49 = vector.extract %48[] : f32 from vector<f32>
          %50 = vector.insert %49, %7 [3] : f32 into vector<4xf32>
          scf.yield %50 : vector<4xf32>
        } else {
          scf.yield %7 : vector<4xf32>
        }
        %11 = affine.apply #map(%arg1)
        %12 = arith.cmpi slt, %arg0, %c7 : index
        %13 = scf.if %12 -> (vector<4xf32>) {
          %47 = vector.transfer_read %alloc[%arg0, %11], %cst_0 : memref<7x42xf32>, vector<f32>
          %48 = vector.extract %47[] : f32 from vector<f32>
          %49 = vector.insert %48, %cst [0] : f32 into vector<4xf32>
          scf.yield %49 : vector<4xf32>
        } else {
          scf.yield %cst : vector<4xf32>
        }
        %14 = affine.apply #map(%arg0)
        %15 = arith.cmpi slt, %14, %c7 : index
        %16 = scf.if %15 -> (vector<4xf32>) {
          %47 = affine.apply #map(%arg0)
          %48 = vector.transfer_read %alloc[%47, %11], %cst_0 : memref<7x42xf32>, vector<f32>
          %49 = vector.extract %48[] : f32 from vector<f32>
          %50 = vector.insert %49, %13 [1] : f32 into vector<4xf32>
          scf.yield %50 : vector<4xf32>
        } else {
          scf.yield %13 : vector<4xf32>
        }
        %17 = affine.apply #map1(%arg0)
        %18 = arith.cmpi slt, %17, %c7 : index
        %19 = scf.if %18 -> (vector<4xf32>) {
          %47 = affine.apply #map1(%arg0)
          %48 = vector.transfer_read %alloc[%47, %11], %cst_0 : memref<7x42xf32>, vector<f32>
          %49 = vector.extract %48[] : f32 from vector<f32>
          %50 = vector.insert %49, %16 [2] : f32 into vector<4xf32>
          scf.yield %50 : vector<4xf32>
        } else {
          scf.yield %16 : vector<4xf32>
        }
        %20 = affine.apply #map2(%arg0)
        %21 = arith.cmpi slt, %20, %c7 : index
        %22 = scf.if %21 -> (vector<4xf32>) {
          %47 = affine.apply #map2(%arg0)
          %48 = vector.transfer_read %alloc[%47, %11], %cst_0 : memref<7x42xf32>, vector<f32>
          %49 = vector.extract %48[] : f32 from vector<f32>
          %50 = vector.insert %49, %19 [3] : f32 into vector<4xf32>
          scf.yield %50 : vector<4xf32>
        } else {
          scf.yield %19 : vector<4xf32>
        }
        %23 = affine.apply #map1(%arg1)
        %24 = arith.cmpi slt, %arg0, %c7 : index
        %25 = scf.if %24 -> (vector<4xf32>) {
          %47 = vector.transfer_read %alloc[%arg0, %23], %cst_0 : memref<7x42xf32>, vector<f32>
          %48 = vector.extract %47[] : f32 from vector<f32>
          %49 = vector.insert %48, %cst [0] : f32 into vector<4xf32>
          scf.yield %49 : vector<4xf32>
        } else {
          scf.yield %cst : vector<4xf32>
        }
        %26 = affine.apply #map(%arg0)
        %27 = arith.cmpi slt, %26, %c7 : index
        %28 = scf.if %27 -> (vector<4xf32>) {
          %47 = affine.apply #map(%arg0)
          %48 = vector.transfer_read %alloc[%47, %23], %cst_0 : memref<7x42xf32>, vector<f32>
          %49 = vector.extract %48[] : f32 from vector<f32>
          %50 = vector.insert %49, %25 [1] : f32 into vector<4xf32>
          scf.yield %50 : vector<4xf32>
        } else {
          scf.yield %25 : vector<4xf32>
        }
        %29 = affine.apply #map1(%arg0)
        %30 = arith.cmpi slt, %29, %c7 : index
        %31 = scf.if %30 -> (vector<4xf32>) {
          %47 = affine.apply #map1(%arg0)
          %48 = vector.transfer_read %alloc[%47, %23], %cst_0 : memref<7x42xf32>, vector<f32>
          %49 = vector.extract %48[] : f32 from vector<f32>
          %50 = vector.insert %49, %28 [2] : f32 into vector<4xf32>
          scf.yield %50 : vector<4xf32>
        } else {
          scf.yield %28 : vector<4xf32>
        }
        %32 = affine.apply #map2(%arg0)
        %33 = arith.cmpi slt, %32, %c7 : index
        %34 = scf.if %33 -> (vector<4xf32>) {
          %47 = affine.apply #map2(%arg0)
          %48 = vector.transfer_read %alloc[%47, %23], %cst_0 : memref<7x42xf32>, vector<f32>
          %49 = vector.extract %48[] : f32 from vector<f32>
          %50 = vector.insert %49, %31 [3] : f32 into vector<4xf32>
          scf.yield %50 : vector<4xf32>
        } else {
          scf.yield %31 : vector<4xf32>
        }
        %35 = affine.apply #map2(%arg1)
        %36 = arith.cmpi slt, %arg0, %c7 : index
        %37 = scf.if %36 -> (vector<4xf32>) {
          %47 = vector.transfer_read %alloc[%arg0, %35], %cst_0 : memref<7x42xf32>, vector<f32>
          %48 = vector.extract %47[] : f32 from vector<f32>
          %49 = vector.insert %48, %cst [0] : f32 into vector<4xf32>
          scf.yield %49 : vector<4xf32>
        } else {
          scf.yield %cst : vector<4xf32>
        }
        %38 = affine.apply #map(%arg0)
        %39 = arith.cmpi slt, %38, %c7 : index
        %40 = scf.if %39 -> (vector<4xf32>) {
          %47 = affine.apply #map(%arg0)
          %48 = vector.transfer_read %alloc[%47, %35], %cst_0 : memref<7x42xf32>, vector<f32>
          %49 = vector.extract %48[] : f32 from vector<f32>
          %50 = vector.insert %49, %37 [1] : f32 into vector<4xf32>
          scf.yield %50 : vector<4xf32>
        } else {
          scf.yield %37 : vector<4xf32>
        }
        %41 = affine.apply #map1(%arg0)
        %42 = arith.cmpi slt, %41, %c7 : index
        %43 = scf.if %42 -> (vector<4xf32>) {
          %47 = affine.apply #map1(%arg0)
          %48 = vector.transfer_read %alloc[%47, %35], %cst_0 : memref<7x42xf32>, vector<f32>
          %49 = vector.extract %48[] : f32 from vector<f32>
          %50 = vector.insert %49, %40 [2] : f32 into vector<4xf32>
          scf.yield %50 : vector<4xf32>
        } else {
          scf.yield %40 : vector<4xf32>
        }
        %44 = affine.apply #map2(%arg0)
        %45 = arith.cmpi slt, %44, %c7 : index
        %46 = scf.if %45 -> (vector<4xf32>) {
          %47 = affine.apply #map2(%arg0)
          %48 = vector.transfer_read %alloc[%47, %35], %cst_0 : memref<7x42xf32>, vector<f32>
          %49 = vector.extract %48[] : f32 from vector<f32>
          %50 = vector.insert %49, %43 [3] : f32 into vector<4xf32>
          scf.yield %50 : vector<4xf32>
        } else {
          scf.yield %43 : vector<4xf32>
        }
        "dummy_use"(%10, %22, %34, %46) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> ()
      }
    }
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0 + 1)>
#map1 = affine_map<(d0) -> (d0 + 2)>
#map2 = affine_map<(d0) -> (d0 + 3)>
#map3 = affine_map<(d0) -> (d0 + 4)>
module {
  func.func @materialize_read_1d_partially_specialized(%arg0: index, %arg1: index, %arg2: index) {
    %c42 = arith.constant 42 : index
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %alloc = memref.alloc(%arg0, %arg1, %arg2) : memref<7x?x?x42x?xf32>
    affine.for %arg3 = 0 to 7 {
      affine.for %arg4 = 0 to %arg0 {
        affine.for %arg5 = 0 to %arg1 {
          affine.for %arg6 = 0 to 42 step 2 {
            affine.for %arg7 = 0 to %arg2 {
              %0 = arith.cmpi slt, %arg6, %c42 : index
              %1 = scf.if %0 -> (vector<4xf32>) {
                %23 = vector.transfer_read %alloc[%arg3, %arg4, %arg5, %arg6, %arg7], %cst_0 : memref<7x?x?x42x?xf32>, vector<f32>
                %24 = vector.extract %23[] : f32 from vector<f32>
                %25 = vector.insert %24, %cst [0] : f32 into vector<4xf32>
                scf.yield %25 : vector<4xf32>
              } else {
                scf.yield %cst : vector<4xf32>
              }
              %2 = affine.apply #map(%arg6)
              %3 = arith.cmpi slt, %2, %c42 : index
              %4 = scf.if %3 -> (vector<4xf32>) {
                %23 = affine.apply #map(%arg6)
                %24 = vector.transfer_read %alloc[%arg3, %arg4, %arg5, %23, %arg7], %cst_0 : memref<7x?x?x42x?xf32>, vector<f32>
                %25 = vector.extract %24[] : f32 from vector<f32>
                %26 = vector.insert %25, %1 [1] : f32 into vector<4xf32>
                scf.yield %26 : vector<4xf32>
              } else {
                scf.yield %1 : vector<4xf32>
              }
              %5 = affine.apply #map1(%arg6)
              %6 = arith.cmpi slt, %5, %c42 : index
              %7 = scf.if %6 -> (vector<4xf32>) {
                %23 = affine.apply #map1(%arg6)
                %24 = vector.transfer_read %alloc[%arg3, %arg4, %arg5, %23, %arg7], %cst_0 : memref<7x?x?x42x?xf32>, vector<f32>
                %25 = vector.extract %24[] : f32 from vector<f32>
                %26 = vector.insert %25, %4 [2] : f32 into vector<4xf32>
                scf.yield %26 : vector<4xf32>
              } else {
                scf.yield %4 : vector<4xf32>
              }
              %8 = affine.apply #map2(%arg6)
              %9 = arith.cmpi slt, %8, %c42 : index
              %10 = scf.if %9 -> (vector<4xf32>) {
                %23 = affine.apply #map2(%arg6)
                %24 = vector.transfer_read %alloc[%arg3, %arg4, %arg5, %23, %arg7], %cst_0 : memref<7x?x?x42x?xf32>, vector<f32>
                %25 = vector.extract %24[] : f32 from vector<f32>
                %26 = vector.insert %25, %7 [3] : f32 into vector<4xf32>
                scf.yield %26 : vector<4xf32>
              } else {
                scf.yield %7 : vector<4xf32>
              }
              %11 = affine.apply #map(%arg6)
              %12 = arith.cmpi slt, %11, %c42 : index
              %13 = scf.if %12 -> (vector<4xf32>) {
                %23 = affine.apply #map(%arg6)
                %24 = vector.transfer_read %alloc[%arg3, %arg4, %arg5, %23, %arg7], %cst_0 : memref<7x?x?x42x?xf32>, vector<f32>
                %25 = vector.extract %24[] : f32 from vector<f32>
                %26 = vector.insert %25, %cst [0] : f32 into vector<4xf32>
                scf.yield %26 : vector<4xf32>
              } else {
                scf.yield %cst : vector<4xf32>
              }
              %14 = affine.apply #map1(%arg6)
              %15 = arith.cmpi slt, %14, %c42 : index
              %16 = scf.if %15 -> (vector<4xf32>) {
                %23 = affine.apply #map1(%arg6)
                %24 = vector.transfer_read %alloc[%arg3, %arg4, %arg5, %23, %arg7], %cst_0 : memref<7x?x?x42x?xf32>, vector<f32>
                %25 = vector.extract %24[] : f32 from vector<f32>
                %26 = vector.insert %25, %13 [1] : f32 into vector<4xf32>
                scf.yield %26 : vector<4xf32>
              } else {
                scf.yield %13 : vector<4xf32>
              }
              %17 = affine.apply #map2(%arg6)
              %18 = arith.cmpi slt, %17, %c42 : index
              %19 = scf.if %18 -> (vector<4xf32>) {
                %23 = affine.apply #map2(%arg6)
                %24 = vector.transfer_read %alloc[%arg3, %arg4, %arg5, %23, %arg7], %cst_0 : memref<7x?x?x42x?xf32>, vector<f32>
                %25 = vector.extract %24[] : f32 from vector<f32>
                %26 = vector.insert %25, %16 [2] : f32 into vector<4xf32>
                scf.yield %26 : vector<4xf32>
              } else {
                scf.yield %16 : vector<4xf32>
              }
              %20 = affine.apply #map3(%arg6)
              %21 = arith.cmpi slt, %20, %c42 : index
              %22 = scf.if %21 -> (vector<4xf32>) {
                %23 = affine.apply #map3(%arg6)
                %24 = vector.transfer_read %alloc[%arg3, %arg4, %arg5, %23, %arg7], %cst_0 : memref<7x?x?x42x?xf32>, vector<f32>
                %25 = vector.extract %24[] : f32 from vector<f32>
                %26 = vector.insert %25, %19 [3] : f32 into vector<4xf32>
                scf.yield %26 : vector<4xf32>
              } else {
                scf.yield %19 : vector<4xf32>
              }
              "dummy_use"(%10, %22) : (vector<4xf32>, vector<4xf32>) -> ()
            }
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
#map3 = affine_map<(d0) -> (d0 + 4)>
module {
  func.func @materialize_read(%arg0: index, %arg1: index, %arg2: index, %arg3: index) {
    %cst = arith.constant dense<0.000000e+00> : vector<5x4x3xf32>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %alloc = memref.alloc(%arg0, %arg1, %arg2, %arg3) : memref<?x?x?x?xf32>
    affine.for %arg4 = 0 to %arg0 step 3 {
      affine.for %arg5 = 0 to %arg1 {
        affine.for %arg6 = 0 to %arg2 {
          affine.for %arg7 = 0 to %arg3 step 5 {
            %0 = arith.cmpi sgt, %arg3, %arg7 : index
            %1 = scf.if %0 -> (vector<5x4x3xf32>) {
              %14 = arith.cmpi sgt, %arg0, %arg4 : index
              %15 = scf.if %14 -> (vector<5x4x3xf32>) {
                %46 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %arg7], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %47 = vector.extract %46[] : f32 from vector<f32>
                %48 = vector.insert %47, %cst [0, 0, 0] : f32 into vector<5x4x3xf32>
                scf.yield %48 : vector<5x4x3xf32>
              } else {
                scf.yield %cst : vector<5x4x3xf32>
              }
              %16 = affine.apply #map(%arg4)
              %17 = arith.cmpi sgt, %arg0, %16 : index
              %18 = scf.if %17 -> (vector<5x4x3xf32>) {
                %46 = affine.apply #map(%arg4)
                %47 = vector.transfer_read %alloc[%46, %arg5, %arg6, %arg7], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %15 [0, 0, 1] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %15 : vector<5x4x3xf32>
              }
              %19 = affine.apply #map1(%arg4)
              %20 = arith.cmpi sgt, %arg0, %19 : index
              %21 = scf.if %20 -> (vector<5x4x3xf32>) {
                %46 = affine.apply #map1(%arg4)
                %47 = vector.transfer_read %alloc[%46, %arg5, %arg6, %arg7], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %18 [0, 0, 2] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %18 : vector<5x4x3xf32>
              }
              %22 = arith.cmpi sgt, %arg0, %arg4 : index
              %23 = scf.if %22 -> (vector<5x4x3xf32>) {
                %46 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %arg7], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %47 = vector.extract %46[] : f32 from vector<f32>
                %48 = vector.insert %47, %21 [0, 1, 0] : f32 into vector<5x4x3xf32>
                scf.yield %48 : vector<5x4x3xf32>
              } else {
                scf.yield %21 : vector<5x4x3xf32>
              }
              %24 = affine.apply #map(%arg4)
              %25 = arith.cmpi sgt, %arg0, %24 : index
              %26 = scf.if %25 -> (vector<5x4x3xf32>) {
                %46 = affine.apply #map(%arg4)
                %47 = vector.transfer_read %alloc[%46, %arg5, %arg6, %arg7], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %23 [0, 1, 1] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %23 : vector<5x4x3xf32>
              }
              %27 = affine.apply #map1(%arg4)
              %28 = arith.cmpi sgt, %arg0, %27 : index
              %29 = scf.if %28 -> (vector<5x4x3xf32>) {
                %46 = affine.apply #map1(%arg4)
                %47 = vector.transfer_read %alloc[%46, %arg5, %arg6, %arg7], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %26 [0, 1, 2] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %26 : vector<5x4x3xf32>
              }
              %30 = arith.cmpi sgt, %arg0, %arg4 : index
              %31 = scf.if %30 -> (vector<5x4x3xf32>) {
                %46 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %arg7], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %47 = vector.extract %46[] : f32 from vector<f32>
                %48 = vector.insert %47, %29 [0, 2, 0] : f32 into vector<5x4x3xf32>
                scf.yield %48 : vector<5x4x3xf32>
              } else {
                scf.yield %29 : vector<5x4x3xf32>
              }
              %32 = affine.apply #map(%arg4)
              %33 = arith.cmpi sgt, %arg0, %32 : index
              %34 = scf.if %33 -> (vector<5x4x3xf32>) {
                %46 = affine.apply #map(%arg4)
                %47 = vector.transfer_read %alloc[%46, %arg5, %arg6, %arg7], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %31 [0, 2, 1] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %31 : vector<5x4x3xf32>
              }
              %35 = affine.apply #map1(%arg4)
              %36 = arith.cmpi sgt, %arg0, %35 : index
              %37 = scf.if %36 -> (vector<5x4x3xf32>) {
                %46 = affine.apply #map1(%arg4)
                %47 = vector.transfer_read %alloc[%46, %arg5, %arg6, %arg7], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %34 [0, 2, 2] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %34 : vector<5x4x3xf32>
              }
              %38 = arith.cmpi sgt, %arg0, %arg4 : index
              %39 = scf.if %38 -> (vector<5x4x3xf32>) {
                %46 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %arg7], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %47 = vector.extract %46[] : f32 from vector<f32>
                %48 = vector.insert %47, %37 [0, 3, 0] : f32 into vector<5x4x3xf32>
                scf.yield %48 : vector<5x4x3xf32>
              } else {
                scf.yield %37 : vector<5x4x3xf32>
              }
              %40 = affine.apply #map(%arg4)
              %41 = arith.cmpi sgt, %arg0, %40 : index
              %42 = scf.if %41 -> (vector<5x4x3xf32>) {
                %46 = affine.apply #map(%arg4)
                %47 = vector.transfer_read %alloc[%46, %arg5, %arg6, %arg7], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %39 [0, 3, 1] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %39 : vector<5x4x3xf32>
              }
              %43 = affine.apply #map1(%arg4)
              %44 = arith.cmpi sgt, %arg0, %43 : index
              %45 = scf.if %44 -> (vector<5x4x3xf32>) {
                %46 = affine.apply #map1(%arg4)
                %47 = vector.transfer_read %alloc[%46, %arg5, %arg6, %arg7], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %42 [0, 3, 2] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %42 : vector<5x4x3xf32>
              }
              scf.yield %45 : vector<5x4x3xf32>
            } else {
              scf.yield %cst : vector<5x4x3xf32>
            }
            %2 = affine.apply #map(%arg7)
            %3 = arith.cmpi sgt, %arg3, %2 : index
            %4 = scf.if %3 -> (vector<5x4x3xf32>) {
              %14 = affine.apply #map(%arg7)
              %15 = arith.cmpi sgt, %arg0, %arg4 : index
              %16 = scf.if %15 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %1 [1, 0, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %1 : vector<5x4x3xf32>
              }
              %17 = affine.apply #map(%arg4)
              %18 = arith.cmpi sgt, %arg0, %17 : index
              %19 = scf.if %18 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %16 [1, 0, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %16 : vector<5x4x3xf32>
              }
              %20 = affine.apply #map1(%arg4)
              %21 = arith.cmpi sgt, %arg0, %20 : index
              %22 = scf.if %21 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %19 [1, 0, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %19 : vector<5x4x3xf32>
              }
              %23 = arith.cmpi sgt, %arg0, %arg4 : index
              %24 = scf.if %23 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %22 [1, 1, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %22 : vector<5x4x3xf32>
              }
              %25 = affine.apply #map(%arg4)
              %26 = arith.cmpi sgt, %arg0, %25 : index
              %27 = scf.if %26 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %24 [1, 1, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %24 : vector<5x4x3xf32>
              }
              %28 = affine.apply #map1(%arg4)
              %29 = arith.cmpi sgt, %arg0, %28 : index
              %30 = scf.if %29 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %27 [1, 1, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %27 : vector<5x4x3xf32>
              }
              %31 = arith.cmpi sgt, %arg0, %arg4 : index
              %32 = scf.if %31 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %30 [1, 2, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %30 : vector<5x4x3xf32>
              }
              %33 = affine.apply #map(%arg4)
              %34 = arith.cmpi sgt, %arg0, %33 : index
              %35 = scf.if %34 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %32 [1, 2, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %32 : vector<5x4x3xf32>
              }
              %36 = affine.apply #map1(%arg4)
              %37 = arith.cmpi sgt, %arg0, %36 : index
              %38 = scf.if %37 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %35 [1, 2, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %35 : vector<5x4x3xf32>
              }
              %39 = arith.cmpi sgt, %arg0, %arg4 : index
              %40 = scf.if %39 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %38 [1, 3, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %38 : vector<5x4x3xf32>
              }
              %41 = affine.apply #map(%arg4)
              %42 = arith.cmpi sgt, %arg0, %41 : index
              %43 = scf.if %42 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %40 [1, 3, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %40 : vector<5x4x3xf32>
              }
              %44 = affine.apply #map1(%arg4)
              %45 = arith.cmpi sgt, %arg0, %44 : index
              %46 = scf.if %45 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %43 [1, 3, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %43 : vector<5x4x3xf32>
              }
              scf.yield %46 : vector<5x4x3xf32>
            } else {
              scf.yield %1 : vector<5x4x3xf32>
            }
            %5 = affine.apply #map1(%arg7)
            %6 = arith.cmpi sgt, %arg3, %5 : index
            %7 = scf.if %6 -> (vector<5x4x3xf32>) {
              %14 = affine.apply #map1(%arg7)
              %15 = arith.cmpi sgt, %arg0, %arg4 : index
              %16 = scf.if %15 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %4 [2, 0, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %4 : vector<5x4x3xf32>
              }
              %17 = affine.apply #map(%arg4)
              %18 = arith.cmpi sgt, %arg0, %17 : index
              %19 = scf.if %18 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %16 [2, 0, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %16 : vector<5x4x3xf32>
              }
              %20 = affine.apply #map1(%arg4)
              %21 = arith.cmpi sgt, %arg0, %20 : index
              %22 = scf.if %21 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %19 [2, 0, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %19 : vector<5x4x3xf32>
              }
              %23 = arith.cmpi sgt, %arg0, %arg4 : index
              %24 = scf.if %23 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %22 [2, 1, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %22 : vector<5x4x3xf32>
              }
              %25 = affine.apply #map(%arg4)
              %26 = arith.cmpi sgt, %arg0, %25 : index
              %27 = scf.if %26 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %24 [2, 1, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %24 : vector<5x4x3xf32>
              }
              %28 = affine.apply #map1(%arg4)
              %29 = arith.cmpi sgt, %arg0, %28 : index
              %30 = scf.if %29 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %27 [2, 1, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %27 : vector<5x4x3xf32>
              }
              %31 = arith.cmpi sgt, %arg0, %arg4 : index
              %32 = scf.if %31 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %30 [2, 2, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %30 : vector<5x4x3xf32>
              }
              %33 = affine.apply #map(%arg4)
              %34 = arith.cmpi sgt, %arg0, %33 : index
              %35 = scf.if %34 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %32 [2, 2, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %32 : vector<5x4x3xf32>
              }
              %36 = affine.apply #map1(%arg4)
              %37 = arith.cmpi sgt, %arg0, %36 : index
              %38 = scf.if %37 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %35 [2, 2, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %35 : vector<5x4x3xf32>
              }
              %39 = arith.cmpi sgt, %arg0, %arg4 : index
              %40 = scf.if %39 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %38 [2, 3, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %38 : vector<5x4x3xf32>
              }
              %41 = affine.apply #map(%arg4)
              %42 = arith.cmpi sgt, %arg0, %41 : index
              %43 = scf.if %42 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %40 [2, 3, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %40 : vector<5x4x3xf32>
              }
              %44 = affine.apply #map1(%arg4)
              %45 = arith.cmpi sgt, %arg0, %44 : index
              %46 = scf.if %45 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %43 [2, 3, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %43 : vector<5x4x3xf32>
              }
              scf.yield %46 : vector<5x4x3xf32>
            } else {
              scf.yield %4 : vector<5x4x3xf32>
            }
            %8 = affine.apply #map2(%arg7)
            %9 = arith.cmpi sgt, %arg3, %8 : index
            %10 = scf.if %9 -> (vector<5x4x3xf32>) {
              %14 = affine.apply #map2(%arg7)
              %15 = arith.cmpi sgt, %arg0, %arg4 : index
              %16 = scf.if %15 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %7 [3, 0, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %7 : vector<5x4x3xf32>
              }
              %17 = affine.apply #map(%arg4)
              %18 = arith.cmpi sgt, %arg0, %17 : index
              %19 = scf.if %18 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %16 [3, 0, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %16 : vector<5x4x3xf32>
              }
              %20 = affine.apply #map1(%arg4)
              %21 = arith.cmpi sgt, %arg0, %20 : index
              %22 = scf.if %21 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %19 [3, 0, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %19 : vector<5x4x3xf32>
              }
              %23 = arith.cmpi sgt, %arg0, %arg4 : index
              %24 = scf.if %23 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %22 [3, 1, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %22 : vector<5x4x3xf32>
              }
              %25 = affine.apply #map(%arg4)
              %26 = arith.cmpi sgt, %arg0, %25 : index
              %27 = scf.if %26 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %24 [3, 1, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %24 : vector<5x4x3xf32>
              }
              %28 = affine.apply #map1(%arg4)
              %29 = arith.cmpi sgt, %arg0, %28 : index
              %30 = scf.if %29 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %27 [3, 1, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %27 : vector<5x4x3xf32>
              }
              %31 = arith.cmpi sgt, %arg0, %arg4 : index
              %32 = scf.if %31 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %30 [3, 2, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %30 : vector<5x4x3xf32>
              }
              %33 = affine.apply #map(%arg4)
              %34 = arith.cmpi sgt, %arg0, %33 : index
              %35 = scf.if %34 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %32 [3, 2, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %32 : vector<5x4x3xf32>
              }
              %36 = affine.apply #map1(%arg4)
              %37 = arith.cmpi sgt, %arg0, %36 : index
              %38 = scf.if %37 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %35 [3, 2, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %35 : vector<5x4x3xf32>
              }
              %39 = arith.cmpi sgt, %arg0, %arg4 : index
              %40 = scf.if %39 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %38 [3, 3, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %38 : vector<5x4x3xf32>
              }
              %41 = affine.apply #map(%arg4)
              %42 = arith.cmpi sgt, %arg0, %41 : index
              %43 = scf.if %42 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %40 [3, 3, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %40 : vector<5x4x3xf32>
              }
              %44 = affine.apply #map1(%arg4)
              %45 = arith.cmpi sgt, %arg0, %44 : index
              %46 = scf.if %45 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %43 [3, 3, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %43 : vector<5x4x3xf32>
              }
              scf.yield %46 : vector<5x4x3xf32>
            } else {
              scf.yield %7 : vector<5x4x3xf32>
            }
            %11 = affine.apply #map3(%arg7)
            %12 = arith.cmpi sgt, %arg3, %11 : index
            %13 = scf.if %12 -> (vector<5x4x3xf32>) {
              %14 = affine.apply #map3(%arg7)
              %15 = arith.cmpi sgt, %arg0, %arg4 : index
              %16 = scf.if %15 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %10 [4, 0, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %10 : vector<5x4x3xf32>
              }
              %17 = affine.apply #map(%arg4)
              %18 = arith.cmpi sgt, %arg0, %17 : index
              %19 = scf.if %18 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %16 [4, 0, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %16 : vector<5x4x3xf32>
              }
              %20 = affine.apply #map1(%arg4)
              %21 = arith.cmpi sgt, %arg0, %20 : index
              %22 = scf.if %21 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %19 [4, 0, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %19 : vector<5x4x3xf32>
              }
              %23 = arith.cmpi sgt, %arg0, %arg4 : index
              %24 = scf.if %23 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %22 [4, 1, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %22 : vector<5x4x3xf32>
              }
              %25 = affine.apply #map(%arg4)
              %26 = arith.cmpi sgt, %arg0, %25 : index
              %27 = scf.if %26 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %24 [4, 1, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %24 : vector<5x4x3xf32>
              }
              %28 = affine.apply #map1(%arg4)
              %29 = arith.cmpi sgt, %arg0, %28 : index
              %30 = scf.if %29 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %27 [4, 1, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %27 : vector<5x4x3xf32>
              }
              %31 = arith.cmpi sgt, %arg0, %arg4 : index
              %32 = scf.if %31 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %30 [4, 2, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %30 : vector<5x4x3xf32>
              }
              %33 = affine.apply #map(%arg4)
              %34 = arith.cmpi sgt, %arg0, %33 : index
              %35 = scf.if %34 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %32 [4, 2, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %32 : vector<5x4x3xf32>
              }
              %36 = affine.apply #map1(%arg4)
              %37 = arith.cmpi sgt, %arg0, %36 : index
              %38 = scf.if %37 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %35 [4, 2, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %35 : vector<5x4x3xf32>
              }
              %39 = arith.cmpi sgt, %arg0, %arg4 : index
              %40 = scf.if %39 -> (vector<5x4x3xf32>) {
                %47 = vector.transfer_read %alloc[%arg4, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %48 = vector.extract %47[] : f32 from vector<f32>
                %49 = vector.insert %48, %38 [4, 3, 0] : f32 into vector<5x4x3xf32>
                scf.yield %49 : vector<5x4x3xf32>
              } else {
                scf.yield %38 : vector<5x4x3xf32>
              }
              %41 = affine.apply #map(%arg4)
              %42 = arith.cmpi sgt, %arg0, %41 : index
              %43 = scf.if %42 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %40 [4, 3, 1] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %40 : vector<5x4x3xf32>
              }
              %44 = affine.apply #map1(%arg4)
              %45 = arith.cmpi sgt, %arg0, %44 : index
              %46 = scf.if %45 -> (vector<5x4x3xf32>) {
                %47 = affine.apply #map1(%arg4)
                %48 = vector.transfer_read %alloc[%47, %arg5, %arg6, %14], %cst_0 : memref<?x?x?x?xf32>, vector<f32>
                %49 = vector.extract %48[] : f32 from vector<f32>
                %50 = vector.insert %49, %43 [4, 3, 2] : f32 into vector<5x4x3xf32>
                scf.yield %50 : vector<5x4x3xf32>
              } else {
                scf.yield %43 : vector<5x4x3xf32>
              }
              scf.yield %46 : vector<5x4x3xf32>
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
#map3 = affine_map<(d0) -> (d0 + 4)>
module {
  func.func @materialize_write(%arg0: index, %arg1: index, %arg2: index, %arg3: index) {
    %cst = arith.constant dense<1.000000e+00> : vector<f32>
    %alloc = memref.alloc(%arg0, %arg1, %arg2, %arg3) : memref<?x?x?x?xf32>
    affine.for %arg4 = 0 to %arg0 step 3 {
      affine.for %arg5 = 0 to %arg1 step 4 {
        affine.for %arg6 = 0 to %arg2 {
          affine.for %arg7 = 0 to %arg3 step 5 {
            %0 = arith.cmpi sgt, %arg0, %arg4 : index
            scf.if %0 {
              %5 = arith.cmpi sgt, %arg1, %arg5 : index
              scf.if %5 {
                %12 = arith.cmpi sgt, %arg3, %arg7 : index
                scf.if %12 {
                  vector.transfer_write %cst, %alloc[%arg4, %arg5, %arg6, %arg7] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %13 = affine.apply #map(%arg7)
                %14 = arith.cmpi sgt, %arg3, %13 : index
                scf.if %14 {
                  %21 = affine.apply #map(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %arg5, %arg6, %21] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %15 = affine.apply #map1(%arg7)
                %16 = arith.cmpi sgt, %arg3, %15 : index
                scf.if %16 {
                  %21 = affine.apply #map1(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %arg5, %arg6, %21] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %17 = affine.apply #map2(%arg7)
                %18 = arith.cmpi sgt, %arg3, %17 : index
                scf.if %18 {
                  %21 = affine.apply #map2(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %arg5, %arg6, %21] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %19 = affine.apply #map3(%arg7)
                %20 = arith.cmpi sgt, %arg3, %19 : index
                scf.if %20 {
                  %21 = affine.apply #map3(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %arg5, %arg6, %21] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
              } else {
              }
              %6 = affine.apply #map(%arg5)
              %7 = arith.cmpi sgt, %arg1, %6 : index
              scf.if %7 {
                %12 = affine.apply #map(%arg5)
                %13 = arith.cmpi sgt, %arg3, %arg7 : index
                scf.if %13 {
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %arg7] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %14 = affine.apply #map(%arg7)
                %15 = arith.cmpi sgt, %arg3, %14 : index
                scf.if %15 {
                  %22 = affine.apply #map(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %16 = affine.apply #map1(%arg7)
                %17 = arith.cmpi sgt, %arg3, %16 : index
                scf.if %17 {
                  %22 = affine.apply #map1(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %18 = affine.apply #map2(%arg7)
                %19 = arith.cmpi sgt, %arg3, %18 : index
                scf.if %19 {
                  %22 = affine.apply #map2(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %20 = affine.apply #map3(%arg7)
                %21 = arith.cmpi sgt, %arg3, %20 : index
                scf.if %21 {
                  %22 = affine.apply #map3(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
              } else {
              }
              %8 = affine.apply #map1(%arg5)
              %9 = arith.cmpi sgt, %arg1, %8 : index
              scf.if %9 {
                %12 = affine.apply #map1(%arg5)
                %13 = arith.cmpi sgt, %arg3, %arg7 : index
                scf.if %13 {
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %arg7] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %14 = affine.apply #map(%arg7)
                %15 = arith.cmpi sgt, %arg3, %14 : index
                scf.if %15 {
                  %22 = affine.apply #map(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %16 = affine.apply #map1(%arg7)
                %17 = arith.cmpi sgt, %arg3, %16 : index
                scf.if %17 {
                  %22 = affine.apply #map1(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %18 = affine.apply #map2(%arg7)
                %19 = arith.cmpi sgt, %arg3, %18 : index
                scf.if %19 {
                  %22 = affine.apply #map2(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %20 = affine.apply #map3(%arg7)
                %21 = arith.cmpi sgt, %arg3, %20 : index
                scf.if %21 {
                  %22 = affine.apply #map3(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
              } else {
              }
              %10 = affine.apply #map2(%arg5)
              %11 = arith.cmpi sgt, %arg1, %10 : index
              scf.if %11 {
                %12 = affine.apply #map2(%arg5)
                %13 = arith.cmpi sgt, %arg3, %arg7 : index
                scf.if %13 {
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %arg7] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %14 = affine.apply #map(%arg7)
                %15 = arith.cmpi sgt, %arg3, %14 : index
                scf.if %15 {
                  %22 = affine.apply #map(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %16 = affine.apply #map1(%arg7)
                %17 = arith.cmpi sgt, %arg3, %16 : index
                scf.if %17 {
                  %22 = affine.apply #map1(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %18 = affine.apply #map2(%arg7)
                %19 = arith.cmpi sgt, %arg3, %18 : index
                scf.if %19 {
                  %22 = affine.apply #map2(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %20 = affine.apply #map3(%arg7)
                %21 = arith.cmpi sgt, %arg3, %20 : index
                scf.if %21 {
                  %22 = affine.apply #map3(%arg7)
                  vector.transfer_write %cst, %alloc[%arg4, %12, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
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
                %13 = arith.cmpi sgt, %arg3, %arg7 : index
                scf.if %13 {
                  vector.transfer_write %cst, %alloc[%5, %arg5, %arg6, %arg7] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %14 = affine.apply #map(%arg7)
                %15 = arith.cmpi sgt, %arg3, %14 : index
                scf.if %15 {
                  %22 = affine.apply #map(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %arg5, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %16 = affine.apply #map1(%arg7)
                %17 = arith.cmpi sgt, %arg3, %16 : index
                scf.if %17 {
                  %22 = affine.apply #map1(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %arg5, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %18 = affine.apply #map2(%arg7)
                %19 = arith.cmpi sgt, %arg3, %18 : index
                scf.if %19 {
                  %22 = affine.apply #map2(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %arg5, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %20 = affine.apply #map3(%arg7)
                %21 = arith.cmpi sgt, %arg3, %20 : index
                scf.if %21 {
                  %22 = affine.apply #map3(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %arg5, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
              } else {
              }
              %7 = affine.apply #map(%arg5)
              %8 = arith.cmpi sgt, %arg1, %7 : index
              scf.if %8 {
                %13 = affine.apply #map(%arg5)
                %14 = arith.cmpi sgt, %arg3, %arg7 : index
                scf.if %14 {
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %arg7] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %15 = affine.apply #map(%arg7)
                %16 = arith.cmpi sgt, %arg3, %15 : index
                scf.if %16 {
                  %23 = affine.apply #map(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %17 = affine.apply #map1(%arg7)
                %18 = arith.cmpi sgt, %arg3, %17 : index
                scf.if %18 {
                  %23 = affine.apply #map1(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %19 = affine.apply #map2(%arg7)
                %20 = arith.cmpi sgt, %arg3, %19 : index
                scf.if %20 {
                  %23 = affine.apply #map2(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %21 = affine.apply #map3(%arg7)
                %22 = arith.cmpi sgt, %arg3, %21 : index
                scf.if %22 {
                  %23 = affine.apply #map3(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
              } else {
              }
              %9 = affine.apply #map1(%arg5)
              %10 = arith.cmpi sgt, %arg1, %9 : index
              scf.if %10 {
                %13 = affine.apply #map1(%arg5)
                %14 = arith.cmpi sgt, %arg3, %arg7 : index
                scf.if %14 {
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %arg7] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %15 = affine.apply #map(%arg7)
                %16 = arith.cmpi sgt, %arg3, %15 : index
                scf.if %16 {
                  %23 = affine.apply #map(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %17 = affine.apply #map1(%arg7)
                %18 = arith.cmpi sgt, %arg3, %17 : index
                scf.if %18 {
                  %23 = affine.apply #map1(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %19 = affine.apply #map2(%arg7)
                %20 = arith.cmpi sgt, %arg3, %19 : index
                scf.if %20 {
                  %23 = affine.apply #map2(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %21 = affine.apply #map3(%arg7)
                %22 = arith.cmpi sgt, %arg3, %21 : index
                scf.if %22 {
                  %23 = affine.apply #map3(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
              } else {
              }
              %11 = affine.apply #map2(%arg5)
              %12 = arith.cmpi sgt, %arg1, %11 : index
              scf.if %12 {
                %13 = affine.apply #map2(%arg5)
                %14 = arith.cmpi sgt, %arg3, %arg7 : index
                scf.if %14 {
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %arg7] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %15 = affine.apply #map(%arg7)
                %16 = arith.cmpi sgt, %arg3, %15 : index
                scf.if %16 {
                  %23 = affine.apply #map(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %17 = affine.apply #map1(%arg7)
                %18 = arith.cmpi sgt, %arg3, %17 : index
                scf.if %18 {
                  %23 = affine.apply #map1(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %19 = affine.apply #map2(%arg7)
                %20 = arith.cmpi sgt, %arg3, %19 : index
                scf.if %20 {
                  %23 = affine.apply #map2(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %21 = affine.apply #map3(%arg7)
                %22 = arith.cmpi sgt, %arg3, %21 : index
                scf.if %22 {
                  %23 = affine.apply #map3(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
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
                %13 = arith.cmpi sgt, %arg3, %arg7 : index
                scf.if %13 {
                  vector.transfer_write %cst, %alloc[%5, %arg5, %arg6, %arg7] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %14 = affine.apply #map(%arg7)
                %15 = arith.cmpi sgt, %arg3, %14 : index
                scf.if %15 {
                  %22 = affine.apply #map(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %arg5, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %16 = affine.apply #map1(%arg7)
                %17 = arith.cmpi sgt, %arg3, %16 : index
                scf.if %17 {
                  %22 = affine.apply #map1(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %arg5, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %18 = affine.apply #map2(%arg7)
                %19 = arith.cmpi sgt, %arg3, %18 : index
                scf.if %19 {
                  %22 = affine.apply #map2(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %arg5, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %20 = affine.apply #map3(%arg7)
                %21 = arith.cmpi sgt, %arg3, %20 : index
                scf.if %21 {
                  %22 = affine.apply #map3(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %arg5, %arg6, %22] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
              } else {
              }
              %7 = affine.apply #map(%arg5)
              %8 = arith.cmpi sgt, %arg1, %7 : index
              scf.if %8 {
                %13 = affine.apply #map(%arg5)
                %14 = arith.cmpi sgt, %arg3, %arg7 : index
                scf.if %14 {
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %arg7] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %15 = affine.apply #map(%arg7)
                %16 = arith.cmpi sgt, %arg3, %15 : index
                scf.if %16 {
                  %23 = affine.apply #map(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %17 = affine.apply #map1(%arg7)
                %18 = arith.cmpi sgt, %arg3, %17 : index
                scf.if %18 {
                  %23 = affine.apply #map1(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %19 = affine.apply #map2(%arg7)
                %20 = arith.cmpi sgt, %arg3, %19 : index
                scf.if %20 {
                  %23 = affine.apply #map2(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %21 = affine.apply #map3(%arg7)
                %22 = arith.cmpi sgt, %arg3, %21 : index
                scf.if %22 {
                  %23 = affine.apply #map3(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
              } else {
              }
              %9 = affine.apply #map1(%arg5)
              %10 = arith.cmpi sgt, %arg1, %9 : index
              scf.if %10 {
                %13 = affine.apply #map1(%arg5)
                %14 = arith.cmpi sgt, %arg3, %arg7 : index
                scf.if %14 {
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %arg7] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %15 = affine.apply #map(%arg7)
                %16 = arith.cmpi sgt, %arg3, %15 : index
                scf.if %16 {
                  %23 = affine.apply #map(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %17 = affine.apply #map1(%arg7)
                %18 = arith.cmpi sgt, %arg3, %17 : index
                scf.if %18 {
                  %23 = affine.apply #map1(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %19 = affine.apply #map2(%arg7)
                %20 = arith.cmpi sgt, %arg3, %19 : index
                scf.if %20 {
                  %23 = affine.apply #map2(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %21 = affine.apply #map3(%arg7)
                %22 = arith.cmpi sgt, %arg3, %21 : index
                scf.if %22 {
                  %23 = affine.apply #map3(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
              } else {
              }
              %11 = affine.apply #map2(%arg5)
              %12 = arith.cmpi sgt, %arg1, %11 : index
              scf.if %12 {
                %13 = affine.apply #map2(%arg5)
                %14 = arith.cmpi sgt, %arg3, %arg7 : index
                scf.if %14 {
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %arg7] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %15 = affine.apply #map(%arg7)
                %16 = arith.cmpi sgt, %arg3, %15 : index
                scf.if %16 {
                  %23 = affine.apply #map(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %17 = affine.apply #map1(%arg7)
                %18 = arith.cmpi sgt, %arg3, %17 : index
                scf.if %18 {
                  %23 = affine.apply #map1(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %19 = affine.apply #map2(%arg7)
                %20 = arith.cmpi sgt, %arg3, %19 : index
                scf.if %20 {
                  %23 = affine.apply #map2(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
                %21 = affine.apply #map3(%arg7)
                %22 = arith.cmpi sgt, %arg3, %21 : index
                scf.if %22 {
                  %23 = affine.apply #map3(%arg7)
                  vector.transfer_write %cst, %alloc[%5, %13, %arg6, %23] : vector<f32>, memref<?x?x?x?xf32>
                } else {
                }
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
#map2 = affine_map<()[s0] -> (s0 + 3)>
#map3 = affine_map<()[s0] -> (s0 + 4)>
#map4 = affine_map<()[s0] -> (s0 + 5)>
#map5 = affine_map<()[s0] -> (s0 + 6)>
#map6 = affine_map<()[s0] -> (s0 + 7)>
#map7 = affine_map<()[s0] -> (s0 + 8)>
#map8 = affine_map<()[s0] -> (s0 + 9)>
#map9 = affine_map<()[s0] -> (s0 + 10)>
#map10 = affine_map<()[s0] -> (s0 + 11)>
#map11 = affine_map<()[s0] -> (s0 + 12)>
#map12 = affine_map<()[s0] -> (s0 + 13)>
#map13 = affine_map<()[s0] -> (s0 + 14)>
module {
  func.func @transfer_read_progressive(%arg0: memref<?x?xf32>, %arg1: index) -> vector<3x15xf32> {
    %c1 = arith.constant 1 : index
    %cst = arith.constant 7.000000e+00 : f32
    %cst_0 = arith.constant dense<7.000000e+00> : vector<3x15xf32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?xf32>
    %0 = arith.cmpi sgt, %dim, %arg1 : index
    %1 = scf.if %0 -> (vector<3x15xf32>) {
      %dim_3 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %8 = arith.cmpi sgt, %dim_3, %arg1 : index
      %9 = scf.if %8 -> (vector<3x15xf32>) {
        %52 = vector.transfer_read %arg0[%arg1, %arg1], %cst : memref<?x?xf32>, vector<f32>
        %53 = vector.extract %52[] : f32 from vector<f32>
        %54 = vector.insert %53, %cst_0 [0, 0] : f32 into vector<3x15xf32>
        scf.yield %54 : vector<3x15xf32>
      } else {
        scf.yield %cst_0 : vector<3x15xf32>
      }
      %dim_4 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %10 = affine.apply #map()[%arg1]
      %11 = arith.cmpi sgt, %dim_4, %10 : index
      %12 = scf.if %11 -> (vector<3x15xf32>) {
        %52 = affine.apply #map()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %9 [0, 1] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %9 : vector<3x15xf32>
      }
      %dim_5 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %13 = affine.apply #map1()[%arg1]
      %14 = arith.cmpi sgt, %dim_5, %13 : index
      %15 = scf.if %14 -> (vector<3x15xf32>) {
        %52 = affine.apply #map1()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %12 [0, 2] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %12 : vector<3x15xf32>
      }
      %dim_6 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %16 = affine.apply #map2()[%arg1]
      %17 = arith.cmpi sgt, %dim_6, %16 : index
      %18 = scf.if %17 -> (vector<3x15xf32>) {
        %52 = affine.apply #map2()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %15 [0, 3] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %15 : vector<3x15xf32>
      }
      %dim_7 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %19 = affine.apply #map3()[%arg1]
      %20 = arith.cmpi sgt, %dim_7, %19 : index
      %21 = scf.if %20 -> (vector<3x15xf32>) {
        %52 = affine.apply #map3()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %18 [0, 4] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %18 : vector<3x15xf32>
      }
      %dim_8 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %22 = affine.apply #map4()[%arg1]
      %23 = arith.cmpi sgt, %dim_8, %22 : index
      %24 = scf.if %23 -> (vector<3x15xf32>) {
        %52 = affine.apply #map4()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %21 [0, 5] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %21 : vector<3x15xf32>
      }
      %dim_9 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %25 = affine.apply #map5()[%arg1]
      %26 = arith.cmpi sgt, %dim_9, %25 : index
      %27 = scf.if %26 -> (vector<3x15xf32>) {
        %52 = affine.apply #map5()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %24 [0, 6] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %24 : vector<3x15xf32>
      }
      %dim_10 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %28 = affine.apply #map6()[%arg1]
      %29 = arith.cmpi sgt, %dim_10, %28 : index
      %30 = scf.if %29 -> (vector<3x15xf32>) {
        %52 = affine.apply #map6()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %27 [0, 7] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %27 : vector<3x15xf32>
      }
      %dim_11 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %31 = affine.apply #map7()[%arg1]
      %32 = arith.cmpi sgt, %dim_11, %31 : index
      %33 = scf.if %32 -> (vector<3x15xf32>) {
        %52 = affine.apply #map7()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %30 [0, 8] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %30 : vector<3x15xf32>
      }
      %dim_12 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %34 = affine.apply #map8()[%arg1]
      %35 = arith.cmpi sgt, %dim_12, %34 : index
      %36 = scf.if %35 -> (vector<3x15xf32>) {
        %52 = affine.apply #map8()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %33 [0, 9] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %33 : vector<3x15xf32>
      }
      %dim_13 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %37 = affine.apply #map9()[%arg1]
      %38 = arith.cmpi sgt, %dim_13, %37 : index
      %39 = scf.if %38 -> (vector<3x15xf32>) {
        %52 = affine.apply #map9()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %36 [0, 10] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %36 : vector<3x15xf32>
      }
      %dim_14 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %40 = affine.apply #map10()[%arg1]
      %41 = arith.cmpi sgt, %dim_14, %40 : index
      %42 = scf.if %41 -> (vector<3x15xf32>) {
        %52 = affine.apply #map10()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %39 [0, 11] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %39 : vector<3x15xf32>
      }
      %dim_15 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %43 = affine.apply #map11()[%arg1]
      %44 = arith.cmpi sgt, %dim_15, %43 : index
      %45 = scf.if %44 -> (vector<3x15xf32>) {
        %52 = affine.apply #map11()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %42 [0, 12] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %42 : vector<3x15xf32>
      }
      %dim_16 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %46 = affine.apply #map12()[%arg1]
      %47 = arith.cmpi sgt, %dim_16, %46 : index
      %48 = scf.if %47 -> (vector<3x15xf32>) {
        %52 = affine.apply #map12()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %45 [0, 13] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %45 : vector<3x15xf32>
      }
      %dim_17 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %49 = affine.apply #map13()[%arg1]
      %50 = arith.cmpi sgt, %dim_17, %49 : index
      %51 = scf.if %50 -> (vector<3x15xf32>) {
        %52 = affine.apply #map13()[%arg1]
        %53 = vector.transfer_read %arg0[%arg1, %52], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %48 [0, 14] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %48 : vector<3x15xf32>
      }
      scf.yield %51 : vector<3x15xf32>
    } else {
      scf.yield %cst_0 : vector<3x15xf32>
    }
    %dim_1 = memref.dim %arg0, %c0 : memref<?x?xf32>
    %2 = affine.apply #map()[%arg1]
    %3 = arith.cmpi sgt, %dim_1, %2 : index
    %4 = scf.if %3 -> (vector<3x15xf32>) {
      %8 = affine.apply #map()[%arg1]
      %dim_3 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %9 = arith.cmpi sgt, %dim_3, %arg1 : index
      %10 = scf.if %9 -> (vector<3x15xf32>) {
        %53 = vector.transfer_read %arg0[%8, %arg1], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %1 [1, 0] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %1 : vector<3x15xf32>
      }
      %dim_4 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %11 = affine.apply #map()[%arg1]
      %12 = arith.cmpi sgt, %dim_4, %11 : index
      %13 = scf.if %12 -> (vector<3x15xf32>) {
        %53 = affine.apply #map()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %10 [1, 1] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %10 : vector<3x15xf32>
      }
      %dim_5 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %14 = affine.apply #map1()[%arg1]
      %15 = arith.cmpi sgt, %dim_5, %14 : index
      %16 = scf.if %15 -> (vector<3x15xf32>) {
        %53 = affine.apply #map1()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %13 [1, 2] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %13 : vector<3x15xf32>
      }
      %dim_6 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %17 = affine.apply #map2()[%arg1]
      %18 = arith.cmpi sgt, %dim_6, %17 : index
      %19 = scf.if %18 -> (vector<3x15xf32>) {
        %53 = affine.apply #map2()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %16 [1, 3] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %16 : vector<3x15xf32>
      }
      %dim_7 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %20 = affine.apply #map3()[%arg1]
      %21 = arith.cmpi sgt, %dim_7, %20 : index
      %22 = scf.if %21 -> (vector<3x15xf32>) {
        %53 = affine.apply #map3()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %19 [1, 4] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %19 : vector<3x15xf32>
      }
      %dim_8 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %23 = affine.apply #map4()[%arg1]
      %24 = arith.cmpi sgt, %dim_8, %23 : index
      %25 = scf.if %24 -> (vector<3x15xf32>) {
        %53 = affine.apply #map4()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %22 [1, 5] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %22 : vector<3x15xf32>
      }
      %dim_9 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %26 = affine.apply #map5()[%arg1]
      %27 = arith.cmpi sgt, %dim_9, %26 : index
      %28 = scf.if %27 -> (vector<3x15xf32>) {
        %53 = affine.apply #map5()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %25 [1, 6] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %25 : vector<3x15xf32>
      }
      %dim_10 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %29 = affine.apply #map6()[%arg1]
      %30 = arith.cmpi sgt, %dim_10, %29 : index
      %31 = scf.if %30 -> (vector<3x15xf32>) {
        %53 = affine.apply #map6()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %28 [1, 7] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %28 : vector<3x15xf32>
      }
      %dim_11 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %32 = affine.apply #map7()[%arg1]
      %33 = arith.cmpi sgt, %dim_11, %32 : index
      %34 = scf.if %33 -> (vector<3x15xf32>) {
        %53 = affine.apply #map7()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %31 [1, 8] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %31 : vector<3x15xf32>
      }
      %dim_12 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %35 = affine.apply #map8()[%arg1]
      %36 = arith.cmpi sgt, %dim_12, %35 : index
      %37 = scf.if %36 -> (vector<3x15xf32>) {
        %53 = affine.apply #map8()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %34 [1, 9] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %34 : vector<3x15xf32>
      }
      %dim_13 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %38 = affine.apply #map9()[%arg1]
      %39 = arith.cmpi sgt, %dim_13, %38 : index
      %40 = scf.if %39 -> (vector<3x15xf32>) {
        %53 = affine.apply #map9()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %37 [1, 10] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %37 : vector<3x15xf32>
      }
      %dim_14 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %41 = affine.apply #map10()[%arg1]
      %42 = arith.cmpi sgt, %dim_14, %41 : index
      %43 = scf.if %42 -> (vector<3x15xf32>) {
        %53 = affine.apply #map10()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %40 [1, 11] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %40 : vector<3x15xf32>
      }
      %dim_15 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %44 = affine.apply #map11()[%arg1]
      %45 = arith.cmpi sgt, %dim_15, %44 : index
      %46 = scf.if %45 -> (vector<3x15xf32>) {
        %53 = affine.apply #map11()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %43 [1, 12] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %43 : vector<3x15xf32>
      }
      %dim_16 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %47 = affine.apply #map12()[%arg1]
      %48 = arith.cmpi sgt, %dim_16, %47 : index
      %49 = scf.if %48 -> (vector<3x15xf32>) {
        %53 = affine.apply #map12()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %46 [1, 13] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %46 : vector<3x15xf32>
      }
      %dim_17 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %50 = affine.apply #map13()[%arg1]
      %51 = arith.cmpi sgt, %dim_17, %50 : index
      %52 = scf.if %51 -> (vector<3x15xf32>) {
        %53 = affine.apply #map13()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %49 [1, 14] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %49 : vector<3x15xf32>
      }
      scf.yield %52 : vector<3x15xf32>
    } else {
      scf.yield %1 : vector<3x15xf32>
    }
    %dim_2 = memref.dim %arg0, %c0 : memref<?x?xf32>
    %5 = affine.apply #map1()[%arg1]
    %6 = arith.cmpi sgt, %dim_2, %5 : index
    %7 = scf.if %6 -> (vector<3x15xf32>) {
      %8 = affine.apply #map1()[%arg1]
      %dim_3 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %9 = arith.cmpi sgt, %dim_3, %arg1 : index
      %10 = scf.if %9 -> (vector<3x15xf32>) {
        %53 = vector.transfer_read %arg0[%8, %arg1], %cst : memref<?x?xf32>, vector<f32>
        %54 = vector.extract %53[] : f32 from vector<f32>
        %55 = vector.insert %54, %4 [2, 0] : f32 into vector<3x15xf32>
        scf.yield %55 : vector<3x15xf32>
      } else {
        scf.yield %4 : vector<3x15xf32>
      }
      %dim_4 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %11 = affine.apply #map()[%arg1]
      %12 = arith.cmpi sgt, %dim_4, %11 : index
      %13 = scf.if %12 -> (vector<3x15xf32>) {
        %53 = affine.apply #map()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %10 [2, 1] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %10 : vector<3x15xf32>
      }
      %dim_5 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %14 = affine.apply #map1()[%arg1]
      %15 = arith.cmpi sgt, %dim_5, %14 : index
      %16 = scf.if %15 -> (vector<3x15xf32>) {
        %53 = affine.apply #map1()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %13 [2, 2] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %13 : vector<3x15xf32>
      }
      %dim_6 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %17 = affine.apply #map2()[%arg1]
      %18 = arith.cmpi sgt, %dim_6, %17 : index
      %19 = scf.if %18 -> (vector<3x15xf32>) {
        %53 = affine.apply #map2()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %16 [2, 3] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %16 : vector<3x15xf32>
      }
      %dim_7 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %20 = affine.apply #map3()[%arg1]
      %21 = arith.cmpi sgt, %dim_7, %20 : index
      %22 = scf.if %21 -> (vector<3x15xf32>) {
        %53 = affine.apply #map3()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %19 [2, 4] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %19 : vector<3x15xf32>
      }
      %dim_8 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %23 = affine.apply #map4()[%arg1]
      %24 = arith.cmpi sgt, %dim_8, %23 : index
      %25 = scf.if %24 -> (vector<3x15xf32>) {
        %53 = affine.apply #map4()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %22 [2, 5] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %22 : vector<3x15xf32>
      }
      %dim_9 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %26 = affine.apply #map5()[%arg1]
      %27 = arith.cmpi sgt, %dim_9, %26 : index
      %28 = scf.if %27 -> (vector<3x15xf32>) {
        %53 = affine.apply #map5()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %25 [2, 6] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %25 : vector<3x15xf32>
      }
      %dim_10 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %29 = affine.apply #map6()[%arg1]
      %30 = arith.cmpi sgt, %dim_10, %29 : index
      %31 = scf.if %30 -> (vector<3x15xf32>) {
        %53 = affine.apply #map6()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %28 [2, 7] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %28 : vector<3x15xf32>
      }
      %dim_11 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %32 = affine.apply #map7()[%arg1]
      %33 = arith.cmpi sgt, %dim_11, %32 : index
      %34 = scf.if %33 -> (vector<3x15xf32>) {
        %53 = affine.apply #map7()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %31 [2, 8] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %31 : vector<3x15xf32>
      }
      %dim_12 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %35 = affine.apply #map8()[%arg1]
      %36 = arith.cmpi sgt, %dim_12, %35 : index
      %37 = scf.if %36 -> (vector<3x15xf32>) {
        %53 = affine.apply #map8()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %34 [2, 9] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %34 : vector<3x15xf32>
      }
      %dim_13 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %38 = affine.apply #map9()[%arg1]
      %39 = arith.cmpi sgt, %dim_13, %38 : index
      %40 = scf.if %39 -> (vector<3x15xf32>) {
        %53 = affine.apply #map9()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %37 [2, 10] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %37 : vector<3x15xf32>
      }
      %dim_14 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %41 = affine.apply #map10()[%arg1]
      %42 = arith.cmpi sgt, %dim_14, %41 : index
      %43 = scf.if %42 -> (vector<3x15xf32>) {
        %53 = affine.apply #map10()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %40 [2, 11] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %40 : vector<3x15xf32>
      }
      %dim_15 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %44 = affine.apply #map11()[%arg1]
      %45 = arith.cmpi sgt, %dim_15, %44 : index
      %46 = scf.if %45 -> (vector<3x15xf32>) {
        %53 = affine.apply #map11()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %43 [2, 12] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %43 : vector<3x15xf32>
      }
      %dim_16 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %47 = affine.apply #map12()[%arg1]
      %48 = arith.cmpi sgt, %dim_16, %47 : index
      %49 = scf.if %48 -> (vector<3x15xf32>) {
        %53 = affine.apply #map12()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %46 [2, 13] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %46 : vector<3x15xf32>
      }
      %dim_17 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %50 = affine.apply #map13()[%arg1]
      %51 = arith.cmpi sgt, %dim_17, %50 : index
      %52 = scf.if %51 -> (vector<3x15xf32>) {
        %53 = affine.apply #map13()[%arg1]
        %54 = vector.transfer_read %arg0[%8, %53], %cst : memref<?x?xf32>, vector<f32>
        %55 = vector.extract %54[] : f32 from vector<f32>
        %56 = vector.insert %55, %49 [2, 14] : f32 into vector<3x15xf32>
        scf.yield %56 : vector<3x15xf32>
      } else {
        scf.yield %49 : vector<3x15xf32>
      }
      scf.yield %52 : vector<3x15xf32>
    } else {
      scf.yield %4 : vector<3x15xf32>
    }
    return %7 : vector<3x15xf32>
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 1)>
#map1 = affine_map<()[s0] -> (s0 + 2)>
#map2 = affine_map<()[s0] -> (s0 + 3)>
#map3 = affine_map<()[s0] -> (s0 + 4)>
#map4 = affine_map<()[s0] -> (s0 + 5)>
#map5 = affine_map<()[s0] -> (s0 + 6)>
#map6 = affine_map<()[s0] -> (s0 + 7)>
#map7 = affine_map<()[s0] -> (s0 + 8)>
#map8 = affine_map<()[s0] -> (s0 + 9)>
#map9 = affine_map<()[s0] -> (s0 + 10)>
#map10 = affine_map<()[s0] -> (s0 + 11)>
#map11 = affine_map<()[s0] -> (s0 + 12)>
#map12 = affine_map<()[s0] -> (s0 + 13)>
#map13 = affine_map<()[s0] -> (s0 + 14)>
module {
  func.func @transfer_write_progressive(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?xf32>
    %0 = arith.cmpi sgt, %dim, %arg1 : index
    scf.if %0 {
      %dim_2 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %5 = arith.cmpi sgt, %dim_2, %arg1 : index
      scf.if %5 {
        %34 = vector.extract %arg2[0, 0] : f32 from vector<3x15xf32>
        %35 = vector.broadcast %34 : f32 to vector<f32>
        vector.transfer_write %35, %arg0[%arg1, %arg1] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_3 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %6 = affine.apply #map()[%arg1]
      %7 = arith.cmpi sgt, %dim_3, %6 : index
      scf.if %7 {
        %34 = affine.apply #map()[%arg1]
        %35 = vector.extract %arg2[0, 1] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_4 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %8 = affine.apply #map1()[%arg1]
      %9 = arith.cmpi sgt, %dim_4, %8 : index
      scf.if %9 {
        %34 = affine.apply #map1()[%arg1]
        %35 = vector.extract %arg2[0, 2] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_5 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %10 = affine.apply #map2()[%arg1]
      %11 = arith.cmpi sgt, %dim_5, %10 : index
      scf.if %11 {
        %34 = affine.apply #map2()[%arg1]
        %35 = vector.extract %arg2[0, 3] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_6 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %12 = affine.apply #map3()[%arg1]
      %13 = arith.cmpi sgt, %dim_6, %12 : index
      scf.if %13 {
        %34 = affine.apply #map3()[%arg1]
        %35 = vector.extract %arg2[0, 4] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_7 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %14 = affine.apply #map4()[%arg1]
      %15 = arith.cmpi sgt, %dim_7, %14 : index
      scf.if %15 {
        %34 = affine.apply #map4()[%arg1]
        %35 = vector.extract %arg2[0, 5] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_8 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %16 = affine.apply #map5()[%arg1]
      %17 = arith.cmpi sgt, %dim_8, %16 : index
      scf.if %17 {
        %34 = affine.apply #map5()[%arg1]
        %35 = vector.extract %arg2[0, 6] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_9 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %18 = affine.apply #map6()[%arg1]
      %19 = arith.cmpi sgt, %dim_9, %18 : index
      scf.if %19 {
        %34 = affine.apply #map6()[%arg1]
        %35 = vector.extract %arg2[0, 7] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_10 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %20 = affine.apply #map7()[%arg1]
      %21 = arith.cmpi sgt, %dim_10, %20 : index
      scf.if %21 {
        %34 = affine.apply #map7()[%arg1]
        %35 = vector.extract %arg2[0, 8] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_11 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %22 = affine.apply #map8()[%arg1]
      %23 = arith.cmpi sgt, %dim_11, %22 : index
      scf.if %23 {
        %34 = affine.apply #map8()[%arg1]
        %35 = vector.extract %arg2[0, 9] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_12 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %24 = affine.apply #map9()[%arg1]
      %25 = arith.cmpi sgt, %dim_12, %24 : index
      scf.if %25 {
        %34 = affine.apply #map9()[%arg1]
        %35 = vector.extract %arg2[0, 10] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_13 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %26 = affine.apply #map10()[%arg1]
      %27 = arith.cmpi sgt, %dim_13, %26 : index
      scf.if %27 {
        %34 = affine.apply #map10()[%arg1]
        %35 = vector.extract %arg2[0, 11] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_14 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %28 = affine.apply #map11()[%arg1]
      %29 = arith.cmpi sgt, %dim_14, %28 : index
      scf.if %29 {
        %34 = affine.apply #map11()[%arg1]
        %35 = vector.extract %arg2[0, 12] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_15 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %30 = affine.apply #map12()[%arg1]
      %31 = arith.cmpi sgt, %dim_15, %30 : index
      scf.if %31 {
        %34 = affine.apply #map12()[%arg1]
        %35 = vector.extract %arg2[0, 13] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_16 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %32 = affine.apply #map13()[%arg1]
      %33 = arith.cmpi sgt, %dim_16, %32 : index
      scf.if %33 {
        %34 = affine.apply #map13()[%arg1]
        %35 = vector.extract %arg2[0, 14] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%arg1, %34] : vector<f32>, memref<?x?xf32>
      } else {
      }
    } else {
    }
    %dim_0 = memref.dim %arg0, %c0 : memref<?x?xf32>
    %1 = affine.apply #map()[%arg1]
    %2 = arith.cmpi sgt, %dim_0, %1 : index
    scf.if %2 {
      %5 = affine.apply #map()[%arg1]
      %dim_2 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %6 = arith.cmpi sgt, %dim_2, %arg1 : index
      scf.if %6 {
        %35 = vector.extract %arg2[1, 0] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%5, %arg1] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_3 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %7 = affine.apply #map()[%arg1]
      %8 = arith.cmpi sgt, %dim_3, %7 : index
      scf.if %8 {
        %35 = affine.apply #map()[%arg1]
        %36 = vector.extract %arg2[1, 1] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_4 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %9 = affine.apply #map1()[%arg1]
      %10 = arith.cmpi sgt, %dim_4, %9 : index
      scf.if %10 {
        %35 = affine.apply #map1()[%arg1]
        %36 = vector.extract %arg2[1, 2] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_5 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %11 = affine.apply #map2()[%arg1]
      %12 = arith.cmpi sgt, %dim_5, %11 : index
      scf.if %12 {
        %35 = affine.apply #map2()[%arg1]
        %36 = vector.extract %arg2[1, 3] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_6 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %13 = affine.apply #map3()[%arg1]
      %14 = arith.cmpi sgt, %dim_6, %13 : index
      scf.if %14 {
        %35 = affine.apply #map3()[%arg1]
        %36 = vector.extract %arg2[1, 4] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_7 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %15 = affine.apply #map4()[%arg1]
      %16 = arith.cmpi sgt, %dim_7, %15 : index
      scf.if %16 {
        %35 = affine.apply #map4()[%arg1]
        %36 = vector.extract %arg2[1, 5] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_8 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %17 = affine.apply #map5()[%arg1]
      %18 = arith.cmpi sgt, %dim_8, %17 : index
      scf.if %18 {
        %35 = affine.apply #map5()[%arg1]
        %36 = vector.extract %arg2[1, 6] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_9 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %19 = affine.apply #map6()[%arg1]
      %20 = arith.cmpi sgt, %dim_9, %19 : index
      scf.if %20 {
        %35 = affine.apply #map6()[%arg1]
        %36 = vector.extract %arg2[1, 7] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_10 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %21 = affine.apply #map7()[%arg1]
      %22 = arith.cmpi sgt, %dim_10, %21 : index
      scf.if %22 {
        %35 = affine.apply #map7()[%arg1]
        %36 = vector.extract %arg2[1, 8] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_11 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %23 = affine.apply #map8()[%arg1]
      %24 = arith.cmpi sgt, %dim_11, %23 : index
      scf.if %24 {
        %35 = affine.apply #map8()[%arg1]
        %36 = vector.extract %arg2[1, 9] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_12 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %25 = affine.apply #map9()[%arg1]
      %26 = arith.cmpi sgt, %dim_12, %25 : index
      scf.if %26 {
        %35 = affine.apply #map9()[%arg1]
        %36 = vector.extract %arg2[1, 10] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_13 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %27 = affine.apply #map10()[%arg1]
      %28 = arith.cmpi sgt, %dim_13, %27 : index
      scf.if %28 {
        %35 = affine.apply #map10()[%arg1]
        %36 = vector.extract %arg2[1, 11] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_14 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %29 = affine.apply #map11()[%arg1]
      %30 = arith.cmpi sgt, %dim_14, %29 : index
      scf.if %30 {
        %35 = affine.apply #map11()[%arg1]
        %36 = vector.extract %arg2[1, 12] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_15 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %31 = affine.apply #map12()[%arg1]
      %32 = arith.cmpi sgt, %dim_15, %31 : index
      scf.if %32 {
        %35 = affine.apply #map12()[%arg1]
        %36 = vector.extract %arg2[1, 13] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_16 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %33 = affine.apply #map13()[%arg1]
      %34 = arith.cmpi sgt, %dim_16, %33 : index
      scf.if %34 {
        %35 = affine.apply #map13()[%arg1]
        %36 = vector.extract %arg2[1, 14] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
    } else {
    }
    %dim_1 = memref.dim %arg0, %c0 : memref<?x?xf32>
    %3 = affine.apply #map1()[%arg1]
    %4 = arith.cmpi sgt, %dim_1, %3 : index
    scf.if %4 {
      %5 = affine.apply #map1()[%arg1]
      %dim_2 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %6 = arith.cmpi sgt, %dim_2, %arg1 : index
      scf.if %6 {
        %35 = vector.extract %arg2[2, 0] : f32 from vector<3x15xf32>
        %36 = vector.broadcast %35 : f32 to vector<f32>
        vector.transfer_write %36, %arg0[%5, %arg1] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_3 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %7 = affine.apply #map()[%arg1]
      %8 = arith.cmpi sgt, %dim_3, %7 : index
      scf.if %8 {
        %35 = affine.apply #map()[%arg1]
        %36 = vector.extract %arg2[2, 1] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_4 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %9 = affine.apply #map1()[%arg1]
      %10 = arith.cmpi sgt, %dim_4, %9 : index
      scf.if %10 {
        %35 = affine.apply #map1()[%arg1]
        %36 = vector.extract %arg2[2, 2] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_5 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %11 = affine.apply #map2()[%arg1]
      %12 = arith.cmpi sgt, %dim_5, %11 : index
      scf.if %12 {
        %35 = affine.apply #map2()[%arg1]
        %36 = vector.extract %arg2[2, 3] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_6 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %13 = affine.apply #map3()[%arg1]
      %14 = arith.cmpi sgt, %dim_6, %13 : index
      scf.if %14 {
        %35 = affine.apply #map3()[%arg1]
        %36 = vector.extract %arg2[2, 4] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_7 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %15 = affine.apply #map4()[%arg1]
      %16 = arith.cmpi sgt, %dim_7, %15 : index
      scf.if %16 {
        %35 = affine.apply #map4()[%arg1]
        %36 = vector.extract %arg2[2, 5] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_8 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %17 = affine.apply #map5()[%arg1]
      %18 = arith.cmpi sgt, %dim_8, %17 : index
      scf.if %18 {
        %35 = affine.apply #map5()[%arg1]
        %36 = vector.extract %arg2[2, 6] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_9 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %19 = affine.apply #map6()[%arg1]
      %20 = arith.cmpi sgt, %dim_9, %19 : index
      scf.if %20 {
        %35 = affine.apply #map6()[%arg1]
        %36 = vector.extract %arg2[2, 7] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_10 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %21 = affine.apply #map7()[%arg1]
      %22 = arith.cmpi sgt, %dim_10, %21 : index
      scf.if %22 {
        %35 = affine.apply #map7()[%arg1]
        %36 = vector.extract %arg2[2, 8] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_11 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %23 = affine.apply #map8()[%arg1]
      %24 = arith.cmpi sgt, %dim_11, %23 : index
      scf.if %24 {
        %35 = affine.apply #map8()[%arg1]
        %36 = vector.extract %arg2[2, 9] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_12 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %25 = affine.apply #map9()[%arg1]
      %26 = arith.cmpi sgt, %dim_12, %25 : index
      scf.if %26 {
        %35 = affine.apply #map9()[%arg1]
        %36 = vector.extract %arg2[2, 10] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_13 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %27 = affine.apply #map10()[%arg1]
      %28 = arith.cmpi sgt, %dim_13, %27 : index
      scf.if %28 {
        %35 = affine.apply #map10()[%arg1]
        %36 = vector.extract %arg2[2, 11] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_14 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %29 = affine.apply #map11()[%arg1]
      %30 = arith.cmpi sgt, %dim_14, %29 : index
      scf.if %30 {
        %35 = affine.apply #map11()[%arg1]
        %36 = vector.extract %arg2[2, 12] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_15 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %31 = affine.apply #map12()[%arg1]
      %32 = arith.cmpi sgt, %dim_15, %31 : index
      scf.if %32 {
        %35 = affine.apply #map12()[%arg1]
        %36 = vector.extract %arg2[2, 13] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
      %dim_16 = memref.dim %arg0, %c1 : memref<?x?xf32>
      %33 = affine.apply #map13()[%arg1]
      %34 = arith.cmpi sgt, %dim_16, %33 : index
      scf.if %34 {
        %35 = affine.apply #map13()[%arg1]
        %36 = vector.extract %arg2[2, 14] : f32 from vector<3x15xf32>
        %37 = vector.broadcast %36 : f32 to vector<f32>
        vector.transfer_write %37, %arg0[%5, %35] : vector<f32>, memref<?x?xf32>
      } else {
      }
    } else {
    }
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 1)>
#map1 = affine_map<()[s0] -> (s0 + 2)>
#map2 = affine_map<()[s0] -> (s0 + 3)>
#map3 = affine_map<()[s0] -> (s0 + 4)>
#map4 = affine_map<()[s0] -> (s0 + 5)>
#map5 = affine_map<()[s0] -> (s0 + 6)>
#map6 = affine_map<()[s0] -> (s0 + 7)>
#map7 = affine_map<()[s0] -> (s0 + 8)>
#map8 = affine_map<()[s0] -> (s0 + 9)>
#map9 = affine_map<()[s0] -> (s0 + 10)>
#map10 = affine_map<()[s0] -> (s0 + 11)>
#map11 = affine_map<()[s0] -> (s0 + 12)>
#map12 = affine_map<()[s0] -> (s0 + 13)>
#map13 = affine_map<()[s0] -> (s0 + 14)>
module {
  func.func @transfer_write_progressive_inbounds(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>) {
    %0 = vector.extract %arg2[0, 0] : f32 from vector<3x15xf32>
    %1 = vector.broadcast %0 : f32 to vector<f32>
    vector.transfer_write %1, %arg0[%arg1, %arg1] : vector<f32>, memref<?x?xf32>
    %2 = affine.apply #map()[%arg1]
    %3 = vector.extract %arg2[0, 1] : f32 from vector<3x15xf32>
    %4 = vector.broadcast %3 : f32 to vector<f32>
    vector.transfer_write %4, %arg0[%arg1, %2] : vector<f32>, memref<?x?xf32>
    %5 = affine.apply #map1()[%arg1]
    %6 = vector.extract %arg2[0, 2] : f32 from vector<3x15xf32>
    %7 = vector.broadcast %6 : f32 to vector<f32>
    vector.transfer_write %7, %arg0[%arg1, %5] : vector<f32>, memref<?x?xf32>
    %8 = affine.apply #map2()[%arg1]
    %9 = vector.extract %arg2[0, 3] : f32 from vector<3x15xf32>
    %10 = vector.broadcast %9 : f32 to vector<f32>
    vector.transfer_write %10, %arg0[%arg1, %8] : vector<f32>, memref<?x?xf32>
    %11 = affine.apply #map3()[%arg1]
    %12 = vector.extract %arg2[0, 4] : f32 from vector<3x15xf32>
    %13 = vector.broadcast %12 : f32 to vector<f32>
    vector.transfer_write %13, %arg0[%arg1, %11] : vector<f32>, memref<?x?xf32>
    %14 = affine.apply #map4()[%arg1]
    %15 = vector.extract %arg2[0, 5] : f32 from vector<3x15xf32>
    %16 = vector.broadcast %15 : f32 to vector<f32>
    vector.transfer_write %16, %arg0[%arg1, %14] : vector<f32>, memref<?x?xf32>
    %17 = affine.apply #map5()[%arg1]
    %18 = vector.extract %arg2[0, 6] : f32 from vector<3x15xf32>
    %19 = vector.broadcast %18 : f32 to vector<f32>
    vector.transfer_write %19, %arg0[%arg1, %17] : vector<f32>, memref<?x?xf32>
    %20 = affine.apply #map6()[%arg1]
    %21 = vector.extract %arg2[0, 7] : f32 from vector<3x15xf32>
    %22 = vector.broadcast %21 : f32 to vector<f32>
    vector.transfer_write %22, %arg0[%arg1, %20] : vector<f32>, memref<?x?xf32>
    %23 = affine.apply #map7()[%arg1]
    %24 = vector.extract %arg2[0, 8] : f32 from vector<3x15xf32>
    %25 = vector.broadcast %24 : f32 to vector<f32>
    vector.transfer_write %25, %arg0[%arg1, %23] : vector<f32>, memref<?x?xf32>
    %26 = affine.apply #map8()[%arg1]
    %27 = vector.extract %arg2[0, 9] : f32 from vector<3x15xf32>
    %28 = vector.broadcast %27 : f32 to vector<f32>
    vector.transfer_write %28, %arg0[%arg1, %26] : vector<f32>, memref<?x?xf32>
    %29 = affine.apply #map9()[%arg1]
    %30 = vector.extract %arg2[0, 10] : f32 from vector<3x15xf32>
    %31 = vector.broadcast %30 : f32 to vector<f32>
    vector.transfer_write %31, %arg0[%arg1, %29] : vector<f32>, memref<?x?xf32>
    %32 = affine.apply #map10()[%arg1]
    %33 = vector.extract %arg2[0, 11] : f32 from vector<3x15xf32>
    %34 = vector.broadcast %33 : f32 to vector<f32>
    vector.transfer_write %34, %arg0[%arg1, %32] : vector<f32>, memref<?x?xf32>
    %35 = affine.apply #map11()[%arg1]
    %36 = vector.extract %arg2[0, 12] : f32 from vector<3x15xf32>
    %37 = vector.broadcast %36 : f32 to vector<f32>
    vector.transfer_write %37, %arg0[%arg1, %35] : vector<f32>, memref<?x?xf32>
    %38 = affine.apply #map12()[%arg1]
    %39 = vector.extract %arg2[0, 13] : f32 from vector<3x15xf32>
    %40 = vector.broadcast %39 : f32 to vector<f32>
    vector.transfer_write %40, %arg0[%arg1, %38] : vector<f32>, memref<?x?xf32>
    %41 = affine.apply #map13()[%arg1]
    %42 = vector.extract %arg2[0, 14] : f32 from vector<3x15xf32>
    %43 = vector.broadcast %42 : f32 to vector<f32>
    vector.transfer_write %43, %arg0[%arg1, %41] : vector<f32>, memref<?x?xf32>
    %44 = affine.apply #map()[%arg1]
    %45 = vector.extract %arg2[1, 0] : f32 from vector<3x15xf32>
    %46 = vector.broadcast %45 : f32 to vector<f32>
    vector.transfer_write %46, %arg0[%44, %arg1] : vector<f32>, memref<?x?xf32>
    %47 = affine.apply #map()[%arg1]
    %48 = vector.extract %arg2[1, 1] : f32 from vector<3x15xf32>
    %49 = vector.broadcast %48 : f32 to vector<f32>
    vector.transfer_write %49, %arg0[%44, %47] : vector<f32>, memref<?x?xf32>
    %50 = affine.apply #map1()[%arg1]
    %51 = vector.extract %arg2[1, 2] : f32 from vector<3x15xf32>
    %52 = vector.broadcast %51 : f32 to vector<f32>
    vector.transfer_write %52, %arg0[%44, %50] : vector<f32>, memref<?x?xf32>
    %53 = affine.apply #map2()[%arg1]
    %54 = vector.extract %arg2[1, 3] : f32 from vector<3x15xf32>
    %55 = vector.broadcast %54 : f32 to vector<f32>
    vector.transfer_write %55, %arg0[%44, %53] : vector<f32>, memref<?x?xf32>
    %56 = affine.apply #map3()[%arg1]
    %57 = vector.extract %arg2[1, 4] : f32 from vector<3x15xf32>
    %58 = vector.broadcast %57 : f32 to vector<f32>
    vector.transfer_write %58, %arg0[%44, %56] : vector<f32>, memref<?x?xf32>
    %59 = affine.apply #map4()[%arg1]
    %60 = vector.extract %arg2[1, 5] : f32 from vector<3x15xf32>
    %61 = vector.broadcast %60 : f32 to vector<f32>
    vector.transfer_write %61, %arg0[%44, %59] : vector<f32>, memref<?x?xf32>
    %62 = affine.apply #map5()[%arg1]
    %63 = vector.extract %arg2[1, 6] : f32 from vector<3x15xf32>
    %64 = vector.broadcast %63 : f32 to vector<f32>
    vector.transfer_write %64, %arg0[%44, %62] : vector<f32>, memref<?x?xf32>
    %65 = affine.apply #map6()[%arg1]
    %66 = vector.extract %arg2[1, 7] : f32 from vector<3x15xf32>
    %67 = vector.broadcast %66 : f32 to vector<f32>
    vector.transfer_write %67, %arg0[%44, %65] : vector<f32>, memref<?x?xf32>
    %68 = affine.apply #map7()[%arg1]
    %69 = vector.extract %arg2[1, 8] : f32 from vector<3x15xf32>
    %70 = vector.broadcast %69 : f32 to vector<f32>
    vector.transfer_write %70, %arg0[%44, %68] : vector<f32>, memref<?x?xf32>
    %71 = affine.apply #map8()[%arg1]
    %72 = vector.extract %arg2[1, 9] : f32 from vector<3x15xf32>
    %73 = vector.broadcast %72 : f32 to vector<f32>
    vector.transfer_write %73, %arg0[%44, %71] : vector<f32>, memref<?x?xf32>
    %74 = affine.apply #map9()[%arg1]
    %75 = vector.extract %arg2[1, 10] : f32 from vector<3x15xf32>
    %76 = vector.broadcast %75 : f32 to vector<f32>
    vector.transfer_write %76, %arg0[%44, %74] : vector<f32>, memref<?x?xf32>
    %77 = affine.apply #map10()[%arg1]
    %78 = vector.extract %arg2[1, 11] : f32 from vector<3x15xf32>
    %79 = vector.broadcast %78 : f32 to vector<f32>
    vector.transfer_write %79, %arg0[%44, %77] : vector<f32>, memref<?x?xf32>
    %80 = affine.apply #map11()[%arg1]
    %81 = vector.extract %arg2[1, 12] : f32 from vector<3x15xf32>
    %82 = vector.broadcast %81 : f32 to vector<f32>
    vector.transfer_write %82, %arg0[%44, %80] : vector<f32>, memref<?x?xf32>
    %83 = affine.apply #map12()[%arg1]
    %84 = vector.extract %arg2[1, 13] : f32 from vector<3x15xf32>
    %85 = vector.broadcast %84 : f32 to vector<f32>
    vector.transfer_write %85, %arg0[%44, %83] : vector<f32>, memref<?x?xf32>
    %86 = affine.apply #map13()[%arg1]
    %87 = vector.extract %arg2[1, 14] : f32 from vector<3x15xf32>
    %88 = vector.broadcast %87 : f32 to vector<f32>
    vector.transfer_write %88, %arg0[%44, %86] : vector<f32>, memref<?x?xf32>
    %89 = affine.apply #map1()[%arg1]
    %90 = vector.extract %arg2[2, 0] : f32 from vector<3x15xf32>
    %91 = vector.broadcast %90 : f32 to vector<f32>
    vector.transfer_write %91, %arg0[%89, %arg1] : vector<f32>, memref<?x?xf32>
    %92 = affine.apply #map()[%arg1]
    %93 = vector.extract %arg2[2, 1] : f32 from vector<3x15xf32>
    %94 = vector.broadcast %93 : f32 to vector<f32>
    vector.transfer_write %94, %arg0[%89, %92] : vector<f32>, memref<?x?xf32>
    %95 = affine.apply #map1()[%arg1]
    %96 = vector.extract %arg2[2, 2] : f32 from vector<3x15xf32>
    %97 = vector.broadcast %96 : f32 to vector<f32>
    vector.transfer_write %97, %arg0[%89, %95] : vector<f32>, memref<?x?xf32>
    %98 = affine.apply #map2()[%arg1]
    %99 = vector.extract %arg2[2, 3] : f32 from vector<3x15xf32>
    %100 = vector.broadcast %99 : f32 to vector<f32>
    vector.transfer_write %100, %arg0[%89, %98] : vector<f32>, memref<?x?xf32>
    %101 = affine.apply #map3()[%arg1]
    %102 = vector.extract %arg2[2, 4] : f32 from vector<3x15xf32>
    %103 = vector.broadcast %102 : f32 to vector<f32>
    vector.transfer_write %103, %arg0[%89, %101] : vector<f32>, memref<?x?xf32>
    %104 = affine.apply #map4()[%arg1]
    %105 = vector.extract %arg2[2, 5] : f32 from vector<3x15xf32>
    %106 = vector.broadcast %105 : f32 to vector<f32>
    vector.transfer_write %106, %arg0[%89, %104] : vector<f32>, memref<?x?xf32>
    %107 = affine.apply #map5()[%arg1]
    %108 = vector.extract %arg2[2, 6] : f32 from vector<3x15xf32>
    %109 = vector.broadcast %108 : f32 to vector<f32>
    vector.transfer_write %109, %arg0[%89, %107] : vector<f32>, memref<?x?xf32>
    %110 = affine.apply #map6()[%arg1]
    %111 = vector.extract %arg2[2, 7] : f32 from vector<3x15xf32>
    %112 = vector.broadcast %111 : f32 to vector<f32>
    vector.transfer_write %112, %arg0[%89, %110] : vector<f32>, memref<?x?xf32>
    %113 = affine.apply #map7()[%arg1]
    %114 = vector.extract %arg2[2, 8] : f32 from vector<3x15xf32>
    %115 = vector.broadcast %114 : f32 to vector<f32>
    vector.transfer_write %115, %arg0[%89, %113] : vector<f32>, memref<?x?xf32>
    %116 = affine.apply #map8()[%arg1]
    %117 = vector.extract %arg2[2, 9] : f32 from vector<3x15xf32>
    %118 = vector.broadcast %117 : f32 to vector<f32>
    vector.transfer_write %118, %arg0[%89, %116] : vector<f32>, memref<?x?xf32>
    %119 = affine.apply #map9()[%arg1]
    %120 = vector.extract %arg2[2, 10] : f32 from vector<3x15xf32>
    %121 = vector.broadcast %120 : f32 to vector<f32>
    vector.transfer_write %121, %arg0[%89, %119] : vector<f32>, memref<?x?xf32>
    %122 = affine.apply #map10()[%arg1]
    %123 = vector.extract %arg2[2, 11] : f32 from vector<3x15xf32>
    %124 = vector.broadcast %123 : f32 to vector<f32>
    vector.transfer_write %124, %arg0[%89, %122] : vector<f32>, memref<?x?xf32>
    %125 = affine.apply #map11()[%arg1]
    %126 = vector.extract %arg2[2, 12] : f32 from vector<3x15xf32>
    %127 = vector.broadcast %126 : f32 to vector<f32>
    vector.transfer_write %127, %arg0[%89, %125] : vector<f32>, memref<?x?xf32>
    %128 = affine.apply #map12()[%arg1]
    %129 = vector.extract %arg2[2, 13] : f32 from vector<3x15xf32>
    %130 = vector.broadcast %129 : f32 to vector<f32>
    vector.transfer_write %130, %arg0[%89, %128] : vector<f32>, memref<?x?xf32>
    %131 = affine.apply #map13()[%arg1]
    %132 = vector.extract %arg2[2, 14] : f32 from vector<3x15xf32>
    %133 = vector.broadcast %132 : f32 to vector<f32>
    vector.transfer_write %133, %arg0[%89, %131] : vector<f32>, memref<?x?xf32>
    return
  }
}

// -----
module {
  func.func @transfer_read_simple(%arg0: memref<2x2xf32>) -> vector<2x2xf32> {
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant dense<0.000000e+00> : vector<2x2xf32>
    %c0 = arith.constant 0 : index
    %0 = vector.transfer_read %arg0[%c0, %c0], %cst : memref<2x2xf32>, vector<f32>
    %1 = vector.extract %0[] : f32 from vector<f32>
    %2 = vector.insert %1, %cst_0 [0, 0] : f32 into vector<2x2xf32>
    %3 = vector.transfer_read %arg0[%c0, %c1], %cst : memref<2x2xf32>, vector<f32>
    %4 = vector.extract %3[] : f32 from vector<f32>
    %5 = vector.insert %4, %2 [0, 1] : f32 into vector<2x2xf32>
    %6 = vector.transfer_read %arg0[%c1, %c0], %cst : memref<2x2xf32>, vector<f32>
    %7 = vector.extract %6[] : f32 from vector<f32>
    %8 = vector.insert %7, %5 [1, 0] : f32 into vector<2x2xf32>
    %9 = vector.transfer_read %arg0[%c1, %c1], %cst : memref<2x2xf32>, vector<f32>
    %10 = vector.extract %9[] : f32 from vector<f32>
    %11 = vector.insert %10, %8 [1, 1] : f32 into vector<2x2xf32>
    return %11 : vector<2x2xf32>
  }
  func.func @transfer_read_minor_identity(%arg0: memref<?x?x?x?xf32>) -> vector<3x3xf32> {
    %c3 = arith.constant 3 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant dense<0.000000e+00> : vector<3x3xf32>
    %c2 = arith.constant 2 : index
    %dim = memref.dim %arg0, %c2 : memref<?x?x?x?xf32>
    %0 = arith.cmpi sgt, %dim, %c0 : index
    %1 = scf.if %0 -> (vector<3x3xf32>) {
      %dim_3 = memref.dim %arg0, %c3 : memref<?x?x?x?xf32>
      %6 = arith.cmpi sgt, %dim_3, %c0 : index
      %7 = scf.if %6 -> (vector<3x3xf32>) {
        %12 = vector.transfer_read %arg0[%c0, %c0, %c0, %c0], %cst : memref<?x?x?x?xf32>, vector<f32>
        %13 = vector.extract %12[] : f32 from vector<f32>
        %14 = vector.insert %13, %cst_0 [0, 0] : f32 into vector<3x3xf32>
        scf.yield %14 : vector<3x3xf32>
      } else {
        scf.yield %cst_0 : vector<3x3xf32>
      }
      %dim_4 = memref.dim %arg0, %c3 : memref<?x?x?x?xf32>
      %8 = arith.cmpi sgt, %dim_4, %c1 : index
      %9 = scf.if %8 -> (vector<3x3xf32>) {
        %12 = vector.transfer_read %arg0[%c0, %c0, %c0, %c1], %cst : memref<?x?x?x?xf32>, vector<f32>
        %13 = vector.extract %12[] : f32 from vector<f32>
        %14 = vector.insert %13, %7 [0, 1] : f32 into vector<3x3xf32>
        scf.yield %14 : vector<3x3xf32>
      } else {
        scf.yield %7 : vector<3x3xf32>
      }
      %dim_5 = memref.dim %arg0, %c3 : memref<?x?x?x?xf32>
      %10 = arith.cmpi sgt, %dim_5, %c2 : index
      %11 = scf.if %10 -> (vector<3x3xf32>) {
        %12 = vector.transfer_read %arg0[%c0, %c0, %c0, %c2], %cst : memref<?x?x?x?xf32>, vector<f32>
        %13 = vector.extract %12[] : f32 from vector<f32>
        %14 = vector.insert %13, %9 [0, 2] : f32 into vector<3x3xf32>
        scf.yield %14 : vector<3x3xf32>
      } else {
        scf.yield %9 : vector<3x3xf32>
      }
      scf.yield %11 : vector<3x3xf32>
    } else {
      scf.yield %cst_0 : vector<3x3xf32>
    }
    %dim_1 = memref.dim %arg0, %c2 : memref<?x?x?x?xf32>
    %2 = arith.cmpi sgt, %dim_1, %c1 : index
    %3 = scf.if %2 -> (vector<3x3xf32>) {
      %dim_3 = memref.dim %arg0, %c3 : memref<?x?x?x?xf32>
      %6 = arith.cmpi sgt, %dim_3, %c0 : index
      %7 = scf.if %6 -> (vector<3x3xf32>) {
        %12 = vector.transfer_read %arg0[%c0, %c0, %c1, %c0], %cst : memref<?x?x?x?xf32>, vector<f32>
        %13 = vector.extract %12[] : f32 from vector<f32>
        %14 = vector.insert %13, %1 [1, 0] : f32 into vector<3x3xf32>
        scf.yield %14 : vector<3x3xf32>
      } else {
        scf.yield %1 : vector<3x3xf32>
      }
      %dim_4 = memref.dim %arg0, %c3 : memref<?x?x?x?xf32>
      %8 = arith.cmpi sgt, %dim_4, %c1 : index
      %9 = scf.if %8 -> (vector<3x3xf32>) {
        %12 = vector.transfer_read %arg0[%c0, %c0, %c1, %c1], %cst : memref<?x?x?x?xf32>, vector<f32>
        %13 = vector.extract %12[] : f32 from vector<f32>
        %14 = vector.insert %13, %7 [1, 1] : f32 into vector<3x3xf32>
        scf.yield %14 : vector<3x3xf32>
      } else {
        scf.yield %7 : vector<3x3xf32>
      }
      %dim_5 = memref.dim %arg0, %c3 : memref<?x?x?x?xf32>
      %10 = arith.cmpi sgt, %dim_5, %c2 : index
      %11 = scf.if %10 -> (vector<3x3xf32>) {
        %12 = vector.transfer_read %arg0[%c0, %c0, %c1, %c2], %cst : memref<?x?x?x?xf32>, vector<f32>
        %13 = vector.extract %12[] : f32 from vector<f32>
        %14 = vector.insert %13, %9 [1, 2] : f32 into vector<3x3xf32>
        scf.yield %14 : vector<3x3xf32>
      } else {
        scf.yield %9 : vector<3x3xf32>
      }
      scf.yield %11 : vector<3x3xf32>
    } else {
      scf.yield %1 : vector<3x3xf32>
    }
    %dim_2 = memref.dim %arg0, %c2 : memref<?x?x?x?xf32>
    %4 = arith.cmpi sgt, %dim_2, %c2 : index
    %5 = scf.if %4 -> (vector<3x3xf32>) {
      %dim_3 = memref.dim %arg0, %c3 : memref<?x?x?x?xf32>
      %6 = arith.cmpi sgt, %dim_3, %c0 : index
      %7 = scf.if %6 -> (vector<3x3xf32>) {
        %12 = vector.transfer_read %arg0[%c0, %c0, %c2, %c0], %cst : memref<?x?x?x?xf32>, vector<f32>
        %13 = vector.extract %12[] : f32 from vector<f32>
        %14 = vector.insert %13, %3 [2, 0] : f32 into vector<3x3xf32>
        scf.yield %14 : vector<3x3xf32>
      } else {
        scf.yield %3 : vector<3x3xf32>
      }
      %dim_4 = memref.dim %arg0, %c3 : memref<?x?x?x?xf32>
      %8 = arith.cmpi sgt, %dim_4, %c1 : index
      %9 = scf.if %8 -> (vector<3x3xf32>) {
        %12 = vector.transfer_read %arg0[%c0, %c0, %c2, %c1], %cst : memref<?x?x?x?xf32>, vector<f32>
        %13 = vector.extract %12[] : f32 from vector<f32>
        %14 = vector.insert %13, %7 [2, 1] : f32 into vector<3x3xf32>
        scf.yield %14 : vector<3x3xf32>
      } else {
        scf.yield %7 : vector<3x3xf32>
      }
      %dim_5 = memref.dim %arg0, %c3 : memref<?x?x?x?xf32>
      %10 = arith.cmpi sgt, %dim_5, %c2 : index
      %11 = scf.if %10 -> (vector<3x3xf32>) {
        %12 = vector.transfer_read %arg0[%c0, %c0, %c2, %c2], %cst : memref<?x?x?x?xf32>, vector<f32>
        %13 = vector.extract %12[] : f32 from vector<f32>
        %14 = vector.insert %13, %9 [2, 2] : f32 into vector<3x3xf32>
        scf.yield %14 : vector<3x3xf32>
      } else {
        scf.yield %9 : vector<3x3xf32>
      }
      scf.yield %11 : vector<3x3xf32>
    } else {
      scf.yield %3 : vector<3x3xf32>
    }
    return %5 : vector<3x3xf32>
  }
  func.func @transfer_write_minor_identity(%arg0: vector<3x3xf32>, %arg1: memref<?x?x?x?xf32>) {
    %c3 = arith.constant 3 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %dim = memref.dim %arg1, %c2 : memref<?x?x?x?xf32>
    %0 = arith.cmpi sgt, %dim, %c0 : index
    scf.if %0 {
      %dim_2 = memref.dim %arg1, %c3 : memref<?x?x?x?xf32>
      %3 = arith.cmpi sgt, %dim_2, %c0 : index
      scf.if %3 {
        %6 = vector.extract %arg0[0, 0] : f32 from vector<3x3xf32>
        %7 = vector.broadcast %6 : f32 to vector<f32>
        vector.transfer_write %7, %arg1[%c0, %c0, %c0, %c0] : vector<f32>, memref<?x?x?x?xf32>
      } else {
      }
      %dim_3 = memref.dim %arg1, %c3 : memref<?x?x?x?xf32>
      %4 = arith.cmpi sgt, %dim_3, %c1 : index
      scf.if %4 {
        %6 = vector.extract %arg0[0, 1] : f32 from vector<3x3xf32>
        %7 = vector.broadcast %6 : f32 to vector<f32>
        vector.transfer_write %7, %arg1[%c0, %c0, %c0, %c1] : vector<f32>, memref<?x?x?x?xf32>
      } else {
      }
      %dim_4 = memref.dim %arg1, %c3 : memref<?x?x?x?xf32>
      %5 = arith.cmpi sgt, %dim_4, %c2 : index
      scf.if %5 {
        %6 = vector.extract %arg0[0, 2] : f32 from vector<3x3xf32>
        %7 = vector.broadcast %6 : f32 to vector<f32>
        vector.transfer_write %7, %arg1[%c0, %c0, %c0, %c2] : vector<f32>, memref<?x?x?x?xf32>
      } else {
      }
    } else {
    }
    %dim_0 = memref.dim %arg1, %c2 : memref<?x?x?x?xf32>
    %1 = arith.cmpi sgt, %dim_0, %c1 : index
    scf.if %1 {
      %dim_2 = memref.dim %arg1, %c3 : memref<?x?x?x?xf32>
      %3 = arith.cmpi sgt, %dim_2, %c0 : index
      scf.if %3 {
        %6 = vector.extract %arg0[1, 0] : f32 from vector<3x3xf32>
        %7 = vector.broadcast %6 : f32 to vector<f32>
        vector.transfer_write %7, %arg1[%c0, %c0, %c1, %c0] : vector<f32>, memref<?x?x?x?xf32>
      } else {
      }
      %dim_3 = memref.dim %arg1, %c3 : memref<?x?x?x?xf32>
      %4 = arith.cmpi sgt, %dim_3, %c1 : index
      scf.if %4 {
        %6 = vector.extract %arg0[1, 1] : f32 from vector<3x3xf32>
        %7 = vector.broadcast %6 : f32 to vector<f32>
        vector.transfer_write %7, %arg1[%c0, %c0, %c1, %c1] : vector<f32>, memref<?x?x?x?xf32>
      } else {
      }
      %dim_4 = memref.dim %arg1, %c3 : memref<?x?x?x?xf32>
      %5 = arith.cmpi sgt, %dim_4, %c2 : index
      scf.if %5 {
        %6 = vector.extract %arg0[1, 2] : f32 from vector<3x3xf32>
        %7 = vector.broadcast %6 : f32 to vector<f32>
        vector.transfer_write %7, %arg1[%c0, %c0, %c1, %c2] : vector<f32>, memref<?x?x?x?xf32>
      } else {
      }
    } else {
    }
    %dim_1 = memref.dim %arg1, %c2 : memref<?x?x?x?xf32>
    %2 = arith.cmpi sgt, %dim_1, %c2 : index
    scf.if %2 {
      %dim_2 = memref.dim %arg1, %c3 : memref<?x?x?x?xf32>
      %3 = arith.cmpi sgt, %dim_2, %c0 : index
      scf.if %3 {
        %6 = vector.extract %arg0[2, 0] : f32 from vector<3x3xf32>
        %7 = vector.broadcast %6 : f32 to vector<f32>
        vector.transfer_write %7, %arg1[%c0, %c0, %c2, %c0] : vector<f32>, memref<?x?x?x?xf32>
      } else {
      }
      %dim_3 = memref.dim %arg1, %c3 : memref<?x?x?x?xf32>
      %4 = arith.cmpi sgt, %dim_3, %c1 : index
      scf.if %4 {
        %6 = vector.extract %arg0[2, 1] : f32 from vector<3x3xf32>
        %7 = vector.broadcast %6 : f32 to vector<f32>
        vector.transfer_write %7, %arg1[%c0, %c0, %c2, %c1] : vector<f32>, memref<?x?x?x?xf32>
      } else {
      }
      %dim_4 = memref.dim %arg1, %c3 : memref<?x?x?x?xf32>
      %5 = arith.cmpi sgt, %dim_4, %c2 : index
      scf.if %5 {
        %6 = vector.extract %arg0[2, 2] : f32 from vector<3x3xf32>
        %7 = vector.broadcast %6 : f32 to vector<f32>
        vector.transfer_write %7, %arg1[%c0, %c0, %c2, %c2] : vector<f32>, memref<?x?x?x?xf32>
      } else {
      }
    } else {
    }
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0 + d1 * 8)>
module {
  func.func @transfer_read_strided(%arg0: memref<8x4xf32, #map>) -> vector<4xf32> {
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant dense<0.000000e+00> : vector<4xf32>
    %0 = vector.transfer_read %arg0[%c0, %c0], %cst : memref<8x4xf32, #map>, vector<f32>
    %1 = vector.extract %0[] : f32 from vector<f32>
    %2 = vector.insert %1, %cst_0 [0] : f32 into vector<4xf32>
    %3 = vector.transfer_read %arg0[%c0, %c1], %cst : memref<8x4xf32, #map>, vector<f32>
    %4 = vector.extract %3[] : f32 from vector<f32>
    %5 = vector.insert %4, %2 [1] : f32 into vector<4xf32>
    %6 = vector.transfer_read %arg0[%c0, %c2], %cst : memref<8x4xf32, #map>, vector<f32>
    %7 = vector.extract %6[] : f32 from vector<f32>
    %8 = vector.insert %7, %5 [2] : f32 into vector<4xf32>
    %9 = vector.transfer_read %arg0[%c0, %c3], %cst : memref<8x4xf32, #map>, vector<f32>
    %10 = vector.extract %9[] : f32 from vector<f32>
    %11 = vector.insert %10, %8 [3] : f32 into vector<4xf32>
    return %11 : vector<4xf32>
  }
  func.func @transfer_write_strided(%arg0: vector<4xf32>, %arg1: memref<8x4xf32, #map>) {
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %0 = vector.extract %arg0[0] : f32 from vector<4xf32>
    %1 = vector.broadcast %0 : f32 to vector<f32>
    vector.transfer_write %1, %arg1[%c0, %c0] : vector<f32>, memref<8x4xf32, #map>
    %2 = vector.extract %arg0[1] : f32 from vector<4xf32>
    %3 = vector.broadcast %2 : f32 to vector<f32>
    vector.transfer_write %3, %arg1[%c0, %c1] : vector<f32>, memref<8x4xf32, #map>
    %4 = vector.extract %arg0[2] : f32 from vector<4xf32>
    %5 = vector.broadcast %4 : f32 to vector<f32>
    vector.transfer_write %5, %arg1[%c0, %c2] : vector<f32>, memref<8x4xf32, #map>
    %6 = vector.extract %arg0[3] : f32 from vector<4xf32>
    %7 = vector.broadcast %6 : f32 to vector<f32>
    vector.transfer_write %7, %arg1[%c0, %c3] : vector<f32>, memref<8x4xf32, #map>
    return
  }
}

// -----
module {
  func.func private @fake_side_effecting_fun(vector<2x2xf32>)
  func.func @transfer_read_within_async_execute(%arg0: memref<2x2xf32>) -> !async.token {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<0.000000e+00> : vector<2x2xf32>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %token = async.execute {
      %0 = vector.transfer_read %arg0[%c0, %c0], %cst_0 : memref<2x2xf32>, vector<f32>
      %1 = vector.extract %0[] : f32 from vector<f32>
      %2 = vector.insert %1, %cst [0, 0] : f32 into vector<2x2xf32>
      %3 = vector.transfer_read %arg0[%c0, %c1], %cst_0 : memref<2x2xf32>, vector<f32>
      %4 = vector.extract %3[] : f32 from vector<f32>
      %5 = vector.insert %4, %2 [0, 1] : f32 into vector<2x2xf32>
      %6 = vector.transfer_read %arg0[%c1, %c0], %cst_0 : memref<2x2xf32>, vector<f32>
      %7 = vector.extract %6[] : f32 from vector<f32>
      %8 = vector.insert %7, %5 [1, 0] : f32 into vector<2x2xf32>
      %9 = vector.transfer_read %arg0[%c1, %c1], %cst_0 : memref<2x2xf32>, vector<f32>
      %10 = vector.extract %9[] : f32 from vector<f32>
      %11 = vector.insert %10, %8 [1, 1] : f32 into vector<2x2xf32>
      func.call @fake_side_effecting_fun(%11) : (vector<2x2xf32>) -> ()
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
    vector.transfer_write %9, %arg0[%c0], %7 {in_bounds = [true]} : vector<[16]xf32>, memref<?xf32, strided<[?], offset: ?>>
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
    %0 = vector.extract %arg1[0, 0] : i1 from vector<1x1xi1>
    %1 = scf.if %0 -> (vector<1x1x1x1xi32>) {
      %2 = vector.transfer_read %arg0[%c0, %c0, %c0, %c0], %c0_i32 : memref<1x1x1x1xi32>, vector<i32>
      %3 = vector.extract %2[] : i32 from vector<i32>
      %4 = vector.insert %3, %cst [0, 0, 0, 0] : i32 into vector<1x1x1x1xi32>
      scf.yield %4 : vector<1x1x1x1xi32>
    } else {
      scf.yield %cst : vector<1x1x1x1xi32>
    }
    return %1 : vector<1x1x1x1xi32>
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
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<4xi32>
    %0 = vector.extract %arg0[0] : i32 from vector<2xi32>
    %1 = vector.broadcast %0 : i32 to vector<i32>
    vector.transfer_write %1, %alloc[%c0] : vector<i32>, memref<4xi32>
    %2 = vector.extract %arg0[1] : i32 from vector<2xi32>
    %3 = vector.broadcast %2 : i32 to vector<i32>
    vector.transfer_write %3, %alloc[%c1] : vector<i32>, memref<4xi32>
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


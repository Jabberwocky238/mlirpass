module {
  func.func @empty() {
    return
  }
  func.func private @body(index)
  func.func @simple_loop() {
    %c1 = arith.constant 1 : index
    %c42 = arith.constant 42 : index
    %c1_0 = arith.constant 1 : index
    scf.for %arg0 = %c1 to %c42 step %c1_0 {
      func.call @body(%arg0) : (index) -> ()
    }
    return
  }
  func.func @for_with_yield(%arg0: memref<1024xf32>) -> f32 {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %c10 = arith.constant 10 : index
    %c2 = arith.constant 2 : index
    %0 = scf.for %arg1 = %c0 to %c10 step %c2 iter_args(%arg2 = %cst) -> (f32) {
      %1 = memref.load %arg0[%arg1] : memref<1024xf32>
      %2 = arith.addf %arg2, %1 : f32
      scf.yield %2 : f32
    }
    return %0 : f32
  }
  func.func private @pre(index)
  func.func private @body2(index, index)
  func.func private @post(index)
  func.func @imperfectly_nested_loops() {
    %c0 = arith.constant 0 : index
    %c42 = arith.constant 42 : index
    %c1 = arith.constant 1 : index
    scf.for %arg0 = %c0 to %c42 step %c1 {
      func.call @pre(%arg0) : (index) -> ()
      %c7 = arith.constant 7 : index
      %c56 = arith.constant 56 : index
      %c2 = arith.constant 2 : index
      scf.for %arg1 = %c7 to %c56 step %c2 {
        func.call @body2(%arg0, %arg1) : (index, index) -> ()
      }
      func.call @post(%arg0) : (index) -> ()
    }
    return
  }
  func.func private @mid(index)
  func.func private @body3(index, index)
  func.func @more_imperfectly_nested_loops() {
    %c0 = arith.constant 0 : index
    %c42 = arith.constant 42 : index
    %c1 = arith.constant 1 : index
    scf.for %arg0 = %c0 to %c42 step %c1 {
      func.call @pre(%arg0) : (index) -> ()
      %c7 = arith.constant 7 : index
      %c56 = arith.constant 56 : index
      %c2 = arith.constant 2 : index
      scf.for %arg1 = %c7 to %c56 step %c2 {
        func.call @body2(%arg0, %arg1) : (index, index) -> ()
      }
      func.call @mid(%arg0) : (index) -> ()
      %c18 = arith.constant 18 : index
      %c37 = arith.constant 37 : index
      %c3 = arith.constant 3 : index
      scf.for %arg1 = %c18 to %c37 step %c3 {
        func.call @body3(%arg0, %arg1) : (index, index) -> ()
      }
      func.call @post(%arg0) : (index) -> ()
    }
    return
  }
  func.func @affine_apply_loops_shorthand(%arg0: index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    scf.for %arg1 = %c0 to %arg0 step %c1 {
      %c42 = arith.constant 42 : index
      %c1_0 = arith.constant 1 : index
      scf.for %arg2 = %arg1 to %c42 step %c1_0 {
        func.call @body2(%arg1, %arg2) : (index, index) -> ()
      }
    }
    return
  }
  func.func private @get_idx() -> index
  func.func @if_only() {
    %0 = call @get_idx() : () -> index
    %c0 = arith.constant 0 : index
    %c-1 = arith.constant -1 : index
    %1 = arith.muli %0, %c-1 overflow<nsw> : index
    %c20 = arith.constant 20 : index
    %2 = arith.addi %1, %c20 : index
    %3 = arith.cmpi sge, %2, %c0 : index
    scf.if %3 {
      func.call @body(%0) : (index) -> ()
    }
    return
  }
  func.func @if_else() {
    %0 = call @get_idx() : () -> index
    %c0 = arith.constant 0 : index
    %c-1 = arith.constant -1 : index
    %1 = arith.muli %0, %c-1 overflow<nsw> : index
    %c20 = arith.constant 20 : index
    %2 = arith.addi %1, %c20 : index
    %3 = arith.cmpi sge, %2, %c0 : index
    scf.if %3 {
      func.call @body(%0) : (index) -> ()
    } else {
      func.call @mid(%0) : (index) -> ()
    }
    return
  }
  func.func @nested_ifs() {
    %0 = call @get_idx() : () -> index
    %c0 = arith.constant 0 : index
    %c-1 = arith.constant -1 : index
    %1 = arith.muli %0, %c-1 overflow<nsw> : index
    %c20 = arith.constant 20 : index
    %2 = arith.addi %1, %c20 : index
    %3 = arith.cmpi sge, %2, %c0 : index
    scf.if %3 {
      %c0_0 = arith.constant 0 : index
      %c-10 = arith.constant -10 : index
      %4 = arith.addi %0, %c-10 : index
      %5 = arith.cmpi sge, %4, %c0_0 : index
      scf.if %5 {
        func.call @body(%0) : (index) -> ()
      }
    } else {
      %c0_0 = arith.constant 0 : index
      %c-10 = arith.constant -10 : index
      %4 = arith.addi %0, %c-10 : index
      %5 = arith.cmpi sge, %4, %c0_0 : index
      scf.if %5 {
        func.call @mid(%0) : (index) -> ()
      }
    }
    return
  }
  func.func @if_with_yield() -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = call @get_idx() : () -> index
    %c0 = arith.constant 0 : index
    %c-10 = arith.constant -10 : index
    %1 = arith.addi %0, %c-10 : index
    %2 = arith.cmpi sge, %1, %c0 : index
    %3 = scf.if %2 -> (i64) {
      scf.yield %c0_i64 : i64
    } else {
      scf.yield %c1_i64 : i64
    }
    return %3 : i64
  }
  func.func @multi_cond(%arg0: index, %arg1: index, %arg2: index, %arg3: index) {
    %0 = call @get_idx() : () -> index
    %c0 = arith.constant 0 : index
    %c-1 = arith.constant -1 : index
    %1 = arith.muli %0, %c-1 overflow<nsw> : index
    %2 = arith.addi %1, %arg0 : index
    %c1 = arith.constant 1 : index
    %3 = arith.addi %2, %c1 : index
    %4 = arith.cmpi sge, %3, %c0 : index
    %c-1_0 = arith.constant -1 : index
    %5 = arith.addi %arg0, %c-1_0 : index
    %6 = arith.cmpi sge, %5, %c0 : index
    %7 = arith.andi %4, %6 : i1
    %c-1_1 = arith.constant -1 : index
    %8 = arith.addi %arg1, %c-1_1 : index
    %9 = arith.cmpi sge, %8, %c0 : index
    %10 = arith.andi %7, %9 : i1
    %c-1_2 = arith.constant -1 : index
    %11 = arith.addi %arg2, %c-1_2 : index
    %12 = arith.cmpi sge, %11, %c0 : index
    %13 = arith.andi %10, %12 : i1
    %c-42 = arith.constant -42 : index
    %14 = arith.addi %arg3, %c-42 : index
    %15 = arith.cmpi eq, %14, %c0 : index
    %16 = arith.andi %13, %15 : i1
    scf.if %16 {
      func.call @body(%0) : (index) -> ()
    } else {
      func.call @mid(%0) : (index) -> ()
    }
    return
  }
  func.func @if_for() {
    %0 = call @get_idx() : () -> index
    %c0 = arith.constant 0 : index
    %c-1 = arith.constant -1 : index
    %1 = arith.muli %0, %c-1 overflow<nsw> : index
    %c20 = arith.constant 20 : index
    %2 = arith.addi %1, %c20 : index
    %3 = arith.cmpi sge, %2, %c0 : index
    scf.if %3 {
      %c0_1 = arith.constant 0 : index
      %c42_2 = arith.constant 42 : index
      %c1_3 = arith.constant 1 : index
      scf.for %arg0 = %c0_1 to %c42_2 step %c1_3 {
        %c0_4 = arith.constant 0 : index
        %c-10 = arith.constant -10 : index
        %4 = arith.addi %arg0, %c-10 : index
        %5 = arith.cmpi sge, %4, %c0_4 : index
        scf.if %5 {
          func.call @body2(%0, %arg0) : (index, index) -> ()
        }
      }
    }
    %c0_0 = arith.constant 0 : index
    %c42 = arith.constant 42 : index
    %c1 = arith.constant 1 : index
    scf.for %arg0 = %c0_0 to %c42 step %c1 {
      %c0_1 = arith.constant 0 : index
      %c-10 = arith.constant -10 : index
      %4 = arith.addi %arg0, %c-10 : index
      %5 = arith.cmpi sge, %4, %c0_1 : index
      scf.if %5 {
        %c0_2 = arith.constant 0 : index
        %c42_3 = arith.constant 42 : index
        %c1_4 = arith.constant 1 : index
        scf.for %arg1 = %c0_2 to %c42_3 step %c1_4 {
          func.call @body3(%arg0, %arg1) : (index, index) -> ()
        }
      }
    }
    return
  }
  func.func @loop_min_max(%arg0: index) {
    %c0 = arith.constant 0 : index
    %c42 = arith.constant 42 : index
    %c1 = arith.constant 1 : index
    scf.for %arg1 = %c0 to %c42 step %c1 {
      %c-1 = arith.constant -1 : index
      %0 = arith.muli %arg1, %c-1 overflow<nsw> : index
      %1 = arith.addi %0, %arg0 : index
      %2 = arith.maxsi %arg1, %1 : index
      %c10 = arith.constant 10 : index
      %3 = arith.addi %arg1, %c10 : index
      %4 = arith.minsi %arg0, %3 : index
      %c1_0 = arith.constant 1 : index
      scf.for %arg2 = %2 to %4 step %c1_0 {
        func.call @body2(%arg1, %arg2) : (index, index) -> ()
      }
    }
    return
  }
  func.func @min_reduction_tree(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index) {
    %c0 = arith.constant 0 : index
    %0 = arith.minsi %arg0, %arg1 : index
    %1 = arith.minsi %0, %arg2 : index
    %2 = arith.minsi %1, %arg3 : index
    %3 = arith.minsi %2, %arg4 : index
    %4 = arith.minsi %3, %arg5 : index
    %5 = arith.minsi %4, %arg6 : index
    %c1 = arith.constant 1 : index
    scf.for %arg7 = %c0 to %5 step %c1 {
      func.call @body(%arg7) : (index) -> ()
    }
    return
  }
  func.func @affine_applies(%arg0: index) {
    %c0 = arith.constant 0 : index
    %c101 = arith.constant 101 : index
    %c102 = arith.constant 102 : index
    %0 = arith.addi %c0, %c0 : index
    %c1 = arith.constant 1 : index
    %1 = arith.addi %0, %c1 : index
    %c2 = arith.constant 2 : index
    %2 = arith.muli %arg0, %c2 overflow<nsw> : index
    %3 = arith.addi %arg0, %2 : index
    %c3 = arith.constant 3 : index
    %4 = arith.muli %arg0, %c3 overflow<nsw> : index
    %5 = arith.addi %3, %4 : index
    %c4 = arith.constant 4 : index
    %6 = arith.muli %arg0, %c4 overflow<nsw> : index
    %7 = arith.addi %5, %6 : index
    %c5 = arith.constant 5 : index
    %8 = arith.muli %arg0, %c5 overflow<nsw> : index
    %9 = arith.addi %7, %8 : index
    %c6 = arith.constant 6 : index
    %10 = arith.muli %arg0, %c6 overflow<nsw> : index
    %11 = arith.addi %9, %10 : index
    %c7 = arith.constant 7 : index
    %12 = arith.muli %arg0, %c7 overflow<nsw> : index
    %13 = arith.addi %11, %12 : index
    return
  }
  func.func @args_ret_affine_apply(%arg0: index, %arg1: index) -> (index, index) {
    return %arg0, %arg1 : index, index
  }
  func.func @affine_apply_mod(%arg0: index) -> index {
    %c42 = arith.constant 42 : index
    %0 = arith.remsi %arg0, %c42 : index
    %c0 = arith.constant 0 : index
    %1 = arith.cmpi slt, %0, %c0 : index
    %2 = arith.addi %0, %c42 : index
    %3 = arith.select %1, %2, %0 : index
    return %3 : index
  }
  func.func @affine_apply_mod_dynamic_divisor(%arg0: index, %arg1: index) -> index {
    %0 = arith.remsi %arg0, %arg1 : index
    %c0 = arith.constant 0 : index
    %1 = arith.cmpi slt, %0, %c0 : index
    %2 = arith.addi %0, %arg1 : index
    %3 = arith.select %1, %2, %0 : index
    return %3 : index
  }
  func.func @affine_apply_floordiv(%arg0: index) -> index {
    %c42 = arith.constant 42 : index
    %c0 = arith.constant 0 : index
    %c-1 = arith.constant -1 : index
    %0 = arith.cmpi slt, %arg0, %c0 : index
    %1 = arith.subi %c-1, %arg0 : index
    %2 = arith.select %0, %1, %arg0 : index
    %3 = arith.divsi %2, %c42 : index
    %4 = arith.subi %c-1, %3 : index
    %5 = arith.select %0, %4, %3 : index
    return %5 : index
  }
  func.func @affine_apply_floordiv_dynamic_divisor(%arg0: index, %arg1: index) -> index {
    %c0 = arith.constant 0 : index
    %c-1 = arith.constant -1 : index
    %0 = arith.cmpi slt, %arg0, %c0 : index
    %1 = arith.subi %c-1, %arg0 : index
    %2 = arith.select %0, %1, %arg0 : index
    %3 = arith.divsi %2, %arg1 : index
    %4 = arith.subi %c-1, %3 : index
    %5 = arith.select %0, %4, %3 : index
    return %5 : index
  }
  func.func @affine_apply_ceildiv(%arg0: index) -> index {
    %c42 = arith.constant 42 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0 = arith.cmpi sle, %arg0, %c0 : index
    %1 = arith.subi %c0, %arg0 : index
    %2 = arith.subi %arg0, %c1 : index
    %3 = arith.select %0, %1, %2 : index
    %4 = arith.divsi %3, %c42 : index
    %5 = arith.subi %c0, %4 : index
    %6 = arith.addi %4, %c1 : index
    %7 = arith.select %0, %5, %6 : index
    return %7 : index
  }
  func.func @affine_apply_ceildiv_dynamic_divisor(%arg0: index, %arg1: index) -> index {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0 = arith.cmpi sle, %arg0, %c0 : index
    %1 = arith.subi %c0, %arg0 : index
    %2 = arith.subi %arg0, %c1 : index
    %3 = arith.select %0, %1, %2 : index
    %4 = arith.divsi %3, %arg1 : index
    %5 = arith.subi %c0, %4 : index
    %6 = arith.addi %4, %c1 : index
    %7 = arith.select %0, %5, %6 : index
    return %7 : index
  }
  func.func @affine_load(%arg0: index) {
    %alloc = memref.alloc() : memref<10xf32>
    %c0 = arith.constant 0 : index
    %c10 = arith.constant 10 : index
    %c1 = arith.constant 1 : index
    scf.for %arg1 = %c0 to %c10 step %c1 {
      %0 = arith.addi %arg1, %arg0 : index
      %c7 = arith.constant 7 : index
      %1 = arith.addi %0, %c7 : index
      %2 = memref.load %alloc[%1] : memref<10xf32>
    }
    return
  }
  func.func @affine_store(%arg0: index) {
    %alloc = memref.alloc() : memref<10xf32>
    %cst = arith.constant 1.100000e+01 : f32
    %c0 = arith.constant 0 : index
    %c10 = arith.constant 10 : index
    %c1 = arith.constant 1 : index
    scf.for %arg1 = %c0 to %c10 step %c1 {
      %c-1 = arith.constant -1 : index
      %0 = arith.muli %arg0, %c-1 overflow<nsw> : index
      %1 = arith.addi %arg1, %0 : index
      %c7 = arith.constant 7 : index
      %2 = arith.addi %1, %c7 : index
      memref.store %cst, %alloc[%2] : memref<10xf32>
    }
    return
  }
  func.func @affine_load_store_zero_dim(%arg0: memref<i32>, %arg1: memref<i32>) {
    %0 = memref.load %arg0[] : memref<i32>
    memref.store %0, %arg1[] : memref<i32>
    return
  }
  func.func @affine_prefetch(%arg0: index) {
    %alloc = memref.alloc() : memref<10xf32>
    %c0 = arith.constant 0 : index
    %c10 = arith.constant 10 : index
    %c1 = arith.constant 1 : index
    scf.for %arg1 = %c0 to %c10 step %c1 {
      %0 = arith.addi %arg1, %arg0 : index
      %c7 = arith.constant 7 : index
      %1 = arith.addi %0, %c7 : index
      memref.prefetch %alloc[%1], read, locality<3>, data : memref<10xf32>
    }
    return
  }
  func.func @affine_dma_start(%arg0: index) {
    %alloc = memref.alloc() : memref<100xf32>
    %alloc_0 = memref.alloc() : memref<100xf32, 2>
    %alloc_1 = memref.alloc() : memref<1xi32>
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c0_2 = arith.constant 0 : index
    %c10 = arith.constant 10 : index
    %c1 = arith.constant 1 : index
    scf.for %arg1 = %c0_2 to %c10 step %c1 {
      %c7 = arith.constant 7 : index
      %0 = arith.addi %arg1, %c7 : index
      %c11 = arith.constant 11 : index
      %1 = arith.addi %arg0, %c11 : index
      memref.dma_start %alloc[%0], %alloc_0[%1], %c64, %alloc_1[%c0] : memref<100xf32>, memref<100xf32, 2>, memref<1xi32>
    }
    return
  }
  func.func @affine_dma_wait(%arg0: index) {
    %alloc = memref.alloc() : memref<1xi32>
    %c64 = arith.constant 64 : index
    %c0 = arith.constant 0 : index
    %c10 = arith.constant 10 : index
    %c1 = arith.constant 1 : index
    scf.for %arg1 = %c0 to %c10 step %c1 {
      %0 = arith.addi %arg1, %arg0 : index
      %c17 = arith.constant 17 : index
      %1 = arith.addi %0, %c17 : index
      memref.dma_wait %alloc[%1], %c64 : memref<1xi32>
    }
    return
  }
  func.func @affine_min(%arg0: index, %arg1: index) -> index {
    %c-1 = arith.constant -1 : index
    %0 = arith.muli %arg1, %c-1 overflow<nsw> : index
    %1 = arith.addi %arg0, %0 : index
    %c-1_0 = arith.constant -1 : index
    %2 = arith.muli %arg0, %c-1_0 overflow<nsw> : index
    %3 = arith.addi %arg1, %2 : index
    %4 = arith.minsi %1, %3 : index
    return %4 : index
  }
  func.func @affine_max(%arg0: index, %arg1: index) -> index {
    %c-1 = arith.constant -1 : index
    %0 = arith.muli %arg1, %c-1 overflow<nsw> : index
    %1 = arith.addi %arg0, %0 : index
    %c-1_0 = arith.constant -1 : index
    %2 = arith.muli %arg0, %c-1_0 overflow<nsw> : index
    %3 = arith.addi %arg1, %2 : index
    %4 = arith.maxsi %1, %3 : index
    return %4 : index
  }
  func.func @affine_parallel(%arg0: memref<100x100xf32>, %arg1: memref<100x100xf32>) {
    %c0 = arith.constant 0 : index
    %c100 = arith.constant 100 : index
    %c0_0 = arith.constant 0 : index
    %c100_1 = arith.constant 100 : index
    %c1 = arith.constant 1 : index
    %c1_2 = arith.constant 1 : index
    scf.parallel (%arg2, %arg3) = (%c0, %c0_0) to (%c100, %c100_1) step (%c1, %c1_2) {
      scf.reduce 
    }
    return
  }
  func.func @affine_parallel_tiled(%arg0: memref<100x100xf32>, %arg1: memref<100x100xf32>, %arg2: memref<100x100xf32>) {
    %c0 = arith.constant 0 : index
    %c100 = arith.constant 100 : index
    %c0_0 = arith.constant 0 : index
    %c100_1 = arith.constant 100 : index
    %c0_2 = arith.constant 0 : index
    %c100_3 = arith.constant 100 : index
    %c10 = arith.constant 10 : index
    %c10_4 = arith.constant 10 : index
    %c10_5 = arith.constant 10 : index
    scf.parallel (%arg3, %arg4, %arg5) = (%c0, %c0_0, %c0_2) to (%c100, %c100_1, %c100_3) step (%c10, %c10_4, %c10_5) {
      %c10_6 = arith.constant 10 : index
      %0 = arith.addi %arg3, %c10_6 : index
      %c10_7 = arith.constant 10 : index
      %1 = arith.addi %arg4, %c10_7 : index
      %c10_8 = arith.constant 10 : index
      %2 = arith.addi %arg5, %c10_8 : index
      %c1 = arith.constant 1 : index
      %c1_9 = arith.constant 1 : index
      %c1_10 = arith.constant 1 : index
      scf.parallel (%arg6, %arg7, %arg8) = (%arg3, %arg4, %arg5) to (%0, %1, %2) step (%c1, %c1_9, %c1_10) {
        %3 = memref.load %arg1[%arg6, %arg8] : memref<100x100xf32>
        %4 = memref.load %arg2[%arg8, %arg7] : memref<100x100xf32>
        %5 = arith.mulf %3, %4 : f32
        scf.reduce 
      }
      scf.reduce 
    }
    return
  }
  func.func @affine_parallel_simple(%arg0: memref<3x3xf32>, %arg1: memref<3x3xf32>) -> memref<3x3xf32> {
    %alloc = memref.alloc() : memref<3x3xf32>
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %c0_0 = arith.constant 0 : index
    %c2_1 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c1_2 = arith.constant 1 : index
    scf.parallel (%arg2, %arg3) = (%c0, %c0_0) to (%c2, %c2_1) step (%c1, %c1_2) {
      %0 = memref.load %arg0[%arg2, %arg3] : memref<3x3xf32>
      %1 = memref.load %arg1[%arg2, %arg3] : memref<3x3xf32>
      %2 = arith.mulf %0, %1 : f32
      memref.store %2, %alloc[%arg2, %arg3] : memref<3x3xf32>
      scf.reduce 
    }
    return %alloc : memref<3x3xf32>
  }
  func.func @affine_parallel_simple_dynamic_bounds(%arg0: memref<?x?xf32>, %arg1: memref<?x?xf32>, %arg2: memref<?x?xf32>) {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?xf32>
    %c0_0 = arith.constant 0 : index
    %c0_1 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c1_2 = arith.constant 1 : index
    scf.parallel (%arg3, %arg4) = (%c0_0, %c0_1) to (%dim, %dim) step (%c1, %c1_2) {
      %0 = memref.load %arg0[%arg3, %arg4] : memref<?x?xf32>
      %1 = memref.load %arg1[%arg3, %arg4] : memref<?x?xf32>
      %2 = arith.mulf %0, %1 : f32
      memref.store %2, %arg2[%arg3, %arg4] : memref<?x?xf32>
      scf.reduce 
    }
    return
  }
  func.func @affine_parallel_with_reductions(%arg0: memref<3x3xf32>, %arg1: memref<3x3xf32>) -> (f32, f32) {
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %c0_0 = arith.constant 0 : index
    %c2_1 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c1_2 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_3 = arith.constant 1.000000e+00 : f32
    %0:2 = scf.parallel (%arg2, %arg3) = (%c0, %c0_0) to (%c2, %c2_1) step (%c1, %c1_2) init (%cst, %cst_3) -> (f32, f32) {
      %1 = memref.load %arg0[%arg2, %arg3] : memref<3x3xf32>
      %2 = memref.load %arg1[%arg2, %arg3] : memref<3x3xf32>
      %3 = arith.mulf %1, %2 : f32
      %4 = arith.addf %1, %2 : f32
      scf.reduce(%3, %4 : f32, f32) {
      ^bb0(%arg4: f32, %arg5: f32):
        %5 = arith.addf %arg4, %arg5 : f32
        scf.reduce.return %5 : f32
      }, {
      ^bb0(%arg4: f32, %arg5: f32):
        %5 = arith.mulf %arg4, %arg5 : f32
        scf.reduce.return %5 : f32
      }
    }
    return %0#0, %0#1 : f32, f32
  }
  func.func @affine_parallel_with_reductions_f64(%arg0: memref<3x3xf64>, %arg1: memref<3x3xf64>) -> (f64, f64) {
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %c0_0 = arith.constant 0 : index
    %c2_1 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c1_2 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f64
    %cst_3 = arith.constant 1.000000e+00 : f64
    %0:2 = scf.parallel (%arg2, %arg3) = (%c0, %c0_0) to (%c2, %c2_1) step (%c1, %c1_2) init (%cst, %cst_3) -> (f64, f64) {
      %1 = memref.load %arg0[%arg2, %arg3] : memref<3x3xf64>
      %2 = memref.load %arg1[%arg2, %arg3] : memref<3x3xf64>
      %3 = arith.mulf %1, %2 : f64
      %4 = arith.addf %1, %2 : f64
      scf.reduce(%3, %4 : f64, f64) {
      ^bb0(%arg4: f64, %arg5: f64):
        %5 = arith.addf %arg4, %arg5 : f64
        scf.reduce.return %5 : f64
      }, {
      ^bb0(%arg4: f64, %arg5: f64):
        %5 = arith.mulf %arg4, %arg5 : f64
        scf.reduce.return %5 : f64
      }
    }
    return %0#0, %0#1 : f64, f64
  }
  func.func @affine_parallel_with_reductions_i64(%arg0: memref<3x3xi64>, %arg1: memref<3x3xi64>) -> (i64, i64) {
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %c0_0 = arith.constant 0 : index
    %c2_1 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c1_2 = arith.constant 1 : index
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %0:2 = scf.parallel (%arg2, %arg3) = (%c0, %c0_0) to (%c2, %c2_1) step (%c1, %c1_2) init (%c0_i64, %c1_i64) -> (i64, i64) {
      %1 = memref.load %arg0[%arg2, %arg3] : memref<3x3xi64>
      %2 = memref.load %arg1[%arg2, %arg3] : memref<3x3xi64>
      %3 = arith.muli %1, %2 : i64
      %4 = arith.addi %1, %2 : i64
      scf.reduce(%3, %4 : i64, i64) {
      ^bb0(%arg4: i64, %arg5: i64):
        %5 = arith.addi %arg4, %arg5 : i64
        scf.reduce.return %5 : i64
      }, {
      ^bb0(%arg4: i64, %arg5: i64):
        %5 = arith.muli %arg4, %arg5 : i64
        scf.reduce.return %5 : i64
      }
    }
    return %0#0, %0#1 : i64, i64
  }
}


module {
  func.func @hoist_matching_extract_insert(%arg0: tensor<?xf32>) -> tensor<?xf32> {
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %3 = arith.addi %c0, %c1 : index
    %4 = arith.subi %3, %c1 : index
    %extracted_slice = tensor.extract_slice %arg0[0] [5] [1] : tensor<?xf32> to tensor<5xf32>
    %5:2 = scf.for %arg1 = %0 to %1 step %2 iter_args(%arg2 = %arg0, %arg3 = %extracted_slice) -> (tensor<?xf32>, tensor<5xf32>) {
      %extracted_slice_0 = tensor.extract_slice %arg2[9] [5] [1] : tensor<?xf32> to tensor<5xf32>
      "test.foo"(%extracted_slice_0) : (tensor<5xf32>) -> ()
      %6 = "test.foo"(%arg3) : (tensor<5xf32>) -> tensor<5xf32>
      scf.yield %arg2, %6 : tensor<?xf32>, tensor<5xf32>
    }
    %inserted_slice = tensor.insert_slice %5#1 into %5#0[%4] [5] [1] : tensor<5xf32> into tensor<?xf32>
    return %inserted_slice : tensor<?xf32>
  }
}

// -----
module {
  func.func @subset_of_subset(%arg0: tensor<?xf32>) -> tensor<?xf32> {
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %extracted_slice = tensor.extract_slice %arg0[0] [5] [1] : tensor<?xf32> to tensor<5xf32>
    %extracted_slice_0 = tensor.extract_slice %extracted_slice[1] [2] [1] : tensor<5xf32> to tensor<2xf32>
    %3:3 = scf.for %arg1 = %0 to %1 step %2 iter_args(%arg2 = %arg0, %arg3 = %extracted_slice, %arg4 = %extracted_slice_0) -> (tensor<?xf32>, tensor<5xf32>, tensor<2xf32>) {
      %4 = "test.foo"(%arg4) : (tensor<2xf32>) -> tensor<2xf32>
      scf.yield %arg2, %arg3, %4 : tensor<?xf32>, tensor<5xf32>, tensor<2xf32>
    }
    %inserted_slice = tensor.insert_slice %3#2 into %3#1[1] [2] [1] : tensor<2xf32> into tensor<5xf32>
    %inserted_slice_1 = tensor.insert_slice %inserted_slice into %3#0[0] [5] [1] : tensor<5xf32> into tensor<?xf32>
    return %inserted_slice_1 : tensor<?xf32>
  }
}

// -----
module {
  func.func @hoist_matching_chain(%arg0: tensor<?xf32>) -> tensor<?xf32> {
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3 = "test.foo"() : () -> index
    %extracted_slice = tensor.extract_slice %arg0[%3] [5] [1] : tensor<?xf32> to tensor<5xf32>
    %extracted_slice_0 = tensor.extract_slice %arg0[0] [%3] [1] : tensor<?xf32> to tensor<?xf32>
    %4:3 = scf.for %arg1 = %0 to %1 step %2 iter_args(%arg2 = %arg0, %arg3 = %extracted_slice, %arg4 = %extracted_slice_0) -> (tensor<?xf32>, tensor<5xf32>, tensor<?xf32>) {
      %5 = "test.foo"(%arg4) : (tensor<?xf32>) -> tensor<?xf32>
      %6 = "test.foo"(%arg3) : (tensor<5xf32>) -> tensor<5xf32>
      scf.yield %arg2, %6, %5 : tensor<?xf32>, tensor<5xf32>, tensor<?xf32>
    }
    %inserted_slice = tensor.insert_slice %4#2 into %4#0[0] [%3] [1] : tensor<?xf32> into tensor<?xf32>
    %inserted_slice_1 = tensor.insert_slice %4#1 into %inserted_slice[%3] [5] [1] : tensor<5xf32> into tensor<?xf32>
    return %inserted_slice_1 : tensor<?xf32>
  }
}

// -----
module {
  func.func @do_not_hoist_overlapping_subsets(%arg0: tensor<?xf32>) -> tensor<?xf32> {
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3 = "test.foo"() : () -> index
    %4 = "test.foo"() : () -> index
    %5 = scf.for %arg1 = %0 to %1 step %2 iter_args(%arg2 = %arg0) -> (tensor<?xf32>) {
      %extracted_slice = tensor.extract_slice %arg2[0] [%3] [1] : tensor<?xf32> to tensor<?xf32>
      %extracted_slice_0 = tensor.extract_slice %arg2[10] [%4] [1] : tensor<?xf32> to tensor<?xf32>
      %6 = "test.foo"(%extracted_slice) : (tensor<?xf32>) -> tensor<?xf32>
      %7 = "test.foo"(%extracted_slice_0) : (tensor<?xf32>) -> tensor<?xf32>
      %inserted_slice = tensor.insert_slice %7 into %arg2[0] [%3] [1] : tensor<?xf32> into tensor<?xf32>
      %inserted_slice_1 = tensor.insert_slice %6 into %inserted_slice[10] [%4] [1] : tensor<?xf32> into tensor<?xf32>
      scf.yield %inserted_slice_1 : tensor<?xf32>
    }
    return %5 : tensor<?xf32>
  }
}

// -----
module {
  func.func @multiple_yields(%arg0: tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>) {
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %extracted_slice = tensor.extract_slice %arg0[0] [5] [1] : tensor<?xf32> to tensor<5xf32>
    %extracted_slice_0 = tensor.extract_slice %arg0[5] [5] [1] : tensor<?xf32> to tensor<5xf32>
    %3:4 = scf.for %arg1 = %0 to %1 step %2 iter_args(%arg2 = %arg0, %arg3 = %arg0, %arg4 = %extracted_slice, %arg5 = %extracted_slice_0) -> (tensor<?xf32>, tensor<?xf32>, tensor<5xf32>, tensor<5xf32>) {
      %4 = "test.foo"(%arg4) : (tensor<5xf32>) -> tensor<5xf32>
      %5 = "test.foo"(%arg5) : (tensor<5xf32>) -> tensor<5xf32>
      scf.yield %arg2, %arg3, %5, %4 : tensor<?xf32>, tensor<?xf32>, tensor<5xf32>, tensor<5xf32>
    }
    %inserted_slice = tensor.insert_slice %3#3 into %3#1[5] [5] [1] : tensor<5xf32> into tensor<?xf32>
    %inserted_slice_1 = tensor.insert_slice %3#2 into %3#0[0] [5] [1] : tensor<5xf32> into tensor<?xf32>
    return %inserted_slice_1, %inserted_slice : tensor<?xf32>, tensor<?xf32>
  }
}

// -----
module {
  func.func @do_not_hoist_swapping_yields(%arg0: tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>) {
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3:2 = scf.for %arg1 = %0 to %1 step %2 iter_args(%arg2 = %arg0, %arg3 = %arg0) -> (tensor<?xf32>, tensor<?xf32>) {
      %extracted_slice = tensor.extract_slice %arg2[0] [5] [1] : tensor<?xf32> to tensor<5xf32>
      %extracted_slice_0 = tensor.extract_slice %arg3[5] [5] [1] : tensor<?xf32> to tensor<5xf32>
      %4 = "test.foo"(%extracted_slice) : (tensor<5xf32>) -> tensor<5xf32>
      %5 = "test.foo"(%extracted_slice_0) : (tensor<5xf32>) -> tensor<5xf32>
      %inserted_slice = tensor.insert_slice %5 into %arg2[0] [5] [1] : tensor<5xf32> into tensor<?xf32>
      %inserted_slice_1 = tensor.insert_slice %4 into %arg3[5] [5] [1] : tensor<5xf32> into tensor<?xf32>
      scf.yield %inserted_slice_1, %inserted_slice : tensor<?xf32>, tensor<?xf32>
    }
    return %3#0, %3#1 : tensor<?xf32>, tensor<?xf32>
  }
}

// -----
module {
  func.func @non_subset_op(%arg0: tensor<?xf32>) -> tensor<?xf32> {
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3 = scf.for %arg1 = %0 to %1 step %2 iter_args(%arg2 = %arg0) -> (tensor<?xf32>) {
      "test.non_subset_op"(%arg2) : (tensor<?xf32>) -> ()
      %extracted_slice = tensor.extract_slice %arg2[0] [5] [1] : tensor<?xf32> to tensor<5xf32>
      %4 = "test.foo"(%extracted_slice) : (tensor<5xf32>) -> tensor<5xf32>
      %inserted_slice = tensor.insert_slice %4 into %arg2[0] [5] [1] : tensor<5xf32> into tensor<?xf32>
      scf.yield %inserted_slice : tensor<?xf32>
    }
    return %3 : tensor<?xf32>
  }
}

// -----
module {
  func.func @non_loop_invariant_subset_op(%arg0: tensor<?xf32>) -> tensor<?xf32> {
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3 = scf.for %arg1 = %0 to %1 step %2 iter_args(%arg2 = %arg0) -> (tensor<?xf32>) {
      %extracted_slice = tensor.extract_slice %arg2[%arg1] [5] [1] : tensor<?xf32> to tensor<5xf32>
      %4 = "test.foo"(%extracted_slice) : (tensor<5xf32>) -> tensor<5xf32>
      %inserted_slice = tensor.insert_slice %4 into %arg2[%arg1] [5] [1] : tensor<5xf32> into tensor<?xf32>
      scf.yield %inserted_slice : tensor<?xf32>
    }
    return %3 : tensor<?xf32>
  }
}

// -----
module {
  func.func @nested_hoisting(%arg0: tensor<?xf32>) -> tensor<?xf32> {
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %extracted_slice = tensor.extract_slice %arg0[0] [5] [1] : tensor<?xf32> to tensor<5xf32>
    %extracted_slice_0 = tensor.extract_slice %arg0[5] [5] [1] : tensor<?xf32> to tensor<5xf32>
    %3:3 = scf.for %arg1 = %0 to %1 step %2 iter_args(%arg2 = %arg0, %arg3 = %extracted_slice, %arg4 = %extracted_slice_0) -> (tensor<?xf32>, tensor<5xf32>, tensor<5xf32>) {
      %4 = "test.foo"(%arg3) : (tensor<5xf32>) -> tensor<5xf32>
      %5:2 = scf.for %arg5 = %0 to %1 step %2 iter_args(%arg6 = %arg2, %arg7 = %arg4) -> (tensor<?xf32>, tensor<5xf32>) {
        %6 = "test.foo"(%arg7) : (tensor<5xf32>) -> tensor<5xf32>
        scf.yield %arg6, %6 : tensor<?xf32>, tensor<5xf32>
      }
      scf.yield %5#0, %4, %5#1 : tensor<?xf32>, tensor<5xf32>, tensor<5xf32>
    }
    %inserted_slice = tensor.insert_slice %3#2 into %3#0[5] [5] [1] : tensor<5xf32> into tensor<?xf32>
    %inserted_slice_1 = tensor.insert_slice %3#1 into %inserted_slice[0] [5] [1] : tensor<5xf32> into tensor<?xf32>
    return %inserted_slice_1 : tensor<?xf32>
  }
}

// -----
module {
  func.func @hoist_vector_transfer_pairs_tensor(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: tensor<?x?xf32>, %arg4: tensor<?x?xf32>, %arg5: tensor<?x?xf32>, %arg6: index, %arg7: index, %arg8: index, %arg9: index) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg1[%c0, %c0], %cst : tensor<?x?xf32>, vector<1xf32>
    %1:7 = scf.for %arg10 = %arg7 to %arg8 step %arg9 iter_args(%arg11 = %arg0, %arg12 = %arg1, %arg13 = %arg2, %arg14 = %arg3, %arg15 = %arg4, %arg16 = %arg5, %arg17 = %0) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<1xf32>) {
      %3 = vector.transfer_read %arg11[%arg10, %arg10], %cst : tensor<?x?xf32>, vector<2xf32>
      %4:8 = scf.for %arg18 = %arg7 to %arg8 step %arg9 iter_args(%arg19 = %arg11, %arg20 = %arg12, %arg21 = %arg13, %arg22 = %arg14, %arg23 = %arg15, %arg24 = %arg16, %arg25 = %3, %arg26 = %arg17) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<2xf32>, vector<1xf32>) {
        %6 = vector.transfer_read %arg22[%c0, %c0], %cst : tensor<?x?xf32>, vector<4xf32>
        "test.some_crippling_use"(%arg23) : (tensor<?x?xf32>) -> ()
        %7 = vector.transfer_read %arg23[%c0, %c0], %cst : tensor<?x?xf32>, vector<5xf32>
        %8 = vector.transfer_read %arg24[%c0, %c0], %cst : tensor<?x?xf32>, vector<6xf32>
        "test.some_crippling_use"(%arg24) : (tensor<?x?xf32>) -> ()
        %9 = "test.some_use"(%arg26) : (vector<1xf32>) -> vector<1xf32>
        %10 = "test.some_use"(%arg25) : (vector<2xf32>) -> vector<2xf32>
        %11 = "test.some_use"(%arg21) : (tensor<?x?xf32>) -> vector<3xf32>
        %12 = "test.some_use"(%6) : (vector<4xf32>) -> vector<4xf32>
        %13 = "test.some_use"(%7) : (vector<5xf32>) -> vector<5xf32>
        %14 = "test.some_use"(%8) : (vector<6xf32>) -> vector<6xf32>
        %15 = vector.transfer_write %11, %arg21[%c0, %c0] : vector<3xf32>, tensor<?x?xf32>
        %16 = vector.transfer_write %12, %arg22[%c0, %c0] : vector<4xf32>, tensor<?x?xf32>
        %17 = vector.transfer_write %13, %arg23[%c0, %c0] : vector<5xf32>, tensor<?x?xf32>
        %18 = vector.transfer_write %14, %arg24[%c0, %c0] : vector<6xf32>, tensor<?x?xf32>
        "test.some_crippling_use"(%16) : (tensor<?x?xf32>) -> ()
        scf.yield %arg19, %arg20, %15, %16, %17, %18, %10, %9 : tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<2xf32>, vector<1xf32>
      }
      %5 = vector.transfer_write %4#6, %4#0[%arg10, %arg10] : vector<2xf32>, tensor<?x?xf32>
      scf.yield %5, %4#1, %4#2, %4#3, %4#4, %4#5, %4#7 : tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<1xf32>
    }
    %2 = vector.transfer_write %1#6, %1#1[%c0, %c0] : vector<1xf32>, tensor<?x?xf32>
    return %1#0, %2, %1#2, %1#3, %1#4, %1#5 : tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>
  }
}

// -----
module {
  func.func @hoist_vector_transfer_pairs_disjoint_tensor(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: tensor<?x?xf32>, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg2[%c0, %c3], %cst : tensor<?x?xf32>, vector<3xf32>
    %1 = vector.transfer_read %arg2[%c0, %c0], %cst : tensor<?x?xf32>, vector<3xf32>
    %2 = vector.transfer_read %arg3[%c1, %arg8], %cst : tensor<?x?xf32>, vector<4xf32>
    %3 = vector.transfer_read %arg3[%c0, %arg8], %cst : tensor<?x?xf32>, vector<4xf32>
    %4:8 = scf.for %arg9 = %arg5 to %arg6 step %arg7 iter_args(%arg10 = %arg0, %arg11 = %arg1, %arg12 = %arg2, %arg13 = %arg3, %arg14 = %0, %arg15 = %1, %arg16 = %2, %arg17 = %3) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<3xf32>, vector<3xf32>, vector<4xf32>, vector<4xf32>) {
      %9:8 = scf.for %arg18 = %arg5 to %arg6 step %arg7 iter_args(%arg19 = %arg10, %arg20 = %arg11, %arg21 = %arg12, %arg22 = %arg13, %arg23 = %arg15, %arg24 = %arg14, %arg25 = %arg17, %arg26 = %arg16) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<3xf32>, vector<3xf32>, vector<4xf32>, vector<4xf32>) {
        %10 = vector.transfer_read %arg20[%c0, %c0], %cst : tensor<?x?xf32>, vector<2xf32>
        %11 = vector.transfer_read %arg20[%c0, %c1], %cst : tensor<?x?xf32>, vector<2xf32>
        %12 = vector.transfer_read %arg19[%arg9, %arg9], %cst : tensor<?x?xf32>, vector<2xf32>
        %13 = vector.transfer_read %arg19[%arg8, %arg8], %cst : tensor<?x?xf32>, vector<2xf32>
        %14 = "test.some_use"(%10) : (vector<2xf32>) -> vector<2xf32>
        %15 = "test.some_use"(%11) : (vector<2xf32>) -> vector<2xf32>
        %16 = "test.some_use"(%arg23) : (vector<3xf32>) -> vector<3xf32>
        %17 = "test.some_use"(%arg24) : (vector<3xf32>) -> vector<3xf32>
        %18 = "test.some_use"(%arg25) : (vector<4xf32>) -> vector<4xf32>
        %19 = "test.some_use"(%arg26) : (vector<4xf32>) -> vector<4xf32>
        %20 = "test.some_use"(%12) : (vector<2xf32>) -> vector<2xf32>
        %21 = "test.some_use"(%13) : (vector<2xf32>) -> vector<2xf32>
        %22 = vector.transfer_write %14, %arg20[%c0, %c0] : vector<2xf32>, tensor<?x?xf32>
        %23 = vector.transfer_write %15, %22[%c0, %c1] : vector<2xf32>, tensor<?x?xf32>
        %24 = vector.transfer_write %20, %arg19[%arg9, %arg9] : vector<2xf32>, tensor<?x?xf32>
        %25 = vector.transfer_write %21, %24[%arg8, %arg8] : vector<2xf32>, tensor<?x?xf32>
        scf.yield %25, %23, %arg21, %arg22, %16, %17, %18, %19 : tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<3xf32>, vector<3xf32>, vector<4xf32>, vector<4xf32>
      }
      scf.yield %9#0, %9#1, %9#2, %9#3, %9#5, %9#4, %9#7, %9#6 : tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<3xf32>, vector<3xf32>, vector<4xf32>, vector<4xf32>
    }
    %5 = vector.transfer_write %4#7, %4#3[%c0, %arg8] : vector<4xf32>, tensor<?x?xf32>
    %6 = vector.transfer_write %4#6, %5[%c1, %arg8] : vector<4xf32>, tensor<?x?xf32>
    %7 = vector.transfer_write %4#5, %4#2[%c0, %c0] : vector<3xf32>, tensor<?x?xf32>
    %8 = vector.transfer_write %4#4, %7[%c0, %c3] : vector<3xf32>, tensor<?x?xf32>
    return %4#0, %4#1, %8, %6 : tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>
  }
}

// -----
module {
  func.func @hoist_vector_transfer_pairs_tensor_and_slices(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: tensor<?x?xf32>, %arg4: tensor<?x?xf32>, %arg5: tensor<?x?xf32>, %arg6: index, %arg7: index, %arg8: index, %arg9: index) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0:3 = scf.for %arg10 = %arg7 to %arg8 step %arg9 iter_args(%arg11 = %arg0, %arg12 = %arg1, %arg13 = %arg2) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) {
      %extracted_slice = tensor.extract_slice %arg11[%arg10, %arg10] [%arg9, %arg9] [1, 1] : tensor<?x?xf32> to tensor<?x?xf32>
      %1 = vector.transfer_read %extracted_slice[%c0, %c0], %cst : tensor<?x?xf32>, vector<1xf32>
      %2:5 = scf.for %arg14 = %arg7 to %arg8 step %arg9 iter_args(%arg15 = %arg11, %arg16 = %arg12, %arg17 = %arg13, %arg18 = %extracted_slice, %arg19 = %1) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<1xf32>) {
        %extracted_slice_0 = tensor.extract_slice %arg16[%arg14, %c0] [%arg9, %arg9] [1, 1] : tensor<?x?xf32> to tensor<?x?xf32>
        %4 = vector.transfer_read %extracted_slice_0[%c0, %c0], %cst : tensor<?x?xf32>, vector<2xf32>
        %extracted_slice_1 = tensor.extract_slice %arg17[%arg10, %c0] [%arg9, %arg9] [1, 1] : tensor<?x?xf32> to tensor<?x?xf32>
        %5 = vector.transfer_read %extracted_slice_1[%c0, %c0], %cst : tensor<?x?xf32>, vector<3xf32>
        %6 = "test.some_use"(%arg19) : (vector<1xf32>) -> vector<1xf32>
        %7 = "test.some_use"(%4) : (vector<2xf32>) -> vector<2xf32>
        %8 = "test.some_use"(%5) : (vector<3xf32>) -> vector<3xf32>
        %9 = vector.transfer_write %7, %extracted_slice_0[%arg10, %arg10] : vector<2xf32>, tensor<?x?xf32>
        %10 = vector.transfer_write %8, %extracted_slice_1[%c0, %c0] : vector<3xf32>, tensor<?x?xf32>
        %inserted_slice_2 = tensor.insert_slice %9 into %arg16[%arg14, %c0] [%arg9, %arg9] [1, 1] : tensor<?x?xf32> into tensor<?x?xf32>
        %inserted_slice_3 = tensor.insert_slice %10 into %arg17[%arg10, %c0] [%arg9, %arg9] [1, 1] : tensor<?x?xf32> into tensor<?x?xf32>
        %extracted_slice_4 = tensor.extract_slice %inserted_slice_3[%arg10, %c0] [%arg9, %arg9] [2, 1] : tensor<?x?xf32> to tensor<?x?xf32>
        %inserted_slice_5 = tensor.insert_slice %extracted_slice_4 into %arg17[%arg10, %c0] [%arg9, %arg9] [1, 1] : tensor<?x?xf32> into tensor<?x?xf32>
        scf.yield %arg15, %inserted_slice_2, %inserted_slice_5, %arg18, %6 : tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<1xf32>
      }
      %3 = vector.transfer_write %2#4, %2#3[%c0, %c0] : vector<1xf32>, tensor<?x?xf32>
      %inserted_slice = tensor.insert_slice %3 into %2#0[%arg10, %arg10] [%arg9, %arg9] [1, 1] : tensor<?x?xf32> into tensor<?x?xf32>
      scf.yield %inserted_slice, %2#1, %2#2 : tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>
    }
    return %0#0, %0#1, %0#2 : tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>
  }
}

// -----
module {
  func.func @hoist_vector_transfer_write_pairs_disjoint_tensor(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> tensor<?x?xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[%c0, %c0], %cst : tensor<?x?xf32>, vector<2xf32>
    %1 = vector.transfer_read %arg0[%c0, %c3], %cst : tensor<?x?xf32>, vector<2xf32>
    %2:3 = scf.for %arg5 = %arg2 to %arg3 step %arg4 iter_args(%arg6 = %arg0, %arg7 = %0, %arg8 = %1) -> (tensor<?x?xf32>, vector<2xf32>, vector<2xf32>) {
      %5 = "test.some_use"(%arg7) : (vector<2xf32>) -> vector<2xf32>
      %6 = "test.some_use"(%arg8) : (vector<2xf32>) -> vector<2xf32>
      scf.yield %arg6, %5, %6 : tensor<?x?xf32>, vector<2xf32>, vector<2xf32>
    }
    %3 = vector.transfer_write %2#2, %2#0[%c0, %c3] : vector<2xf32>, tensor<?x?xf32>
    %4 = vector.transfer_write %2#1, %3[%c0, %c0] : vector<2xf32>, tensor<?x?xf32>
    return %4 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @hoist_buffer(%arg0: memref<7x7xf16>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %alloc = memref.alloc() : memref<7x7xf16>
    %0 = scf.for %arg1 = %c0 to %c1 step %c1 iter_args(%arg2 = %alloc) -> (memref<7x7xf16>) {
      linalg.copy ins(%arg0 : memref<7x7xf16>) outs(%arg2 : memref<7x7xf16>)
      scf.yield %alloc : memref<7x7xf16>
    }
    return
  }
}


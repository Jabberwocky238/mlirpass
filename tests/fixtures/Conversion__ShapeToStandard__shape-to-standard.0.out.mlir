module {
  func.func @binary_ops(%arg0: index, %arg1: index) {
    %0 = arith.addi %arg0, %arg1 : index
    %1 = arith.muli %arg0, %arg1 : index
    return
  }
}

// -----
module {
  func.func @binary_ops_on_size(%arg0: !shape.size, %arg1: !shape.size) {
    %0 = shape.add %arg0, %arg1 : !shape.size, !shape.size -> !shape.size
    %1 = shape.mul %arg0, %arg1 : !shape.size, !shape.size -> !shape.size
    return
  }
}

// -----
module {
  func.func @rank(%arg0: tensor<?xindex>) -> index {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xindex>
    return %dim : index
  }
}

// -----
module {
  func.func @get_extent(%arg0: tensor<?xindex>, %arg1: !shape.size) -> !shape.size {
    %0 = shape.get_extent %arg0, %arg1 : tensor<?xindex>, !shape.size -> !shape.size
    return %0 : !shape.size
  }
}

// -----
module {
  func.func @rank(%arg0: !shape.shape) {
    %0 = shape.rank %arg0 : !shape.shape -> !shape.size
    return
  }
}

// -----
module {
  func.func @dim(%arg0: tensor<2x3xf32>, %arg1: index) -> index {
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %from_elements = tensor.from_elements %c2, %c3 : tensor<2xindex>
    %cast = tensor.cast %from_elements : tensor<2xindex> to tensor<2xindex>
    %dim = tensor.dim %arg0, %arg1 : tensor<2x3xf32>
    return %dim : index
  }
}

// -----
module {
  func.func @get_extent_shape_of(%arg0: tensor<2x3xf32>, %arg1: index) -> index {
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %from_elements = tensor.from_elements %c2, %c3 : tensor<2xindex>
    %cast = tensor.cast %from_elements : tensor<2xindex> to tensor<?xindex>
    %dim = tensor.dim %arg0, %arg1 : tensor<2x3xf32>
    return %dim : index
  }
}

// -----
module {
  func.func @get_extent_from_extent_tensor(%arg0: tensor<?xindex>, %arg1: index) -> index {
    %extracted = tensor.extract %arg0[%arg1] : tensor<?xindex>
    return %extracted : index
  }
}

// -----
module {
  func.func @const_shape() -> tensor<3xindex> {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %from_elements = tensor.from_elements %c1, %c2, %c3 : tensor<3xindex>
    %cast = tensor.cast %from_elements : tensor<3xindex> to tensor<3xindex>
    return %cast : tensor<3xindex>
  }
}

// -----
module {
  func.func @const_shape_zero_elements() -> tensor<0xindex> {
    %from_elements = tensor.from_elements  : tensor<0xindex>
    %cast = tensor.cast %from_elements : tensor<0xindex> to tensor<0xindex>
    return %cast : tensor<0xindex>
  }
}

// -----
module {
  func.func @any_of_three(%arg0: tensor<?xindex>, %arg1: tensor<?xindex>, %arg2: tensor<?xindex>) -> tensor<?xindex> {
    return %arg0 : tensor<?xindex>
  }
}

// -----
module {
  func.func @any_of_one(%arg0: tensor<?xindex>) -> tensor<?xindex> {
    return %arg0 : tensor<?xindex>
  }
}

// -----
module {
  func.func @const_size() -> index {
    %c42 = arith.constant 42 : index
    %c42_0 = arith.constant 42 : index
    return %c42_0 : index
  }
}

// -----
module {
  func.func @to_extent_tensor(%arg0: tensor<?xindex>) -> tensor<3xindex> {
    %cast = tensor.cast %arg0 : tensor<?xindex> to tensor<3xindex>
    return %cast : tensor<3xindex>
  }
  func.func @shape_reduce(%arg0: tensor<?xindex>) -> index {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c1_0 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xindex>
    %0 = scf.for %arg1 = %c0 to %dim step %c1_0 iter_args(%arg2 = %c1) -> (index) {
      %extracted = tensor.extract %arg0[%arg1] : tensor<?xindex>
      %1 = arith.muli %arg2, %extracted : index
      scf.yield %1 : index
    }
    return %0 : index
  }
}

// -----
module {
  func.func @shape_of(%arg0: tensor<*xf32>) {
    %0 = shape.shape_of %arg0 : tensor<*xf32> -> !shape.shape
    return
  }
}

// -----
module {
  func.func @shape_of_unranked(%arg0: tensor<*xf32>) {
    %rank = tensor.rank %arg0 : tensor<*xf32>
    %generated = tensor.generate %rank {
    ^bb0(%arg1: index):
      %dim = tensor.dim %arg0, %arg1 : tensor<*xf32>
      tensor.yield %dim : index
    } : tensor<?xindex>
    return
  }
}

// -----
module {
  func.func @shape_of_stat(%arg0: tensor<1x2x3xf32>) {
    %0 = shape.shape_of %arg0 : tensor<1x2x3xf32> -> !shape.shape
    return
  }
}

// -----
module {
  func.func @shape_of_stat(%arg0: tensor<1x2x3xf32>) {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %from_elements = tensor.from_elements %c1, %c2, %c3 : tensor<3xindex>
    %cast = tensor.cast %from_elements : tensor<3xindex> to tensor<?xindex>
    return
  }
}

// -----
module {
  func.func @shape_of_zero_d(%arg0: tensor<f32>) {
    %from_elements = tensor.from_elements  : tensor<0xindex>
    %cast = tensor.cast %from_elements : tensor<0xindex> to tensor<?xindex>
    return
  }
}

// -----
module {
  func.func @shape_of_dyn(%arg0: tensor<1x5x?xf32>) {
    %c1 = arith.constant 1 : index
    %c5 = arith.constant 5 : index
    %c2 = arith.constant 2 : index
    %dim = tensor.dim %arg0, %c2 : tensor<1x5x?xf32>
    %from_elements = tensor.from_elements %c1, %c5, %dim : tensor<3xindex>
    %cast = tensor.cast %from_elements : tensor<3xindex> to tensor<?xindex>
    return
  }
}

// -----
module {
  func.func @shape_eq(%arg0: tensor<?xindex>, %arg1: tensor<?xindex>) -> i1 {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xindex>
    %dim_0 = tensor.dim %arg1, %c0 : tensor<?xindex>
    %0 = arith.cmpi eq, %dim, %dim_0 : index
    %1 = scf.if %0 -> (i1) {
      %c1 = arith.constant 1 : index
      %true = arith.constant true
      %2 = scf.for %arg2 = %c0 to %dim step %c1 iter_args(%arg3 = %true) -> (i1) {
        %extracted = tensor.extract %arg0[%arg2] : tensor<?xindex>
        %extracted_1 = tensor.extract %arg1[%arg2] : tensor<?xindex>
        %3 = arith.cmpi eq, %extracted, %extracted_1 : index
        %4 = arith.andi %arg3, %3 : i1
        scf.yield %4 : i1
      }
      scf.yield %2 : i1
    } else {
      %false = arith.constant false
      scf.yield %false : i1
    }
    return %1 : i1
  }
}

// -----
module {
  func.func @shape_eq(%arg0: tensor<?xindex>, %arg1: tensor<?xindex>, %arg2: tensor<?xindex>) -> i1 {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xindex>
    %dim_0 = tensor.dim %arg1, %c0 : tensor<?xindex>
    %0 = arith.cmpi eq, %dim, %dim_0 : index
    %1 = scf.if %0 -> (i1) {
      %c1 = arith.constant 1 : index
      %true = arith.constant true
      %5 = scf.for %arg3 = %c0 to %dim step %c1 iter_args(%arg4 = %true) -> (i1) {
        %extracted = tensor.extract %arg0[%arg3] : tensor<?xindex>
        %extracted_2 = tensor.extract %arg1[%arg3] : tensor<?xindex>
        %6 = arith.cmpi eq, %extracted, %extracted_2 : index
        %7 = arith.andi %arg4, %6 : i1
        scf.yield %7 : i1
      }
      scf.yield %5 : i1
    } else {
      %false = arith.constant false
      scf.yield %false : i1
    }
    %dim_1 = tensor.dim %arg2, %c0 : tensor<?xindex>
    %2 = arith.cmpi eq, %dim, %dim_1 : index
    %3 = scf.if %2 -> (i1) {
      %c1 = arith.constant 1 : index
      %true = arith.constant true
      %5 = scf.for %arg3 = %c0 to %dim step %c1 iter_args(%arg4 = %true) -> (i1) {
        %extracted = tensor.extract %arg0[%arg3] : tensor<?xindex>
        %extracted_2 = tensor.extract %arg2[%arg3] : tensor<?xindex>
        %6 = arith.cmpi eq, %extracted, %extracted_2 : index
        %7 = arith.andi %arg4, %6 : i1
        scf.yield %7 : i1
      }
      scf.yield %5 : i1
    } else {
      %false = arith.constant false
      scf.yield %false : i1
    }
    %4 = arith.andi %1, %3 : i1
    return %4 : i1
  }
}

// -----
module {
  func.func @broadcast(%arg0: tensor<?xindex>, %arg1: !shape.shape) -> !shape.shape {
    %0 = shape.broadcast %arg0, %arg1 : tensor<?xindex>, !shape.shape -> !shape.shape
    return %0 : !shape.shape
  }
}

// -----
module {
  func.func @try_is_broadcastable(%arg0: tensor<2xindex>, %arg1: tensor<3xindex>, %arg2: tensor<2xindex>) -> i1 {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c0 : tensor<2xindex>
    %dim_0 = tensor.dim %arg1, %c0 : tensor<3xindex>
    %dim_1 = tensor.dim %arg2, %c0 : tensor<2xindex>
    %0 = arith.maxui %dim_0, %dim : index
    %1 = arith.maxui %dim_1, %0 : index
    %2 = arith.subi %1, %dim : index
    %3 = arith.subi %1, %dim_0 : index
    %4 = arith.subi %1, %dim_1 : index
    %true = arith.constant true
    %5 = scf.for %arg3 = %c0 to %1 step %c1 iter_args(%arg4 = %true) -> (i1) {
      %c1_2 = arith.constant 1 : index
      %6 = arith.cmpi ult, %arg3, %2 : index
      %7 = scf.if %6 -> (index) {
        scf.yield %c1_2 : index
      } else {
        %18 = arith.subi %arg3, %2 : index
        %extracted = tensor.extract %arg0[%18] : tensor<2xindex>
        %19 = arith.cmpi eq, %extracted, %c1_2 : index
        %20 = arith.select %19, %c1_2, %extracted : index
        scf.yield %20 : index
      }
      %8 = arith.cmpi ult, %arg3, %3 : index
      %9 = scf.if %8 -> (index) {
        scf.yield %7 : index
      } else {
        %18 = arith.subi %arg3, %3 : index
        %extracted = tensor.extract %arg1[%18] : tensor<3xindex>
        %19 = arith.cmpi eq, %extracted, %c1_2 : index
        %20 = arith.select %19, %7, %extracted : index
        scf.yield %20 : index
      }
      %10 = arith.cmpi ult, %arg3, %4 : index
      %11 = scf.if %10 -> (index) {
        scf.yield %9 : index
      } else {
        %18 = arith.subi %arg3, %4 : index
        %extracted = tensor.extract %arg2[%18] : tensor<2xindex>
        %19 = arith.cmpi eq, %extracted, %c1_2 : index
        %20 = arith.select %19, %9, %extracted : index
        scf.yield %20 : index
      }
      %12 = arith.cmpi ult, %arg3, %2 : index
      %13 = scf.if %12 -> (i1) {
        scf.yield %arg4 : i1
      } else {
        %18 = arith.subi %arg3, %2 : index
        %extracted = tensor.extract %arg0[%18] : tensor<2xindex>
        %19 = arith.cmpi eq, %extracted, %c1 : index
        %20 = arith.cmpi eq, %extracted, %11 : index
        %21 = arith.ori %19, %20 : i1
        %22 = arith.andi %arg4, %21 : i1
        scf.yield %22 : i1
      }
      %14 = arith.cmpi ult, %arg3, %3 : index
      %15 = scf.if %14 -> (i1) {
        scf.yield %13 : i1
      } else {
        %18 = arith.subi %arg3, %3 : index
        %extracted = tensor.extract %arg1[%18] : tensor<3xindex>
        %19 = arith.cmpi eq, %extracted, %c1 : index
        %20 = arith.cmpi eq, %extracted, %11 : index
        %21 = arith.ori %19, %20 : i1
        %22 = arith.andi %13, %21 : i1
        scf.yield %22 : i1
      }
      %16 = arith.cmpi ult, %arg3, %4 : index
      %17 = scf.if %16 -> (i1) {
        scf.yield %15 : i1
      } else {
        %18 = arith.subi %arg3, %4 : index
        %extracted = tensor.extract %arg2[%18] : tensor<2xindex>
        %19 = arith.cmpi eq, %extracted, %c1 : index
        %20 = arith.cmpi eq, %extracted, %11 : index
        %21 = arith.ori %19, %20 : i1
        %22 = arith.andi %15, %21 : i1
        scf.yield %22 : i1
      }
      scf.yield %17 : i1
    }
    return %5 : i1
  }
}

// -----
module {
  func.func @broadcast(%arg0: tensor<2xindex>, %arg1: tensor<3xindex>, %arg2: tensor<2xindex>) -> !shape.witness {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c0 : tensor<2xindex>
    %dim_0 = tensor.dim %arg1, %c0 : tensor<3xindex>
    %dim_1 = tensor.dim %arg2, %c0 : tensor<2xindex>
    %0 = arith.maxui %dim_0, %dim : index
    %1 = arith.maxui %dim_1, %0 : index
    %2 = arith.subi %1, %dim : index
    %3 = arith.subi %1, %dim_0 : index
    %4 = arith.subi %1, %dim_1 : index
    %true = arith.constant true
    %5 = scf.for %arg3 = %c0 to %1 step %c1 iter_args(%arg4 = %true) -> (i1) {
      %c1_2 = arith.constant 1 : index
      %7 = arith.cmpi ult, %arg3, %2 : index
      %8 = scf.if %7 -> (index) {
        scf.yield %c1_2 : index
      } else {
        %19 = arith.subi %arg3, %2 : index
        %extracted = tensor.extract %arg0[%19] : tensor<2xindex>
        %20 = arith.cmpi eq, %extracted, %c1_2 : index
        %21 = arith.select %20, %c1_2, %extracted : index
        scf.yield %21 : index
      }
      %9 = arith.cmpi ult, %arg3, %3 : index
      %10 = scf.if %9 -> (index) {
        scf.yield %8 : index
      } else {
        %19 = arith.subi %arg3, %3 : index
        %extracted = tensor.extract %arg1[%19] : tensor<3xindex>
        %20 = arith.cmpi eq, %extracted, %c1_2 : index
        %21 = arith.select %20, %8, %extracted : index
        scf.yield %21 : index
      }
      %11 = arith.cmpi ult, %arg3, %4 : index
      %12 = scf.if %11 -> (index) {
        scf.yield %10 : index
      } else {
        %19 = arith.subi %arg3, %4 : index
        %extracted = tensor.extract %arg2[%19] : tensor<2xindex>
        %20 = arith.cmpi eq, %extracted, %c1_2 : index
        %21 = arith.select %20, %10, %extracted : index
        scf.yield %21 : index
      }
      %13 = arith.cmpi ult, %arg3, %2 : index
      %14 = scf.if %13 -> (i1) {
        scf.yield %arg4 : i1
      } else {
        %19 = arith.subi %arg3, %2 : index
        %extracted = tensor.extract %arg0[%19] : tensor<2xindex>
        %20 = arith.cmpi eq, %extracted, %c1 : index
        %21 = arith.cmpi eq, %extracted, %12 : index
        %22 = arith.ori %20, %21 : i1
        %23 = arith.andi %arg4, %22 : i1
        scf.yield %23 : i1
      }
      %15 = arith.cmpi ult, %arg3, %3 : index
      %16 = scf.if %15 -> (i1) {
        scf.yield %14 : i1
      } else {
        %19 = arith.subi %arg3, %3 : index
        %extracted = tensor.extract %arg1[%19] : tensor<3xindex>
        %20 = arith.cmpi eq, %extracted, %c1 : index
        %21 = arith.cmpi eq, %extracted, %12 : index
        %22 = arith.ori %20, %21 : i1
        %23 = arith.andi %14, %22 : i1
        scf.yield %23 : i1
      }
      %17 = arith.cmpi ult, %arg3, %4 : index
      %18 = scf.if %17 -> (i1) {
        scf.yield %16 : i1
      } else {
        %19 = arith.subi %arg3, %4 : index
        %extracted = tensor.extract %arg2[%19] : tensor<2xindex>
        %20 = arith.cmpi eq, %extracted, %c1 : index
        %21 = arith.cmpi eq, %extracted, %12 : index
        %22 = arith.ori %20, %21 : i1
        %23 = arith.andi %16, %22 : i1
        scf.yield %23 : i1
      }
      scf.yield %18 : i1
    }
    %6 = shape.cstr_require %5, "required broadcastable shapes"
    return %6 : !shape.witness
  }
}

// -----
module {
  func.func @broadcast_3_shapes_different_extents(%arg0: tensor<2xindex>, %arg1: tensor<3xindex>, %arg2: tensor<2xindex>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<2xindex>
    %dim_0 = tensor.dim %arg1, %c0 : tensor<3xindex>
    %dim_1 = tensor.dim %arg2, %c0 : tensor<2xindex>
    %0 = arith.maxui %dim_0, %dim : index
    %1 = arith.maxui %dim_1, %0 : index
    %2 = arith.subi %1, %dim : index
    %3 = arith.subi %1, %dim_0 : index
    %4 = arith.subi %1, %dim_1 : index
    %generated = tensor.generate %1 {
    ^bb0(%arg3: index):
      %c1 = arith.constant 1 : index
      %5 = arith.cmpi ult, %arg3, %2 : index
      %6 = scf.if %5 -> (index) {
        scf.yield %c1 : index
      } else {
        %11 = arith.subi %arg3, %2 : index
        %extracted = tensor.extract %arg0[%11] : tensor<2xindex>
        %12 = arith.cmpi eq, %extracted, %c1 : index
        %13 = arith.select %12, %c1, %extracted : index
        scf.yield %13 : index
      }
      %7 = arith.cmpi ult, %arg3, %3 : index
      %8 = scf.if %7 -> (index) {
        scf.yield %6 : index
      } else {
        %11 = arith.subi %arg3, %3 : index
        %extracted = tensor.extract %arg1[%11] : tensor<3xindex>
        %12 = arith.cmpi eq, %extracted, %c1 : index
        %13 = arith.select %12, %6, %extracted : index
        scf.yield %13 : index
      }
      %9 = arith.cmpi ult, %arg3, %4 : index
      %10 = scf.if %9 -> (index) {
        scf.yield %8 : index
      } else {
        %11 = arith.subi %arg3, %4 : index
        %extracted = tensor.extract %arg2[%11] : tensor<2xindex>
        %12 = arith.cmpi eq, %extracted, %c1 : index
        %13 = arith.select %12, %8, %extracted : index
        scf.yield %13 : index
      }
      tensor.yield %10 : index
    } : tensor<?xindex>
    return
  }
}

// -----
module {
  func.func @broadcast_to_known_rank(%arg0: tensor<1xindex>, %arg1: tensor<3xindex>) -> tensor<3xindex> {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<1xindex>
    %dim_0 = tensor.dim %arg1, %c0 : tensor<3xindex>
    %0 = arith.maxui %dim_0, %dim : index
    %1 = arith.subi %0, %dim : index
    %2 = arith.subi %0, %dim_0 : index
    %generated = tensor.generate %0 {
    ^bb0(%arg2: index):
      %c1 = arith.constant 1 : index
      %3 = arith.cmpi ult, %arg2, %1 : index
      %4 = scf.if %3 -> (index) {
        scf.yield %c1 : index
      } else {
        %7 = arith.subi %arg2, %1 : index
        %extracted = tensor.extract %arg0[%7] : tensor<1xindex>
        %8 = arith.cmpi eq, %extracted, %c1 : index
        %9 = arith.select %8, %c1, %extracted : index
        scf.yield %9 : index
      }
      %5 = arith.cmpi ult, %arg2, %2 : index
      %6 = scf.if %5 -> (index) {
        scf.yield %4 : index
      } else {
        %7 = arith.subi %arg2, %2 : index
        %extracted = tensor.extract %arg1[%7] : tensor<3xindex>
        %8 = arith.cmpi eq, %extracted, %c1 : index
        %9 = arith.select %8, %4, %extracted : index
        scf.yield %9 : index
      }
      tensor.yield %6 : index
    } : tensor<?xindex>
    %cast = tensor.cast %generated : tensor<?xindex> to tensor<3xindex>
    return %cast : tensor<3xindex>
  }
}

// -----
module {
  func.func @split_at(%arg0: tensor<?xindex>, %arg1: index) -> (tensor<?xindex>, tensor<?xindex>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xindex>
    %0 = arith.addi %arg1, %dim : index
    %1 = arith.cmpi slt, %arg1, %c0 : index
    %2 = arith.select %1, %0, %arg1 : index
    %c1 = arith.constant 1 : index
    %extracted_slice = tensor.extract_slice %arg0[%c0] [%2] [%c1] : tensor<?xindex> to tensor<?xindex>
    %3 = arith.subi %dim, %2 : index
    %extracted_slice_0 = tensor.extract_slice %arg0[%2] [%3] [%c1] : tensor<?xindex> to tensor<?xindex>
    return %extracted_slice, %extracted_slice_0 : tensor<?xindex>, tensor<?xindex>
  }
}


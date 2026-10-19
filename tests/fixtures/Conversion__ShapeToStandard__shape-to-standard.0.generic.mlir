"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "binary_ops"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %1 = "arith.muli"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.size, !shape.size) -> (), sym_name = "binary_ops_on_size"}> ({
  ^bb0(%arg0: !shape.size, %arg1: !shape.size):
    %0 = "shape.add"(%arg0, %arg1) : (!shape.size, !shape.size) -> !shape.size
    %1 = "shape.mul"(%arg0, %arg1) : (!shape.size, !shape.size) -> !shape.size
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> index, sym_name = "rank"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?xindex>, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, !shape.size) -> !shape.size, sym_name = "get_extent"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: !shape.size):
    %0 = "shape.get_extent"(%arg0, %arg1) : (tensor<?xindex>, !shape.size) -> !shape.size
    "func.return"(%0) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> (), sym_name = "rank"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.rank"(%arg0) : (!shape.shape) -> !shape.size
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>, index) -> index, sym_name = "dim"}> ({
  ^bb0(%arg0: tensor<2x3xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "tensor.from_elements"(%0, %1) : (index, index) -> tensor<2xindex>
    %3 = "tensor.cast"(%2) : (tensor<2xindex>) -> tensor<2xindex>
    %4 = "tensor.dim"(%arg0, %arg1) : (tensor<2x3xf32>, index) -> index
    "func.return"(%4) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>, index) -> index, sym_name = "get_extent_shape_of"}> ({
  ^bb0(%arg0: tensor<2x3xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "tensor.from_elements"(%0, %1) : (index, index) -> tensor<2xindex>
    %3 = "tensor.cast"(%2) : (tensor<2xindex>) -> tensor<?xindex>
    %4 = "tensor.dim"(%arg0, %arg1) : (tensor<2x3xf32>, index) -> index
    "func.return"(%4) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, index) -> index, sym_name = "get_extent_from_extent_tensor"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: index):
    %0 = "tensor.extract"(%arg0, %arg1) : (tensor<?xindex>, index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<3xindex>, sym_name = "const_shape"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "tensor.from_elements"(%0, %1, %2) : (index, index, index) -> tensor<3xindex>
    %4 = "tensor.cast"(%3) : (tensor<3xindex>) -> tensor<3xindex>
    "func.return"(%4) : (tensor<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<0xindex>, sym_name = "const_shape_zero_elements"}> ({
    %0 = "tensor.from_elements"() : () -> tensor<0xindex>
    %1 = "tensor.cast"(%0) : (tensor<0xindex>) -> tensor<0xindex>
    "func.return"(%1) : (tensor<0xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, tensor<?xindex>, tensor<?xindex>) -> tensor<?xindex>, sym_name = "any_of_three"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: tensor<?xindex>, %arg2: tensor<?xindex>):
    "func.return"(%arg0) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> tensor<?xindex>, sym_name = "any_of_one"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    "func.return"(%arg0) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "const_size"}> ({
    %0 = "arith.constant"() <{value = 42 : index}> : () -> index
    %1 = "arith.constant"() <{value = 42 : index}> : () -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> tensor<3xindex>, sym_name = "to_extent_tensor"}> ({
  ^bb0(%arg3: tensor<?xindex>):
    %7 = "tensor.cast"(%arg3) : (tensor<?xindex>) -> tensor<3xindex>
    "func.return"(%7) : (tensor<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xindex>) -> index, sym_name = "shape_reduce"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %1) : (tensor<?xindex>, index) -> index
    %4 = "scf.for"(%1, %3, %2, %0) ({
    ^bb0(%arg1: index, %arg2: index):
      %5 = "tensor.extract"(%arg0, %arg1) : (tensor<?xindex>, index) -> index
      %6 = "arith.muli"(%arg2, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%6) : (index) -> ()
    }) : (index, index, index, index) -> index
    "func.return"(%4) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>) -> (), sym_name = "shape_of"}> ({
  ^bb0(%arg0: tensor<*xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<*xf32>) -> !shape.shape
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>) -> (), sym_name = "shape_of_unranked"}> ({
  ^bb0(%arg0: tensor<*xf32>):
    %0 = "tensor.rank"(%arg0) : (tensor<*xf32>) -> index
    %1 = "tensor.generate"(%0) ({
    ^bb0(%arg1: index):
      %2 = "tensor.dim"(%arg0, %arg1) : (tensor<*xf32>, index) -> index
      "tensor.yield"(%2) : (index) -> ()
    }) : (index) -> tensor<?xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x3xf32>) -> (), sym_name = "shape_of_stat"}> ({
  ^bb0(%arg0: tensor<1x2x3xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<1x2x3xf32>) -> !shape.shape
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x3xf32>) -> (), sym_name = "shape_of_stat"}> ({
  ^bb0(%arg0: tensor<1x2x3xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "tensor.from_elements"(%0, %1, %2) : (index, index, index) -> tensor<3xindex>
    %4 = "tensor.cast"(%3) : (tensor<3xindex>) -> tensor<?xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> (), sym_name = "shape_of_zero_d"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tensor.from_elements"() : () -> tensor<0xindex>
    %1 = "tensor.cast"(%0) : (tensor<0xindex>) -> tensor<?xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5x?xf32>) -> (), sym_name = "shape_of_dyn"}> ({
  ^bb0(%arg0: tensor<1x5x?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<1x5x?xf32>, index) -> index
    %4 = "tensor.from_elements"(%0, %1, %3) : (index, index, index) -> tensor<3xindex>
    %5 = "tensor.cast"(%4) : (tensor<3xindex>) -> tensor<?xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, tensor<?xindex>) -> i1, sym_name = "shape_eq"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: tensor<?xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?xindex>, index) -> index
    %2 = "tensor.dim"(%arg1, %0) : (tensor<?xindex>, index) -> index
    %3 = "arith.cmpi"(%1, %2) <{predicate = 0 : i64}> : (index, index) -> i1
    %4 = "scf.if"(%3) ({
      %6 = "arith.constant"() <{value = 1 : index}> : () -> index
      %7 = "arith.constant"() <{value = true}> : () -> i1
      %8 = "scf.for"(%0, %1, %6, %7) ({
      ^bb0(%arg2: index, %arg3: i1):
        %9 = "tensor.extract"(%arg0, %arg2) : (tensor<?xindex>, index) -> index
        %10 = "tensor.extract"(%arg1, %arg2) : (tensor<?xindex>, index) -> index
        %11 = "arith.cmpi"(%9, %10) <{predicate = 0 : i64}> : (index, index) -> i1
        %12 = "arith.andi"(%arg3, %11) : (i1, i1) -> i1
        "scf.yield"(%12) : (i1) -> ()
      }) : (index, index, index, i1) -> i1
      "scf.yield"(%8) : (i1) -> ()
    }, {
      %5 = "arith.constant"() <{value = false}> : () -> i1
      "scf.yield"(%5) : (i1) -> ()
    }) : (i1) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, tensor<?xindex>, tensor<?xindex>) -> i1, sym_name = "shape_eq"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: tensor<?xindex>, %arg2: tensor<?xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?xindex>, index) -> index
    %2 = "tensor.dim"(%arg1, %0) : (tensor<?xindex>, index) -> index
    %3 = "arith.cmpi"(%1, %2) <{predicate = 0 : i64}> : (index, index) -> i1
    %4 = "scf.if"(%3) ({
      %18 = "arith.constant"() <{value = 1 : index}> : () -> index
      %19 = "arith.constant"() <{value = true}> : () -> i1
      %20 = "scf.for"(%0, %1, %18, %19) ({
      ^bb0(%arg5: index, %arg6: i1):
        %21 = "tensor.extract"(%arg0, %arg5) : (tensor<?xindex>, index) -> index
        %22 = "tensor.extract"(%arg1, %arg5) : (tensor<?xindex>, index) -> index
        %23 = "arith.cmpi"(%21, %22) <{predicate = 0 : i64}> : (index, index) -> i1
        %24 = "arith.andi"(%arg6, %23) : (i1, i1) -> i1
        "scf.yield"(%24) : (i1) -> ()
      }) : (index, index, index, i1) -> i1
      "scf.yield"(%20) : (i1) -> ()
    }, {
      %17 = "arith.constant"() <{value = false}> : () -> i1
      "scf.yield"(%17) : (i1) -> ()
    }) : (i1) -> i1
    %5 = "tensor.dim"(%arg2, %0) : (tensor<?xindex>, index) -> index
    %6 = "arith.cmpi"(%1, %5) <{predicate = 0 : i64}> : (index, index) -> i1
    %7 = "scf.if"(%6) ({
      %10 = "arith.constant"() <{value = 1 : index}> : () -> index
      %11 = "arith.constant"() <{value = true}> : () -> i1
      %12 = "scf.for"(%0, %1, %10, %11) ({
      ^bb0(%arg3: index, %arg4: i1):
        %13 = "tensor.extract"(%arg0, %arg3) : (tensor<?xindex>, index) -> index
        %14 = "tensor.extract"(%arg2, %arg3) : (tensor<?xindex>, index) -> index
        %15 = "arith.cmpi"(%13, %14) <{predicate = 0 : i64}> : (index, index) -> i1
        %16 = "arith.andi"(%arg4, %15) : (i1, i1) -> i1
        "scf.yield"(%16) : (i1) -> ()
      }) : (index, index, index, i1) -> i1
      "scf.yield"(%12) : (i1) -> ()
    }, {
      %9 = "arith.constant"() <{value = false}> : () -> i1
      "scf.yield"(%9) : (i1) -> ()
    }) : (i1) -> i1
    %8 = "arith.andi"(%4, %7) : (i1, i1) -> i1
    "func.return"(%8) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, !shape.shape) -> !shape.shape, sym_name = "broadcast"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: !shape.shape):
    %0 = "shape.broadcast"(%arg0, %arg1) : (tensor<?xindex>, !shape.shape) -> !shape.shape
    "func.return"(%0) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xindex>, tensor<3xindex>, tensor<2xindex>) -> i1, sym_name = "try_is_broadcastable"}> ({
  ^bb0(%arg0: tensor<2xindex>, %arg1: tensor<3xindex>, %arg2: tensor<2xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %0) : (tensor<2xindex>, index) -> index
    %3 = "tensor.dim"(%arg1, %0) : (tensor<3xindex>, index) -> index
    %4 = "tensor.dim"(%arg2, %0) : (tensor<2xindex>, index) -> index
    %5 = "arith.maxui"(%3, %2) : (index, index) -> index
    %6 = "arith.maxui"(%4, %5) : (index, index) -> index
    %7 = "arith.subi"(%6, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %8 = "arith.subi"(%6, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %9 = "arith.subi"(%6, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "arith.constant"() <{value = true}> : () -> i1
    %11 = "scf.for"(%0, %6, %1, %10) ({
    ^bb0(%arg3: index, %arg4: i1):
      %12 = "arith.constant"() <{value = 1 : index}> : () -> index
      %13 = "arith.cmpi"(%arg3, %7) <{predicate = 6 : i64}> : (index, index) -> i1
      %14 = "scf.if"(%13) ({
        "scf.yield"(%12) : (index) -> ()
      }, {
        %51 = "arith.subi"(%arg3, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %52 = "tensor.extract"(%arg0, %51) : (tensor<2xindex>, index) -> index
        %53 = "arith.cmpi"(%52, %12) <{predicate = 0 : i64}> : (index, index) -> i1
        %54 = "arith.select"(%53, %12, %52) : (i1, index, index) -> index
        "scf.yield"(%54) : (index) -> ()
      }) : (i1) -> index
      %15 = "arith.cmpi"(%arg3, %8) <{predicate = 6 : i64}> : (index, index) -> i1
      %16 = "scf.if"(%15) ({
        "scf.yield"(%14) : (index) -> ()
      }, {
        %47 = "arith.subi"(%arg3, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %48 = "tensor.extract"(%arg1, %47) : (tensor<3xindex>, index) -> index
        %49 = "arith.cmpi"(%48, %12) <{predicate = 0 : i64}> : (index, index) -> i1
        %50 = "arith.select"(%49, %14, %48) : (i1, index, index) -> index
        "scf.yield"(%50) : (index) -> ()
      }) : (i1) -> index
      %17 = "arith.cmpi"(%arg3, %9) <{predicate = 6 : i64}> : (index, index) -> i1
      %18 = "scf.if"(%17) ({
        "scf.yield"(%16) : (index) -> ()
      }, {
        %43 = "arith.subi"(%arg3, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %44 = "tensor.extract"(%arg2, %43) : (tensor<2xindex>, index) -> index
        %45 = "arith.cmpi"(%44, %12) <{predicate = 0 : i64}> : (index, index) -> i1
        %46 = "arith.select"(%45, %16, %44) : (i1, index, index) -> index
        "scf.yield"(%46) : (index) -> ()
      }) : (i1) -> index
      %19 = "arith.cmpi"(%arg3, %7) <{predicate = 6 : i64}> : (index, index) -> i1
      %20 = "scf.if"(%19) ({
        "scf.yield"(%arg4) : (i1) -> ()
      }, {
        %37 = "arith.subi"(%arg3, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %38 = "tensor.extract"(%arg0, %37) : (tensor<2xindex>, index) -> index
        %39 = "arith.cmpi"(%38, %1) <{predicate = 0 : i64}> : (index, index) -> i1
        %40 = "arith.cmpi"(%38, %18) <{predicate = 0 : i64}> : (index, index) -> i1
        %41 = "arith.ori"(%39, %40) : (i1, i1) -> i1
        %42 = "arith.andi"(%arg4, %41) : (i1, i1) -> i1
        "scf.yield"(%42) : (i1) -> ()
      }) : (i1) -> i1
      %21 = "arith.cmpi"(%arg3, %8) <{predicate = 6 : i64}> : (index, index) -> i1
      %22 = "scf.if"(%21) ({
        "scf.yield"(%20) : (i1) -> ()
      }, {
        %31 = "arith.subi"(%arg3, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %32 = "tensor.extract"(%arg1, %31) : (tensor<3xindex>, index) -> index
        %33 = "arith.cmpi"(%32, %1) <{predicate = 0 : i64}> : (index, index) -> i1
        %34 = "arith.cmpi"(%32, %18) <{predicate = 0 : i64}> : (index, index) -> i1
        %35 = "arith.ori"(%33, %34) : (i1, i1) -> i1
        %36 = "arith.andi"(%20, %35) : (i1, i1) -> i1
        "scf.yield"(%36) : (i1) -> ()
      }) : (i1) -> i1
      %23 = "arith.cmpi"(%arg3, %9) <{predicate = 6 : i64}> : (index, index) -> i1
      %24 = "scf.if"(%23) ({
        "scf.yield"(%22) : (i1) -> ()
      }, {
        %25 = "arith.subi"(%arg3, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %26 = "tensor.extract"(%arg2, %25) : (tensor<2xindex>, index) -> index
        %27 = "arith.cmpi"(%26, %1) <{predicate = 0 : i64}> : (index, index) -> i1
        %28 = "arith.cmpi"(%26, %18) <{predicate = 0 : i64}> : (index, index) -> i1
        %29 = "arith.ori"(%27, %28) : (i1, i1) -> i1
        %30 = "arith.andi"(%22, %29) : (i1, i1) -> i1
        "scf.yield"(%30) : (i1) -> ()
      }) : (i1) -> i1
      "scf.yield"(%24) : (i1) -> ()
    }) : (index, index, index, i1) -> i1
    "func.return"(%11) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xindex>, tensor<3xindex>, tensor<2xindex>) -> !shape.witness, sym_name = "broadcast"}> ({
  ^bb0(%arg0: tensor<2xindex>, %arg1: tensor<3xindex>, %arg2: tensor<2xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %0) : (tensor<2xindex>, index) -> index
    %3 = "tensor.dim"(%arg1, %0) : (tensor<3xindex>, index) -> index
    %4 = "tensor.dim"(%arg2, %0) : (tensor<2xindex>, index) -> index
    %5 = "arith.maxui"(%3, %2) : (index, index) -> index
    %6 = "arith.maxui"(%4, %5) : (index, index) -> index
    %7 = "arith.subi"(%6, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %8 = "arith.subi"(%6, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %9 = "arith.subi"(%6, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "arith.constant"() <{value = true}> : () -> i1
    %11 = "scf.for"(%0, %6, %1, %10) ({
    ^bb0(%arg3: index, %arg4: i1):
      %13 = "arith.constant"() <{value = 1 : index}> : () -> index
      %14 = "arith.cmpi"(%arg3, %7) <{predicate = 6 : i64}> : (index, index) -> i1
      %15 = "scf.if"(%14) ({
        "scf.yield"(%13) : (index) -> ()
      }, {
        %52 = "arith.subi"(%arg3, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %53 = "tensor.extract"(%arg0, %52) : (tensor<2xindex>, index) -> index
        %54 = "arith.cmpi"(%53, %13) <{predicate = 0 : i64}> : (index, index) -> i1
        %55 = "arith.select"(%54, %13, %53) : (i1, index, index) -> index
        "scf.yield"(%55) : (index) -> ()
      }) : (i1) -> index
      %16 = "arith.cmpi"(%arg3, %8) <{predicate = 6 : i64}> : (index, index) -> i1
      %17 = "scf.if"(%16) ({
        "scf.yield"(%15) : (index) -> ()
      }, {
        %48 = "arith.subi"(%arg3, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %49 = "tensor.extract"(%arg1, %48) : (tensor<3xindex>, index) -> index
        %50 = "arith.cmpi"(%49, %13) <{predicate = 0 : i64}> : (index, index) -> i1
        %51 = "arith.select"(%50, %15, %49) : (i1, index, index) -> index
        "scf.yield"(%51) : (index) -> ()
      }) : (i1) -> index
      %18 = "arith.cmpi"(%arg3, %9) <{predicate = 6 : i64}> : (index, index) -> i1
      %19 = "scf.if"(%18) ({
        "scf.yield"(%17) : (index) -> ()
      }, {
        %44 = "arith.subi"(%arg3, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %45 = "tensor.extract"(%arg2, %44) : (tensor<2xindex>, index) -> index
        %46 = "arith.cmpi"(%45, %13) <{predicate = 0 : i64}> : (index, index) -> i1
        %47 = "arith.select"(%46, %17, %45) : (i1, index, index) -> index
        "scf.yield"(%47) : (index) -> ()
      }) : (i1) -> index
      %20 = "arith.cmpi"(%arg3, %7) <{predicate = 6 : i64}> : (index, index) -> i1
      %21 = "scf.if"(%20) ({
        "scf.yield"(%arg4) : (i1) -> ()
      }, {
        %38 = "arith.subi"(%arg3, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %39 = "tensor.extract"(%arg0, %38) : (tensor<2xindex>, index) -> index
        %40 = "arith.cmpi"(%39, %1) <{predicate = 0 : i64}> : (index, index) -> i1
        %41 = "arith.cmpi"(%39, %19) <{predicate = 0 : i64}> : (index, index) -> i1
        %42 = "arith.ori"(%40, %41) : (i1, i1) -> i1
        %43 = "arith.andi"(%arg4, %42) : (i1, i1) -> i1
        "scf.yield"(%43) : (i1) -> ()
      }) : (i1) -> i1
      %22 = "arith.cmpi"(%arg3, %8) <{predicate = 6 : i64}> : (index, index) -> i1
      %23 = "scf.if"(%22) ({
        "scf.yield"(%21) : (i1) -> ()
      }, {
        %32 = "arith.subi"(%arg3, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %33 = "tensor.extract"(%arg1, %32) : (tensor<3xindex>, index) -> index
        %34 = "arith.cmpi"(%33, %1) <{predicate = 0 : i64}> : (index, index) -> i1
        %35 = "arith.cmpi"(%33, %19) <{predicate = 0 : i64}> : (index, index) -> i1
        %36 = "arith.ori"(%34, %35) : (i1, i1) -> i1
        %37 = "arith.andi"(%21, %36) : (i1, i1) -> i1
        "scf.yield"(%37) : (i1) -> ()
      }) : (i1) -> i1
      %24 = "arith.cmpi"(%arg3, %9) <{predicate = 6 : i64}> : (index, index) -> i1
      %25 = "scf.if"(%24) ({
        "scf.yield"(%23) : (i1) -> ()
      }, {
        %26 = "arith.subi"(%arg3, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %27 = "tensor.extract"(%arg2, %26) : (tensor<2xindex>, index) -> index
        %28 = "arith.cmpi"(%27, %1) <{predicate = 0 : i64}> : (index, index) -> i1
        %29 = "arith.cmpi"(%27, %19) <{predicate = 0 : i64}> : (index, index) -> i1
        %30 = "arith.ori"(%28, %29) : (i1, i1) -> i1
        %31 = "arith.andi"(%23, %30) : (i1, i1) -> i1
        "scf.yield"(%31) : (i1) -> ()
      }) : (i1) -> i1
      "scf.yield"(%25) : (i1) -> ()
    }) : (index, index, index, i1) -> i1
    %12 = "shape.cstr_require"(%11) <{msg = "required broadcastable shapes"}> : (i1) -> !shape.witness
    "func.return"(%12) : (!shape.witness) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xindex>, tensor<3xindex>, tensor<2xindex>) -> (), sym_name = "broadcast_3_shapes_different_extents"}> ({
  ^bb0(%arg0: tensor<2xindex>, %arg1: tensor<3xindex>, %arg2: tensor<2xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<2xindex>, index) -> index
    %2 = "tensor.dim"(%arg1, %0) : (tensor<3xindex>, index) -> index
    %3 = "tensor.dim"(%arg2, %0) : (tensor<2xindex>, index) -> index
    %4 = "arith.maxui"(%2, %1) : (index, index) -> index
    %5 = "arith.maxui"(%3, %4) : (index, index) -> index
    %6 = "arith.subi"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %7 = "arith.subi"(%5, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %8 = "arith.subi"(%5, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %9 = "tensor.generate"(%5) ({
    ^bb0(%arg3: index):
      %10 = "arith.constant"() <{value = 1 : index}> : () -> index
      %11 = "arith.cmpi"(%arg3, %6) <{predicate = 6 : i64}> : (index, index) -> i1
      %12 = "scf.if"(%11) ({
        "scf.yield"(%10) : (index) -> ()
      }, {
        %25 = "arith.subi"(%arg3, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %26 = "tensor.extract"(%arg0, %25) : (tensor<2xindex>, index) -> index
        %27 = "arith.cmpi"(%26, %10) <{predicate = 0 : i64}> : (index, index) -> i1
        %28 = "arith.select"(%27, %10, %26) : (i1, index, index) -> index
        "scf.yield"(%28) : (index) -> ()
      }) : (i1) -> index
      %13 = "arith.cmpi"(%arg3, %7) <{predicate = 6 : i64}> : (index, index) -> i1
      %14 = "scf.if"(%13) ({
        "scf.yield"(%12) : (index) -> ()
      }, {
        %21 = "arith.subi"(%arg3, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %22 = "tensor.extract"(%arg1, %21) : (tensor<3xindex>, index) -> index
        %23 = "arith.cmpi"(%22, %10) <{predicate = 0 : i64}> : (index, index) -> i1
        %24 = "arith.select"(%23, %12, %22) : (i1, index, index) -> index
        "scf.yield"(%24) : (index) -> ()
      }) : (i1) -> index
      %15 = "arith.cmpi"(%arg3, %8) <{predicate = 6 : i64}> : (index, index) -> i1
      %16 = "scf.if"(%15) ({
        "scf.yield"(%14) : (index) -> ()
      }, {
        %17 = "arith.subi"(%arg3, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %18 = "tensor.extract"(%arg2, %17) : (tensor<2xindex>, index) -> index
        %19 = "arith.cmpi"(%18, %10) <{predicate = 0 : i64}> : (index, index) -> i1
        %20 = "arith.select"(%19, %14, %18) : (i1, index, index) -> index
        "scf.yield"(%20) : (index) -> ()
      }) : (i1) -> index
      "tensor.yield"(%16) : (index) -> ()
    }) : (index) -> tensor<?xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xindex>, tensor<3xindex>) -> tensor<3xindex>, sym_name = "broadcast_to_known_rank"}> ({
  ^bb0(%arg0: tensor<1xindex>, %arg1: tensor<3xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<1xindex>, index) -> index
    %2 = "tensor.dim"(%arg1, %0) : (tensor<3xindex>, index) -> index
    %3 = "arith.maxui"(%2, %1) : (index, index) -> index
    %4 = "arith.subi"(%3, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "arith.subi"(%3, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "tensor.generate"(%3) ({
    ^bb0(%arg2: index):
      %8 = "arith.constant"() <{value = 1 : index}> : () -> index
      %9 = "arith.cmpi"(%arg2, %4) <{predicate = 6 : i64}> : (index, index) -> i1
      %10 = "scf.if"(%9) ({
        "scf.yield"(%8) : (index) -> ()
      }, {
        %17 = "arith.subi"(%arg2, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %18 = "tensor.extract"(%arg0, %17) : (tensor<1xindex>, index) -> index
        %19 = "arith.cmpi"(%18, %8) <{predicate = 0 : i64}> : (index, index) -> i1
        %20 = "arith.select"(%19, %8, %18) : (i1, index, index) -> index
        "scf.yield"(%20) : (index) -> ()
      }) : (i1) -> index
      %11 = "arith.cmpi"(%arg2, %5) <{predicate = 6 : i64}> : (index, index) -> i1
      %12 = "scf.if"(%11) ({
        "scf.yield"(%10) : (index) -> ()
      }, {
        %13 = "arith.subi"(%arg2, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %14 = "tensor.extract"(%arg1, %13) : (tensor<3xindex>, index) -> index
        %15 = "arith.cmpi"(%14, %8) <{predicate = 0 : i64}> : (index, index) -> i1
        %16 = "arith.select"(%15, %10, %14) : (i1, index, index) -> index
        "scf.yield"(%16) : (index) -> ()
      }) : (i1) -> index
      "tensor.yield"(%12) : (index) -> ()
    }) : (index) -> tensor<?xindex>
    %7 = "tensor.cast"(%6) : (tensor<?xindex>) -> tensor<3xindex>
    "func.return"(%7) : (tensor<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, index) -> (tensor<?xindex>, tensor<?xindex>), sym_name = "split_at"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?xindex>, index) -> index
    %2 = "arith.addi"(%arg1, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %3 = "arith.cmpi"(%arg1, %0) <{predicate = 2 : i64}> : (index, index) -> i1
    %4 = "arith.select"(%3, %2, %arg1) : (i1, index, index) -> index
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    %6 = "tensor.extract_slice"(%arg0, %0, %4, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: -9223372036854775808>}> : (tensor<?xindex>, index, index, index) -> tensor<?xindex>
    %7 = "arith.subi"(%1, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %8 = "tensor.extract_slice"(%arg0, %4, %7, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: -9223372036854775808>}> : (tensor<?xindex>, index, index, index) -> tensor<?xindex>
    "func.return"(%6, %8) : (tensor<?xindex>, tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()


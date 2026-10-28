#map = affine_map<()[s0, s1] -> (s0 * s1)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "foo"}> ({
    "gpu.func"() <{arg_attrs = [{gpu.test_promote_workgroup}], function_type = (memref<5x4xf32>) -> ()}> ({
    ^bb0(%arg0: memref<5x4xf32>, %arg1: memref<5x4xf32, #gpu.address_space<workgroup>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = 1 : index}> : () -> index
      %2 = "arith.constant"() <{value = 0 : index}> : () -> index
      %3 = "arith.constant"() <{value = 5 : index}> : () -> index
      %4 = "arith.constant"() <{value = 1 : index}> : () -> index
      %5 = "arith.constant"() <{value = 4 : index}> : () -> index
      %6 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %8 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %10 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "affine.apply"(%10, %1) <{map = #map}> : (index, index) -> index
      %13 = "affine.apply"(%12, %0) <{map = #map1}> : (index, index) -> index
      %14 = "affine.apply"(%11, %1) <{map = #map}> : (index, index) -> index
      "scf.for"(%13, %1, %14) ({
      ^bb0(%arg5: index):
        %37 = "affine.apply"(%8, %1) <{map = #map}> : (index, index) -> index
        %38 = "affine.apply"(%37, %0) <{map = #map1}> : (index, index) -> index
        %39 = "affine.apply"(%9, %1) <{map = #map}> : (index, index) -> index
        "scf.for"(%38, %3, %39) ({
        ^bb0(%arg6: index):
          %40 = "affine.apply"(%6, %1) <{map = #map}> : (index, index) -> index
          %41 = "affine.apply"(%40, %0) <{map = #map1}> : (index, index) -> index
          %42 = "affine.apply"(%7, %1) <{map = #map}> : (index, index) -> index
          "scf.for"(%41, %5, %42) ({
          ^bb0(%arg7: index):
            %43 = "memref.load"(%arg0, %arg6, %arg7) <{nontemporal = false}> : (memref<5x4xf32>, index, index) -> f32
            "memref.store"(%43, %arg1, %arg6, %arg7) <{nontemporal = false}> : (f32, memref<5x4xf32, #gpu.address_space<workgroup>>, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "gpu.barrier"() : () -> ()
      "use"(%arg1) : (memref<5x4xf32, #gpu.address_space<workgroup>>) -> ()
      "gpu.barrier"() : () -> ()
      %15 = "arith.constant"() <{value = 0 : index}> : () -> index
      %16 = "arith.constant"() <{value = 1 : index}> : () -> index
      %17 = "arith.constant"() <{value = 0 : index}> : () -> index
      %18 = "arith.constant"() <{value = 5 : index}> : () -> index
      %19 = "arith.constant"() <{value = 1 : index}> : () -> index
      %20 = "arith.constant"() <{value = 4 : index}> : () -> index
      %21 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %22 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %23 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %24 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %25 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %26 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %27 = "affine.apply"(%25, %16) <{map = #map}> : (index, index) -> index
      %28 = "affine.apply"(%27, %15) <{map = #map1}> : (index, index) -> index
      %29 = "affine.apply"(%26, %16) <{map = #map}> : (index, index) -> index
      "scf.for"(%28, %16, %29) ({
      ^bb0(%arg2: index):
        %30 = "affine.apply"(%23, %16) <{map = #map}> : (index, index) -> index
        %31 = "affine.apply"(%30, %15) <{map = #map1}> : (index, index) -> index
        %32 = "affine.apply"(%24, %16) <{map = #map}> : (index, index) -> index
        "scf.for"(%31, %18, %32) ({
        ^bb0(%arg3: index):
          %33 = "affine.apply"(%21, %16) <{map = #map}> : (index, index) -> index
          %34 = "affine.apply"(%33, %15) <{map = #map1}> : (index, index) -> index
          %35 = "affine.apply"(%22, %16) <{map = #map}> : (index, index) -> index
          "scf.for"(%34, %20, %35) ({
          ^bb0(%arg4: index):
            %36 = "memref.load"(%arg1, %arg3, %arg4) <{nontemporal = false}> : (memref<5x4xf32, #gpu.address_space<workgroup>>, index, index) -> f32
            "memref.store"(%36, %arg0, %arg3, %arg4) <{nontemporal = false}> : (f32, memref<5x4xf32>, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "memref3d", workgroup_attributions = 1 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 * s1)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "foo"}> ({
    "gpu.func"() <{arg_attrs = [{gpu.test_promote_workgroup}], function_type = (memref<8x7x6x5x4xf32>) -> ()}> ({
    ^bb0(%arg0: memref<8x7x6x5x4xf32>, %arg1: memref<8x7x6x5x4xf32, #gpu.address_space<workgroup>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = 1 : index}> : () -> index
      %2 = "arith.constant"() <{value = 0 : index}> : () -> index
      %3 = "arith.constant"() <{value = 8 : index}> : () -> index
      %4 = "arith.constant"() <{value = 1 : index}> : () -> index
      %5 = "arith.constant"() <{value = 7 : index}> : () -> index
      %6 = "arith.constant"() <{value = 2 : index}> : () -> index
      %7 = "arith.constant"() <{value = 6 : index}> : () -> index
      %8 = "arith.constant"() <{value = 3 : index}> : () -> index
      %9 = "arith.constant"() <{value = 5 : index}> : () -> index
      %10 = "arith.constant"() <{value = 4 : index}> : () -> index
      %11 = "arith.constant"() <{value = 4 : index}> : () -> index
      %12 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %13 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %14 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %15 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %16 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %17 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "scf.for"(%0, %3, %1) ({
      ^bb0(%arg7: index):
        "scf.for"(%0, %5, %1) ({
        ^bb0(%arg8: index):
          %46 = "affine.apply"(%16, %1) <{map = #map}> : (index, index) -> index
          %47 = "affine.apply"(%46, %0) <{map = #map1}> : (index, index) -> index
          %48 = "affine.apply"(%17, %1) <{map = #map}> : (index, index) -> index
          "scf.for"(%47, %7, %48) ({
          ^bb0(%arg9: index):
            %49 = "affine.apply"(%14, %1) <{map = #map}> : (index, index) -> index
            %50 = "affine.apply"(%49, %0) <{map = #map1}> : (index, index) -> index
            %51 = "affine.apply"(%15, %1) <{map = #map}> : (index, index) -> index
            "scf.for"(%50, %9, %51) ({
            ^bb0(%arg10: index):
              %52 = "affine.apply"(%12, %1) <{map = #map}> : (index, index) -> index
              %53 = "affine.apply"(%52, %0) <{map = #map1}> : (index, index) -> index
              %54 = "affine.apply"(%13, %1) <{map = #map}> : (index, index) -> index
              "scf.for"(%53, %11, %54) ({
              ^bb0(%arg11: index):
                %55 = "memref.load"(%arg0, %arg7, %arg8, %arg9, %arg10, %arg11) <{nontemporal = false}> : (memref<8x7x6x5x4xf32>, index, index, index, index, index) -> f32
                "memref.store"(%55, %arg1, %arg7, %arg8, %arg9, %arg10, %arg11) <{nontemporal = false}> : (f32, memref<8x7x6x5x4xf32, #gpu.address_space<workgroup>>, index, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }) : (index, index, index) -> ()
              "scf.yield"() : () -> ()
            }) : (index, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "gpu.barrier"() : () -> ()
      "use"(%arg1) : (memref<8x7x6x5x4xf32, #gpu.address_space<workgroup>>) -> ()
      "gpu.barrier"() : () -> ()
      %18 = "arith.constant"() <{value = 0 : index}> : () -> index
      %19 = "arith.constant"() <{value = 1 : index}> : () -> index
      %20 = "arith.constant"() <{value = 0 : index}> : () -> index
      %21 = "arith.constant"() <{value = 8 : index}> : () -> index
      %22 = "arith.constant"() <{value = 1 : index}> : () -> index
      %23 = "arith.constant"() <{value = 7 : index}> : () -> index
      %24 = "arith.constant"() <{value = 2 : index}> : () -> index
      %25 = "arith.constant"() <{value = 6 : index}> : () -> index
      %26 = "arith.constant"() <{value = 3 : index}> : () -> index
      %27 = "arith.constant"() <{value = 5 : index}> : () -> index
      %28 = "arith.constant"() <{value = 4 : index}> : () -> index
      %29 = "arith.constant"() <{value = 4 : index}> : () -> index
      %30 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %31 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %32 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %33 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %34 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %35 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "scf.for"(%18, %21, %19) ({
      ^bb0(%arg2: index):
        "scf.for"(%18, %23, %19) ({
        ^bb0(%arg3: index):
          %36 = "affine.apply"(%34, %19) <{map = #map}> : (index, index) -> index
          %37 = "affine.apply"(%36, %18) <{map = #map1}> : (index, index) -> index
          %38 = "affine.apply"(%35, %19) <{map = #map}> : (index, index) -> index
          "scf.for"(%37, %25, %38) ({
          ^bb0(%arg4: index):
            %39 = "affine.apply"(%32, %19) <{map = #map}> : (index, index) -> index
            %40 = "affine.apply"(%39, %18) <{map = #map1}> : (index, index) -> index
            %41 = "affine.apply"(%33, %19) <{map = #map}> : (index, index) -> index
            "scf.for"(%40, %27, %41) ({
            ^bb0(%arg5: index):
              %42 = "affine.apply"(%30, %19) <{map = #map}> : (index, index) -> index
              %43 = "affine.apply"(%42, %18) <{map = #map1}> : (index, index) -> index
              %44 = "affine.apply"(%31, %19) <{map = #map}> : (index, index) -> index
              "scf.for"(%43, %29, %44) ({
              ^bb0(%arg6: index):
                %45 = "memref.load"(%arg1, %arg2, %arg3, %arg4, %arg5, %arg6) <{nontemporal = false}> : (memref<8x7x6x5x4xf32, #gpu.address_space<workgroup>>, index, index, index, index, index) -> f32
                "memref.store"(%45, %arg0, %arg2, %arg3, %arg4, %arg5, %arg6) <{nontemporal = false}> : (f32, memref<8x7x6x5x4xf32>, index, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }) : (index, index, index) -> ()
              "scf.yield"() : () -> ()
            }) : (index, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "memref5d", workgroup_attributions = 1 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 * s1)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "foo"}> ({
    "gpu.func"() <{arg_attrs = [{gpu.test_promote_workgroup}], function_type = (memref<4xf32>) -> ()}> ({
    ^bb0(%arg0: memref<4xf32>, %arg1: memref<1x1xf64, #gpu.address_space<workgroup>>, %arg2: memref<4xf32, #gpu.address_space<workgroup>>, %arg3: memref<1x1xi64, 5>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = 1 : index}> : () -> index
      %2 = "arith.constant"() <{value = 0 : index}> : () -> index
      %3 = "arith.constant"() <{value = 4 : index}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %5 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %6 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %7 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %10 = "affine.apply"(%8, %1) <{map = #map}> : (index, index) -> index
      %11 = "affine.apply"(%10, %0) <{map = #map1}> : (index, index) -> index
      %12 = "affine.apply"(%9, %1) <{map = #map}> : (index, index) -> index
      "scf.for"(%11, %1, %12) ({
      ^bb0(%arg7: index):
        %33 = "affine.apply"(%6, %1) <{map = #map}> : (index, index) -> index
        %34 = "affine.apply"(%33, %0) <{map = #map1}> : (index, index) -> index
        %35 = "affine.apply"(%7, %1) <{map = #map}> : (index, index) -> index
        "scf.for"(%34, %1, %35) ({
        ^bb0(%arg8: index):
          %36 = "affine.apply"(%4, %1) <{map = #map}> : (index, index) -> index
          %37 = "affine.apply"(%36, %0) <{map = #map1}> : (index, index) -> index
          %38 = "affine.apply"(%5, %1) <{map = #map}> : (index, index) -> index
          "scf.for"(%37, %3, %38) ({
          ^bb0(%arg9: index):
            %39 = "memref.load"(%arg0, %arg9) <{nontemporal = false}> : (memref<4xf32>, index) -> f32
            "memref.store"(%39, %arg2, %arg9) <{nontemporal = false}> : (f32, memref<4xf32, #gpu.address_space<workgroup>>, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "gpu.barrier"() : () -> ()
      "use"(%arg2) : (memref<4xf32, #gpu.address_space<workgroup>>) -> ()
      "gpu.barrier"() : () -> ()
      %13 = "arith.constant"() <{value = 0 : index}> : () -> index
      %14 = "arith.constant"() <{value = 1 : index}> : () -> index
      %15 = "arith.constant"() <{value = 0 : index}> : () -> index
      %16 = "arith.constant"() <{value = 4 : index}> : () -> index
      %17 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %18 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %19 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %20 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %21 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %22 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %23 = "affine.apply"(%21, %14) <{map = #map}> : (index, index) -> index
      %24 = "affine.apply"(%23, %13) <{map = #map1}> : (index, index) -> index
      %25 = "affine.apply"(%22, %14) <{map = #map}> : (index, index) -> index
      "scf.for"(%24, %14, %25) ({
      ^bb0(%arg4: index):
        %26 = "affine.apply"(%19, %14) <{map = #map}> : (index, index) -> index
        %27 = "affine.apply"(%26, %13) <{map = #map1}> : (index, index) -> index
        %28 = "affine.apply"(%20, %14) <{map = #map}> : (index, index) -> index
        "scf.for"(%27, %14, %28) ({
        ^bb0(%arg5: index):
          %29 = "affine.apply"(%17, %14) <{map = #map}> : (index, index) -> index
          %30 = "affine.apply"(%29, %13) <{map = #map1}> : (index, index) -> index
          %31 = "affine.apply"(%18, %14) <{map = #map}> : (index, index) -> index
          "scf.for"(%30, %16, %31) ({
          ^bb0(%arg6: index):
            %32 = "memref.load"(%arg2, %arg6) <{nontemporal = false}> : (memref<4xf32, #gpu.address_space<workgroup>>, index) -> f32
            "memref.store"(%32, %arg0, %arg6) <{nontemporal = false}> : (f32, memref<4xf32>, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "insert", workgroup_attributions = 2 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()


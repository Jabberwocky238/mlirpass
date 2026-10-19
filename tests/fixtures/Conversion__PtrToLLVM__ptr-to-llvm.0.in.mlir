"builtin.module"() ({
  "func.func"() <{function_type = (!ptr.ptr<#ptr.generic_space>, index) -> (!ptr.ptr<#ptr.generic_space>, !ptr.ptr<#ptr.generic_space>, !ptr.ptr<#ptr.generic_space>, !ptr.ptr<#ptr.generic_space>), sym_name = "test_ptr_add"}> ({
  ^bb0(%arg13: !ptr.ptr<#ptr.generic_space>, %arg14: index):
    %26 = "ptr.ptr_add"(%arg13, %arg14) <{flags = 0 : i32}> : (!ptr.ptr<#ptr.generic_space>, index) -> !ptr.ptr<#ptr.generic_space>
    %27 = "ptr.ptr_add"(%arg13, %arg14) <{flags = 1 : i32}> : (!ptr.ptr<#ptr.generic_space>, index) -> !ptr.ptr<#ptr.generic_space>
    %28 = "ptr.ptr_add"(%arg13, %arg14) <{flags = 2 : i32}> : (!ptr.ptr<#ptr.generic_space>, index) -> !ptr.ptr<#ptr.generic_space>
    %29 = "ptr.ptr_add"(%arg13, %arg14) <{flags = 3 : i32}> : (!ptr.ptr<#ptr.generic_space>, index) -> !ptr.ptr<#ptr.generic_space>
    "func.return"(%26, %27, %28, %29) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr<#ptr.generic_space>, !ptr.ptr<#ptr.generic_space>, !ptr.ptr<#ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (index, index, index), sym_name = "test_type_offset"}> ({
    %23 = "ptr.type_offset"() <{elementType = f32}> : () -> index
    %24 = "ptr.type_offset"() <{elementType = i64}> : () -> index
    %25 = "ptr.type_offset"() <{elementType = !llvm.struct<(i32, f64)>}> : () -> index
    "func.return"(%23, %24, %25) : (index, index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>, sym_name = "test_to_ptr"}> ({
  ^bb0(%arg12: memref<10xf32, #ptr.generic_space>):
    %22 = "ptr.to_ptr"(%arg12) : (memref<10xf32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    "func.return"(%22) : (!ptr.ptr<#ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10x20xf32, #ptr.generic_space>) -> !ptr.ptr_metadata<memref<10x20xf32, #ptr.generic_space>>, sym_name = "test_get_metadata_static"}> ({
  ^bb0(%arg11: memref<10x20xf32, #ptr.generic_space>):
    %21 = "ptr.get_metadata"(%arg11) : (memref<10x20xf32, #ptr.generic_space>) -> !ptr.ptr_metadata<memref<10x20xf32, #ptr.generic_space>>
    "func.return"(%21) : (!ptr.ptr_metadata<memref<10x20xf32, #ptr.generic_space>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32, #ptr.generic_space>) -> !ptr.ptr_metadata<memref<?x?xf32, #ptr.generic_space>>, sym_name = "test_get_metadata_dynamic"}> ({
  ^bb0(%arg10: memref<?x?xf32, #ptr.generic_space>):
    %20 = "ptr.get_metadata"(%arg10) : (memref<?x?xf32, #ptr.generic_space>) -> !ptr.ptr_metadata<memref<?x?xf32, #ptr.generic_space>>
    "func.return"(%20) : (!ptr.ptr_metadata<memref<?x?xf32, #ptr.generic_space>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<10x20xf32, #ptr.generic_space>>) -> memref<10x20xf32, #ptr.generic_space>, sym_name = "test_from_ptr_static"}> ({
  ^bb0(%arg8: !ptr.ptr<#ptr.generic_space>, %arg9: !ptr.ptr_metadata<memref<10x20xf32, #ptr.generic_space>>):
    %19 = "ptr.from_ptr"(%arg8, %arg9) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<10x20xf32, #ptr.generic_space>>) -> memref<10x20xf32, #ptr.generic_space>
    "func.return"(%19) : (memref<10x20xf32, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<?x?xf32, #ptr.generic_space>>) -> memref<?x?xf32, #ptr.generic_space>, sym_name = "test_from_ptr_dynamic"}> ({
  ^bb0(%arg6: !ptr.ptr<#ptr.generic_space>, %arg7: !ptr.ptr_metadata<memref<?x?xf32, #ptr.generic_space>>):
    %18 = "ptr.from_ptr"(%arg6, %arg7) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<?x?xf32, #ptr.generic_space>>) -> memref<?x?xf32, #ptr.generic_space>
    "func.return"(%18) : (memref<?x?xf32, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10x?x30xf32, #ptr.generic_space>) -> memref<10x?x30xf32, #ptr.generic_space>, sym_name = "test_memref_mixed"}> ({
  ^bb0(%arg5: memref<10x?x30xf32, #ptr.generic_space>):
    %15 = "ptr.to_ptr"(%arg5) : (memref<10x?x30xf32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %16 = "ptr.get_metadata"(%arg5) : (memref<10x?x30xf32, #ptr.generic_space>) -> !ptr.ptr_metadata<memref<10x?x30xf32, #ptr.generic_space>>
    %17 = "ptr.from_ptr"(%15, %16) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<10x?x30xf32, #ptr.generic_space>>) -> memref<10x?x30xf32, #ptr.generic_space>
    "func.return"(%17) : (memref<10x?x30xf32, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10x20xf32, strided<[40, 2], offset: 5>, #ptr.generic_space>) -> memref<10x20xf32, strided<[40, 2], offset: 5>, #ptr.generic_space>, sym_name = "test_memref_strided"}> ({
  ^bb0(%arg4: memref<10x20xf32, strided<[40, 2], offset: 5>, #ptr.generic_space>):
    %12 = "ptr.to_ptr"(%arg4) : (memref<10x20xf32, strided<[40, 2], offset: 5>, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %13 = "ptr.get_metadata"(%arg4) : (memref<10x20xf32, strided<[40, 2], offset: 5>, #ptr.generic_space>) -> !ptr.ptr_metadata<memref<10x20xf32, strided<[40, 2], offset: 5>, #ptr.generic_space>>
    %14 = "ptr.from_ptr"(%12, %13) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<10x20xf32, strided<[40, 2], offset: 5>, #ptr.generic_space>>) -> memref<10x20xf32, strided<[40, 2], offset: 5>, #ptr.generic_space>
    "func.return"(%14) : (memref<10x20xf32, strided<[40, 2], offset: 5>, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>, #ptr.generic_space>) -> memref<?x?xf32, strided<[?, ?], offset: ?>, #ptr.generic_space>, sym_name = "test_comprehensive_dynamic"}> ({
  ^bb0(%arg3: memref<?x?xf32, strided<[?, ?], offset: ?>, #ptr.generic_space>):
    %7 = "ptr.to_ptr"(%arg3) : (memref<?x?xf32, strided<[?, ?], offset: ?>, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %8 = "ptr.get_metadata"(%arg3) : (memref<?x?xf32, strided<[?, ?], offset: ?>, #ptr.generic_space>) -> !ptr.ptr_metadata<memref<?x?xf32, strided<[?, ?], offset: ?>, #ptr.generic_space>>
    %9 = "ptr.type_offset"() <{elementType = f32}> : () -> index
    %10 = "ptr.ptr_add"(%7, %9) <{flags = 3 : i32}> : (!ptr.ptr<#ptr.generic_space>, index) -> !ptr.ptr<#ptr.generic_space>
    %11 = "ptr.from_ptr"(%10, %8) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<?x?xf32, strided<[?, ?], offset: ?>, #ptr.generic_space>>) -> memref<?x?xf32, strided<[?, ?], offset: ?>, #ptr.generic_space>
    "func.return"(%11) : (memref<?x?xf32, strided<[?, ?], offset: ?>, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #ptr.generic_space>) -> memref<f32, #ptr.generic_space>, sym_name = "test_memref_0d"}> ({
  ^bb0(%arg2: memref<f32, #ptr.generic_space>):
    %4 = "ptr.to_ptr"(%arg2) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %5 = "ptr.get_metadata"(%arg2) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>
    %6 = "ptr.from_ptr"(%4, %5) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space>
    "func.return"(%6) : (memref<f32, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10x?x30xf32, #ptr.generic_space>, index) -> !ptr.ptr<#ptr.generic_space>, sym_name = "test_memref_ptradd_indexing"}> ({
  ^bb0(%arg0: memref<10x?x30xf32, #ptr.generic_space>, %arg1: index):
    %0 = "ptr.to_ptr"(%arg0) : (memref<10x?x30xf32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %1 = "ptr.type_offset"() <{elementType = f32}> : () -> index
    %2 = "arith.muli"(%1, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %3 = "ptr.ptr_add"(%0, %2) <{flags = 0 : i32}> : (!ptr.ptr<#ptr.generic_space>, index) -> !ptr.ptr<#ptr.generic_space>
    "func.return"(%3) : (!ptr.ptr<#ptr.generic_space>) -> ()
  }) : () -> ()
}) : () -> ()


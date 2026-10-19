"builtin.module"() ({
  "func.func"() <{function_type = (!ptr.ptr<#ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>, sym_name = "zero_offset"}> ({
  ^bb0(%arg11: !ptr.ptr<#ptr.generic_space>):
    %27 = "index.constant"() <{value = 0 : index}> : () -> index
    %28 = "ptr.ptr_add"(%arg11, %27) <{flags = 0 : i32}> : (!ptr.ptr<#ptr.generic_space>, index) -> !ptr.ptr<#ptr.generic_space>
    "func.return"(%28) : (!ptr.ptr<#ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #ptr.generic_space>) -> memref<f32, #ptr.generic_space>, sym_name = "test_from_ptr_0"}> ({
  ^bb0(%arg10: memref<f32, #ptr.generic_space>):
    %24 = "ptr.to_ptr"(%arg10) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %25 = "ptr.get_metadata"(%arg10) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>
    %26 = "ptr.from_ptr"(%24, %25) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space>
    "func.return"(%26) : (memref<f32, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #ptr.generic_space>) -> memref<f32, #ptr.generic_space>, sym_name = "test_from_ptr_1"}> ({
  ^bb0(%arg9: memref<f32, #ptr.generic_space>):
    %22 = "ptr.to_ptr"(%arg9) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %23 = "ptr.from_ptr"(%22) : (!ptr.ptr<#ptr.generic_space>) -> memref<f32, #ptr.generic_space>
    "func.return"(%23) : (memref<f32, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space>, sym_name = "test_from_ptr_2"}> ({
  ^bb0(%arg7: memref<f32, #ptr.generic_space>, %arg8: !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>):
    %20 = "ptr.to_ptr"(%arg7) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %21 = "ptr.from_ptr"(%20, %arg8) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space>
    "func.return"(%21) : (memref<f32, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #ptr.generic_space>) -> memref<f32, #ptr.generic_space>, sym_name = "test_from_ptr_3"}> ({
  ^bb0(%arg6: memref<f32, #ptr.generic_space>):
    %15 = "ptr.get_metadata"(%arg6) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>
    %16 = "ptr.to_ptr"(%arg6) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %17 = "ptr.from_ptr"(%16, %15) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space>
    %18 = "ptr.to_ptr"(%17) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %19 = "ptr.from_ptr"(%18, %15) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space>
    "func.return"(%19) : (memref<f32, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> !ptr.ptr<#ptr.generic_space>, sym_name = "test_to_ptr_0"}> ({
  ^bb0(%arg4: !ptr.ptr<#ptr.generic_space>, %arg5: !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>):
    %13 = "ptr.from_ptr"(%arg4, %arg5) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space>
    %14 = "ptr.to_ptr"(%13) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    "func.return"(%14) : (!ptr.ptr<#ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!ptr.ptr<#ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>, sym_name = "test_to_ptr_1"}> ({
  ^bb0(%arg3: !ptr.ptr<#ptr.generic_space>):
    %11 = "ptr.from_ptr"(%arg3) : (!ptr.ptr<#ptr.generic_space>) -> memref<f32, #ptr.generic_space>
    %12 = "ptr.to_ptr"(%11) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    "func.return"(%12) : (!ptr.ptr<#ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!ptr.ptr<#ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>, sym_name = "test_to_ptr_2"}> ({
  ^bb0(%arg2: !ptr.ptr<#ptr.generic_space>):
    %5 = "ptr.from_ptr"(%arg2) : (!ptr.ptr<#ptr.generic_space>) -> memref<f32, #ptr.generic_space>
    %6 = "ptr.to_ptr"(%5) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %7 = "ptr.from_ptr"(%6) : (!ptr.ptr<#ptr.generic_space>) -> memref<f32, #ptr.generic_space>
    %8 = "ptr.to_ptr"(%7) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %9 = "ptr.from_ptr"(%8) : (!ptr.ptr<#ptr.generic_space>) -> memref<f32, #ptr.generic_space>
    %10 = "ptr.to_ptr"(%9) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    "func.return"(%10) : (!ptr.ptr<#ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space>, sym_name = "test_cast_chain_folding"}> ({
  ^bb0(%arg0: memref<f32, #ptr.generic_space>, %arg1: !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>):
    %0 = "ptr.to_ptr"(%arg0) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %1 = "ptr.from_ptr"(%0, %arg1) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space>
    %2 = "ptr.to_ptr"(%1) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %3 = "ptr.get_metadata"(%arg0) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>
    %4 = "ptr.from_ptr"(%2, %3) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space>
    "func.return"(%4) : (memref<f32, #ptr.generic_space>) -> ()
  }) : () -> ()
}) : () -> ()


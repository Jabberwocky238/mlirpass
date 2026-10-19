"builtin.module"() ({
  "func.func"() <{function_type = (!ptr.ptr<#ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>, sym_name = "zero_offset"}> ({
  ^bb0(%arg11: !ptr.ptr<#ptr.generic_space>):
    "func.return"(%arg11) : (!ptr.ptr<#ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #ptr.generic_space>) -> memref<f32, #ptr.generic_space>, sym_name = "test_from_ptr_0"}> ({
  ^bb0(%arg10: memref<f32, #ptr.generic_space>):
    "func.return"(%arg10) : (memref<f32, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #ptr.generic_space>) -> memref<f32, #ptr.generic_space>, sym_name = "test_from_ptr_1"}> ({
  ^bb0(%arg9: memref<f32, #ptr.generic_space>):
    %2 = "ptr.to_ptr"(%arg9) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %3 = "ptr.from_ptr"(%2) : (!ptr.ptr<#ptr.generic_space>) -> memref<f32, #ptr.generic_space>
    "func.return"(%3) : (memref<f32, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space>, sym_name = "test_from_ptr_2"}> ({
  ^bb0(%arg7: memref<f32, #ptr.generic_space>, %arg8: !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>):
    %0 = "ptr.to_ptr"(%arg7) : (memref<f32, #ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>
    %1 = "ptr.from_ptr"(%0, %arg8) : (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space>
    "func.return"(%1) : (memref<f32, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #ptr.generic_space>) -> memref<f32, #ptr.generic_space>, sym_name = "test_from_ptr_3"}> ({
  ^bb0(%arg6: memref<f32, #ptr.generic_space>):
    "func.return"(%arg6) : (memref<f32, #ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!ptr.ptr<#ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> !ptr.ptr<#ptr.generic_space>, sym_name = "test_to_ptr_0"}> ({
  ^bb0(%arg4: !ptr.ptr<#ptr.generic_space>, %arg5: !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>):
    "func.return"(%arg4) : (!ptr.ptr<#ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!ptr.ptr<#ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>, sym_name = "test_to_ptr_1"}> ({
  ^bb0(%arg3: !ptr.ptr<#ptr.generic_space>):
    "func.return"(%arg3) : (!ptr.ptr<#ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!ptr.ptr<#ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space>, sym_name = "test_to_ptr_2"}> ({
  ^bb0(%arg2: !ptr.ptr<#ptr.generic_space>):
    "func.return"(%arg2) : (!ptr.ptr<#ptr.generic_space>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #ptr.generic_space>, !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space>, sym_name = "test_cast_chain_folding"}> ({
  ^bb0(%arg0: memref<f32, #ptr.generic_space>, %arg1: !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>):
    "func.return"(%arg0) : (memref<f32, #ptr.generic_space>) -> ()
  }) : () -> ()
}) : () -> ()


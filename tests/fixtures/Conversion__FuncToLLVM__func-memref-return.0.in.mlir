"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x18xf32>) -> memref<32x18xf32>, sym_name = "check_static_return"}> ({
  ^bb0(%arg7: memref<32x18xf32>):
    "func.return"(%arg7) : (memref<32x18xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<32x18xf32, strided<[22, 1], offset: 7>>) -> memref<32x18xf32, strided<[22, 1], offset: 7>>, sym_name = "check_static_return_with_offset"}> ({
  ^bb0(%arg6: memref<32x18xf32, strided<[22, 1], offset: 7>>):
    "func.return"(%arg6) : (memref<32x18xf32, strided<[22, 1], offset: 7>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi8>) -> memref<20xi8>, sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi8>) -> memref<20xi8>, sym_name = "check_memref_func_call"}> ({
  ^bb0(%arg5: memref<10xi8>):
    %1 = "func.call"(%arg5) <{callee = @foo}> : (memref<10xi8>) -> memref<20xi8>
    "func.return"(%1) : (memref<20xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi8>) -> memref<?xi8>, sym_name = "check_return"}> ({
  ^bb0(%arg4: memref<?xi8>):
    "func.return"(%arg4) : (memref<?xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (memref<?xf32>, memref<?xf32>), sym_name = "unconvertible_multiresult"}> ({
  ^bb0(%arg2: memref<?xf32>, %arg3: memref<?xf32>):
    "func.return"(%arg2, %arg3) : (memref<?xf32>, memref<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xi32>) -> (), sym_name = "unranked_memref"}> ({
  ^bb0(%arg1: memref<*xi32>):
    "func.call"(%arg1) <{callee = @printMemrefI32}> : (memref<*xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xi32>) -> (), sym_name = "printMemrefI32", sym_visibility = "private"}> ({
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_conversion_patterns"(%0) <{legal_dialects = ["llvm"], partial_conversion}> ({
        "transform.apply_conversion_patterns.func.func_to_llvm"() : () -> ()
      }, {
        "transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter"() <{use_bare_ptr_call_conv = true}> {use_opaque_pointers = true} : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()


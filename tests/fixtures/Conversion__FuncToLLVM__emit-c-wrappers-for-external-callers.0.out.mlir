module {
  llvm.func @res_attrs_with_memref_return() -> (!llvm.struct<(ptr, ptr, i64)> {test.returnOne}) attributes {llvm.emit_c_interface} {
    %alloc = memref.alloc() : memref<f32>
    %0 = builtin.unrealized_conversion_cast %alloc : memref<f32> to !llvm.struct<(ptr, ptr, i64)>
    llvm.return %0 : !llvm.struct<(ptr, ptr, i64)>
  }
  llvm.func @_mlir_ciface_res_attrs_with_memref_return(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.call @res_attrs_with_memref_return() : () -> !llvm.struct<(ptr, ptr, i64)>
    llvm.store %0, %arg0 : !llvm.struct<(ptr, ptr, i64)>, !llvm.ptr
    llvm.return
  }
  llvm.func @res_attrs_with_value_return() -> (f32 {test.returnOne = 1 : i64}) attributes {llvm.emit_c_interface} {
    %cst = arith.constant 1.000000e+00 : f32
    llvm.return %cst : f32
  }
  llvm.func @_mlir_ciface_res_attrs_with_value_return() -> (f32 {test.returnOne = 1 : i64}) attributes {llvm.emit_c_interface} {
    %0 = llvm.call @res_attrs_with_value_return() : () -> f32
    llvm.return %0 : f32
  }
  llvm.func @multiple_return() -> !llvm.struct<(struct<(ptr, ptr, i64)>, f32)> attributes {llvm.emit_c_interface} {
    %alloc = memref.alloc() : memref<f32>
    %0 = builtin.unrealized_conversion_cast %alloc : memref<f32> to !llvm.struct<(ptr, ptr, i64)>
    %cst = arith.constant 1.000000e+00 : f32
    %1 = llvm.mlir.poison : !llvm.struct<(struct<(ptr, ptr, i64)>, f32)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<(struct<(ptr, ptr, i64)>, f32)> 
    %3 = llvm.insertvalue %cst, %2[1] : !llvm.struct<(struct<(ptr, ptr, i64)>, f32)> 
    llvm.return %3 : !llvm.struct<(struct<(ptr, ptr, i64)>, f32)>
  }
  llvm.func @_mlir_ciface_multiple_return(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.call @multiple_return() : () -> !llvm.struct<(struct<(ptr, ptr, i64)>, f32)>
    llvm.store %0, %arg0 : !llvm.struct<(struct<(ptr, ptr, i64)>, f32)>, !llvm.ptr
    llvm.return
  }
  llvm.func @multiple_return_missing_res_attr() -> !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)> attributes {llvm.emit_c_interface} {
    %alloc = memref.alloc() : memref<f32>
    %0 = builtin.unrealized_conversion_cast %alloc : memref<f32> to !llvm.struct<(ptr, ptr, i64)>
    %c2_i64 = arith.constant 2 : i64
    %cst = arith.constant 1.000000e+00 : f32
    %1 = llvm.mlir.poison : !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)> 
    %3 = llvm.insertvalue %c2_i64, %2[1] : !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)> 
    %4 = llvm.insertvalue %cst, %3[2] : !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)> 
    llvm.return %4 : !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>
  }
  llvm.func @_mlir_ciface_multiple_return_missing_res_attr(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.call @multiple_return_missing_res_attr() : () -> !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>
    llvm.store %0, %arg0 : !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>, !llvm.ptr
    llvm.return
  }
  llvm.func @one_arg_attr_no_res_attrs_with_memref_return(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) -> !llvm.struct<(ptr, ptr, i64)> attributes {llvm.emit_c_interface} {
    %alloc = memref.alloc() : memref<f32>
    %0 = builtin.unrealized_conversion_cast %alloc : memref<f32> to !llvm.struct<(ptr, ptr, i64)>
    llvm.return %0 : !llvm.struct<(ptr, ptr, i64)>
  }
  llvm.func @_mlir_ciface_one_arg_attr_no_res_attrs_with_memref_return(%arg0: !llvm.ptr, %arg1: !llvm.ptr {test.argOne = 1 : i64}) attributes {llvm.emit_c_interface} {
    %0 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64)> 
    %4 = llvm.call @one_arg_attr_no_res_attrs_with_memref_return(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.struct<(ptr, ptr, i64)>
    llvm.store %4, %arg0 : !llvm.struct<(ptr, ptr, i64)>, !llvm.ptr
    llvm.return
  }
  llvm.func @one_arg_attr_one_res_attr_with_memref_return(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) -> (!llvm.struct<(ptr, ptr, i64)> {test.returnOne = 1 : i64}) attributes {llvm.emit_c_interface} {
    %alloc = memref.alloc() : memref<f32>
    %0 = builtin.unrealized_conversion_cast %alloc : memref<f32> to !llvm.struct<(ptr, ptr, i64)>
    llvm.return %0 : !llvm.struct<(ptr, ptr, i64)>
  }
  llvm.func @_mlir_ciface_one_arg_attr_one_res_attr_with_memref_return(%arg0: !llvm.ptr, %arg1: !llvm.ptr {test.argOne = 1 : i64}) attributes {llvm.emit_c_interface} {
    %0 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64)> 
    %4 = llvm.call @one_arg_attr_one_res_attr_with_memref_return(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.struct<(ptr, ptr, i64)>
    llvm.store %4, %arg0 : !llvm.struct<(ptr, ptr, i64)>, !llvm.ptr
    llvm.return
  }
  llvm.func @one_arg_attr_one_res_attr_with_value_return(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) -> (f32 {test.returnOne = 1 : i64}) attributes {llvm.emit_c_interface} {
    %cst = arith.constant 1.000000e+00 : f32
    llvm.return %cst : f32
  }
  llvm.func @_mlir_ciface_one_arg_attr_one_res_attr_with_value_return(%arg0: !llvm.ptr {test.argOne = 1 : i64}) -> (f32 {test.returnOne = 1 : i64}) attributes {llvm.emit_c_interface} {
    %0 = llvm.load %arg0 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64)> 
    %4 = llvm.call @one_arg_attr_one_res_attr_with_value_return(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i64) -> f32
    llvm.return %4 : f32
  }
  llvm.func @multiple_arg_attr_multiple_res_attr(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: f32, %arg4: i32 {test.argTwo = 2 : i64}) -> !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)> attributes {llvm.emit_c_interface} {
    %cst = arith.constant 1.000000e+00 : f32
    %alloc = memref.alloc() : memref<i32>
    %0 = builtin.unrealized_conversion_cast %alloc : memref<i32> to !llvm.struct<(ptr, ptr, i64)>
    %c2_i32 = arith.constant 2 : i32
    %1 = llvm.mlir.poison : !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>
    %2 = llvm.insertvalue %cst, %1[0] : !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)> 
    %3 = llvm.insertvalue %0, %2[1] : !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)> 
    %4 = llvm.insertvalue %c2_i32, %3[2] : !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)> 
    llvm.return %4 : !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>
  }
  llvm.func @_mlir_ciface_multiple_arg_attr_multiple_res_attr(%arg0: !llvm.ptr, %arg1: !llvm.ptr {test.argZero = 0 : i64}, %arg2: f32, %arg3: i32 {test.argTwo = 2 : i64}) attributes {llvm.emit_c_interface} {
    %0 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64)> 
    %4 = llvm.call @multiple_arg_attr_multiple_res_attr(%1, %2, %3, %arg2, %arg3) : (!llvm.ptr, !llvm.ptr, i64, f32, i32) -> !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>
    llvm.store %4, %arg0 : !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>, !llvm.ptr
    llvm.return
  }
  llvm.func @drop_linkage_attr() -> (!llvm.struct<(ptr, ptr, i64)> {test.returnOne}) attributes {llvm.emit_c_interface} {
    %alloc = memref.alloc() : memref<f32>
    %0 = builtin.unrealized_conversion_cast %alloc : memref<f32> to !llvm.struct<(ptr, ptr, i64)>
    llvm.return %0 : !llvm.struct<(ptr, ptr, i64)>
  }
  llvm.func @_mlir_ciface_drop_linkage_attr(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.call @drop_linkage_attr() : () -> !llvm.struct<(ptr, ptr, i64)>
    llvm.store %0, %arg0 : !llvm.struct<(ptr, ptr, i64)>, !llvm.ptr
    llvm.return
  }
}


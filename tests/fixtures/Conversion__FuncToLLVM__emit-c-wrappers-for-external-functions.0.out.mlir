module {
  llvm.func private @res_attrs_with_memref_return() -> (!llvm.struct<(ptr, ptr, i64)> {test.returnOne}) attributes {llvm.emit_c_interface, sym_visibility = "private"} {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.alloca %0 x !llvm.struct<(ptr, ptr, i64)> : (i64) -> !llvm.ptr
    llvm.call @_mlir_ciface_res_attrs_with_memref_return(%1) : (!llvm.ptr) -> ()
    %2 = llvm.load %1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64)>
    llvm.return %2 : !llvm.struct<(ptr, ptr, i64)>
  }
  llvm.func @_mlir_ciface_res_attrs_with_memref_return(!llvm.ptr) attributes {llvm.emit_c_interface, sym_visibility = "private"}
  llvm.func private @res_attrs_with_value_return() -> (f32 {test.returnOne = 1 : i64}) attributes {llvm.emit_c_interface, sym_visibility = "private"} {
    %0 = llvm.call @_mlir_ciface_res_attrs_with_value_return() : () -> f32
    llvm.return %0 : f32
  }
  llvm.func @_mlir_ciface_res_attrs_with_value_return() -> (f32 {test.returnOne = 1 : i64}) attributes {llvm.emit_c_interface, sym_visibility = "private"}
  llvm.func private @multiple_return() -> !llvm.struct<(struct<(ptr, ptr, i64)>, f32)> attributes {llvm.emit_c_interface, sym_visibility = "private"} {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.alloca %0 x !llvm.struct<(struct<(ptr, ptr, i64)>, f32)> : (i64) -> !llvm.ptr
    llvm.call @_mlir_ciface_multiple_return(%1) : (!llvm.ptr) -> ()
    %2 = llvm.load %1 : !llvm.ptr -> !llvm.struct<(struct<(ptr, ptr, i64)>, f32)>
    llvm.return %2 : !llvm.struct<(struct<(ptr, ptr, i64)>, f32)>
  }
  llvm.func @_mlir_ciface_multiple_return(!llvm.ptr) attributes {llvm.emit_c_interface, sym_visibility = "private"}
  llvm.func private @multiple_return_missing_res_attr() -> !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)> attributes {llvm.emit_c_interface, sym_visibility = "private"} {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.alloca %0 x !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)> : (i64) -> !llvm.ptr
    llvm.call @_mlir_ciface_multiple_return_missing_res_attr(%1) : (!llvm.ptr) -> ()
    %2 = llvm.load %1 : !llvm.ptr -> !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>
    llvm.return %2 : !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>
  }
  llvm.func @_mlir_ciface_multiple_return_missing_res_attr(!llvm.ptr) attributes {llvm.emit_c_interface, sym_visibility = "private"}
  llvm.func private @one_arg_attr_no_res_attrs_with_memref_return(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) -> !llvm.struct<(ptr, ptr, i64)> attributes {llvm.emit_c_interface, sym_visibility = "private"} {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.alloca %0 x !llvm.struct<(ptr, ptr, i64)> : (i64) -> !llvm.ptr
    %2 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %3 = llvm.insertvalue %arg0, %2[0] : !llvm.struct<(ptr, ptr, i64)> 
    %4 = llvm.insertvalue %arg1, %3[1] : !llvm.struct<(ptr, ptr, i64)> 
    %5 = llvm.insertvalue %arg2, %4[2] : !llvm.struct<(ptr, ptr, i64)> 
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.alloca %6 x !llvm.struct<(ptr, ptr, i64)> : (i64) -> !llvm.ptr
    llvm.store %5, %7 : !llvm.struct<(ptr, ptr, i64)>, !llvm.ptr
    llvm.call @_mlir_ciface_one_arg_attr_no_res_attrs_with_memref_return(%1, %7) : (!llvm.ptr, !llvm.ptr) -> ()
    %8 = llvm.load %1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64)>
    llvm.return %8 : !llvm.struct<(ptr, ptr, i64)>
  }
  llvm.func @_mlir_ciface_one_arg_attr_no_res_attrs_with_memref_return(!llvm.ptr, !llvm.ptr {test.argOne = 1 : i64}) attributes {llvm.emit_c_interface, sym_visibility = "private"}
  llvm.func private @one_arg_attr_one_res_attr_with_memref_return(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) -> (!llvm.struct<(ptr, ptr, i64)> {test.returnOne = 1 : i64}) attributes {llvm.emit_c_interface, sym_visibility = "private"} {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.alloca %0 x !llvm.struct<(ptr, ptr, i64)> : (i64) -> !llvm.ptr
    %2 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %3 = llvm.insertvalue %arg0, %2[0] : !llvm.struct<(ptr, ptr, i64)> 
    %4 = llvm.insertvalue %arg1, %3[1] : !llvm.struct<(ptr, ptr, i64)> 
    %5 = llvm.insertvalue %arg2, %4[2] : !llvm.struct<(ptr, ptr, i64)> 
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.alloca %6 x !llvm.struct<(ptr, ptr, i64)> : (i64) -> !llvm.ptr
    llvm.store %5, %7 : !llvm.struct<(ptr, ptr, i64)>, !llvm.ptr
    llvm.call @_mlir_ciface_one_arg_attr_one_res_attr_with_memref_return(%1, %7) : (!llvm.ptr, !llvm.ptr) -> ()
    %8 = llvm.load %1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64)>
    llvm.return %8 : !llvm.struct<(ptr, ptr, i64)>
  }
  llvm.func @_mlir_ciface_one_arg_attr_one_res_attr_with_memref_return(!llvm.ptr, !llvm.ptr {test.argOne = 1 : i64}) attributes {llvm.emit_c_interface, sym_visibility = "private"}
  llvm.func private @one_arg_attr_one_res_attr_with_value_return(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) -> (f32 {test.returnOne = 1 : i64}) attributes {llvm.emit_c_interface, sym_visibility = "private"} {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64)> 
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.alloca %4 x !llvm.struct<(ptr, ptr, i64)> : (i64) -> !llvm.ptr
    llvm.store %3, %5 : !llvm.struct<(ptr, ptr, i64)>, !llvm.ptr
    %6 = llvm.call @_mlir_ciface_one_arg_attr_one_res_attr_with_value_return(%5) : (!llvm.ptr) -> f32
    llvm.return %6 : f32
  }
  llvm.func @_mlir_ciface_one_arg_attr_one_res_attr_with_value_return(!llvm.ptr {test.argOne = 1 : i64}) -> (f32 {test.returnOne = 1 : i64}) attributes {llvm.emit_c_interface, sym_visibility = "private"}
  llvm.func private @multiple_arg_attr_multiple_res_attr(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: f32, %arg4: i32 {test.argTwo = 2 : i64}) -> !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)> attributes {llvm.emit_c_interface, sym_visibility = "private"} {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.alloca %0 x !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)> : (i64) -> !llvm.ptr
    %2 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %3 = llvm.insertvalue %arg0, %2[0] : !llvm.struct<(ptr, ptr, i64)> 
    %4 = llvm.insertvalue %arg1, %3[1] : !llvm.struct<(ptr, ptr, i64)> 
    %5 = llvm.insertvalue %arg2, %4[2] : !llvm.struct<(ptr, ptr, i64)> 
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.alloca %6 x !llvm.struct<(ptr, ptr, i64)> : (i64) -> !llvm.ptr
    llvm.store %5, %7 : !llvm.struct<(ptr, ptr, i64)>, !llvm.ptr
    llvm.call @_mlir_ciface_multiple_arg_attr_multiple_res_attr(%1, %7, %arg3, %arg4) : (!llvm.ptr, !llvm.ptr, f32, i32) -> ()
    %8 = llvm.load %1 : !llvm.ptr -> !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>
    llvm.return %8 : !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>
  }
  llvm.func @_mlir_ciface_multiple_arg_attr_multiple_res_attr(!llvm.ptr, !llvm.ptr {test.argZero = 0 : i64}, f32, i32 {test.argTwo = 2 : i64}) attributes {llvm.emit_c_interface, sym_visibility = "private"}
  llvm.func private @drop_linkage_attr() -> (!llvm.struct<(ptr, ptr, i64)> {test.returnOne}) attributes {llvm.emit_c_interface, sym_visibility = "private"} {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.alloca %0 x !llvm.struct<(ptr, ptr, i64)> : (i64) -> !llvm.ptr
    llvm.call @_mlir_ciface_drop_linkage_attr(%1) : (!llvm.ptr) -> ()
    %2 = llvm.load %1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64)>
    llvm.return %2 : !llvm.struct<(ptr, ptr, i64)>
  }
  llvm.func @_mlir_ciface_drop_linkage_attr(!llvm.ptr) attributes {llvm.emit_c_interface, sym_visibility = "private"}
}


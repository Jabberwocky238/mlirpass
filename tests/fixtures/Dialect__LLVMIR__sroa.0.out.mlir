module {
  llvm.func @basic_struct() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
}

// -----
module {
  llvm.func @basic_array() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
}

// -----
module {
  llvm.func @multi_level_direct() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
}

// -----
module {
  llvm.func @multi_level_direct_two_applications() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
}

// -----
module {
  llvm.func @multi_level_indirect() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
}

// -----
module {
  llvm.func @nested_access_over_slot_bound() -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<(i32, struct<(array<10 x i32>)>, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[0, 1, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<(i32, struct<(array<10 x i32>)>, i32)>
    %3 = llvm.getelementptr inbounds %2[0, 9] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x i32>
    %4 = llvm.load %3 : !llvm.ptr -> i64
    llvm.return %4 : i64
  }
}

// -----
module {
  llvm.func @resolve_alias(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 : i32, !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
}

// -----
module {
  llvm.func @no_non_single_support() -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"foo", (i32, f64, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<"foo", (i32, f64, i32)>
    %3 = llvm.load %2 : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @no_pointer_indexing() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"foo", (i32, f64, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.getelementptr %1[1, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<"foo", (i32, f64, i32)>
    %3 = llvm.load %2 : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @no_direct_use() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"foo", (i32, f64, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.getelementptr %1[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<"foo", (i32, f64, i32)>
    %3 = llvm.load %2 : !llvm.ptr -> i32
    llvm.call @use(%1) : (!llvm.ptr) -> ()
    llvm.return %3 : i32
  }
  llvm.func @use(!llvm.ptr)
}

// -----
module {
  llvm.func @direct_promotable_use_is_fine() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
}

// -----
module {
  llvm.func @direct_promotable_use_is_fine_on_accessor() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
}

// -----
module {
  llvm.func @no_dynamic_indexing(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<10 x i32> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.getelementptr %1[0, %arg0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.array<10 x i32>
    %3 = llvm.load %2 : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @no_nested_dynamic_indexing(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<(array<10 x i32>, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.getelementptr %1[0, 0, %arg0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(array<10 x i32>, i32)>
    %3 = llvm.load %2 : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @store_first_field(%arg0: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 : i32, !llvm.ptr
    llvm.return
  }
}

// -----
module {
  llvm.func @store_first_field_different_type(%arg0: f32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 : f32, !llvm.ptr
    llvm.return
  }
}

// -----
module {
  llvm.func @store_sub_field(%arg0: f32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 : f32, !llvm.ptr
    llvm.return
  }
}

// -----
module {
  llvm.func @load_first_field() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
}

// -----
module {
  llvm.func @load_first_field_different_type() -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> f32
    llvm.return %2 : f32
  }
}

// -----
module {
  llvm.func @load_sub_field() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
}

// -----
module {
  llvm.func @vector_store_type_mismatch(%arg0: vector<4xi32>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x vector<4xf32> : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 : vector<4xi32>, !llvm.ptr
    llvm.return
  }
}

// -----
module {
  llvm.func @store_to_memory(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"foo", (vector<4xf32>)> : (i32) -> !llvm.ptr
    llvm.store %1, %arg0 : !llvm.ptr, !llvm.ptr
    llvm.return
  }
}

// -----
module {
  llvm.func @type_mismatch_array_access(%arg0: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 : i32, !llvm.ptr
    llvm.return
  }
}

// -----
module {
  llvm.func @type_mismatch_struct_access(%arg0: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 : i32, !llvm.ptr
    llvm.return
  }
}

// -----
module {
  llvm.func @index_in_final_padding(%arg0: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"foo", (i32, i8)> : (i32) -> !llvm.ptr
    %2 = llvm.getelementptr %1[7] : (!llvm.ptr) -> !llvm.ptr, i8
    llvm.store %arg0, %2 : i32, !llvm.ptr
    llvm.return
  }
}

// -----
module {
  llvm.func @index_out_of_bounds(%arg0: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"foo", (i32, i32)> : (i32) -> !llvm.ptr
    %2 = llvm.getelementptr %1[9] : (!llvm.ptr) -> !llvm.ptr, i8
    llvm.store %arg0, %2 : i32, !llvm.ptr
    llvm.return
  }
}

// -----
module {
  llvm.func @index_in_padding(%arg0: i16) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"foo", (i16, i32)> : (i32) -> !llvm.ptr
    %2 = llvm.getelementptr %1[2] : (!llvm.ptr) -> !llvm.ptr, i8
    llvm.store %arg0, %2 : i16, !llvm.ptr
    llvm.return
  }
}

// -----
module {
  llvm.func @index_not_in_padding_because_packed(%arg0: i16) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 : i16, !llvm.ptr
    llvm.return
  }
}

// -----
module {
  llvm.func @no_crash_on_negative_gep_index(%arg0: f16) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"foo", (i32, i32, i32)> : (i32) -> !llvm.ptr
    %2 = llvm.getelementptr %1[-1] : (!llvm.ptr) -> !llvm.ptr, f32
    llvm.store %arg0, %2 : f16, !llvm.ptr
    llvm.return
  }
}

// -----
module {
  llvm.func @out_of_bound_gep_array_access(%arg0: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 : i32, !llvm.ptr
    llvm.return
  }
}


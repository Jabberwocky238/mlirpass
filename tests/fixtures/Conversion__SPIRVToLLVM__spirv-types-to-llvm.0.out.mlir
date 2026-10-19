module {
  llvm.func @array(!llvm.array<16 x f32>, !llvm.array<32 x vector<4xf32>>)
  llvm.func @array_with_natural_stride(!llvm.array<16 x f32>)
  llvm.func @pointer_scalar(!llvm.ptr, !llvm.ptr)
  llvm.func @pointer_vector(!llvm.ptr)
  llvm.func @runtime_array_vector(!llvm.array<0 x vector<4xf32>>)
  llvm.func @runtime_array_scalar(!llvm.array<0 x f32>)
  llvm.func @struct(!llvm.struct<packed (f64)>)
  llvm.func @struct_nested(!llvm.struct<packed (i32, struct<packed (i64, i32)>)>)
  llvm.func @struct_with_natural_offset(!llvm.struct<(i8, i32)>)
}


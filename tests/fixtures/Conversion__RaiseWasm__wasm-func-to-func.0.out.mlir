module {
  func.func @callee(%arg0: i32) -> i32 {
    %alloca = memref.alloca() : memref<i32>
    memref.store %arg0, %alloca[] : memref<i32>
    %0 = memref.load %alloca[] : memref<i32>
    return %0 : i32
  }
  func.func @caller(%arg0: i32) -> i32 {
    %alloca = memref.alloca() : memref<i32>
    memref.store %arg0, %alloca[] : memref<i32>
    %0 = memref.load %alloca[] : memref<i32>
    %1 = call @callee(%0) : (i32) -> i32
    return %1 : i32
  }
  func.func private @"my_module::foo"() -> i32
  func.func @user_of_func0() -> i32 {
    %0 = call @"my_module::foo"() : () -> i32
    return %0 : i32
  }
}


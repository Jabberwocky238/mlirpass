module {
  func.func @test_reorder_constants_and_match(%arg0: i32) -> i32 {
    %c43_i32 = arith.constant 43 : i32
    %0 = "test.op_commutative2"(%arg0, %c43_i32) : (i32, i32) -> i32
    return %c43_i32 : i32
  }
}


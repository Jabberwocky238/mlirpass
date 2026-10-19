module {
  func.func @test_simple_sink(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = arith.subi %arg2, %arg1 : i32
    %1 = test.region_if %arg0: i32 -> i32 then {
    ^bb0(%arg3: i32):
      %2 = arith.subi %arg1, %arg2 : i32
      test.region_if_yield %2 : i32
    } else {
    ^bb0(%arg3: i32):
      %2 = arith.addi %arg1, %arg1 : i32
      %3 = arith.addi %0, %2 : i32
      test.region_if_yield %3 : i32
    } join {
    ^bb0(%arg3: i32):
      %2 = arith.addi %arg2, %arg2 : i32
      %3 = arith.addi %2, %0 : i32
      test.region_if_yield %3 : i32
    }
    return %1 : i32
  }
  func.func @test_region_sink(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = test.region_if %arg0: i32 -> i32 then {
    ^bb0(%arg3: i32):
      %1 = test.region_if %arg0: i32 -> i32 then {
      ^bb0(%arg4: i32):
        test.region_if_yield %arg1 : i32
      } else {
      ^bb0(%arg4: i32):
        %2 = arith.subi %arg1, %arg2 : i32
        test.region_if_yield %2 : i32
      } join {
      ^bb0(%arg4: i32):
        test.region_if_yield %arg2 : i32
      }
      test.region_if_yield %1 : i32
    } else {
    ^bb0(%arg3: i32):
      test.region_if_yield %arg1 : i32
    } join {
    ^bb0(%arg3: i32):
      test.region_if_yield %arg2 : i32
    }
    return %0 : i32
  }
  func.func @test_subgraph_sink(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = test.region_if %arg0: i32 -> i32 then {
    ^bb0(%arg3: i32):
      %1 = arith.subi %arg1, %arg2 : i32
      %2 = arith.addi %arg1, %arg2 : i32
      %3 = arith.subi %arg2, %arg1 : i32
      %4 = arith.muli %3, %3 : i32
      %5 = arith.muli %2, %1 : i32
      %6 = arith.addi %5, %4 : i32
      test.region_if_yield %6 : i32
    } else {
    ^bb0(%arg3: i32):
      test.region_if_yield %arg1 : i32
    } join {
    ^bb0(%arg3: i32):
      test.region_if_yield %arg2 : i32
    }
    return %0 : i32
  }
  func.func @test_multiblock_region_sink(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = arith.addi %arg1, %arg2 : i32
    %1 = "test.any_cond"() ({
      %3 = arith.addi %0, %arg2 : i32
      %4 = arith.addi %3, %arg1 : i32
      cf.br ^bb1(%4 : i32)
    ^bb1(%5: i32):  // pred: ^bb0
      %6 = arith.addi %5, %4 : i32
      "test.yield"(%6) : (i32) -> ()
    }) : () -> i32
    %2 = arith.addi %0, %1 : i32
    return %2 : i32
  }
  func.func @test_nested_region_sink(%arg0: i32, %arg1: i32) -> i32 {
    %0 = test.region_if %arg0: i32 -> i32 then {
    ^bb0(%arg2: i32):
      %1 = test.region_if %arg0: i32 -> i32 then {
      ^bb0(%arg3: i32):
        %2 = arith.addi %arg1, %arg1 : i32
        test.region_if_yield %2 : i32
      } else {
      ^bb0(%arg3: i32):
        test.region_if_yield %arg1 : i32
      } join {
      ^bb0(%arg3: i32):
        test.region_if_yield %arg1 : i32
      }
      test.region_if_yield %1 : i32
    } else {
    ^bb0(%arg2: i32):
      test.region_if_yield %arg1 : i32
    } join {
    ^bb0(%arg2: i32):
      test.region_if_yield %arg1 : i32
    }
    return %0 : i32
  }
  func.func @test_not_sunk_deeply(%arg0: i32) -> i32 {
    %0 = "test.any_cond"() ({
      %1 = arith.addi %arg0, %arg0 : i32
      cf.br ^bb1
    ^bb1:  // pred: ^bb0
      "test.yield"(%1) : (i32) -> ()
    }) : () -> i32
    return %0 : i32
  }
}


module {
  func.func @default_insertion_position(%arg0: i1) {
    %c2_i32 = arith.constant 2 : i32
    scf.if %arg0 {
      "foo.yield"(%c2_i32) : (i32) -> ()
    }
    return
  }
  func.func @custom_insertion_position() {
    "test.one_region_op"() ({
      %c2_i32 = arith.constant 2 : i32
      "foo.yield"(%c2_i32) : (i32) -> ()
    }) : () -> ()
    return
  }
}


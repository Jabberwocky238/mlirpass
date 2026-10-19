module {
  func.func @empty() {
    %0 = llvm.intr.stacksave : !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.intr.stackrestore %0 : !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    return
  }
  func.func @returns_nothing(%arg0: f32) {
    %cst = arith.constant 1.000000e+01 : f32
    %0 = llvm.intr.stacksave : !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = arith.addf %arg0, %cst : f32
    llvm.intr.stackrestore %0 : !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    return
  }
  func.func @returns_one_value(%arg0: f32) -> f32 {
    %cst = arith.constant 1.000000e+01 : f32
    %0 = llvm.intr.stacksave : !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = arith.addf %arg0, %cst : f32
    llvm.intr.stackrestore %0 : !llvm.ptr
    llvm.br ^bb2(%1 : f32)
  ^bb2(%2: f32):  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    return %2 : f32
  }
  func.func @returns_multiple_values(%arg0: f32) -> f32 {
    %cst = arith.constant 1.000000e+01 : f32
    %0 = llvm.intr.stacksave : !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = arith.addf %arg0, %cst : f32
    %2 = arith.subf %cst, %arg0 : f32
    llvm.intr.stackrestore %0 : !llvm.ptr
    llvm.br ^bb2(%1, %2 : f32, f32)
  ^bb2(%3: f32, %4: f32):  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    %5 = arith.addf %3, %4 : f32
    return %5 : f32
  }
}


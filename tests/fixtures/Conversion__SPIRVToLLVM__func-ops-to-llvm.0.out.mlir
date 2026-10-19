module {
  llvm.func @return() {
    llvm.return
  }
  llvm.func @return_value(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }
  llvm.func @none() {
    llvm.return
  }
  llvm.func @inline() attributes {always_inline} {
    llvm.return
  }
  llvm.func @dont_inline() attributes {no_inline} {
    llvm.return
  }
  llvm.func @pure() attributes {passthrough = ["readonly"]} {
    llvm.return
  }
  llvm.func @const() attributes {passthrough = ["readnone"]} {
    llvm.return
  }
  llvm.func @scalar_types(%arg0: i32, %arg1: i1, %arg2: f64, %arg3: f32) {
    llvm.return
  }
  llvm.func @vector_types(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.add %arg0, %arg1 : vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }
  llvm.func @function_calls(%arg0: i32, %arg1: i1, %arg2: f64, %arg3: vector<2xi64>, %arg4: vector<2xf32>) {
    llvm.call @void_1() : () -> ()
    llvm.call @void_2(%arg3) : (vector<2xi64>) -> ()
    %0 = llvm.call @value_scalar(%arg0, %arg1, %arg2) : (i32, i1, f64) -> i32
    %1 = llvm.call @value_vector(%arg3, %arg4) : (vector<2xi64>, vector<2xf32>) -> vector<2xf32>
    llvm.return
  }
  llvm.func @void_1() {
    llvm.return
  }
  llvm.func @void_2(%arg0: vector<2xi64>) {
    llvm.return
  }
  llvm.func @value_scalar(%arg0: i32, %arg1: i1, %arg2: f64) -> i32 {
    llvm.return %arg0 : i32
  }
  llvm.func @value_vector(%arg0: vector<2xi64>, %arg1: vector<2xf32>) -> vector<2xf32> {
    llvm.return %arg1 : vector<2xf32>
  }
}


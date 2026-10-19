module {
  llvm.func @i_equal_scalar(%arg0: i32, %arg1: i32) {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.return
  }
  llvm.func @i_equal_vector(%arg0: vector<4xi64>, %arg1: vector<4xi64>) {
    %0 = llvm.icmp "eq" %arg0, %arg1 : vector<4xi64>
    llvm.return
  }
  llvm.func @i_not_equal_scalar(%arg0: i64, %arg1: i64) {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    llvm.return
  }
  llvm.func @i_not_equal_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>) {
    %0 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi64>
    llvm.return
  }
  llvm.func @s_greater_than_equal_scalar(%arg0: i64, %arg1: i64) {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    llvm.return
  }
  llvm.func @s_greater_than_equal_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>) {
    %0 = llvm.icmp "sge" %arg0, %arg1 : vector<2xi64>
    llvm.return
  }
  llvm.func @s_greater_than_scalar(%arg0: i64, %arg1: i64) {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    llvm.return
  }
  llvm.func @s_greater_than_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>) {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : vector<2xi64>
    llvm.return
  }
  llvm.func @s_less_than_equal_scalar(%arg0: i64, %arg1: i64) {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    llvm.return
  }
  llvm.func @s_less_than_equal_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>) {
    %0 = llvm.icmp "sle" %arg0, %arg1 : vector<2xi64>
    llvm.return
  }
  llvm.func @s_less_than_scalar(%arg0: i64, %arg1: i64) {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    llvm.return
  }
  llvm.func @s_less_than_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>) {
    %0 = llvm.icmp "slt" %arg0, %arg1 : vector<2xi64>
    llvm.return
  }
  llvm.func @u_greater_than_equal_scalar(%arg0: i64, %arg1: i64) {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    llvm.return
  }
  llvm.func @u_greater_than_equal_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>) {
    %0 = llvm.icmp "uge" %arg0, %arg1 : vector<2xi64>
    llvm.return
  }
  llvm.func @u_greater_than_scalar(%arg0: i64, %arg1: i64) {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    llvm.return
  }
  llvm.func @u_greater_than_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>) {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi64>
    llvm.return
  }
  llvm.func @u_less_than_equal_scalar(%arg0: i64, %arg1: i64) {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    llvm.return
  }
  llvm.func @u_less_than_equal_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>) {
    %0 = llvm.icmp "ule" %arg0, %arg1 : vector<2xi64>
    llvm.return
  }
  llvm.func @u_less_than_scalar(%arg0: i64, %arg1: i64) {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    llvm.return
  }
  llvm.func @u_less_than_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>) {
    %0 = llvm.icmp "ult" %arg0, %arg1 : vector<2xi64>
    llvm.return
  }
  llvm.func @f_ord_equal_scalar(%arg0: f32, %arg1: f32) {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 : f32
    llvm.return
  }
  llvm.func @f_ord_equal_vector(%arg0: vector<4xf64>, %arg1: vector<4xf64>) {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 : vector<4xf64>
    llvm.return
  }
  llvm.func @f_ord_greater_than_equal_scalar(%arg0: f64, %arg1: f64) {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return
  }
  llvm.func @f_ord_greater_than_equal_vector(%arg0: vector<2xf64>, %arg1: vector<2xf64>) {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : vector<2xf64>
    llvm.return
  }
  llvm.func @f_ord_greater_than_scalar(%arg0: f64, %arg1: f64) {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    llvm.return
  }
  llvm.func @f_ord_greater_than_vector(%arg0: vector<2xf64>, %arg1: vector<2xf64>) {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : vector<2xf64>
    llvm.return
  }
  llvm.func @f_ord_less_than_scalar(%arg0: f64, %arg1: f64) {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    llvm.return
  }
  llvm.func @f_ord_less_than_vector(%arg0: vector<2xf64>, %arg1: vector<2xf64>) {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : vector<2xf64>
    llvm.return
  }
  llvm.func @f_ord_less_than_equal_scalar(%arg0: f64, %arg1: f64) {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    llvm.return
  }
  llvm.func @f_ord_less_than_equal_vector(%arg0: vector<2xf64>, %arg1: vector<2xf64>) {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : vector<2xf64>
    llvm.return
  }
  llvm.func @f_ord_not_equal_scalar(%arg0: f32, %arg1: f32) {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f32
    llvm.return
  }
  llvm.func @f_ord_not_equal_vector(%arg0: vector<4xf64>, %arg1: vector<4xf64>) {
    %0 = llvm.fcmp "one" %arg0, %arg1 : vector<4xf64>
    llvm.return
  }
  llvm.func @f_unord_equal_scalar(%arg0: f32, %arg1: f32) {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f32
    llvm.return
  }
  llvm.func @f_unord_equal_vector(%arg0: vector<4xf64>, %arg1: vector<4xf64>) {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : vector<4xf64>
    llvm.return
  }
  llvm.func @f_unord_greater_than_equal_scalar(%arg0: f64, %arg1: f64) {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return
  }
  llvm.func @f_unord_greater_than_equal_vector(%arg0: vector<2xf64>, %arg1: vector<2xf64>) {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : vector<2xf64>
    llvm.return
  }
  llvm.func @f_unord_greater_than_scalar(%arg0: f64, %arg1: f64) {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    llvm.return
  }
  llvm.func @f_unord_greater_than_vector(%arg0: vector<2xf64>, %arg1: vector<2xf64>) {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : vector<2xf64>
    llvm.return
  }
  llvm.func @f_unord_less_than_scalar(%arg0: f64, %arg1: f64) {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return
  }
  llvm.func @f_unord_less_than_vector(%arg0: vector<2xf64>, %arg1: vector<2xf64>) {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : vector<2xf64>
    llvm.return
  }
  llvm.func @f_unord_less_than_equal_scalar(%arg0: f64, %arg1: f64) {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return
  }
  llvm.func @f_unord_less_than_equal_vector(%arg0: vector<2xf64>, %arg1: vector<2xf64>) {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : vector<2xf64>
    llvm.return
  }
  llvm.func @f_unord_not_equal_scalar(%arg0: f32, %arg1: f32) {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f32
    llvm.return
  }
  llvm.func @f_unord_not_equal_vector(%arg0: vector<4xf64>, %arg1: vector<4xf64>) {
    %0 = llvm.fcmp "une" %arg0, %arg1 : vector<4xf64>
    llvm.return
  }
}


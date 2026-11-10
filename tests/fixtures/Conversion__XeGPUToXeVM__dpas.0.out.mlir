module {
  gpu.module @test_kernel [#xevm.target<chip = "pvc">] {
    func.func @dpas(%arg0: vector<8xf16>, %arg1: vector<16xf16>, %arg2: vector<8xf32>) -> vector<8xf32> {
      %0 = xevm.mma %arg0, %arg1, %arg2 {shape = <m = 8, n = 16, k = 16>, types = <d = f32, a = f16, b = f16, c = f32>} : (vector<8xf16>, vector<16xf16>, vector<8xf32>) -> vector<8xf32>
      return %0 : vector<8xf32>
    }
  }
}


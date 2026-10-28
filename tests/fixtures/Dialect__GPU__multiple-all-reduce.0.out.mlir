module attributes {gpu.container_module} {
  func.func @main() {
    %alloc = memref.alloc() : memref<2x6xf32>
    %alloc_0 = memref.alloc() : memref<2xf32>
    %alloc_1 = memref.alloc() : memref<2xf32>
    %c1 = arith.constant 1 : index
    gpu.launch_func  @main_kernel::@main_kernel blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  args(%alloc : memref<2x6xf32>, %alloc_0 : memref<2xf32>, %alloc_1 : memref<2xf32>)
    return
  }
  gpu.module @main_kernel {
    llvm.mlir.global internal @__wg_main_kernel_0() {addr_space = 3 : i32} : !llvm.array<32 x f32>
    llvm.mlir.global internal @__wg_main_kernel_1() {addr_space = 3 : i32} : !llvm.array<32 x f32>
    llvm.func @main_kernel(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: !llvm.ptr, %arg13: !llvm.ptr, %arg14: i64, %arg15: i64, %arg16: i64) attributes {gpu.kernel, gpu.known_block_size = array<i32: 1, 1, 1>, gpu.known_grid_size = array<i32: 1, 1, 1>, nvvm.kernel, nvvm.maxntid = array<i32: 1, 1, 1>} {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %1 = llvm.insertvalue %arg12, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %2 = llvm.insertvalue %arg13, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %3 = llvm.insertvalue %arg14, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %arg15, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.insertvalue %arg16, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %6 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %7 = llvm.insertvalue %arg7, %6[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %8 = llvm.insertvalue %arg8, %7[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %9 = llvm.insertvalue %arg9, %8[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %10 = llvm.insertvalue %arg10, %9[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %11 = llvm.insertvalue %arg11, %10[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %12 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %13 = llvm.insertvalue %arg0, %12[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %14 = llvm.insertvalue %arg1, %13[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %15 = llvm.insertvalue %arg2, %14[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %16 = llvm.insertvalue %arg3, %15[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %17 = llvm.insertvalue %arg5, %16[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %18 = llvm.insertvalue %arg4, %17[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %19 = llvm.insertvalue %arg6, %18[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %20 = llvm.mlir.addressof @__wg_main_kernel_0 : !llvm.ptr<3>
      %21 = llvm.getelementptr %20[0, 0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, !llvm.array<32 x f32>
      %22 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %23 = llvm.insertvalue %21, %22[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %24 = llvm.insertvalue %21, %23[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %25 = llvm.mlir.constant(0 : index) : i64
      %26 = llvm.insertvalue %25, %24[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %27 = llvm.mlir.constant(32 : index) : i64
      %28 = llvm.insertvalue %27, %26[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %29 = llvm.mlir.constant(1 : index) : i64
      %30 = llvm.insertvalue %29, %28[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %31 = llvm.mlir.addressof @__wg_main_kernel_1 : !llvm.ptr<3>
      %32 = llvm.getelementptr %31[0, 0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, !llvm.array<32 x f32>
      %33 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %34 = llvm.insertvalue %32, %33[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %35 = llvm.insertvalue %32, %34[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %36 = llvm.mlir.constant(0 : index) : i64
      %37 = llvm.insertvalue %36, %35[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %38 = llvm.mlir.constant(32 : index) : i64
      %39 = llvm.insertvalue %38, %37[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %40 = llvm.mlir.constant(1 : index) : i64
      %41 = llvm.insertvalue %40, %39[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %42 = llvm.mlir.constant(0 : index) : i64
      %43 = llvm.mlir.constant(16 : i32) : i32
      %44 = llvm.mlir.constant(8 : i32) : i32
      %45 = llvm.mlir.constant(4 : i32) : i32
      %46 = llvm.mlir.constant(2 : i32) : i32
      %47 = llvm.mlir.constant(1 : i32) : i32
      %48 = llvm.mlir.constant(32 : i32) : i32
      %49 = llvm.mlir.constant(0 : i32) : i32
      %50 = llvm.mlir.constant(31 : i32) : i32
      %51 = nvvm.read.ptx.sreg.ctaid.x range <i32, 0, 1> : i32
      %52 = llvm.sext %51 : i32 to i64
      %53 = nvvm.read.ptx.sreg.tid.x range <i32, 0, 1> : i32
      %54 = llvm.sext %53 : i32 to i64
      %55 = llvm.extractvalue %19[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %56 = llvm.mlir.constant(6 : index) : i64
      %57 = llvm.mul %52, %56 overflow<nsw, nuw> : i64
      %58 = llvm.add %57, %54 overflow<nsw, nuw> : i64
      %59 = llvm.getelementptr inbounds|nuw %55[%58] : (!llvm.ptr, i64) -> !llvm.ptr, f32
      %60 = llvm.load %59 : !llvm.ptr -> f32
      %61 = nvvm.read.ptx.sreg.ntid.x range <i32, 1, 2> : i32
      %62 = llvm.sext %61 : i32 to i64
      %63 = llvm.trunc %62 : i64 to i32
      %64 = nvvm.read.ptx.sreg.ntid.y range <i32, 1, 2> : i32
      %65 = llvm.sext %64 : i32 to i64
      %66 = llvm.trunc %65 : i64 to i32
      %67 = nvvm.read.ptx.sreg.ntid.z range <i32, 1, 2> : i32
      %68 = llvm.sext %67 : i32 to i64
      %69 = llvm.trunc %68 : i64 to i32
      %70 = nvvm.read.ptx.sreg.tid.x range <i32, 0, 1> : i32
      %71 = llvm.sext %70 : i32 to i64
      %72 = llvm.trunc %71 : i64 to i32
      %73 = nvvm.read.ptx.sreg.tid.y range <i32, 0, 1> : i32
      %74 = llvm.sext %73 : i32 to i64
      %75 = llvm.trunc %74 : i64 to i32
      %76 = nvvm.read.ptx.sreg.tid.z range <i32, 0, 1> : i32
      %77 = llvm.sext %76 : i32 to i64
      %78 = llvm.trunc %77 : i64 to i32
      %79 = llvm.mul %78, %66 : i32
      %80 = llvm.add %79, %75 : i32
      %81 = llvm.mul %80, %63 : i32
      %82 = llvm.mul %63, %66 : i32
      %83 = llvm.add %81, %72 : i32
      %84 = llvm.mul %82, %69 : i32
      %85 = llvm.and %83, %50 : i32
      %86 = llvm.icmp "eq" %85, %49 : i32
      %87 = llvm.sub %83, %85 : i32
      %88 = llvm.sub %84, %87 : i32
      %89 = llvm.icmp "slt" %88, %48 : i32
      llvm.cond_br %89, ^bb1, ^bb17
    ^bb1:  // pred: ^bb0
      %90 = llvm.mlir.constant(1 : i32) : i32
      %91 = llvm.mlir.constant(-1 : i32) : i32
      %92 = llvm.mlir.constant(32 : i32) : i32
      %93 = llvm.sub %92, %88 : i32
      %94 = llvm.lshr %91, %93 : i32
      %95 = llvm.sub %88, %90 : i32
      %96 = nvvm.shfl.sync  bfly %94, %60, %47, %95 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %97 = llvm.extractvalue %96[0] : !llvm.struct<(f32, i1)> 
      %98 = llvm.extractvalue %96[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %98, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %99 = llvm.fadd %60, %97 : f32
      llvm.br ^bb4(%99 : f32)
    ^bb3:  // pred: ^bb1
      llvm.br ^bb4(%60 : f32)
    ^bb4(%100: f32):  // 2 preds: ^bb2, ^bb3
      %101 = llvm.mlir.constant(1 : i32) : i32
      %102 = llvm.mlir.constant(-1 : i32) : i32
      %103 = llvm.mlir.constant(32 : i32) : i32
      %104 = llvm.sub %103, %88 : i32
      %105 = llvm.lshr %102, %104 : i32
      %106 = llvm.sub %88, %101 : i32
      %107 = nvvm.shfl.sync  bfly %105, %100, %46, %106 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %108 = llvm.extractvalue %107[0] : !llvm.struct<(f32, i1)> 
      %109 = llvm.extractvalue %107[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %109, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %110 = llvm.fadd %100, %108 : f32
      llvm.br ^bb7(%110 : f32)
    ^bb6:  // pred: ^bb4
      llvm.br ^bb7(%100 : f32)
    ^bb7(%111: f32):  // 2 preds: ^bb5, ^bb6
      %112 = llvm.mlir.constant(1 : i32) : i32
      %113 = llvm.mlir.constant(-1 : i32) : i32
      %114 = llvm.mlir.constant(32 : i32) : i32
      %115 = llvm.sub %114, %88 : i32
      %116 = llvm.lshr %113, %115 : i32
      %117 = llvm.sub %88, %112 : i32
      %118 = nvvm.shfl.sync  bfly %116, %111, %45, %117 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %119 = llvm.extractvalue %118[0] : !llvm.struct<(f32, i1)> 
      %120 = llvm.extractvalue %118[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %120, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %121 = llvm.fadd %111, %119 : f32
      llvm.br ^bb10(%121 : f32)
    ^bb9:  // pred: ^bb7
      llvm.br ^bb10(%111 : f32)
    ^bb10(%122: f32):  // 2 preds: ^bb8, ^bb9
      %123 = llvm.mlir.constant(1 : i32) : i32
      %124 = llvm.mlir.constant(-1 : i32) : i32
      %125 = llvm.mlir.constant(32 : i32) : i32
      %126 = llvm.sub %125, %88 : i32
      %127 = llvm.lshr %124, %126 : i32
      %128 = llvm.sub %88, %123 : i32
      %129 = nvvm.shfl.sync  bfly %127, %122, %44, %128 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %130 = llvm.extractvalue %129[0] : !llvm.struct<(f32, i1)> 
      %131 = llvm.extractvalue %129[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %131, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %132 = llvm.fadd %122, %130 : f32
      llvm.br ^bb13(%132 : f32)
    ^bb12:  // pred: ^bb10
      llvm.br ^bb13(%122 : f32)
    ^bb13(%133: f32):  // 2 preds: ^bb11, ^bb12
      %134 = llvm.mlir.constant(1 : i32) : i32
      %135 = llvm.mlir.constant(-1 : i32) : i32
      %136 = llvm.mlir.constant(32 : i32) : i32
      %137 = llvm.sub %136, %88 : i32
      %138 = llvm.lshr %135, %137 : i32
      %139 = llvm.sub %88, %134 : i32
      %140 = nvvm.shfl.sync  bfly %138, %133, %43, %139 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %141 = llvm.extractvalue %140[0] : !llvm.struct<(f32, i1)> 
      %142 = llvm.extractvalue %140[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %142, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %143 = llvm.fadd %133, %141 : f32
      llvm.br ^bb16(%143 : f32)
    ^bb15:  // pred: ^bb13
      llvm.br ^bb16(%133 : f32)
    ^bb16(%144: f32):  // 2 preds: ^bb14, ^bb15
      llvm.br ^bb18(%144 : f32)
    ^bb17:  // pred: ^bb0
      %145 = llvm.mlir.constant(1 : i32) : i32
      %146 = llvm.mlir.constant(-1 : i32) : i32
      %147 = llvm.mlir.constant(32 : i32) : i32
      %148 = llvm.sub %147, %48 : i32
      %149 = llvm.lshr %146, %148 : i32
      %150 = llvm.sub %48, %145 : i32
      %151 = nvvm.shfl.sync  bfly %149, %60, %47, %150 : f32 -> f32
      %152 = llvm.fadd %60, %151 : f32
      %153 = llvm.mlir.constant(1 : i32) : i32
      %154 = llvm.mlir.constant(-1 : i32) : i32
      %155 = llvm.mlir.constant(32 : i32) : i32
      %156 = llvm.sub %155, %48 : i32
      %157 = llvm.lshr %154, %156 : i32
      %158 = llvm.sub %48, %153 : i32
      %159 = nvvm.shfl.sync  bfly %157, %152, %46, %158 : f32 -> f32
      %160 = llvm.fadd %152, %159 : f32
      %161 = llvm.mlir.constant(1 : i32) : i32
      %162 = llvm.mlir.constant(-1 : i32) : i32
      %163 = llvm.mlir.constant(32 : i32) : i32
      %164 = llvm.sub %163, %48 : i32
      %165 = llvm.lshr %162, %164 : i32
      %166 = llvm.sub %48, %161 : i32
      %167 = nvvm.shfl.sync  bfly %165, %160, %45, %166 : f32 -> f32
      %168 = llvm.fadd %160, %167 : f32
      %169 = llvm.mlir.constant(1 : i32) : i32
      %170 = llvm.mlir.constant(-1 : i32) : i32
      %171 = llvm.mlir.constant(32 : i32) : i32
      %172 = llvm.sub %171, %48 : i32
      %173 = llvm.lshr %170, %172 : i32
      %174 = llvm.sub %48, %169 : i32
      %175 = nvvm.shfl.sync  bfly %173, %168, %44, %174 : f32 -> f32
      %176 = llvm.fadd %168, %175 : f32
      %177 = llvm.mlir.constant(1 : i32) : i32
      %178 = llvm.mlir.constant(-1 : i32) : i32
      %179 = llvm.mlir.constant(32 : i32) : i32
      %180 = llvm.sub %179, %48 : i32
      %181 = llvm.lshr %178, %180 : i32
      %182 = llvm.sub %48, %177 : i32
      %183 = nvvm.shfl.sync  bfly %181, %176, %43, %182 : f32 -> f32
      %184 = llvm.fadd %176, %183 : f32
      llvm.br ^bb18(%184 : f32)
    ^bb18(%185: f32):  // 2 preds: ^bb16, ^bb17
      llvm.cond_br %86, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %186 = llvm.sdiv %83, %48 : i32
      %187 = llvm.sext %186 : i32 to i64
      %188 = llvm.extractvalue %30[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %189 = llvm.getelementptr inbounds|nuw %188[%187] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      llvm.store %185, %189 : f32, !llvm.ptr<3>
      llvm.br ^bb21
    ^bb20:  // pred: ^bb18
      llvm.br ^bb21
    ^bb21:  // 2 preds: ^bb19, ^bb20
      nvvm.barrier0
      %190 = llvm.add %84, %50 : i32
      %191 = llvm.sdiv %190, %48 : i32
      %192 = llvm.icmp "slt" %83, %191 : i32
      llvm.cond_br %192, ^bb22, ^bb41
    ^bb22:  // pred: ^bb21
      %193 = llvm.sext %83 : i32 to i64
      %194 = llvm.extractvalue %30[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %195 = llvm.getelementptr inbounds|nuw %194[%193] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      %196 = llvm.load %195 : !llvm.ptr<3> -> f32
      %197 = llvm.icmp "slt" %191, %48 : i32
      llvm.cond_br %197, ^bb23, ^bb39
    ^bb23:  // pred: ^bb22
      %198 = llvm.mlir.constant(1 : i32) : i32
      %199 = llvm.mlir.constant(-1 : i32) : i32
      %200 = llvm.mlir.constant(32 : i32) : i32
      %201 = llvm.sub %200, %191 : i32
      %202 = llvm.lshr %199, %201 : i32
      %203 = llvm.sub %191, %198 : i32
      %204 = nvvm.shfl.sync  bfly %202, %196, %47, %203 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %205 = llvm.extractvalue %204[0] : !llvm.struct<(f32, i1)> 
      %206 = llvm.extractvalue %204[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %206, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %207 = llvm.fadd %196, %205 : f32
      llvm.br ^bb26(%207 : f32)
    ^bb25:  // pred: ^bb23
      llvm.br ^bb26(%196 : f32)
    ^bb26(%208: f32):  // 2 preds: ^bb24, ^bb25
      %209 = llvm.mlir.constant(1 : i32) : i32
      %210 = llvm.mlir.constant(-1 : i32) : i32
      %211 = llvm.mlir.constant(32 : i32) : i32
      %212 = llvm.sub %211, %191 : i32
      %213 = llvm.lshr %210, %212 : i32
      %214 = llvm.sub %191, %209 : i32
      %215 = nvvm.shfl.sync  bfly %213, %208, %46, %214 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %216 = llvm.extractvalue %215[0] : !llvm.struct<(f32, i1)> 
      %217 = llvm.extractvalue %215[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %217, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %218 = llvm.fadd %208, %216 : f32
      llvm.br ^bb29(%218 : f32)
    ^bb28:  // pred: ^bb26
      llvm.br ^bb29(%208 : f32)
    ^bb29(%219: f32):  // 2 preds: ^bb27, ^bb28
      %220 = llvm.mlir.constant(1 : i32) : i32
      %221 = llvm.mlir.constant(-1 : i32) : i32
      %222 = llvm.mlir.constant(32 : i32) : i32
      %223 = llvm.sub %222, %191 : i32
      %224 = llvm.lshr %221, %223 : i32
      %225 = llvm.sub %191, %220 : i32
      %226 = nvvm.shfl.sync  bfly %224, %219, %45, %225 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %227 = llvm.extractvalue %226[0] : !llvm.struct<(f32, i1)> 
      %228 = llvm.extractvalue %226[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %228, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %229 = llvm.fadd %219, %227 : f32
      llvm.br ^bb32(%229 : f32)
    ^bb31:  // pred: ^bb29
      llvm.br ^bb32(%219 : f32)
    ^bb32(%230: f32):  // 2 preds: ^bb30, ^bb31
      %231 = llvm.mlir.constant(1 : i32) : i32
      %232 = llvm.mlir.constant(-1 : i32) : i32
      %233 = llvm.mlir.constant(32 : i32) : i32
      %234 = llvm.sub %233, %191 : i32
      %235 = llvm.lshr %232, %234 : i32
      %236 = llvm.sub %191, %231 : i32
      %237 = nvvm.shfl.sync  bfly %235, %230, %44, %236 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %238 = llvm.extractvalue %237[0] : !llvm.struct<(f32, i1)> 
      %239 = llvm.extractvalue %237[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %239, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %240 = llvm.fadd %230, %238 : f32
      llvm.br ^bb35(%240 : f32)
    ^bb34:  // pred: ^bb32
      llvm.br ^bb35(%230 : f32)
    ^bb35(%241: f32):  // 2 preds: ^bb33, ^bb34
      %242 = llvm.mlir.constant(1 : i32) : i32
      %243 = llvm.mlir.constant(-1 : i32) : i32
      %244 = llvm.mlir.constant(32 : i32) : i32
      %245 = llvm.sub %244, %191 : i32
      %246 = llvm.lshr %243, %245 : i32
      %247 = llvm.sub %191, %242 : i32
      %248 = nvvm.shfl.sync  bfly %246, %241, %43, %247 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %249 = llvm.extractvalue %248[0] : !llvm.struct<(f32, i1)> 
      %250 = llvm.extractvalue %248[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %250, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %251 = llvm.fadd %241, %249 : f32
      llvm.br ^bb38(%251 : f32)
    ^bb37:  // pred: ^bb35
      llvm.br ^bb38(%241 : f32)
    ^bb38(%252: f32):  // 2 preds: ^bb36, ^bb37
      llvm.br ^bb40(%252 : f32)
    ^bb39:  // pred: ^bb22
      %253 = llvm.mlir.constant(1 : i32) : i32
      %254 = llvm.mlir.constant(-1 : i32) : i32
      %255 = llvm.mlir.constant(32 : i32) : i32
      %256 = llvm.sub %255, %48 : i32
      %257 = llvm.lshr %254, %256 : i32
      %258 = llvm.sub %48, %253 : i32
      %259 = nvvm.shfl.sync  bfly %257, %196, %47, %258 : f32 -> f32
      %260 = llvm.fadd %196, %259 : f32
      %261 = llvm.mlir.constant(1 : i32) : i32
      %262 = llvm.mlir.constant(-1 : i32) : i32
      %263 = llvm.mlir.constant(32 : i32) : i32
      %264 = llvm.sub %263, %48 : i32
      %265 = llvm.lshr %262, %264 : i32
      %266 = llvm.sub %48, %261 : i32
      %267 = nvvm.shfl.sync  bfly %265, %260, %46, %266 : f32 -> f32
      %268 = llvm.fadd %260, %267 : f32
      %269 = llvm.mlir.constant(1 : i32) : i32
      %270 = llvm.mlir.constant(-1 : i32) : i32
      %271 = llvm.mlir.constant(32 : i32) : i32
      %272 = llvm.sub %271, %48 : i32
      %273 = llvm.lshr %270, %272 : i32
      %274 = llvm.sub %48, %269 : i32
      %275 = nvvm.shfl.sync  bfly %273, %268, %45, %274 : f32 -> f32
      %276 = llvm.fadd %268, %275 : f32
      %277 = llvm.mlir.constant(1 : i32) : i32
      %278 = llvm.mlir.constant(-1 : i32) : i32
      %279 = llvm.mlir.constant(32 : i32) : i32
      %280 = llvm.sub %279, %48 : i32
      %281 = llvm.lshr %278, %280 : i32
      %282 = llvm.sub %48, %277 : i32
      %283 = nvvm.shfl.sync  bfly %281, %276, %44, %282 : f32 -> f32
      %284 = llvm.fadd %276, %283 : f32
      %285 = llvm.mlir.constant(1 : i32) : i32
      %286 = llvm.mlir.constant(-1 : i32) : i32
      %287 = llvm.mlir.constant(32 : i32) : i32
      %288 = llvm.sub %287, %48 : i32
      %289 = llvm.lshr %286, %288 : i32
      %290 = llvm.sub %48, %285 : i32
      %291 = nvvm.shfl.sync  bfly %289, %284, %43, %290 : f32 -> f32
      %292 = llvm.fadd %284, %291 : f32
      llvm.br ^bb40(%292 : f32)
    ^bb40(%293: f32):  // 2 preds: ^bb38, ^bb39
      %294 = llvm.extractvalue %30[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %295 = llvm.getelementptr inbounds|nuw %294[%42] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      llvm.store %293, %295 : f32, !llvm.ptr<3>
      llvm.br ^bb42
    ^bb41:  // pred: ^bb21
      llvm.br ^bb42
    ^bb42:  // 2 preds: ^bb40, ^bb41
      nvvm.barrier0
      %296 = llvm.extractvalue %30[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %297 = llvm.getelementptr inbounds|nuw %296[%42] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      %298 = llvm.load %297 : !llvm.ptr<3> -> f32
      %299 = llvm.extractvalue %11[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %300 = llvm.getelementptr inbounds|nuw %299[%52] : (!llvm.ptr, i64) -> !llvm.ptr, f32
      llvm.store %298, %300 : f32, !llvm.ptr
      %301 = nvvm.read.ptx.sreg.ntid.x range <i32, 1, 2> : i32
      %302 = llvm.sext %301 : i32 to i64
      %303 = llvm.trunc %302 : i64 to i32
      %304 = nvvm.read.ptx.sreg.ntid.y range <i32, 1, 2> : i32
      %305 = llvm.sext %304 : i32 to i64
      %306 = llvm.trunc %305 : i64 to i32
      %307 = nvvm.read.ptx.sreg.ntid.z range <i32, 1, 2> : i32
      %308 = llvm.sext %307 : i32 to i64
      %309 = llvm.trunc %308 : i64 to i32
      %310 = nvvm.read.ptx.sreg.tid.x range <i32, 0, 1> : i32
      %311 = llvm.sext %310 : i32 to i64
      %312 = llvm.trunc %311 : i64 to i32
      %313 = nvvm.read.ptx.sreg.tid.y range <i32, 0, 1> : i32
      %314 = llvm.sext %313 : i32 to i64
      %315 = llvm.trunc %314 : i64 to i32
      %316 = nvvm.read.ptx.sreg.tid.z range <i32, 0, 1> : i32
      %317 = llvm.sext %316 : i32 to i64
      %318 = llvm.trunc %317 : i64 to i32
      %319 = llvm.mul %318, %306 : i32
      %320 = llvm.add %319, %315 : i32
      %321 = llvm.mul %320, %303 : i32
      %322 = llvm.mul %303, %306 : i32
      %323 = llvm.add %321, %312 : i32
      %324 = llvm.mul %322, %309 : i32
      %325 = llvm.and %323, %50 : i32
      %326 = llvm.icmp "eq" %325, %49 : i32
      %327 = llvm.sub %323, %325 : i32
      %328 = llvm.sub %324, %327 : i32
      %329 = llvm.icmp "slt" %328, %48 : i32
      llvm.cond_br %329, ^bb43, ^bb59
    ^bb43:  // pred: ^bb42
      %330 = llvm.mlir.constant(1 : i32) : i32
      %331 = llvm.mlir.constant(-1 : i32) : i32
      %332 = llvm.mlir.constant(32 : i32) : i32
      %333 = llvm.sub %332, %328 : i32
      %334 = llvm.lshr %331, %333 : i32
      %335 = llvm.sub %328, %330 : i32
      %336 = nvvm.shfl.sync  bfly %334, %60, %47, %335 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %337 = llvm.extractvalue %336[0] : !llvm.struct<(f32, i1)> 
      %338 = llvm.extractvalue %336[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %338, ^bb44, ^bb45
    ^bb44:  // pred: ^bb43
      %339 = llvm.fmul %60, %337 : f32
      llvm.br ^bb46(%339 : f32)
    ^bb45:  // pred: ^bb43
      llvm.br ^bb46(%60 : f32)
    ^bb46(%340: f32):  // 2 preds: ^bb44, ^bb45
      %341 = llvm.mlir.constant(1 : i32) : i32
      %342 = llvm.mlir.constant(-1 : i32) : i32
      %343 = llvm.mlir.constant(32 : i32) : i32
      %344 = llvm.sub %343, %328 : i32
      %345 = llvm.lshr %342, %344 : i32
      %346 = llvm.sub %328, %341 : i32
      %347 = nvvm.shfl.sync  bfly %345, %340, %46, %346 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %348 = llvm.extractvalue %347[0] : !llvm.struct<(f32, i1)> 
      %349 = llvm.extractvalue %347[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %349, ^bb47, ^bb48
    ^bb47:  // pred: ^bb46
      %350 = llvm.fmul %340, %348 : f32
      llvm.br ^bb49(%350 : f32)
    ^bb48:  // pred: ^bb46
      llvm.br ^bb49(%340 : f32)
    ^bb49(%351: f32):  // 2 preds: ^bb47, ^bb48
      %352 = llvm.mlir.constant(1 : i32) : i32
      %353 = llvm.mlir.constant(-1 : i32) : i32
      %354 = llvm.mlir.constant(32 : i32) : i32
      %355 = llvm.sub %354, %328 : i32
      %356 = llvm.lshr %353, %355 : i32
      %357 = llvm.sub %328, %352 : i32
      %358 = nvvm.shfl.sync  bfly %356, %351, %45, %357 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %359 = llvm.extractvalue %358[0] : !llvm.struct<(f32, i1)> 
      %360 = llvm.extractvalue %358[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %360, ^bb50, ^bb51
    ^bb50:  // pred: ^bb49
      %361 = llvm.fmul %351, %359 : f32
      llvm.br ^bb52(%361 : f32)
    ^bb51:  // pred: ^bb49
      llvm.br ^bb52(%351 : f32)
    ^bb52(%362: f32):  // 2 preds: ^bb50, ^bb51
      %363 = llvm.mlir.constant(1 : i32) : i32
      %364 = llvm.mlir.constant(-1 : i32) : i32
      %365 = llvm.mlir.constant(32 : i32) : i32
      %366 = llvm.sub %365, %328 : i32
      %367 = llvm.lshr %364, %366 : i32
      %368 = llvm.sub %328, %363 : i32
      %369 = nvvm.shfl.sync  bfly %367, %362, %44, %368 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %370 = llvm.extractvalue %369[0] : !llvm.struct<(f32, i1)> 
      %371 = llvm.extractvalue %369[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %371, ^bb53, ^bb54
    ^bb53:  // pred: ^bb52
      %372 = llvm.fmul %362, %370 : f32
      llvm.br ^bb55(%372 : f32)
    ^bb54:  // pred: ^bb52
      llvm.br ^bb55(%362 : f32)
    ^bb55(%373: f32):  // 2 preds: ^bb53, ^bb54
      %374 = llvm.mlir.constant(1 : i32) : i32
      %375 = llvm.mlir.constant(-1 : i32) : i32
      %376 = llvm.mlir.constant(32 : i32) : i32
      %377 = llvm.sub %376, %328 : i32
      %378 = llvm.lshr %375, %377 : i32
      %379 = llvm.sub %328, %374 : i32
      %380 = nvvm.shfl.sync  bfly %378, %373, %43, %379 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %381 = llvm.extractvalue %380[0] : !llvm.struct<(f32, i1)> 
      %382 = llvm.extractvalue %380[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %382, ^bb56, ^bb57
    ^bb56:  // pred: ^bb55
      %383 = llvm.fmul %373, %381 : f32
      llvm.br ^bb58(%383 : f32)
    ^bb57:  // pred: ^bb55
      llvm.br ^bb58(%373 : f32)
    ^bb58(%384: f32):  // 2 preds: ^bb56, ^bb57
      llvm.br ^bb60(%384 : f32)
    ^bb59:  // pred: ^bb42
      %385 = llvm.mlir.constant(1 : i32) : i32
      %386 = llvm.mlir.constant(-1 : i32) : i32
      %387 = llvm.mlir.constant(32 : i32) : i32
      %388 = llvm.sub %387, %48 : i32
      %389 = llvm.lshr %386, %388 : i32
      %390 = llvm.sub %48, %385 : i32
      %391 = nvvm.shfl.sync  bfly %389, %60, %47, %390 : f32 -> f32
      %392 = llvm.fmul %60, %391 : f32
      %393 = llvm.mlir.constant(1 : i32) : i32
      %394 = llvm.mlir.constant(-1 : i32) : i32
      %395 = llvm.mlir.constant(32 : i32) : i32
      %396 = llvm.sub %395, %48 : i32
      %397 = llvm.lshr %394, %396 : i32
      %398 = llvm.sub %48, %393 : i32
      %399 = nvvm.shfl.sync  bfly %397, %392, %46, %398 : f32 -> f32
      %400 = llvm.fmul %392, %399 : f32
      %401 = llvm.mlir.constant(1 : i32) : i32
      %402 = llvm.mlir.constant(-1 : i32) : i32
      %403 = llvm.mlir.constant(32 : i32) : i32
      %404 = llvm.sub %403, %48 : i32
      %405 = llvm.lshr %402, %404 : i32
      %406 = llvm.sub %48, %401 : i32
      %407 = nvvm.shfl.sync  bfly %405, %400, %45, %406 : f32 -> f32
      %408 = llvm.fmul %400, %407 : f32
      %409 = llvm.mlir.constant(1 : i32) : i32
      %410 = llvm.mlir.constant(-1 : i32) : i32
      %411 = llvm.mlir.constant(32 : i32) : i32
      %412 = llvm.sub %411, %48 : i32
      %413 = llvm.lshr %410, %412 : i32
      %414 = llvm.sub %48, %409 : i32
      %415 = nvvm.shfl.sync  bfly %413, %408, %44, %414 : f32 -> f32
      %416 = llvm.fmul %408, %415 : f32
      %417 = llvm.mlir.constant(1 : i32) : i32
      %418 = llvm.mlir.constant(-1 : i32) : i32
      %419 = llvm.mlir.constant(32 : i32) : i32
      %420 = llvm.sub %419, %48 : i32
      %421 = llvm.lshr %418, %420 : i32
      %422 = llvm.sub %48, %417 : i32
      %423 = nvvm.shfl.sync  bfly %421, %416, %43, %422 : f32 -> f32
      %424 = llvm.fmul %416, %423 : f32
      llvm.br ^bb60(%424 : f32)
    ^bb60(%425: f32):  // 2 preds: ^bb58, ^bb59
      llvm.cond_br %326, ^bb61, ^bb62
    ^bb61:  // pred: ^bb60
      %426 = llvm.sdiv %323, %48 : i32
      %427 = llvm.sext %426 : i32 to i64
      %428 = llvm.extractvalue %41[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %429 = llvm.getelementptr inbounds|nuw %428[%427] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      llvm.store %425, %429 : f32, !llvm.ptr<3>
      llvm.br ^bb63
    ^bb62:  // pred: ^bb60
      llvm.br ^bb63
    ^bb63:  // 2 preds: ^bb61, ^bb62
      nvvm.barrier0
      %430 = llvm.add %324, %50 : i32
      %431 = llvm.sdiv %430, %48 : i32
      %432 = llvm.icmp "slt" %323, %431 : i32
      llvm.cond_br %432, ^bb64, ^bb83
    ^bb64:  // pred: ^bb63
      %433 = llvm.sext %323 : i32 to i64
      %434 = llvm.extractvalue %41[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %435 = llvm.getelementptr inbounds|nuw %434[%433] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      %436 = llvm.load %435 : !llvm.ptr<3> -> f32
      %437 = llvm.icmp "slt" %431, %48 : i32
      llvm.cond_br %437, ^bb65, ^bb81
    ^bb65:  // pred: ^bb64
      %438 = llvm.mlir.constant(1 : i32) : i32
      %439 = llvm.mlir.constant(-1 : i32) : i32
      %440 = llvm.mlir.constant(32 : i32) : i32
      %441 = llvm.sub %440, %431 : i32
      %442 = llvm.lshr %439, %441 : i32
      %443 = llvm.sub %431, %438 : i32
      %444 = nvvm.shfl.sync  bfly %442, %436, %47, %443 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %445 = llvm.extractvalue %444[0] : !llvm.struct<(f32, i1)> 
      %446 = llvm.extractvalue %444[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %446, ^bb66, ^bb67
    ^bb66:  // pred: ^bb65
      %447 = llvm.fmul %436, %445 : f32
      llvm.br ^bb68(%447 : f32)
    ^bb67:  // pred: ^bb65
      llvm.br ^bb68(%436 : f32)
    ^bb68(%448: f32):  // 2 preds: ^bb66, ^bb67
      %449 = llvm.mlir.constant(1 : i32) : i32
      %450 = llvm.mlir.constant(-1 : i32) : i32
      %451 = llvm.mlir.constant(32 : i32) : i32
      %452 = llvm.sub %451, %431 : i32
      %453 = llvm.lshr %450, %452 : i32
      %454 = llvm.sub %431, %449 : i32
      %455 = nvvm.shfl.sync  bfly %453, %448, %46, %454 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %456 = llvm.extractvalue %455[0] : !llvm.struct<(f32, i1)> 
      %457 = llvm.extractvalue %455[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %457, ^bb69, ^bb70
    ^bb69:  // pred: ^bb68
      %458 = llvm.fmul %448, %456 : f32
      llvm.br ^bb71(%458 : f32)
    ^bb70:  // pred: ^bb68
      llvm.br ^bb71(%448 : f32)
    ^bb71(%459: f32):  // 2 preds: ^bb69, ^bb70
      %460 = llvm.mlir.constant(1 : i32) : i32
      %461 = llvm.mlir.constant(-1 : i32) : i32
      %462 = llvm.mlir.constant(32 : i32) : i32
      %463 = llvm.sub %462, %431 : i32
      %464 = llvm.lshr %461, %463 : i32
      %465 = llvm.sub %431, %460 : i32
      %466 = nvvm.shfl.sync  bfly %464, %459, %45, %465 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %467 = llvm.extractvalue %466[0] : !llvm.struct<(f32, i1)> 
      %468 = llvm.extractvalue %466[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %468, ^bb72, ^bb73
    ^bb72:  // pred: ^bb71
      %469 = llvm.fmul %459, %467 : f32
      llvm.br ^bb74(%469 : f32)
    ^bb73:  // pred: ^bb71
      llvm.br ^bb74(%459 : f32)
    ^bb74(%470: f32):  // 2 preds: ^bb72, ^bb73
      %471 = llvm.mlir.constant(1 : i32) : i32
      %472 = llvm.mlir.constant(-1 : i32) : i32
      %473 = llvm.mlir.constant(32 : i32) : i32
      %474 = llvm.sub %473, %431 : i32
      %475 = llvm.lshr %472, %474 : i32
      %476 = llvm.sub %431, %471 : i32
      %477 = nvvm.shfl.sync  bfly %475, %470, %44, %476 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %478 = llvm.extractvalue %477[0] : !llvm.struct<(f32, i1)> 
      %479 = llvm.extractvalue %477[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %479, ^bb75, ^bb76
    ^bb75:  // pred: ^bb74
      %480 = llvm.fmul %470, %478 : f32
      llvm.br ^bb77(%480 : f32)
    ^bb76:  // pred: ^bb74
      llvm.br ^bb77(%470 : f32)
    ^bb77(%481: f32):  // 2 preds: ^bb75, ^bb76
      %482 = llvm.mlir.constant(1 : i32) : i32
      %483 = llvm.mlir.constant(-1 : i32) : i32
      %484 = llvm.mlir.constant(32 : i32) : i32
      %485 = llvm.sub %484, %431 : i32
      %486 = llvm.lshr %483, %485 : i32
      %487 = llvm.sub %431, %482 : i32
      %488 = nvvm.shfl.sync  bfly %486, %481, %43, %487 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %489 = llvm.extractvalue %488[0] : !llvm.struct<(f32, i1)> 
      %490 = llvm.extractvalue %488[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %490, ^bb78, ^bb79
    ^bb78:  // pred: ^bb77
      %491 = llvm.fmul %481, %489 : f32
      llvm.br ^bb80(%491 : f32)
    ^bb79:  // pred: ^bb77
      llvm.br ^bb80(%481 : f32)
    ^bb80(%492: f32):  // 2 preds: ^bb78, ^bb79
      llvm.br ^bb82(%492 : f32)
    ^bb81:  // pred: ^bb64
      %493 = llvm.mlir.constant(1 : i32) : i32
      %494 = llvm.mlir.constant(-1 : i32) : i32
      %495 = llvm.mlir.constant(32 : i32) : i32
      %496 = llvm.sub %495, %48 : i32
      %497 = llvm.lshr %494, %496 : i32
      %498 = llvm.sub %48, %493 : i32
      %499 = nvvm.shfl.sync  bfly %497, %436, %47, %498 : f32 -> f32
      %500 = llvm.fmul %436, %499 : f32
      %501 = llvm.mlir.constant(1 : i32) : i32
      %502 = llvm.mlir.constant(-1 : i32) : i32
      %503 = llvm.mlir.constant(32 : i32) : i32
      %504 = llvm.sub %503, %48 : i32
      %505 = llvm.lshr %502, %504 : i32
      %506 = llvm.sub %48, %501 : i32
      %507 = nvvm.shfl.sync  bfly %505, %500, %46, %506 : f32 -> f32
      %508 = llvm.fmul %500, %507 : f32
      %509 = llvm.mlir.constant(1 : i32) : i32
      %510 = llvm.mlir.constant(-1 : i32) : i32
      %511 = llvm.mlir.constant(32 : i32) : i32
      %512 = llvm.sub %511, %48 : i32
      %513 = llvm.lshr %510, %512 : i32
      %514 = llvm.sub %48, %509 : i32
      %515 = nvvm.shfl.sync  bfly %513, %508, %45, %514 : f32 -> f32
      %516 = llvm.fmul %508, %515 : f32
      %517 = llvm.mlir.constant(1 : i32) : i32
      %518 = llvm.mlir.constant(-1 : i32) : i32
      %519 = llvm.mlir.constant(32 : i32) : i32
      %520 = llvm.sub %519, %48 : i32
      %521 = llvm.lshr %518, %520 : i32
      %522 = llvm.sub %48, %517 : i32
      %523 = nvvm.shfl.sync  bfly %521, %516, %44, %522 : f32 -> f32
      %524 = llvm.fmul %516, %523 : f32
      %525 = llvm.mlir.constant(1 : i32) : i32
      %526 = llvm.mlir.constant(-1 : i32) : i32
      %527 = llvm.mlir.constant(32 : i32) : i32
      %528 = llvm.sub %527, %48 : i32
      %529 = llvm.lshr %526, %528 : i32
      %530 = llvm.sub %48, %525 : i32
      %531 = nvvm.shfl.sync  bfly %529, %524, %43, %530 : f32 -> f32
      %532 = llvm.fmul %524, %531 : f32
      llvm.br ^bb82(%532 : f32)
    ^bb82(%533: f32):  // 2 preds: ^bb80, ^bb81
      %534 = llvm.extractvalue %41[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %535 = llvm.getelementptr inbounds|nuw %534[%42] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      llvm.store %533, %535 : f32, !llvm.ptr<3>
      llvm.br ^bb84
    ^bb83:  // pred: ^bb63
      llvm.br ^bb84
    ^bb84:  // 2 preds: ^bb82, ^bb83
      nvvm.barrier0
      %536 = llvm.extractvalue %41[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %537 = llvm.getelementptr inbounds|nuw %536[%42] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      %538 = llvm.load %537 : !llvm.ptr<3> -> f32
      %539 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %540 = llvm.getelementptr inbounds|nuw %539[%52] : (!llvm.ptr, i64) -> !llvm.ptr, f32
      llvm.store %538, %540 : f32, !llvm.ptr
      llvm.return
    }
  }
}


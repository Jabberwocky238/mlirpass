module {
  gpu.module @test_module_0 {
    llvm.func @gpu_index_ops() -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> {
      %0 = nvvm.read.ptx.sreg.tid.x : i32
      %1 = llvm.sext %0 : i32 to i64
      %2 = nvvm.read.ptx.sreg.tid.y : i32
      %3 = llvm.sext %2 : i32 to i64
      %4 = nvvm.read.ptx.sreg.tid.z : i32
      %5 = llvm.sext %4 : i32 to i64
      %6 = nvvm.read.ptx.sreg.ntid.x : i32
      %7 = llvm.sext %6 : i32 to i64
      %8 = nvvm.read.ptx.sreg.ntid.y : i32
      %9 = llvm.sext %8 : i32 to i64
      %10 = nvvm.read.ptx.sreg.ntid.z : i32
      %11 = llvm.sext %10 : i32 to i64
      %12 = nvvm.read.ptx.sreg.ctaid.x : i32
      %13 = llvm.sext %12 : i32 to i64
      %14 = nvvm.read.ptx.sreg.ctaid.y : i32
      %15 = llvm.sext %14 : i32 to i64
      %16 = nvvm.read.ptx.sreg.ctaid.z : i32
      %17 = llvm.sext %16 : i32 to i64
      %18 = nvvm.read.ptx.sreg.nctaid.x : i32
      %19 = llvm.sext %18 : i32 to i64
      %20 = nvvm.read.ptx.sreg.nctaid.y : i32
      %21 = llvm.sext %20 : i32 to i64
      %22 = nvvm.read.ptx.sreg.nctaid.z : i32
      %23 = llvm.sext %22 : i32 to i64
      %24 = nvvm.read.ptx.sreg.laneid range <i32, 0, 32> : i32
      %25 = llvm.sext %24 : i32 to i64
      %26 = llvm.mlir.poison : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %27 = llvm.insertvalue %1, %26[0] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %28 = llvm.insertvalue %3, %27[1] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %29 = llvm.insertvalue %5, %28[2] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %30 = llvm.insertvalue %7, %29[3] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %31 = llvm.insertvalue %9, %30[4] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %32 = llvm.insertvalue %11, %31[5] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %33 = llvm.insertvalue %13, %32[6] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %34 = llvm.insertvalue %15, %33[7] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %35 = llvm.insertvalue %17, %34[8] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %36 = llvm.insertvalue %19, %35[9] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %37 = llvm.insertvalue %21, %36[10] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %38 = llvm.insertvalue %23, %37[11] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %39 = llvm.insertvalue %25, %38[12] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      llvm.return %39 : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
    }
  }
  gpu.module @test_module_1 {
    llvm.func @gpu_index_comp(%arg0: i64) -> i64 {
      %0 = llvm.add %arg0, %arg0 : i64
      llvm.return %0 : i64
    }
  }
  gpu.module @test_module_2 {
    llvm.mlir.global internal @__wg_gpu_all_reduce_op_0() {addr_space = 3 : i32} : !llvm.array<32 x f32>
    llvm.func @gpu_all_reduce_op() {
      %0 = llvm.mlir.addressof @__wg_gpu_all_reduce_op_0 : !llvm.ptr<3>
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, !llvm.array<32 x f32>
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.mlir.constant(0 : index) : i64
      %6 = llvm.insertvalue %5, %4[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %7 = llvm.mlir.constant(32 : index) : i64
      %8 = llvm.insertvalue %7, %6[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %9 = llvm.mlir.constant(1 : index) : i64
      %10 = llvm.insertvalue %9, %8[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %11 = builtin.unrealized_conversion_cast %10 : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> to memref<32xf32, #gpu.address_space<workgroup>>
      %12 = llvm.mlir.constant(0 : index) : i64
      %13 = builtin.unrealized_conversion_cast %12 : i64 to index
      %14 = llvm.mlir.constant(16 : i32) : i32
      %15 = llvm.mlir.constant(8 : i32) : i32
      %16 = llvm.mlir.constant(4 : i32) : i32
      %17 = llvm.mlir.constant(2 : i32) : i32
      %18 = llvm.mlir.constant(1 : i32) : i32
      %19 = llvm.mlir.constant(32 : i32) : i32
      %20 = llvm.mlir.constant(0 : i32) : i32
      %21 = llvm.mlir.constant(31 : i32) : i32
      %22 = llvm.mlir.constant(1.000000e+00 : f32) : f32
      %23 = nvvm.read.ptx.sreg.ntid.x : i32
      %24 = llvm.sext %23 : i32 to i64
      %25 = llvm.trunc %24 : i64 to i32
      %26 = nvvm.read.ptx.sreg.ntid.y : i32
      %27 = llvm.sext %26 : i32 to i64
      %28 = llvm.trunc %27 : i64 to i32
      %29 = nvvm.read.ptx.sreg.ntid.z : i32
      %30 = llvm.sext %29 : i32 to i64
      %31 = llvm.trunc %30 : i64 to i32
      %32 = nvvm.read.ptx.sreg.tid.x : i32
      %33 = llvm.sext %32 : i32 to i64
      %34 = llvm.trunc %33 : i64 to i32
      %35 = nvvm.read.ptx.sreg.tid.y : i32
      %36 = llvm.sext %35 : i32 to i64
      %37 = llvm.trunc %36 : i64 to i32
      %38 = nvvm.read.ptx.sreg.tid.z : i32
      %39 = llvm.sext %38 : i32 to i64
      %40 = llvm.trunc %39 : i64 to i32
      %41 = llvm.mul %40, %28 : i32
      %42 = llvm.add %41, %37 : i32
      %43 = llvm.mul %42, %25 : i32
      %44 = llvm.mul %25, %28 : i32
      %45 = llvm.add %43, %34 : i32
      %46 = llvm.mul %44, %31 : i32
      %47 = llvm.and %45, %21 : i32
      %48 = llvm.icmp "eq" %47, %20 : i32
      %49 = llvm.sub %45, %47 : i32
      %50 = llvm.sub %46, %49 : i32
      %51 = llvm.icmp "slt" %50, %19 : i32
      llvm.cond_br %51, ^bb1, ^bb17
    ^bb1:  // pred: ^bb0
      %52 = llvm.mlir.constant(1 : i32) : i32
      %53 = llvm.mlir.constant(-1 : i32) : i32
      %54 = llvm.mlir.constant(32 : i32) : i32
      %55 = llvm.sub %54, %50 : i32
      %56 = llvm.lshr %53, %55 : i32
      %57 = llvm.sub %50, %52 : i32
      %58 = nvvm.shfl.sync bfly %56, %22, %18, %57 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %59 = llvm.extractvalue %58[0] : !llvm.struct<(f32, i1)> 
      %60 = llvm.extractvalue %58[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %60, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %61 = llvm.fadd %59, %22 : f32
      llvm.br ^bb4(%61 : f32)
    ^bb3:  // pred: ^bb1
      llvm.br ^bb4(%22 : f32)
    ^bb4(%62: f32):  // 2 preds: ^bb2, ^bb3
      %63 = llvm.mlir.constant(1 : i32) : i32
      %64 = llvm.mlir.constant(-1 : i32) : i32
      %65 = llvm.mlir.constant(32 : i32) : i32
      %66 = llvm.sub %65, %50 : i32
      %67 = llvm.lshr %64, %66 : i32
      %68 = llvm.sub %50, %63 : i32
      %69 = nvvm.shfl.sync bfly %67, %62, %17, %68 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %70 = llvm.extractvalue %69[0] : !llvm.struct<(f32, i1)> 
      %71 = llvm.extractvalue %69[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %71, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %72 = llvm.fadd %62, %70 : f32
      llvm.br ^bb7(%72 : f32)
    ^bb6:  // pred: ^bb4
      llvm.br ^bb7(%62 : f32)
    ^bb7(%73: f32):  // 2 preds: ^bb5, ^bb6
      %74 = llvm.mlir.constant(1 : i32) : i32
      %75 = llvm.mlir.constant(-1 : i32) : i32
      %76 = llvm.mlir.constant(32 : i32) : i32
      %77 = llvm.sub %76, %50 : i32
      %78 = llvm.lshr %75, %77 : i32
      %79 = llvm.sub %50, %74 : i32
      %80 = nvvm.shfl.sync bfly %78, %73, %16, %79 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %81 = llvm.extractvalue %80[0] : !llvm.struct<(f32, i1)> 
      %82 = llvm.extractvalue %80[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %82, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %83 = llvm.fadd %73, %81 : f32
      llvm.br ^bb10(%83 : f32)
    ^bb9:  // pred: ^bb7
      llvm.br ^bb10(%73 : f32)
    ^bb10(%84: f32):  // 2 preds: ^bb8, ^bb9
      %85 = llvm.mlir.constant(1 : i32) : i32
      %86 = llvm.mlir.constant(-1 : i32) : i32
      %87 = llvm.mlir.constant(32 : i32) : i32
      %88 = llvm.sub %87, %50 : i32
      %89 = llvm.lshr %86, %88 : i32
      %90 = llvm.sub %50, %85 : i32
      %91 = nvvm.shfl.sync bfly %89, %84, %15, %90 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %92 = llvm.extractvalue %91[0] : !llvm.struct<(f32, i1)> 
      %93 = llvm.extractvalue %91[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %93, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %94 = llvm.fadd %84, %92 : f32
      llvm.br ^bb13(%94 : f32)
    ^bb12:  // pred: ^bb10
      llvm.br ^bb13(%84 : f32)
    ^bb13(%95: f32):  // 2 preds: ^bb11, ^bb12
      %96 = llvm.mlir.constant(1 : i32) : i32
      %97 = llvm.mlir.constant(-1 : i32) : i32
      %98 = llvm.mlir.constant(32 : i32) : i32
      %99 = llvm.sub %98, %50 : i32
      %100 = llvm.lshr %97, %99 : i32
      %101 = llvm.sub %50, %96 : i32
      %102 = nvvm.shfl.sync bfly %100, %95, %14, %101 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %103 = llvm.extractvalue %102[0] : !llvm.struct<(f32, i1)> 
      %104 = llvm.extractvalue %102[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %104, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %105 = llvm.fadd %95, %103 : f32
      llvm.br ^bb16(%105 : f32)
    ^bb15:  // pred: ^bb13
      llvm.br ^bb16(%95 : f32)
    ^bb16(%106: f32):  // 2 preds: ^bb14, ^bb15
      llvm.br ^bb18(%106 : f32)
    ^bb17:  // pred: ^bb0
      %107 = llvm.mlir.constant(1 : i32) : i32
      %108 = llvm.mlir.constant(-1 : i32) : i32
      %109 = llvm.mlir.constant(32 : i32) : i32
      %110 = llvm.sub %109, %19 : i32
      %111 = llvm.lshr %108, %110 : i32
      %112 = llvm.sub %19, %107 : i32
      %113 = nvvm.shfl.sync bfly %111, %22, %18, %112 : f32 -> f32
      %114 = llvm.fadd %113, %22 : f32
      %115 = llvm.mlir.constant(1 : i32) : i32
      %116 = llvm.mlir.constant(-1 : i32) : i32
      %117 = llvm.mlir.constant(32 : i32) : i32
      %118 = llvm.sub %117, %19 : i32
      %119 = llvm.lshr %116, %118 : i32
      %120 = llvm.sub %19, %115 : i32
      %121 = nvvm.shfl.sync bfly %119, %114, %17, %120 : f32 -> f32
      %122 = llvm.fadd %114, %121 : f32
      %123 = llvm.mlir.constant(1 : i32) : i32
      %124 = llvm.mlir.constant(-1 : i32) : i32
      %125 = llvm.mlir.constant(32 : i32) : i32
      %126 = llvm.sub %125, %19 : i32
      %127 = llvm.lshr %124, %126 : i32
      %128 = llvm.sub %19, %123 : i32
      %129 = nvvm.shfl.sync bfly %127, %122, %16, %128 : f32 -> f32
      %130 = llvm.fadd %122, %129 : f32
      %131 = llvm.mlir.constant(1 : i32) : i32
      %132 = llvm.mlir.constant(-1 : i32) : i32
      %133 = llvm.mlir.constant(32 : i32) : i32
      %134 = llvm.sub %133, %19 : i32
      %135 = llvm.lshr %132, %134 : i32
      %136 = llvm.sub %19, %131 : i32
      %137 = nvvm.shfl.sync bfly %135, %130, %15, %136 : f32 -> f32
      %138 = llvm.fadd %130, %137 : f32
      %139 = llvm.mlir.constant(1 : i32) : i32
      %140 = llvm.mlir.constant(-1 : i32) : i32
      %141 = llvm.mlir.constant(32 : i32) : i32
      %142 = llvm.sub %141, %19 : i32
      %143 = llvm.lshr %140, %142 : i32
      %144 = llvm.sub %19, %139 : i32
      %145 = nvvm.shfl.sync bfly %143, %138, %14, %144 : f32 -> f32
      %146 = llvm.fadd %138, %145 : f32
      llvm.br ^bb18(%146 : f32)
    ^bb18(%147: f32):  // 2 preds: ^bb16, ^bb17
      llvm.cond_br %48, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %148 = llvm.sdiv %45, %19 : i32
      %149 = llvm.sext %148 : i32 to i64
      %150 = builtin.unrealized_conversion_cast %149 : i64 to index
      memref.store %147, %11[%150] : memref<32xf32, #gpu.address_space<workgroup>>
      llvm.br ^bb21
    ^bb20:  // pred: ^bb18
      llvm.br ^bb21
    ^bb21:  // 2 preds: ^bb19, ^bb20
      nvvm.barrier
      %151 = llvm.add %46, %21 : i32
      %152 = llvm.sdiv %151, %19 : i32
      %153 = llvm.icmp "slt" %45, %152 : i32
      llvm.cond_br %153, ^bb22, ^bb41
    ^bb22:  // pred: ^bb21
      %154 = llvm.sext %45 : i32 to i64
      %155 = builtin.unrealized_conversion_cast %154 : i64 to index
      %156 = memref.load %11[%155] : memref<32xf32, #gpu.address_space<workgroup>>
      %157 = llvm.icmp "slt" %152, %19 : i32
      llvm.cond_br %157, ^bb23, ^bb39
    ^bb23:  // pred: ^bb22
      %158 = llvm.mlir.constant(1 : i32) : i32
      %159 = llvm.mlir.constant(-1 : i32) : i32
      %160 = llvm.mlir.constant(32 : i32) : i32
      %161 = llvm.sub %160, %152 : i32
      %162 = llvm.lshr %159, %161 : i32
      %163 = llvm.sub %152, %158 : i32
      %164 = nvvm.shfl.sync bfly %162, %156, %18, %163 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %165 = llvm.extractvalue %164[0] : !llvm.struct<(f32, i1)> 
      %166 = llvm.extractvalue %164[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %166, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %167 = llvm.fadd %156, %165 : f32
      llvm.br ^bb26(%167 : f32)
    ^bb25:  // pred: ^bb23
      llvm.br ^bb26(%156 : f32)
    ^bb26(%168: f32):  // 2 preds: ^bb24, ^bb25
      %169 = llvm.mlir.constant(1 : i32) : i32
      %170 = llvm.mlir.constant(-1 : i32) : i32
      %171 = llvm.mlir.constant(32 : i32) : i32
      %172 = llvm.sub %171, %152 : i32
      %173 = llvm.lshr %170, %172 : i32
      %174 = llvm.sub %152, %169 : i32
      %175 = nvvm.shfl.sync bfly %173, %168, %17, %174 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %176 = llvm.extractvalue %175[0] : !llvm.struct<(f32, i1)> 
      %177 = llvm.extractvalue %175[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %177, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %178 = llvm.fadd %168, %176 : f32
      llvm.br ^bb29(%178 : f32)
    ^bb28:  // pred: ^bb26
      llvm.br ^bb29(%168 : f32)
    ^bb29(%179: f32):  // 2 preds: ^bb27, ^bb28
      %180 = llvm.mlir.constant(1 : i32) : i32
      %181 = llvm.mlir.constant(-1 : i32) : i32
      %182 = llvm.mlir.constant(32 : i32) : i32
      %183 = llvm.sub %182, %152 : i32
      %184 = llvm.lshr %181, %183 : i32
      %185 = llvm.sub %152, %180 : i32
      %186 = nvvm.shfl.sync bfly %184, %179, %16, %185 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %187 = llvm.extractvalue %186[0] : !llvm.struct<(f32, i1)> 
      %188 = llvm.extractvalue %186[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %188, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %189 = llvm.fadd %179, %187 : f32
      llvm.br ^bb32(%189 : f32)
    ^bb31:  // pred: ^bb29
      llvm.br ^bb32(%179 : f32)
    ^bb32(%190: f32):  // 2 preds: ^bb30, ^bb31
      %191 = llvm.mlir.constant(1 : i32) : i32
      %192 = llvm.mlir.constant(-1 : i32) : i32
      %193 = llvm.mlir.constant(32 : i32) : i32
      %194 = llvm.sub %193, %152 : i32
      %195 = llvm.lshr %192, %194 : i32
      %196 = llvm.sub %152, %191 : i32
      %197 = nvvm.shfl.sync bfly %195, %190, %15, %196 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %198 = llvm.extractvalue %197[0] : !llvm.struct<(f32, i1)> 
      %199 = llvm.extractvalue %197[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %199, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %200 = llvm.fadd %190, %198 : f32
      llvm.br ^bb35(%200 : f32)
    ^bb34:  // pred: ^bb32
      llvm.br ^bb35(%190 : f32)
    ^bb35(%201: f32):  // 2 preds: ^bb33, ^bb34
      %202 = llvm.mlir.constant(1 : i32) : i32
      %203 = llvm.mlir.constant(-1 : i32) : i32
      %204 = llvm.mlir.constant(32 : i32) : i32
      %205 = llvm.sub %204, %152 : i32
      %206 = llvm.lshr %203, %205 : i32
      %207 = llvm.sub %152, %202 : i32
      %208 = nvvm.shfl.sync bfly %206, %201, %14, %207 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %209 = llvm.extractvalue %208[0] : !llvm.struct<(f32, i1)> 
      %210 = llvm.extractvalue %208[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %210, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %211 = llvm.fadd %201, %209 : f32
      llvm.br ^bb38(%211 : f32)
    ^bb37:  // pred: ^bb35
      llvm.br ^bb38(%201 : f32)
    ^bb38(%212: f32):  // 2 preds: ^bb36, ^bb37
      llvm.br ^bb40(%212 : f32)
    ^bb39:  // pred: ^bb22
      %213 = llvm.mlir.constant(1 : i32) : i32
      %214 = llvm.mlir.constant(-1 : i32) : i32
      %215 = llvm.mlir.constant(32 : i32) : i32
      %216 = llvm.sub %215, %19 : i32
      %217 = llvm.lshr %214, %216 : i32
      %218 = llvm.sub %19, %213 : i32
      %219 = nvvm.shfl.sync bfly %217, %156, %18, %218 : f32 -> f32
      %220 = llvm.fadd %156, %219 : f32
      %221 = llvm.mlir.constant(1 : i32) : i32
      %222 = llvm.mlir.constant(-1 : i32) : i32
      %223 = llvm.mlir.constant(32 : i32) : i32
      %224 = llvm.sub %223, %19 : i32
      %225 = llvm.lshr %222, %224 : i32
      %226 = llvm.sub %19, %221 : i32
      %227 = nvvm.shfl.sync bfly %225, %220, %17, %226 : f32 -> f32
      %228 = llvm.fadd %220, %227 : f32
      %229 = llvm.mlir.constant(1 : i32) : i32
      %230 = llvm.mlir.constant(-1 : i32) : i32
      %231 = llvm.mlir.constant(32 : i32) : i32
      %232 = llvm.sub %231, %19 : i32
      %233 = llvm.lshr %230, %232 : i32
      %234 = llvm.sub %19, %229 : i32
      %235 = nvvm.shfl.sync bfly %233, %228, %16, %234 : f32 -> f32
      %236 = llvm.fadd %228, %235 : f32
      %237 = llvm.mlir.constant(1 : i32) : i32
      %238 = llvm.mlir.constant(-1 : i32) : i32
      %239 = llvm.mlir.constant(32 : i32) : i32
      %240 = llvm.sub %239, %19 : i32
      %241 = llvm.lshr %238, %240 : i32
      %242 = llvm.sub %19, %237 : i32
      %243 = nvvm.shfl.sync bfly %241, %236, %15, %242 : f32 -> f32
      %244 = llvm.fadd %236, %243 : f32
      %245 = llvm.mlir.constant(1 : i32) : i32
      %246 = llvm.mlir.constant(-1 : i32) : i32
      %247 = llvm.mlir.constant(32 : i32) : i32
      %248 = llvm.sub %247, %19 : i32
      %249 = llvm.lshr %246, %248 : i32
      %250 = llvm.sub %19, %245 : i32
      %251 = nvvm.shfl.sync bfly %249, %244, %14, %250 : f32 -> f32
      %252 = llvm.fadd %244, %251 : f32
      llvm.br ^bb40(%252 : f32)
    ^bb40(%253: f32):  // 2 preds: ^bb38, ^bb39
      memref.store %253, %11[%13] : memref<32xf32, #gpu.address_space<workgroup>>
      llvm.br ^bb42
    ^bb41:  // pred: ^bb21
      llvm.br ^bb42
    ^bb42:  // 2 preds: ^bb40, ^bb41
      nvvm.barrier
      llvm.return
    }
  }
  gpu.module @test_module_3 {
    llvm.mlir.global internal @__wg_gpu_all_reduce_region_0() {addr_space = 3 : i32} : !llvm.array<32 x i32>
    llvm.func @gpu_all_reduce_region() {
      %0 = llvm.mlir.addressof @__wg_gpu_all_reduce_region_0 : !llvm.ptr<3>
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, !llvm.array<32 x i32>
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.mlir.constant(0 : index) : i64
      %6 = llvm.insertvalue %5, %4[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %7 = llvm.mlir.constant(32 : index) : i64
      %8 = llvm.insertvalue %7, %6[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %9 = llvm.mlir.constant(1 : index) : i64
      %10 = llvm.insertvalue %9, %8[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %11 = builtin.unrealized_conversion_cast %10 : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> to memref<32xi32, #gpu.address_space<workgroup>>
      %12 = llvm.mlir.constant(0 : index) : i64
      %13 = builtin.unrealized_conversion_cast %12 : i64 to index
      %14 = llvm.mlir.constant(16 : i32) : i32
      %15 = llvm.mlir.constant(8 : i32) : i32
      %16 = llvm.mlir.constant(4 : i32) : i32
      %17 = llvm.mlir.constant(2 : i32) : i32
      %18 = llvm.mlir.constant(32 : i32) : i32
      %19 = llvm.mlir.constant(0 : i32) : i32
      %20 = llvm.mlir.constant(31 : i32) : i32
      %21 = llvm.mlir.constant(1 : i32) : i32
      %22 = nvvm.read.ptx.sreg.ntid.x : i32
      %23 = llvm.sext %22 : i32 to i64
      %24 = llvm.trunc %23 : i64 to i32
      %25 = nvvm.read.ptx.sreg.ntid.y : i32
      %26 = llvm.sext %25 : i32 to i64
      %27 = llvm.trunc %26 : i64 to i32
      %28 = nvvm.read.ptx.sreg.ntid.z : i32
      %29 = llvm.sext %28 : i32 to i64
      %30 = llvm.trunc %29 : i64 to i32
      %31 = nvvm.read.ptx.sreg.tid.x : i32
      %32 = llvm.sext %31 : i32 to i64
      %33 = llvm.trunc %32 : i64 to i32
      %34 = nvvm.read.ptx.sreg.tid.y : i32
      %35 = llvm.sext %34 : i32 to i64
      %36 = llvm.trunc %35 : i64 to i32
      %37 = nvvm.read.ptx.sreg.tid.z : i32
      %38 = llvm.sext %37 : i32 to i64
      %39 = llvm.trunc %38 : i64 to i32
      %40 = llvm.mul %39, %27 : i32
      %41 = llvm.add %40, %36 : i32
      %42 = llvm.mul %41, %24 : i32
      %43 = llvm.mul %24, %27 : i32
      %44 = llvm.add %42, %33 : i32
      %45 = llvm.mul %43, %30 : i32
      %46 = llvm.and %44, %20 : i32
      %47 = llvm.icmp "eq" %46, %19 : i32
      %48 = llvm.sub %44, %46 : i32
      %49 = llvm.sub %45, %48 : i32
      %50 = llvm.icmp "slt" %49, %18 : i32
      llvm.cond_br %50, ^bb1, ^bb22
    ^bb1:  // pred: ^bb0
      %51 = llvm.mlir.constant(1 : i32) : i32
      %52 = llvm.mlir.constant(-1 : i32) : i32
      %53 = llvm.mlir.constant(32 : i32) : i32
      %54 = llvm.sub %53, %49 : i32
      %55 = llvm.lshr %52, %54 : i32
      %56 = llvm.sub %49, %51 : i32
      %57 = nvvm.shfl.sync bfly %55, %21, %21, %56 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %58 = llvm.extractvalue %57[0] : !llvm.struct<(i32, i1)> 
      %59 = llvm.extractvalue %57[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %59, ^bb2, ^bb4(%21 : i32)
    ^bb2:  // pred: ^bb1
      llvm.br ^bb3
    ^bb3:  // pred: ^bb2
      %60 = llvm.xor %58, %21 : i32
      llvm.br ^bb4(%60 : i32)
    ^bb4(%61: i32):  // 2 preds: ^bb1, ^bb3
      llvm.br ^bb5
    ^bb5:  // pred: ^bb4
      %62 = llvm.mlir.constant(1 : i32) : i32
      %63 = llvm.mlir.constant(-1 : i32) : i32
      %64 = llvm.mlir.constant(32 : i32) : i32
      %65 = llvm.sub %64, %49 : i32
      %66 = llvm.lshr %63, %65 : i32
      %67 = llvm.sub %49, %62 : i32
      %68 = nvvm.shfl.sync bfly %66, %61, %17, %67 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %69 = llvm.extractvalue %68[0] : !llvm.struct<(i32, i1)> 
      %70 = llvm.extractvalue %68[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %70, ^bb6, ^bb8(%61 : i32)
    ^bb6:  // pred: ^bb5
      llvm.br ^bb7
    ^bb7:  // pred: ^bb6
      %71 = llvm.xor %61, %69 : i32
      llvm.br ^bb8(%71 : i32)
    ^bb8(%72: i32):  // 2 preds: ^bb5, ^bb7
      llvm.br ^bb9
    ^bb9:  // pred: ^bb8
      %73 = llvm.mlir.constant(1 : i32) : i32
      %74 = llvm.mlir.constant(-1 : i32) : i32
      %75 = llvm.mlir.constant(32 : i32) : i32
      %76 = llvm.sub %75, %49 : i32
      %77 = llvm.lshr %74, %76 : i32
      %78 = llvm.sub %49, %73 : i32
      %79 = nvvm.shfl.sync bfly %77, %72, %16, %78 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %80 = llvm.extractvalue %79[0] : !llvm.struct<(i32, i1)> 
      %81 = llvm.extractvalue %79[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %81, ^bb10, ^bb12(%72 : i32)
    ^bb10:  // pred: ^bb9
      llvm.br ^bb11
    ^bb11:  // pred: ^bb10
      %82 = llvm.xor %72, %80 : i32
      llvm.br ^bb12(%82 : i32)
    ^bb12(%83: i32):  // 2 preds: ^bb9, ^bb11
      llvm.br ^bb13
    ^bb13:  // pred: ^bb12
      %84 = llvm.mlir.constant(1 : i32) : i32
      %85 = llvm.mlir.constant(-1 : i32) : i32
      %86 = llvm.mlir.constant(32 : i32) : i32
      %87 = llvm.sub %86, %49 : i32
      %88 = llvm.lshr %85, %87 : i32
      %89 = llvm.sub %49, %84 : i32
      %90 = nvvm.shfl.sync bfly %88, %83, %15, %89 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %91 = llvm.extractvalue %90[0] : !llvm.struct<(i32, i1)> 
      %92 = llvm.extractvalue %90[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %92, ^bb14, ^bb16(%83 : i32)
    ^bb14:  // pred: ^bb13
      llvm.br ^bb15
    ^bb15:  // pred: ^bb14
      %93 = llvm.xor %83, %91 : i32
      llvm.br ^bb16(%93 : i32)
    ^bb16(%94: i32):  // 2 preds: ^bb13, ^bb15
      llvm.br ^bb17
    ^bb17:  // pred: ^bb16
      %95 = llvm.mlir.constant(1 : i32) : i32
      %96 = llvm.mlir.constant(-1 : i32) : i32
      %97 = llvm.mlir.constant(32 : i32) : i32
      %98 = llvm.sub %97, %49 : i32
      %99 = llvm.lshr %96, %98 : i32
      %100 = llvm.sub %49, %95 : i32
      %101 = nvvm.shfl.sync bfly %99, %94, %14, %100 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %102 = llvm.extractvalue %101[0] : !llvm.struct<(i32, i1)> 
      %103 = llvm.extractvalue %101[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %103, ^bb18, ^bb20(%94 : i32)
    ^bb18:  // pred: ^bb17
      llvm.br ^bb19
    ^bb19:  // pred: ^bb18
      %104 = llvm.xor %94, %102 : i32
      llvm.br ^bb20(%104 : i32)
    ^bb20(%105: i32):  // 2 preds: ^bb17, ^bb19
      llvm.br ^bb21(%105 : i32)
    ^bb21(%106: i32):  // 2 preds: ^bb20, ^bb31
      llvm.br ^bb32
    ^bb22:  // pred: ^bb0
      %107 = llvm.mlir.constant(1 : i32) : i32
      %108 = llvm.mlir.constant(-1 : i32) : i32
      %109 = llvm.mlir.constant(32 : i32) : i32
      %110 = llvm.sub %109, %18 : i32
      %111 = llvm.lshr %108, %110 : i32
      %112 = llvm.sub %18, %107 : i32
      %113 = nvvm.shfl.sync bfly %111, %21, %21, %112 : i32 -> i32
      llvm.br ^bb23
    ^bb23:  // pred: ^bb22
      %114 = llvm.xor %113, %21 : i32
      llvm.br ^bb24
    ^bb24:  // pred: ^bb23
      %115 = llvm.mlir.constant(1 : i32) : i32
      %116 = llvm.mlir.constant(-1 : i32) : i32
      %117 = llvm.mlir.constant(32 : i32) : i32
      %118 = llvm.sub %117, %18 : i32
      %119 = llvm.lshr %116, %118 : i32
      %120 = llvm.sub %18, %115 : i32
      %121 = nvvm.shfl.sync bfly %119, %114, %17, %120 : i32 -> i32
      llvm.br ^bb25
    ^bb25:  // pred: ^bb24
      %122 = llvm.xor %114, %121 : i32
      llvm.br ^bb26
    ^bb26:  // pred: ^bb25
      %123 = llvm.mlir.constant(1 : i32) : i32
      %124 = llvm.mlir.constant(-1 : i32) : i32
      %125 = llvm.mlir.constant(32 : i32) : i32
      %126 = llvm.sub %125, %18 : i32
      %127 = llvm.lshr %124, %126 : i32
      %128 = llvm.sub %18, %123 : i32
      %129 = nvvm.shfl.sync bfly %127, %122, %16, %128 : i32 -> i32
      llvm.br ^bb27
    ^bb27:  // pred: ^bb26
      %130 = llvm.xor %122, %129 : i32
      llvm.br ^bb28
    ^bb28:  // pred: ^bb27
      %131 = llvm.mlir.constant(1 : i32) : i32
      %132 = llvm.mlir.constant(-1 : i32) : i32
      %133 = llvm.mlir.constant(32 : i32) : i32
      %134 = llvm.sub %133, %18 : i32
      %135 = llvm.lshr %132, %134 : i32
      %136 = llvm.sub %18, %131 : i32
      %137 = nvvm.shfl.sync bfly %135, %130, %15, %136 : i32 -> i32
      llvm.br ^bb29
    ^bb29:  // pred: ^bb28
      %138 = llvm.xor %130, %137 : i32
      llvm.br ^bb30
    ^bb30:  // pred: ^bb29
      %139 = llvm.mlir.constant(1 : i32) : i32
      %140 = llvm.mlir.constant(-1 : i32) : i32
      %141 = llvm.mlir.constant(32 : i32) : i32
      %142 = llvm.sub %141, %18 : i32
      %143 = llvm.lshr %140, %142 : i32
      %144 = llvm.sub %18, %139 : i32
      %145 = nvvm.shfl.sync bfly %143, %138, %14, %144 : i32 -> i32
      llvm.br ^bb31
    ^bb31:  // pred: ^bb30
      %146 = llvm.xor %138, %145 : i32
      llvm.br ^bb21(%146 : i32)
    ^bb32:  // pred: ^bb21
      llvm.cond_br %47, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %147 = llvm.sdiv %44, %18 : i32
      %148 = llvm.sext %147 : i32 to i64
      %149 = builtin.unrealized_conversion_cast %148 : i64 to index
      memref.store %106, %11[%149] : memref<32xi32, #gpu.address_space<workgroup>>
      llvm.br ^bb35
    ^bb34:  // pred: ^bb32
      llvm.br ^bb35
    ^bb35:  // 2 preds: ^bb33, ^bb34
      nvvm.barrier
      %150 = llvm.add %45, %20 : i32
      %151 = llvm.sdiv %150, %18 : i32
      %152 = llvm.icmp "slt" %44, %151 : i32
      llvm.cond_br %152, ^bb36, ^bb69
    ^bb36:  // pred: ^bb35
      %153 = llvm.sext %44 : i32 to i64
      %154 = builtin.unrealized_conversion_cast %153 : i64 to index
      %155 = memref.load %11[%154] : memref<32xi32, #gpu.address_space<workgroup>>
      %156 = llvm.icmp "slt" %151, %18 : i32
      llvm.cond_br %156, ^bb37, ^bb58
    ^bb37:  // pred: ^bb36
      %157 = llvm.mlir.constant(1 : i32) : i32
      %158 = llvm.mlir.constant(-1 : i32) : i32
      %159 = llvm.mlir.constant(32 : i32) : i32
      %160 = llvm.sub %159, %151 : i32
      %161 = llvm.lshr %158, %160 : i32
      %162 = llvm.sub %151, %157 : i32
      %163 = nvvm.shfl.sync bfly %161, %155, %21, %162 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %164 = llvm.extractvalue %163[0] : !llvm.struct<(i32, i1)> 
      %165 = llvm.extractvalue %163[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %165, ^bb38, ^bb40(%155 : i32)
    ^bb38:  // pred: ^bb37
      llvm.br ^bb39
    ^bb39:  // pred: ^bb38
      %166 = llvm.xor %155, %164 : i32
      llvm.br ^bb40(%166 : i32)
    ^bb40(%167: i32):  // 2 preds: ^bb37, ^bb39
      llvm.br ^bb41
    ^bb41:  // pred: ^bb40
      %168 = llvm.mlir.constant(1 : i32) : i32
      %169 = llvm.mlir.constant(-1 : i32) : i32
      %170 = llvm.mlir.constant(32 : i32) : i32
      %171 = llvm.sub %170, %151 : i32
      %172 = llvm.lshr %169, %171 : i32
      %173 = llvm.sub %151, %168 : i32
      %174 = nvvm.shfl.sync bfly %172, %167, %17, %173 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %175 = llvm.extractvalue %174[0] : !llvm.struct<(i32, i1)> 
      %176 = llvm.extractvalue %174[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %176, ^bb42, ^bb44(%167 : i32)
    ^bb42:  // pred: ^bb41
      llvm.br ^bb43
    ^bb43:  // pred: ^bb42
      %177 = llvm.xor %167, %175 : i32
      llvm.br ^bb44(%177 : i32)
    ^bb44(%178: i32):  // 2 preds: ^bb41, ^bb43
      llvm.br ^bb45
    ^bb45:  // pred: ^bb44
      %179 = llvm.mlir.constant(1 : i32) : i32
      %180 = llvm.mlir.constant(-1 : i32) : i32
      %181 = llvm.mlir.constant(32 : i32) : i32
      %182 = llvm.sub %181, %151 : i32
      %183 = llvm.lshr %180, %182 : i32
      %184 = llvm.sub %151, %179 : i32
      %185 = nvvm.shfl.sync bfly %183, %178, %16, %184 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %186 = llvm.extractvalue %185[0] : !llvm.struct<(i32, i1)> 
      %187 = llvm.extractvalue %185[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %187, ^bb46, ^bb48(%178 : i32)
    ^bb46:  // pred: ^bb45
      llvm.br ^bb47
    ^bb47:  // pred: ^bb46
      %188 = llvm.xor %178, %186 : i32
      llvm.br ^bb48(%188 : i32)
    ^bb48(%189: i32):  // 2 preds: ^bb45, ^bb47
      llvm.br ^bb49
    ^bb49:  // pred: ^bb48
      %190 = llvm.mlir.constant(1 : i32) : i32
      %191 = llvm.mlir.constant(-1 : i32) : i32
      %192 = llvm.mlir.constant(32 : i32) : i32
      %193 = llvm.sub %192, %151 : i32
      %194 = llvm.lshr %191, %193 : i32
      %195 = llvm.sub %151, %190 : i32
      %196 = nvvm.shfl.sync bfly %194, %189, %15, %195 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %197 = llvm.extractvalue %196[0] : !llvm.struct<(i32, i1)> 
      %198 = llvm.extractvalue %196[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %198, ^bb50, ^bb52(%189 : i32)
    ^bb50:  // pred: ^bb49
      llvm.br ^bb51
    ^bb51:  // pred: ^bb50
      %199 = llvm.xor %189, %197 : i32
      llvm.br ^bb52(%199 : i32)
    ^bb52(%200: i32):  // 2 preds: ^bb49, ^bb51
      llvm.br ^bb53
    ^bb53:  // pred: ^bb52
      %201 = llvm.mlir.constant(1 : i32) : i32
      %202 = llvm.mlir.constant(-1 : i32) : i32
      %203 = llvm.mlir.constant(32 : i32) : i32
      %204 = llvm.sub %203, %151 : i32
      %205 = llvm.lshr %202, %204 : i32
      %206 = llvm.sub %151, %201 : i32
      %207 = nvvm.shfl.sync bfly %205, %200, %14, %206 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %208 = llvm.extractvalue %207[0] : !llvm.struct<(i32, i1)> 
      %209 = llvm.extractvalue %207[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %209, ^bb54, ^bb56(%200 : i32)
    ^bb54:  // pred: ^bb53
      llvm.br ^bb55
    ^bb55:  // pred: ^bb54
      %210 = llvm.xor %200, %208 : i32
      llvm.br ^bb56(%210 : i32)
    ^bb56(%211: i32):  // 2 preds: ^bb53, ^bb55
      llvm.br ^bb57(%211 : i32)
    ^bb57(%212: i32):  // 2 preds: ^bb56, ^bb67
      llvm.br ^bb68
    ^bb58:  // pred: ^bb36
      %213 = llvm.mlir.constant(1 : i32) : i32
      %214 = llvm.mlir.constant(-1 : i32) : i32
      %215 = llvm.mlir.constant(32 : i32) : i32
      %216 = llvm.sub %215, %18 : i32
      %217 = llvm.lshr %214, %216 : i32
      %218 = llvm.sub %18, %213 : i32
      %219 = nvvm.shfl.sync bfly %217, %155, %21, %218 : i32 -> i32
      llvm.br ^bb59
    ^bb59:  // pred: ^bb58
      %220 = llvm.xor %155, %219 : i32
      llvm.br ^bb60
    ^bb60:  // pred: ^bb59
      %221 = llvm.mlir.constant(1 : i32) : i32
      %222 = llvm.mlir.constant(-1 : i32) : i32
      %223 = llvm.mlir.constant(32 : i32) : i32
      %224 = llvm.sub %223, %18 : i32
      %225 = llvm.lshr %222, %224 : i32
      %226 = llvm.sub %18, %221 : i32
      %227 = nvvm.shfl.sync bfly %225, %220, %17, %226 : i32 -> i32
      llvm.br ^bb61
    ^bb61:  // pred: ^bb60
      %228 = llvm.xor %220, %227 : i32
      llvm.br ^bb62
    ^bb62:  // pred: ^bb61
      %229 = llvm.mlir.constant(1 : i32) : i32
      %230 = llvm.mlir.constant(-1 : i32) : i32
      %231 = llvm.mlir.constant(32 : i32) : i32
      %232 = llvm.sub %231, %18 : i32
      %233 = llvm.lshr %230, %232 : i32
      %234 = llvm.sub %18, %229 : i32
      %235 = nvvm.shfl.sync bfly %233, %228, %16, %234 : i32 -> i32
      llvm.br ^bb63
    ^bb63:  // pred: ^bb62
      %236 = llvm.xor %228, %235 : i32
      llvm.br ^bb64
    ^bb64:  // pred: ^bb63
      %237 = llvm.mlir.constant(1 : i32) : i32
      %238 = llvm.mlir.constant(-1 : i32) : i32
      %239 = llvm.mlir.constant(32 : i32) : i32
      %240 = llvm.sub %239, %18 : i32
      %241 = llvm.lshr %238, %240 : i32
      %242 = llvm.sub %18, %237 : i32
      %243 = nvvm.shfl.sync bfly %241, %236, %15, %242 : i32 -> i32
      llvm.br ^bb65
    ^bb65:  // pred: ^bb64
      %244 = llvm.xor %236, %243 : i32
      llvm.br ^bb66
    ^bb66:  // pred: ^bb65
      %245 = llvm.mlir.constant(1 : i32) : i32
      %246 = llvm.mlir.constant(-1 : i32) : i32
      %247 = llvm.mlir.constant(32 : i32) : i32
      %248 = llvm.sub %247, %18 : i32
      %249 = llvm.lshr %246, %248 : i32
      %250 = llvm.sub %18, %245 : i32
      %251 = nvvm.shfl.sync bfly %249, %244, %14, %250 : i32 -> i32
      llvm.br ^bb67
    ^bb67:  // pred: ^bb66
      %252 = llvm.xor %244, %251 : i32
      llvm.br ^bb57(%252 : i32)
    ^bb68:  // pred: ^bb57
      memref.store %212, %11[%13] : memref<32xi32, #gpu.address_space<workgroup>>
      llvm.br ^bb70
    ^bb69:  // pred: ^bb35
      llvm.br ^bb70
    ^bb70:  // 2 preds: ^bb68, ^bb69
      nvvm.barrier
      llvm.return
    }
  }
  gpu.module @test_module_4 {
    llvm.func @gpu_shuffle() -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)> {
      %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
      %1 = llvm.mlir.constant(4 : i32) : i32
      %2 = llvm.mlir.constant(23 : i32) : i32
      %3 = llvm.mlir.constant(1 : i32) : i32
      %4 = llvm.mlir.constant(-1 : i32) : i32
      %5 = llvm.mlir.constant(32 : i32) : i32
      %6 = llvm.sub %5, %2 : i32
      %7 = llvm.lshr %4, %6 : i32
      %8 = llvm.sub %2, %3 : i32
      %9 = nvvm.shfl.sync bfly %7, %0, %1, %8 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %10 = llvm.extractvalue %9[0] : !llvm.struct<(f32, i1)> 
      %11 = llvm.extractvalue %9[1] : !llvm.struct<(f32, i1)> 
      %12 = llvm.mlir.constant(1 : i32) : i32
      %13 = llvm.mlir.constant(-1 : i32) : i32
      %14 = llvm.mlir.constant(32 : i32) : i32
      %15 = llvm.sub %14, %2 : i32
      %16 = llvm.lshr %13, %15 : i32
      %17 = nvvm.shfl.sync up %16, %0, %1, %15 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %18 = llvm.extractvalue %17[0] : !llvm.struct<(f32, i1)> 
      %19 = llvm.extractvalue %17[1] : !llvm.struct<(f32, i1)> 
      %20 = llvm.mlir.constant(1 : i32) : i32
      %21 = llvm.mlir.constant(-1 : i32) : i32
      %22 = llvm.mlir.constant(32 : i32) : i32
      %23 = llvm.sub %22, %2 : i32
      %24 = llvm.lshr %21, %23 : i32
      %25 = llvm.sub %2, %20 : i32
      %26 = nvvm.shfl.sync down %24, %0, %1, %25 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %27 = llvm.extractvalue %26[0] : !llvm.struct<(f32, i1)> 
      %28 = llvm.extractvalue %26[1] : !llvm.struct<(f32, i1)> 
      %29 = llvm.mlir.constant(1 : i32) : i32
      %30 = llvm.mlir.constant(-1 : i32) : i32
      %31 = llvm.mlir.constant(32 : i32) : i32
      %32 = llvm.sub %31, %2 : i32
      %33 = llvm.lshr %30, %32 : i32
      %34 = llvm.sub %2, %29 : i32
      %35 = nvvm.shfl.sync idx %33, %0, %1, %34 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %36 = llvm.extractvalue %35[0] : !llvm.struct<(f32, i1)> 
      %37 = llvm.extractvalue %35[1] : !llvm.struct<(f32, i1)> 
      %38 = llvm.mlir.poison : !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
      %39 = llvm.insertvalue %10, %38[0] : !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)> 
      %40 = llvm.insertvalue %18, %39[1] : !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)> 
      %41 = llvm.insertvalue %27, %40[2] : !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)> 
      %42 = llvm.insertvalue %36, %41[3] : !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)> 
      %43 = llvm.insertvalue %11, %42[4] : !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)> 
      %44 = llvm.insertvalue %19, %43[5] : !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)> 
      %45 = llvm.insertvalue %28, %44[6] : !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)> 
      %46 = llvm.insertvalue %37, %45[7] : !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)> 
      llvm.return %46 : !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)>
    }
    llvm.func @gpu_shuffle_unused_pred() -> !llvm.struct<(f32, f32, f32, f32)> {
      %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
      %1 = llvm.mlir.constant(4 : i32) : i32
      %2 = llvm.mlir.constant(23 : i32) : i32
      %3 = llvm.mlir.constant(1 : i32) : i32
      %4 = llvm.mlir.constant(-1 : i32) : i32
      %5 = llvm.mlir.constant(32 : i32) : i32
      %6 = llvm.sub %5, %2 : i32
      %7 = llvm.lshr %4, %6 : i32
      %8 = llvm.sub %2, %3 : i32
      %9 = nvvm.shfl.sync bfly %7, %0, %1, %8 : f32 -> f32
      %10 = llvm.mlir.constant(1 : i32) : i32
      %11 = llvm.mlir.constant(-1 : i32) : i32
      %12 = llvm.mlir.constant(32 : i32) : i32
      %13 = llvm.sub %12, %2 : i32
      %14 = llvm.lshr %11, %13 : i32
      %15 = nvvm.shfl.sync up %14, %0, %1, %13 : f32 -> f32
      %16 = llvm.mlir.constant(1 : i32) : i32
      %17 = llvm.mlir.constant(-1 : i32) : i32
      %18 = llvm.mlir.constant(32 : i32) : i32
      %19 = llvm.sub %18, %2 : i32
      %20 = llvm.lshr %17, %19 : i32
      %21 = llvm.sub %2, %16 : i32
      %22 = nvvm.shfl.sync down %20, %0, %1, %21 : f32 -> f32
      %23 = llvm.mlir.constant(1 : i32) : i32
      %24 = llvm.mlir.constant(-1 : i32) : i32
      %25 = llvm.mlir.constant(32 : i32) : i32
      %26 = llvm.sub %25, %2 : i32
      %27 = llvm.lshr %24, %26 : i32
      %28 = llvm.sub %2, %23 : i32
      %29 = nvvm.shfl.sync idx %27, %0, %1, %28 : f32 -> f32
      %30 = llvm.mlir.poison : !llvm.struct<(f32, f32, f32, f32)>
      %31 = llvm.insertvalue %9, %30[0] : !llvm.struct<(f32, f32, f32, f32)> 
      %32 = llvm.insertvalue %15, %31[1] : !llvm.struct<(f32, f32, f32, f32)> 
      %33 = llvm.insertvalue %22, %32[2] : !llvm.struct<(f32, f32, f32, f32)> 
      %34 = llvm.insertvalue %29, %33[3] : !llvm.struct<(f32, f32, f32, f32)> 
      llvm.return %34 : !llvm.struct<(f32, f32, f32, f32)>
    }
  }
  gpu.module @test_module_5 {
    llvm.func @gpu_sync() {
      nvvm.barrier
      llvm.return
    }
    llvm.func @gpu_sync_subgroup() {
      %0 = llvm.mlir.constant(-1 : i32) : i32
      nvvm.bar.warp.sync %0 : i32
      llvm.return
    }
    llvm.func @gpu_named_barriers(%arg0: i32) {
      %0 = llvm.mlir.constant(2 : i32) : i32
      %1 = llvm.mlir.addressof @__named_barrier_id : !llvm.ptr
      %2 = llvm.load %1 : !llvm.ptr -> i32
      %3 = llvm.mlir.constant(32 : i32) : i32
      %4 = llvm.mul %arg0, %3 : i32
      %5 = llvm.mlir.poison : !llvm.struct<(i32, i32)>
      %6 = llvm.insertvalue %2, %5[0] : !llvm.struct<(i32, i32)> 
      %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<(i32, i32)> 
      %8 = llvm.mlir.addressof @__named_barrier_id_0 : !llvm.ptr
      %9 = llvm.load %8 : !llvm.ptr -> i32
      %10 = llvm.mlir.constant(32 : i32) : i32
      %11 = llvm.mul %0, %10 : i32
      %12 = llvm.mlir.poison : !llvm.struct<(i32, i32)>
      %13 = llvm.insertvalue %9, %12[0] : !llvm.struct<(i32, i32)> 
      %14 = llvm.insertvalue %11, %13[1] : !llvm.struct<(i32, i32)> 
      %15 = llvm.extractvalue %7[0] : !llvm.struct<(i32, i32)> 
      %16 = llvm.extractvalue %7[1] : !llvm.struct<(i32, i32)> 
      nvvm.barrier id = %15 number_of_threads = %16
      %17 = llvm.extractvalue %14[0] : !llvm.struct<(i32, i32)> 
      %18 = llvm.extractvalue %14[1] : !llvm.struct<(i32, i32)> 
      nvvm.barrier id = %17 number_of_threads = %18
      llvm.return
    }
    llvm.func @gpu_named_barrier_arg(%arg0: !llvm.struct<(i32, i32)>) {
      %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
      %1 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
      nvvm.barrier id = %0 number_of_threads = %1
      llvm.return
    }
    llvm.mlir.global internal constant @__named_barrier_id(1 : i32) {addr_space = 0 : i32} : i32
    llvm.mlir.global internal constant @__named_barrier_id_0(2 : i32) {addr_space = 0 : i32} : i32
  }
  gpu.module @test_module_6 {
    llvm.func @__nv_fabsf(f32) -> f32
    llvm.func @__nv_fabs(f64) -> f64
    llvm.func @gpu_fabs(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_fabsf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_fabs(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_7 {
    llvm.func @__nv_cbrtf(f32) -> f32
    llvm.func @__nv_cbrt(f64) -> f64
    llvm.func @gpu_cbrt(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_cbrtf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_cbrt(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_8 {
    llvm.func @__nv_ceilf(f32) -> f32
    llvm.func @__nv_ceil(f64) -> f64
    llvm.func @gpu_ceil(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_ceilf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_ceil(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_9 {
    llvm.func @__nv_floorf(f32) -> f32
    llvm.func @__nv_floor(f64) -> f64
    llvm.func @gpu_floor(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_floorf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_floor(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_10 {
    llvm.func @__nv_cosf(f32) -> f32
    llvm.func @__nv_cos(f64) -> f64
    llvm.func @__nv_fast_cosf(f32) -> f32
    llvm.func @gpu_cos(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> {
      %0 = llvm.call @__nv_cosf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_cos(%arg1) : (f64) -> f64
      %2 = llvm.call @__nv_fast_cosf(%arg0) : (f32) -> f32
      %3 = llvm.mlir.poison : !llvm.struct<(f32, f64, f32)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f32, f64, f32)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f32, f64, f32)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f32, f64, f32)> 
      llvm.return %6 : !llvm.struct<(f32, f64, f32)>
    }
  }
  gpu.module @test_module_11 {
    llvm.func @__nv_expf(f32) -> f32
    llvm.func @__nv_exp(f64) -> f64
    llvm.func @__nv_fast_expf(f32) -> f32
    llvm.func @gpu_exp(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> {
      %0 = llvm.call @__nv_expf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_exp(%arg1) : (f64) -> f64
      %2 = llvm.call @__nv_fast_expf(%arg0) : (f32) -> f32
      %3 = llvm.mlir.poison : !llvm.struct<(f32, f64, f32)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f32, f64, f32)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f32, f64, f32)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f32, f64, f32)> 
      llvm.return %6 : !llvm.struct<(f32, f64, f32)>
    }
  }
  gpu.module @test_module_12 {
    llvm.func @__nv_exp2f(f32) -> f32
    llvm.func @__nv_exp2(f64) -> f64
    llvm.func @gpu_exp2(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_exp2f(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_exp2(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_13 {
    llvm.func @__nv_logf(f32) -> f32
    llvm.func @__nv_log(f64) -> f64
    llvm.func @__nv_fast_logf(f32) -> f32
    llvm.func @gpu_log(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> {
      %0 = llvm.call @__nv_logf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_log(%arg1) : (f64) -> f64
      %2 = llvm.call @__nv_fast_logf(%arg0) : (f32) -> f32
      %3 = llvm.mlir.poison : !llvm.struct<(f32, f64, f32)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f32, f64, f32)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f32, f64, f32)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f32, f64, f32)> 
      llvm.return %6 : !llvm.struct<(f32, f64, f32)>
    }
  }
  gpu.module @test_module_14 {
    llvm.func @__nv_log10f(f32) -> f32
    llvm.func @__nv_log10(f64) -> f64
    llvm.func @__nv_fast_log10f(f32) -> f32
    llvm.func @gpu_log10(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> {
      %0 = llvm.call @__nv_log10f(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_log10(%arg1) : (f64) -> f64
      %2 = llvm.call @__nv_fast_log10f(%arg0) : (f32) -> f32
      %3 = llvm.mlir.poison : !llvm.struct<(f32, f64, f32)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f32, f64, f32)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f32, f64, f32)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f32, f64, f32)> 
      llvm.return %6 : !llvm.struct<(f32, f64, f32)>
    }
  }
  gpu.module @test_module_15 {
    llvm.func @__nv_log1pf(f32) -> f32
    llvm.func @__nv_log1p(f64) -> f64
    llvm.func @gpu_log1p(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_log1pf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_log1p(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_16 {
    llvm.func @__nv_log2f(f32) -> f32
    llvm.func @__nv_log2(f64) -> f64
    llvm.func @__nv_fast_log2f(f32) -> f32
    llvm.func @gpu_log2(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> {
      %0 = llvm.call @__nv_log2f(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_log2(%arg1) : (f64) -> f64
      %2 = llvm.call @__nv_fast_log2f(%arg0) : (f32) -> f32
      %3 = llvm.mlir.poison : !llvm.struct<(f32, f64, f32)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f32, f64, f32)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f32, f64, f32)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f32, f64, f32)> 
      llvm.return %6 : !llvm.struct<(f32, f64, f32)>
    }
  }
  gpu.module @test_module_17 {
    llvm.func @__nv_sinf(f32) -> f32
    llvm.func @__nv_sin(f64) -> f64
    llvm.func @__nv_fast_sinf(f32) -> f32
    llvm.func @gpu_sin(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> {
      %0 = llvm.call @__nv_sinf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_sin(%arg1) : (f64) -> f64
      %2 = llvm.call @__nv_fast_sinf(%arg0) : (f32) -> f32
      %3 = llvm.mlir.poison : !llvm.struct<(f32, f64, f32)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f32, f64, f32)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f32, f64, f32)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f32, f64, f32)> 
      llvm.return %6 : !llvm.struct<(f32, f64, f32)>
    }
  }
  gpu.module @test_module_18 {
    llvm.func @__nv_tanf(f32) -> f32
    llvm.func @__nv_tan(f64) -> f64
    llvm.func @__nv_fast_tanf(f32) -> f32
    llvm.func @gpu_tan(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64, f32)> {
      %0 = llvm.fpext %arg0 : f16 to f32
      %1 = llvm.call @__nv_tanf(%0) : (f32) -> f32
      %2 = llvm.fptrunc %1 : f32 to f16
      %3 = llvm.call @__nv_tanf(%arg1) : (f32) -> f32
      %4 = llvm.call @__nv_tan(%arg2) : (f64) -> f64
      %5 = llvm.call @__nv_fast_tanf(%arg1) : (f32) -> f32
      %6 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64, f32)>
      %7 = llvm.insertvalue %2, %6[0] : !llvm.struct<(f16, f32, f64, f32)> 
      %8 = llvm.insertvalue %3, %7[1] : !llvm.struct<(f16, f32, f64, f32)> 
      %9 = llvm.insertvalue %4, %8[2] : !llvm.struct<(f16, f32, f64, f32)> 
      %10 = llvm.insertvalue %5, %9[3] : !llvm.struct<(f16, f32, f64, f32)> 
      llvm.return %10 : !llvm.struct<(f16, f32, f64, f32)>
    }
  }
  gpu.module @test_module_19 {
    llvm.func @__nv_tanhf(f32) -> f32
    llvm.func @__nv_tanh(f64) -> f64
    llvm.func @gpu_tanh(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> {
      %0 = llvm.fpext %arg0 : f16 to f32
      %1 = llvm.call @__nv_tanhf(%0) : (f32) -> f32
      %2 = llvm.fptrunc %1 : f32 to f16
      %3 = llvm.call @__nv_tanhf(%arg1) : (f32) -> f32
      %4 = llvm.call @__nv_tanh(%arg2) : (f64) -> f64
      %5 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %6 = llvm.insertvalue %2, %5[0] : !llvm.struct<(f16, f32, f64)> 
      %7 = llvm.insertvalue %3, %6[1] : !llvm.struct<(f16, f32, f64)> 
      %8 = llvm.insertvalue %4, %7[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %8 : !llvm.struct<(f16, f32, f64)>
    }
  }
  gpu.module @test_module_20 {
    llvm.func @__nv_rsqrtf(f32) -> f32
    llvm.func @__nv_rsqrt(f64) -> f64
    llvm.func @gpu_rsqrt(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> {
      %0 = llvm.fpext %arg0 : f16 to f32
      %1 = llvm.call @__nv_rsqrtf(%0) : (f32) -> f32
      %2 = llvm.fptrunc %1 : f32 to f16
      %3 = llvm.call @__nv_rsqrtf(%arg1) : (f32) -> f32
      %4 = llvm.call @__nv_rsqrt(%arg2) : (f64) -> f64
      %5 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %6 = llvm.insertvalue %2, %5[0] : !llvm.struct<(f16, f32, f64)> 
      %7 = llvm.insertvalue %3, %6[1] : !llvm.struct<(f16, f32, f64)> 
      %8 = llvm.insertvalue %4, %7[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %8 : !llvm.struct<(f16, f32, f64)>
    }
  }
  gpu.module @test_module_21 {
    llvm.func @__nv_sqrtf(f32) -> f32
    llvm.func @__nv_sqrt(f64) -> f64
    llvm.func @gpu_sqrt(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> {
      %0 = llvm.fpext %arg0 : f16 to f32
      %1 = llvm.call @__nv_sqrtf(%0) : (f32) -> f32
      %2 = llvm.fptrunc %1 : f32 to f16
      %3 = llvm.call @__nv_sqrtf(%arg1) : (f32) -> f32
      %4 = llvm.call @__nv_sqrt(%arg2) : (f64) -> f64
      %5 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %6 = llvm.insertvalue %2, %5[0] : !llvm.struct<(f16, f32, f64)> 
      %7 = llvm.insertvalue %3, %6[1] : !llvm.struct<(f16, f32, f64)> 
      %8 = llvm.insertvalue %4, %7[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %8 : !llvm.struct<(f16, f32, f64)>
    }
  }
  gpu.module @test_module_22 {
    llvm.func @__nv_atanf(f32) -> f32
    llvm.func @__nv_atan(f64) -> f64
    llvm.func @gpu_atan(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> {
      %0 = llvm.fpext %arg0 : f16 to f32
      %1 = llvm.call @__nv_atanf(%0) : (f32) -> f32
      %2 = llvm.fptrunc %1 : f32 to f16
      %3 = llvm.call @__nv_atanf(%arg1) : (f32) -> f32
      %4 = llvm.call @__nv_atan(%arg2) : (f64) -> f64
      %5 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %6 = llvm.insertvalue %2, %5[0] : !llvm.struct<(f16, f32, f64)> 
      %7 = llvm.insertvalue %3, %6[1] : !llvm.struct<(f16, f32, f64)> 
      %8 = llvm.insertvalue %4, %7[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %8 : !llvm.struct<(f16, f32, f64)>
    }
  }
  gpu.module @test_module_23 {
    llvm.func @__nv_atan2f(f32, f32) -> f32
    llvm.func @__nv_atan2(f64, f64) -> f64
    llvm.func @gpu_atan2(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> {
      %0 = llvm.fpext %arg0 : f16 to f32
      %1 = llvm.fpext %arg0 : f16 to f32
      %2 = llvm.call @__nv_atan2f(%0, %1) : (f32, f32) -> f32
      %3 = llvm.fptrunc %2 : f32 to f16
      %4 = llvm.call @__nv_atan2f(%arg1, %arg1) : (f32, f32) -> f32
      %5 = llvm.call @__nv_atan2(%arg2, %arg2) : (f64, f64) -> f64
      %6 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %7 = llvm.insertvalue %3, %6[0] : !llvm.struct<(f16, f32, f64)> 
      %8 = llvm.insertvalue %4, %7[1] : !llvm.struct<(f16, f32, f64)> 
      %9 = llvm.insertvalue %5, %8[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %9 : !llvm.struct<(f16, f32, f64)>
    }
  }
  gpu.module @test_module_24 {
    "test.symbol_scope"() ({
      llvm.func @__nv_expf(f32) -> f32
      llvm.func @__nv_exp(f64) -> f64
      llvm.func @__nv_fast_expf(f32) -> f32
      llvm.func @gpu_exp(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> {
        %0 = llvm.call @__nv_expf(%arg0) : (f32) -> f32
        %1 = llvm.call @__nv_exp(%arg1) : (f64) -> f64
        %2 = llvm.call @__nv_fast_expf(%arg0) : (f32) -> f32
        %3 = llvm.mlir.poison : !llvm.struct<(f32, f64, f32)>
        %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f32, f64, f32)> 
        %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f32, f64, f32)> 
        %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f32, f64, f32)> 
        llvm.return %6 : !llvm.struct<(f32, f64, f32)>
      }
      "test.finish"() : () -> ()
    }) : () -> ()
  }
  gpu.module @test_module_25 {
    llvm.func @__nv_expm1f(f32) -> f32
    llvm.func @__nv_expm1(f64) -> f64
    llvm.func @gpu_expm1(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_expm1f(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_expm1(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_26 {
    llvm.func @__nv_powf(f32, f32) -> f32
    llvm.func @__nv_pow(f64, f64) -> f64
    llvm.func @__nv_fast_powf(f32, f32) -> f32
    llvm.func @gpu_pow(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> {
      %0 = llvm.call @__nv_powf(%arg0, %arg0) : (f32, f32) -> f32
      %1 = llvm.call @__nv_pow(%arg1, %arg1) : (f64, f64) -> f64
      %2 = llvm.call @__nv_fast_powf(%arg0, %arg0) : (f32, f32) -> f32
      %3 = llvm.mlir.poison : !llvm.struct<(f32, f64, f32)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f32, f64, f32)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f32, f64, f32)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f32, f64, f32)> 
      llvm.return %6 : !llvm.struct<(f32, f64, f32)>
    }
  }
  gpu.module @test_module_27 {
    llvm.func @__nv_expf(f32) -> f32
    llvm.func @gpu_unroll(%arg0: vector<4xf32>) -> vector<4xf32> {
      %0 = llvm.mlir.poison : vector<4xf32>
      %1 = llvm.mlir.constant(0 : i64) : i64
      %2 = llvm.extractelement %arg0[%1 : i64] : vector<4xf32>
      %3 = llvm.call @__nv_expf(%2) : (f32) -> f32
      %4 = llvm.insertelement %3, %0[%1 : i64] : vector<4xf32>
      %5 = llvm.mlir.constant(1 : i64) : i64
      %6 = llvm.extractelement %arg0[%5 : i64] : vector<4xf32>
      %7 = llvm.call @__nv_expf(%6) : (f32) -> f32
      %8 = llvm.insertelement %7, %4[%5 : i64] : vector<4xf32>
      %9 = llvm.mlir.constant(2 : i64) : i64
      %10 = llvm.extractelement %arg0[%9 : i64] : vector<4xf32>
      %11 = llvm.call @__nv_expf(%10) : (f32) -> f32
      %12 = llvm.insertelement %11, %8[%9 : i64] : vector<4xf32>
      %13 = llvm.mlir.constant(3 : i64) : i64
      %14 = llvm.extractelement %arg0[%13 : i64] : vector<4xf32>
      %15 = llvm.call @__nv_expf(%14) : (f32) -> f32
      %16 = llvm.insertelement %15, %12[%13 : i64] : vector<4xf32>
      llvm.return %16 : vector<4xf32>
    }
  }
  gpu.module @test_module_28 {
    llvm.func @kernel_func() attributes {gpu.kernel, nvvm.kernel} {
      llvm.return
    }
  }
  gpu.module @test_module_29 {
    llvm.mlir.global internal constant @printfFormat_1("Hello: %d\0A\00") {addr_space = 0 : i32}
    llvm.mlir.global internal constant @printfFormat_0("Hello, world\0A\00") {addr_space = 0 : i32}
    llvm.func @vprintf(!llvm.ptr, !llvm.ptr) -> i32
    llvm.func @test_const_printf() {
      %0 = llvm.mlir.addressof @printfFormat_0 : !llvm.ptr
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<14 x i8>
      %2 = llvm.mlir.constant(1 : index) : i64
      %3 = llvm.alloca %2 x !llvm.struct<()> : (i64) -> !llvm.ptr
      %4 = llvm.call @vprintf(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i32
      %5 = llvm.mlir.addressof @printfFormat_0 : !llvm.ptr
      %6 = llvm.getelementptr %5[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<14 x i8>
      %7 = llvm.mlir.constant(1 : index) : i64
      %8 = llvm.alloca %7 x !llvm.struct<()> : (i64) -> !llvm.ptr
      %9 = llvm.call @vprintf(%6, %8) : (!llvm.ptr, !llvm.ptr) -> i32
      llvm.return
    }
    llvm.func @test_printf(%arg0: i32, %arg1: f32) {
      %0 = llvm.mlir.addressof @printfFormat_1 : !llvm.ptr
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<11 x i8>
      %2 = llvm.fpext %arg1 : f32 to f64
      %3 = llvm.mlir.constant(1 : index) : i64
      %4 = llvm.alloca %3 x !llvm.struct<(i32, f64)> : (i64) -> !llvm.ptr
      %5 = llvm.getelementptr %4[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<(i32, f64)>
      llvm.store %arg0, %5 : i32, !llvm.ptr
      %6 = llvm.getelementptr %4[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<(i32, f64)>
      llvm.store %2, %6 : f64, !llvm.ptr
      %7 = llvm.call @vprintf(%1, %4) : (!llvm.ptr, !llvm.ptr) -> i32
      llvm.return
    }
  }
  gpu.module @test_module_30 {
    llvm.func @subgroup_reduce_add(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64) {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
      %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr, ptr, i64)> 
      %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr, ptr, i64)> 
      %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr, ptr, i64)> 
      %4 = builtin.unrealized_conversion_cast %3 : !llvm.struct<(ptr, ptr, i64)> to memref<i32>
      %5 = llvm.mlir.constant(-1 : i32) : i32
      %6 = nvvm.redux.sync add %arg0, %5 : i32 -> i32
      memref.store %6, %4[] : memref<i32>
      llvm.return
    }
    llvm.func @subgroup_reduce_minsi(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64) {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
      %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr, ptr, i64)> 
      %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr, ptr, i64)> 
      %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr, ptr, i64)> 
      %4 = builtin.unrealized_conversion_cast %3 : !llvm.struct<(ptr, ptr, i64)> to memref<i32>
      %5 = llvm.mlir.constant(-1 : i32) : i32
      %6 = nvvm.redux.sync min %arg0, %5 : i32 -> i32
      memref.store %6, %4[] : memref<i32>
      llvm.return
    }
    llvm.func @subgroup_reduce_maxsi(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64) {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
      %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr, ptr, i64)> 
      %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr, ptr, i64)> 
      %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr, ptr, i64)> 
      %4 = builtin.unrealized_conversion_cast %3 : !llvm.struct<(ptr, ptr, i64)> to memref<i32>
      %5 = llvm.mlir.constant(-1 : i32) : i32
      %6 = nvvm.redux.sync max %arg0, %5 : i32 -> i32
      memref.store %6, %4[] : memref<i32>
      llvm.return
    }
    llvm.func @subgroup_reduce_and(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64) {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
      %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr, ptr, i64)> 
      %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr, ptr, i64)> 
      %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr, ptr, i64)> 
      %4 = builtin.unrealized_conversion_cast %3 : !llvm.struct<(ptr, ptr, i64)> to memref<i32>
      %5 = llvm.mlir.constant(-1 : i32) : i32
      %6 = nvvm.redux.sync and %arg0, %5 : i32 -> i32
      memref.store %6, %4[] : memref<i32>
      llvm.return
    }
    llvm.func @subgroup_reduce_or(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64) {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
      %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr, ptr, i64)> 
      %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr, ptr, i64)> 
      %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr, ptr, i64)> 
      %4 = builtin.unrealized_conversion_cast %3 : !llvm.struct<(ptr, ptr, i64)> to memref<i32>
      %5 = llvm.mlir.constant(-1 : i32) : i32
      %6 = nvvm.redux.sync or %arg0, %5 : i32 -> i32
      memref.store %6, %4[] : memref<i32>
      llvm.return
    }
    llvm.func @subgroup_reduce_xor(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64) {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
      %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr, ptr, i64)> 
      %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr, ptr, i64)> 
      %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr, ptr, i64)> 
      %4 = builtin.unrealized_conversion_cast %3 : !llvm.struct<(ptr, ptr, i64)> to memref<i32>
      %5 = llvm.mlir.constant(-1 : i32) : i32
      %6 = nvvm.redux.sync xor %arg0, %5 : i32 -> i32
      memref.store %6, %4[] : memref<i32>
      llvm.return
    }
  }
  gpu.module @test_module_31 {
    llvm.func @__nv_fmodf(f32, f32) -> f32
    llvm.func @__nv_fmod(f64, f64) -> f64
    llvm.func @gpu_fmod(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_fmodf(%arg0, %arg0) : (f32, f32) -> f32
      %1 = llvm.call @__nv_fmod(%arg1, %arg1) : (f64, f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_32 {
    llvm.func @__nv_erff(f32) -> f32
    llvm.func @__nv_erf(f64) -> f64
    llvm.func @gpu_erf(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_erff(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_erf(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_33 {
    llvm.func @kernel_with_block_size(%arg0: !llvm.ptr) attributes {gpu.kernel, gpu.known_block_size = array<i32: 32, 4, 2>, nvvm.kernel, nvvm.maxntid = array<i32: 32, 4, 2>} {
      %0 = nvvm.read.ptx.sreg.tid.x range <i32, 0, 32> : i32
      %1 = llvm.sext %0 : i32 to i64
      %2 = nvvm.read.ptx.sreg.tid.y range <i32, 0, 4> : i32
      %3 = llvm.sext %2 : i32 to i64
      %4 = nvvm.read.ptx.sreg.tid.z range <i32, 0, 2> : i32
      %5 = llvm.sext %4 : i32 to i64
      %6 = llvm.add %1, %3 : i64
      %7 = llvm.add %6, %5 : i64
      llvm.store %7, %arg0 : i64, !llvm.ptr
      llvm.return
    }
  }
  gpu.module @test_module_34 {
    llvm.func @memref_signature(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: f32) -> !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)> {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %6 = llvm.mlir.poison : !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>
      %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)> 
      %8 = llvm.insertvalue %arg5, %7[1] : !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)> 
      llvm.return %8 : !llvm.struct<(struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, f32)>
    }
  }
  gpu.module @test_module_35 {
    llvm.func @__nv_acosf(f32) -> f32
    llvm.func @__nv_acos(f64) -> f64
    llvm.func @gpu_acos(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_acosf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_acos(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_36 {
    llvm.func @__nv_acoshf(f32) -> f32
    llvm.func @__nv_acosh(f64) -> f64
    llvm.func @gpu_acosh(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_acoshf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_acosh(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_37 {
    llvm.func @__nv_asinf(f32) -> f32
    llvm.func @__nv_asin(f64) -> f64
    llvm.func @gpu_asin(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_asinf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_asin(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_38 {
    llvm.func @__nv_asinhf(f32) -> f32
    llvm.func @__nv_asinh(f64) -> f64
    llvm.func @gpu_asinh(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_asinhf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_asinh(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_39 {
    llvm.func @__nv_atanhf(f32) -> f32
    llvm.func @__nv_atanh(f64) -> f64
    llvm.func @gpu_atanh(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> {
      %0 = llvm.fpext %arg0 : f16 to f32
      %1 = llvm.call @__nv_atanhf(%0) : (f32) -> f32
      %2 = llvm.fptrunc %1 : f32 to f16
      %3 = llvm.call @__nv_atanhf(%arg1) : (f32) -> f32
      %4 = llvm.call @__nv_atanh(%arg2) : (f64) -> f64
      %5 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %6 = llvm.insertvalue %2, %5[0] : !llvm.struct<(f16, f32, f64)> 
      %7 = llvm.insertvalue %3, %6[1] : !llvm.struct<(f16, f32, f64)> 
      %8 = llvm.insertvalue %4, %7[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %8 : !llvm.struct<(f16, f32, f64)>
    }
  }
  gpu.module @test_module_40 {
    llvm.func @__nv_copysignf(f32, f32) -> f32
    llvm.func @__nv_copysign(f64, f64) -> f64
    llvm.func @gpu_copysign(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_copysignf(%arg0, %arg0) : (f32, f32) -> f32
      %1 = llvm.call @__nv_copysign(%arg1, %arg1) : (f64, f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_41 {
    llvm.func @__nv_coshf(f32) -> f32
    llvm.func @__nv_cosh(f64) -> f64
    llvm.func @gpu_cosh(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_coshf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_cosh(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_42 {
    llvm.func @__nv_fmaf(f32, f32, f32) -> f32
    llvm.func @__nv_fma(f64, f64, f64) -> f64
    llvm.func @gpu_fma(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_fmaf(%arg0, %arg0, %arg0) : (f32, f32, f32) -> f32
      %1 = llvm.call @__nv_fma(%arg1, %arg1, %arg1) : (f64, f64, f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_43 {
    llvm.func @__nv_roundf(f32) -> f32
    llvm.func @__nv_round(f64) -> f64
    llvm.func @gpu_round(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_roundf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_round(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_44 {
    llvm.func @__nv_rintf(f32) -> f32
    llvm.func @__nv_rint(f64) -> f64
    llvm.func @gpu_roundeven(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_rintf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_rint(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_45 {
    llvm.func @__nv_sinhf(f32) -> f32
    llvm.func @__nv_sinh(f64) -> f64
    llvm.func @gpu_sinh(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_sinhf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_sinh(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_46 {
    llvm.func @__nv_coshf(f32) -> f32
    llvm.func @__nv_cosh(f64) -> f64
    llvm.func @gpu_cosh_with_fastmath(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_coshf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_cosh(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_47 {
    llvm.func @__nv_sinhf(f32) -> f32
    llvm.func @__nv_sinh(f64) -> f64
    llvm.func @gpu_sinh_with_fastmath(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_sinhf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_sinh(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_48 {
    llvm.func @__nv_expf(f32) -> f32
    llvm.func @__nv_exp(f64) -> f64
    llvm.func @gpu_exp_with_fastmath(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> {
      %0 = llvm.call @__nv_expf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_exp(%arg1) : (f64) -> f64
      %2 = llvm.call @__nv_expf(%arg0) : (f32) -> f32
      %3 = llvm.mlir.poison : !llvm.struct<(f32, f64, f32)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f32, f64, f32)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f32, f64, f32)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f32, f64, f32)> 
      llvm.return %6 : !llvm.struct<(f32, f64, f32)>
    }
  }
  gpu.module @test_module_49 {
    llvm.func @explicit_id_bounds() -> !llvm.struct<(i64, i64, i64)> {
      %0 = nvvm.read.ptx.sreg.tid.x range <i32, 0, 32> : i32
      %1 = llvm.sext %0 : i32 to i64
      %2 = nvvm.read.ptx.sreg.ntid.x range <i32, 1, 33> : i32
      %3 = llvm.sext %2 : i32 to i64
      %4 = nvvm.read.ptx.sreg.laneid range <i32, 0, 16> : i32
      %5 = llvm.sext %4 : i32 to i64
      %6 = llvm.mlir.poison : !llvm.struct<(i64, i64, i64)>
      %7 = llvm.insertvalue %1, %6[0] : !llvm.struct<(i64, i64, i64)> 
      %8 = llvm.insertvalue %3, %7[1] : !llvm.struct<(i64, i64, i64)> 
      %9 = llvm.insertvalue %5, %8[2] : !llvm.struct<(i64, i64, i64)> 
      llvm.return %9 : !llvm.struct<(i64, i64, i64)>
    }
  }
  gpu.module @test_module_50 {
    llvm.func @kernel_with_grid_size(%arg0: !llvm.ptr) attributes {gpu.kernel, gpu.known_grid_size = array<i32: 32, 4, 2>, nvvm.kernel} {
      %0 = nvvm.read.ptx.sreg.ctaid.x range <i32, 0, 32> : i32
      %1 = llvm.sext %0 : i32 to i64
      %2 = nvvm.read.ptx.sreg.ctaid.y range <i32, 0, 4> : i32
      %3 = llvm.sext %2 : i32 to i64
      %4 = nvvm.read.ptx.sreg.ctaid.z range <i32, 0, 2> : i32
      %5 = llvm.sext %4 : i32 to i64
      %6 = llvm.add %1, %3 : i64
      %7 = llvm.add %6, %5 : i64
      llvm.store %7, %arg0 : i64, !llvm.ptr
      llvm.return
    }
  }
  gpu.module @test_module_51 {
    llvm.mlir.global internal constant @assert_func_0("(unknown)\00") {addr_space = 0 : i32}
    llvm.mlir.global internal constant @assert_file_0("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm.mlir\00") {addr_space = 0 : i32}
    llvm.mlir.global internal constant @assert_message_0("assert message\00") {addr_space = 0 : i32}
    llvm.func @__assertfail(!llvm.ptr, !llvm.ptr, i32, !llvm.ptr, i64) attributes {passthrough = ["noreturn"]}
    llvm.func @test_assert(%arg0: i1) attributes {gpu.kernel, nvvm.kernel} {
      llvm.cond_br %arg0, ^bb2, ^bb1
    ^bb1:  // pred: ^bb0
      %0 = llvm.mlir.addressof @assert_message_0 : !llvm.ptr
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<15 x i8>
      %2 = llvm.mlir.addressof @assert_file_0 : !llvm.ptr
      %3 = llvm.getelementptr %2[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<90 x i8>
      %4 = llvm.mlir.addressof @assert_func_0 : !llvm.ptr
      %5 = llvm.getelementptr %4[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x i8>
      %6 = llvm.mlir.constant(1056 : i32) : i32
      %7 = llvm.mlir.constant(1 : i64) : i64
      llvm.call @__assertfail(%1, %3, %6, %5, %7) : (!llvm.ptr, !llvm.ptr, i32, !llvm.ptr, i64) -> ()
      llvm.br ^bb2
    ^bb2:  // 2 preds: ^bb0, ^bb1
      llvm.return
    }
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["gpu.module"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.gpu.gpu_rewrite_patterns
      } : !transform.any_op
      transform.apply_conversion_patterns to %0 {
        transform.apply_conversion_patterns.dialect_to_llvm "arith"
        transform.apply_conversion_patterns.dialect_to_llvm "cf"
        transform.apply_conversion_patterns.vector.vector_to_llvm
        transform.apply_conversion_patterns.func.func_to_llvm
        transform.apply_conversion_patterns.dialect_to_llvm "memref"
        transform.apply_conversion_patterns.gpu.gpu_to_nvvm {benefit = 10 : i16}
        transform.apply_conversion_patterns.gpu.gpu_wmma_to_nvvm
        transform.apply_conversion_patterns.gpu.gpu_subgroup_reduce_to_nvvm
        transform.apply_conversion_patterns.nvgpu.nvgpu_to_nvvm
      } with type_converter {
        transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter
      } {illegal_dialects = ["gpu"], illegal_ops = ["llvm.copysign", "llvm.cos", "llvm.exp", "llvm.exp2", "llvm.fabs", "llvm.fceil", "llvm.ffloor", "llvm.frem", "llvm.log", "llvm.log10", "llvm.log2", "llvm.pow", "llvm.roundeven", "llvm.round", "llvm.sin", "llvm.sqrt"], legal_dialects = ["llvm", "memref", "nvvm", "test"], legal_ops = ["gpu.module", "gpu.yield"], partial_conversion} : !transform.any_op
      transform.yield 
    }
  }
  gpu.module @test_module_52 {
    llvm.func @__nv_abs(i32) -> i32
    llvm.func @gpu_abs(%arg0: i32) -> i32 {
      %0 = llvm.call @__nv_abs(%arg0) : (i32) -> i32
      llvm.return %0 : i32
    }
  }
  gpu.module @test_module_53 {
    llvm.func @__nv_powif(f32, i32) -> f32
    llvm.func @__nv_powi(f64, i32) -> f64
    llvm.func @gpu_powi(%arg0: f32, %arg1: f64, %arg2: i32) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_powif(%arg0, %arg2) : (f32, i32) -> f32
      %1 = llvm.call @__nv_powi(%arg1, %arg2) : (f64, i32) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_54 {
    llvm.func @__nv_isinff(f32) -> i32
    llvm.func @__nv_isinfd(f64) -> i32
    llvm.func @__nv_isnanf(f32) -> i32
    llvm.func @__nv_isnand(f64) -> i32
    llvm.func @__nv_finitef(f32) -> i32
    llvm.func @__nv_isfinited(f64) -> i32
    llvm.func @fpclassify(%arg0: f32, %arg1: f64) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)> {
      %0 = llvm.call @__nv_isinff(%arg0) : (f32) -> i32
      %1 = llvm.mlir.constant(0 : i32) : i32
      %2 = llvm.icmp "ne" %0, %1 : i32
      %3 = llvm.call @__nv_isinfd(%arg1) : (f64) -> i32
      %4 = llvm.mlir.constant(0 : i32) : i32
      %5 = llvm.icmp "ne" %3, %4 : i32
      %6 = llvm.call @__nv_isnanf(%arg0) : (f32) -> i32
      %7 = llvm.mlir.constant(0 : i32) : i32
      %8 = llvm.icmp "ne" %6, %7 : i32
      %9 = llvm.call @__nv_isnand(%arg1) : (f64) -> i32
      %10 = llvm.mlir.constant(0 : i32) : i32
      %11 = llvm.icmp "ne" %9, %10 : i32
      %12 = llvm.call @__nv_finitef(%arg0) : (f32) -> i32
      %13 = llvm.mlir.constant(0 : i32) : i32
      %14 = llvm.icmp "ne" %12, %13 : i32
      %15 = llvm.call @__nv_isfinited(%arg1) : (f64) -> i32
      %16 = llvm.mlir.constant(0 : i32) : i32
      %17 = llvm.icmp "ne" %15, %16 : i32
      %18 = llvm.mlir.poison : !llvm.struct<(i1, i1, i1, i1, i1, i1)>
      %19 = llvm.insertvalue %2, %18[0] : !llvm.struct<(i1, i1, i1, i1, i1, i1)> 
      %20 = llvm.insertvalue %5, %19[1] : !llvm.struct<(i1, i1, i1, i1, i1, i1)> 
      %21 = llvm.insertvalue %8, %20[2] : !llvm.struct<(i1, i1, i1, i1, i1, i1)> 
      %22 = llvm.insertvalue %11, %21[3] : !llvm.struct<(i1, i1, i1, i1, i1, i1)> 
      %23 = llvm.insertvalue %14, %22[4] : !llvm.struct<(i1, i1, i1, i1, i1, i1)> 
      %24 = llvm.insertvalue %17, %23[5] : !llvm.struct<(i1, i1, i1, i1, i1, i1)> 
      llvm.return %24 : !llvm.struct<(i1, i1, i1, i1, i1, i1)>
    }
  }
  gpu.module @test_module_55 {
    llvm.func @__nv_erfcf(f32) -> f32
    llvm.func @__nv_erfc(f64) -> f64
    llvm.func @gpu_erfc(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> {
      %0 = llvm.call @__nv_erfcf(%arg0) : (f32) -> f32
      %1 = llvm.call @__nv_erfc(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f32, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f32, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f32, f64)> 
      llvm.return %4 : !llvm.struct<(f32, f64)>
    }
  }
  gpu.module @test_module_56 {
    llvm.func @__nv_sincosf(f32, !llvm.ptr, !llvm.ptr)
    llvm.func @__nv_sincos(f64, !llvm.ptr, !llvm.ptr)
    llvm.func @gpu_sincos(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)> {
      %0 = llvm.mlir.constant(1 : i32) : i32
      %1 = llvm.alloca %0 x f64 : (i32) -> !llvm.ptr
      %2 = llvm.alloca %0 x f64 : (i32) -> !llvm.ptr
      %3 = llvm.mlir.constant(1 : i32) : i32
      %4 = llvm.alloca %3 x f32 : (i32) -> !llvm.ptr
      %5 = llvm.alloca %3 x f32 : (i32) -> !llvm.ptr
      %6 = llvm.mlir.constant(1 : i32) : i32
      %7 = llvm.alloca %6 x f32 : (i32) -> !llvm.ptr
      %8 = llvm.alloca %6 x f32 : (i32) -> !llvm.ptr
      %9 = llvm.fpext %arg0 : f16 to f32
      llvm.call @__nv_sincosf(%9, %7, %8) : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %10 = llvm.load %7 : !llvm.ptr -> f32
      %11 = llvm.load %8 : !llvm.ptr -> f32
      %12 = llvm.fptrunc %10 : f32 to f16
      %13 = llvm.fptrunc %11 : f32 to f16
      llvm.call @__nv_sincosf(%arg1, %4, %5) : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %14 = llvm.load %4 : !llvm.ptr -> f32
      %15 = llvm.load %5 : !llvm.ptr -> f32
      llvm.call @__nv_sincos(%arg2, %1, %2) : (f64, !llvm.ptr, !llvm.ptr) -> ()
      %16 = llvm.load %1 : !llvm.ptr -> f64
      %17 = llvm.load %2 : !llvm.ptr -> f64
      %18 = llvm.mlir.poison : !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %19 = llvm.insertvalue %12, %18[0] : !llvm.struct<(f16, f16, f32, f32, f64, f64)> 
      %20 = llvm.insertvalue %13, %19[1] : !llvm.struct<(f16, f16, f32, f32, f64, f64)> 
      %21 = llvm.insertvalue %14, %20[2] : !llvm.struct<(f16, f16, f32, f32, f64, f64)> 
      %22 = llvm.insertvalue %15, %21[3] : !llvm.struct<(f16, f16, f32, f32, f64, f64)> 
      %23 = llvm.insertvalue %16, %22[4] : !llvm.struct<(f16, f16, f32, f32, f64, f64)> 
      %24 = llvm.insertvalue %17, %23[5] : !llvm.struct<(f16, f16, f32, f32, f64, f64)> 
      llvm.return %24 : !llvm.struct<(f16, f16, f32, f32, f64, f64)>
    }
    llvm.func @__nv_fast_sincosf(f32, !llvm.ptr, !llvm.ptr)
    llvm.func @gpu_sincos_fastmath(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)> {
      %0 = llvm.mlir.constant(1 : i32) : i32
      %1 = llvm.alloca %0 x f64 : (i32) -> !llvm.ptr
      %2 = llvm.alloca %0 x f64 : (i32) -> !llvm.ptr
      %3 = llvm.mlir.constant(1 : i32) : i32
      %4 = llvm.alloca %3 x f32 : (i32) -> !llvm.ptr
      %5 = llvm.alloca %3 x f32 : (i32) -> !llvm.ptr
      %6 = llvm.mlir.constant(1 : i32) : i32
      %7 = llvm.alloca %6 x f32 : (i32) -> !llvm.ptr
      %8 = llvm.alloca %6 x f32 : (i32) -> !llvm.ptr
      %9 = llvm.fpext %arg0 : f16 to f32
      llvm.call @__nv_fast_sincosf(%9, %7, %8) : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %10 = llvm.load %7 : !llvm.ptr -> f32
      %11 = llvm.load %8 : !llvm.ptr -> f32
      %12 = llvm.fptrunc %10 : f32 to f16
      %13 = llvm.fptrunc %11 : f32 to f16
      llvm.call @__nv_fast_sincosf(%arg1, %4, %5) : (f32, !llvm.ptr, !llvm.ptr) -> ()
      %14 = llvm.load %4 : !llvm.ptr -> f32
      %15 = llvm.load %5 : !llvm.ptr -> f32
      llvm.call @__nv_sincos(%arg2, %1, %2) : (f64, !llvm.ptr, !llvm.ptr) -> ()
      %16 = llvm.load %1 : !llvm.ptr -> f64
      %17 = llvm.load %2 : !llvm.ptr -> f64
      %18 = llvm.mlir.poison : !llvm.struct<(f16, f16, f32, f32, f64, f64)>
      %19 = llvm.insertvalue %12, %18[0] : !llvm.struct<(f16, f16, f32, f32, f64, f64)> 
      %20 = llvm.insertvalue %13, %19[1] : !llvm.struct<(f16, f16, f32, f32, f64, f64)> 
      %21 = llvm.insertvalue %14, %20[2] : !llvm.struct<(f16, f16, f32, f32, f64, f64)> 
      %22 = llvm.insertvalue %15, %21[3] : !llvm.struct<(f16, f16, f32, f32, f64, f64)> 
      %23 = llvm.insertvalue %16, %22[4] : !llvm.struct<(f16, f16, f32, f32, f64, f64)> 
      %24 = llvm.insertvalue %17, %23[5] : !llvm.struct<(f16, f16, f32, f32, f64, f64)> 
      llvm.return %24 : !llvm.struct<(f16, f16, f32, f32, f64, f64)>
    }
  }
  gpu.module @test_module_cluster_size {
    llvm.func @kernel_with_cluster_size() attributes {gpu.kernel, gpu.known_cluster_size = array<i32: 8, 2, 4>, nvvm.cluster_dim = array<i32: 8, 2, 4>, nvvm.kernel} {
      llvm.return
    }
  }
  gpu.module @test_module_cluster_block_ops {
    llvm.func @kernel_with_cluster_size(%arg0: !llvm.ptr) attributes {gpu.kernel, gpu.known_cluster_size = array<i32: 8, 4, 2>, nvvm.cluster_dim = array<i32: 8, 4, 2>, nvvm.kernel} {
      %0 = nvvm.read.ptx.sreg.cluster.ctaid.x range <i32, 0, 8> : i32
      %1 = llvm.sext %0 : i32 to i64
      %2 = nvvm.read.ptx.sreg.cluster.ctaid.y range <i32, 0, 4> : i32
      %3 = llvm.sext %2 : i32 to i64
      %4 = nvvm.read.ptx.sreg.cluster.ctaid.z range <i32, 0, 2> : i32
      %5 = llvm.sext %4 : i32 to i64
      %6 = nvvm.read.ptx.sreg.cluster.nctaid.x range <i32, 8, 9> : i32
      %7 = llvm.sext %6 : i32 to i64
      %8 = nvvm.read.ptx.sreg.cluster.nctaid.y range <i32, 4, 5> : i32
      %9 = llvm.sext %8 : i32 to i64
      %10 = nvvm.read.ptx.sreg.cluster.nctaid.z range <i32, 2, 3> : i32
      %11 = llvm.sext %10 : i32 to i64
      %12 = llvm.add %1, %3 : i64
      %13 = llvm.add %12, %5 : i64
      %14 = llvm.add %13, %7 : i64
      %15 = llvm.add %14, %9 : i64
      %16 = llvm.add %15, %11 : i64
      llvm.store %16, %arg0 : i64, !llvm.ptr
      llvm.return
    }
  }
  module attributes {gpu.container_module} {
    gpu.module @kernels {
      llvm.func @gpu_ballot(%arg0: i1) -> !llvm.struct<(i32, i64)> {
        %0 = llvm.mlir.constant(-1 : i32) : i32
        %1 = nvvm.vote.sync ballot %0, %arg0 -> i32
        %2 = llvm.mlir.constant(-1 : i32) : i32
        %3 = nvvm.vote.sync ballot %2, %arg0 -> i32
        %4 = llvm.zext %3 : i32 to i64
        %5 = llvm.mlir.poison : !llvm.struct<(i32, i64)>
        %6 = llvm.insertvalue %1, %5[0] : !llvm.struct<(i32, i64)> 
        %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<(i32, i64)> 
        llvm.return %7 : !llvm.struct<(i32, i64)>
      }
    }
  }
}


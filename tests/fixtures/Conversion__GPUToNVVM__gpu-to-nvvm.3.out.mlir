module {
  gpu.module @test_module_0 {
    llvm.func @gpu_index_ops() -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_index_comp(%arg0: i64) -> i64 attributes {llvm.emit_c_interface} {
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
      %11 = llvm.mlir.constant(0 : index) : i64
      %12 = llvm.mlir.constant(16 : i32) : i32
      %13 = llvm.mlir.constant(8 : i32) : i32
      %14 = llvm.mlir.constant(4 : i32) : i32
      %15 = llvm.mlir.constant(2 : i32) : i32
      %16 = llvm.mlir.constant(1 : i32) : i32
      %17 = llvm.mlir.constant(32 : i32) : i32
      %18 = llvm.mlir.constant(0 : i32) : i32
      %19 = llvm.mlir.constant(31 : i32) : i32
      %20 = llvm.mlir.constant(1.000000e+00 : f32) : f32
      %21 = nvvm.read.ptx.sreg.ntid.x : i32
      %22 = llvm.sext %21 : i32 to i64
      %23 = llvm.trunc %22 : i64 to i32
      %24 = nvvm.read.ptx.sreg.ntid.y : i32
      %25 = llvm.sext %24 : i32 to i64
      %26 = llvm.trunc %25 : i64 to i32
      %27 = nvvm.read.ptx.sreg.ntid.z : i32
      %28 = llvm.sext %27 : i32 to i64
      %29 = llvm.trunc %28 : i64 to i32
      %30 = nvvm.read.ptx.sreg.tid.x : i32
      %31 = llvm.sext %30 : i32 to i64
      %32 = llvm.trunc %31 : i64 to i32
      %33 = nvvm.read.ptx.sreg.tid.y : i32
      %34 = llvm.sext %33 : i32 to i64
      %35 = llvm.trunc %34 : i64 to i32
      %36 = nvvm.read.ptx.sreg.tid.z : i32
      %37 = llvm.sext %36 : i32 to i64
      %38 = llvm.trunc %37 : i64 to i32
      %39 = llvm.mul %38, %26 : i32
      %40 = llvm.add %39, %35 : i32
      %41 = llvm.mul %40, %23 : i32
      %42 = llvm.mul %23, %26 : i32
      %43 = llvm.add %41, %32 : i32
      %44 = llvm.mul %42, %29 : i32
      %45 = llvm.and %43, %19 : i32
      %46 = llvm.icmp "eq" %45, %18 : i32
      %47 = llvm.sub %43, %45 : i32
      %48 = llvm.sub %44, %47 : i32
      %49 = llvm.icmp "slt" %48, %17 : i32
      llvm.cond_br %49, ^bb1, ^bb17
    ^bb1:  // pred: ^bb0
      %50 = llvm.mlir.constant(1 : i32) : i32
      %51 = llvm.mlir.constant(-1 : i32) : i32
      %52 = llvm.mlir.constant(32 : i32) : i32
      %53 = llvm.sub %52, %48 : i32
      %54 = llvm.lshr %51, %53 : i32
      %55 = llvm.sub %48, %50 : i32
      %56 = nvvm.shfl.sync  bfly %54, %20, %16, %55 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %57 = llvm.extractvalue %56[0] : !llvm.struct<(f32, i1)> 
      %58 = llvm.extractvalue %56[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %58, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %59 = llvm.fadd %57, %20 : f32
      llvm.br ^bb4(%59 : f32)
    ^bb3:  // pred: ^bb1
      llvm.br ^bb4(%20 : f32)
    ^bb4(%60: f32):  // 2 preds: ^bb2, ^bb3
      %61 = llvm.mlir.constant(1 : i32) : i32
      %62 = llvm.mlir.constant(-1 : i32) : i32
      %63 = llvm.mlir.constant(32 : i32) : i32
      %64 = llvm.sub %63, %48 : i32
      %65 = llvm.lshr %62, %64 : i32
      %66 = llvm.sub %48, %61 : i32
      %67 = nvvm.shfl.sync  bfly %65, %60, %15, %66 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %68 = llvm.extractvalue %67[0] : !llvm.struct<(f32, i1)> 
      %69 = llvm.extractvalue %67[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %69, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %70 = llvm.fadd %60, %68 : f32
      llvm.br ^bb7(%70 : f32)
    ^bb6:  // pred: ^bb4
      llvm.br ^bb7(%60 : f32)
    ^bb7(%71: f32):  // 2 preds: ^bb5, ^bb6
      %72 = llvm.mlir.constant(1 : i32) : i32
      %73 = llvm.mlir.constant(-1 : i32) : i32
      %74 = llvm.mlir.constant(32 : i32) : i32
      %75 = llvm.sub %74, %48 : i32
      %76 = llvm.lshr %73, %75 : i32
      %77 = llvm.sub %48, %72 : i32
      %78 = nvvm.shfl.sync  bfly %76, %71, %14, %77 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %79 = llvm.extractvalue %78[0] : !llvm.struct<(f32, i1)> 
      %80 = llvm.extractvalue %78[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %80, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %81 = llvm.fadd %71, %79 : f32
      llvm.br ^bb10(%81 : f32)
    ^bb9:  // pred: ^bb7
      llvm.br ^bb10(%71 : f32)
    ^bb10(%82: f32):  // 2 preds: ^bb8, ^bb9
      %83 = llvm.mlir.constant(1 : i32) : i32
      %84 = llvm.mlir.constant(-1 : i32) : i32
      %85 = llvm.mlir.constant(32 : i32) : i32
      %86 = llvm.sub %85, %48 : i32
      %87 = llvm.lshr %84, %86 : i32
      %88 = llvm.sub %48, %83 : i32
      %89 = nvvm.shfl.sync  bfly %87, %82, %13, %88 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %90 = llvm.extractvalue %89[0] : !llvm.struct<(f32, i1)> 
      %91 = llvm.extractvalue %89[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %91, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %92 = llvm.fadd %82, %90 : f32
      llvm.br ^bb13(%92 : f32)
    ^bb12:  // pred: ^bb10
      llvm.br ^bb13(%82 : f32)
    ^bb13(%93: f32):  // 2 preds: ^bb11, ^bb12
      %94 = llvm.mlir.constant(1 : i32) : i32
      %95 = llvm.mlir.constant(-1 : i32) : i32
      %96 = llvm.mlir.constant(32 : i32) : i32
      %97 = llvm.sub %96, %48 : i32
      %98 = llvm.lshr %95, %97 : i32
      %99 = llvm.sub %48, %94 : i32
      %100 = nvvm.shfl.sync  bfly %98, %93, %12, %99 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %101 = llvm.extractvalue %100[0] : !llvm.struct<(f32, i1)> 
      %102 = llvm.extractvalue %100[1] : !llvm.struct<(f32, i1)> 
      llvm.cond_br %102, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %103 = llvm.fadd %93, %101 : f32
      llvm.br ^bb16(%103 : f32)
    ^bb15:  // pred: ^bb13
      llvm.br ^bb16(%93 : f32)
    ^bb16(%104: f32):  // 2 preds: ^bb14, ^bb15
      llvm.br ^bb18(%104 : f32)
    ^bb17:  // pred: ^bb0
      %105 = llvm.mlir.constant(1 : i32) : i32
      %106 = llvm.mlir.constant(-1 : i32) : i32
      %107 = llvm.mlir.constant(32 : i32) : i32
      %108 = llvm.sub %107, %17 : i32
      %109 = llvm.lshr %106, %108 : i32
      %110 = llvm.sub %17, %105 : i32
      %111 = nvvm.shfl.sync  bfly %109, %20, %16, %110 : f32 -> f32
      %112 = llvm.fadd %111, %20 : f32
      %113 = llvm.mlir.constant(1 : i32) : i32
      %114 = llvm.mlir.constant(-1 : i32) : i32
      %115 = llvm.mlir.constant(32 : i32) : i32
      %116 = llvm.sub %115, %17 : i32
      %117 = llvm.lshr %114, %116 : i32
      %118 = llvm.sub %17, %113 : i32
      %119 = nvvm.shfl.sync  bfly %117, %112, %15, %118 : f32 -> f32
      %120 = llvm.fadd %112, %119 : f32
      %121 = llvm.mlir.constant(1 : i32) : i32
      %122 = llvm.mlir.constant(-1 : i32) : i32
      %123 = llvm.mlir.constant(32 : i32) : i32
      %124 = llvm.sub %123, %17 : i32
      %125 = llvm.lshr %122, %124 : i32
      %126 = llvm.sub %17, %121 : i32
      %127 = nvvm.shfl.sync  bfly %125, %120, %14, %126 : f32 -> f32
      %128 = llvm.fadd %120, %127 : f32
      %129 = llvm.mlir.constant(1 : i32) : i32
      %130 = llvm.mlir.constant(-1 : i32) : i32
      %131 = llvm.mlir.constant(32 : i32) : i32
      %132 = llvm.sub %131, %17 : i32
      %133 = llvm.lshr %130, %132 : i32
      %134 = llvm.sub %17, %129 : i32
      %135 = nvvm.shfl.sync  bfly %133, %128, %13, %134 : f32 -> f32
      %136 = llvm.fadd %128, %135 : f32
      %137 = llvm.mlir.constant(1 : i32) : i32
      %138 = llvm.mlir.constant(-1 : i32) : i32
      %139 = llvm.mlir.constant(32 : i32) : i32
      %140 = llvm.sub %139, %17 : i32
      %141 = llvm.lshr %138, %140 : i32
      %142 = llvm.sub %17, %137 : i32
      %143 = nvvm.shfl.sync  bfly %141, %136, %12, %142 : f32 -> f32
      %144 = llvm.fadd %136, %143 : f32
      llvm.br ^bb18(%144 : f32)
    ^bb18(%145: f32):  // 2 preds: ^bb16, ^bb17
      llvm.cond_br %46, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %146 = llvm.sdiv %43, %17 : i32
      %147 = llvm.sext %146 : i32 to i64
      %148 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %149 = llvm.getelementptr inbounds|nuw %148[%147] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      llvm.store %145, %149 : f32, !llvm.ptr<3>
      llvm.br ^bb21
    ^bb20:  // pred: ^bb18
      llvm.br ^bb21
    ^bb21:  // 2 preds: ^bb19, ^bb20
      nvvm.barrier0
      %150 = llvm.add %44, %19 : i32
      %151 = llvm.sdiv %150, %17 : i32
      %152 = llvm.icmp "slt" %43, %151 : i32
      llvm.cond_br %152, ^bb22, ^bb41
    ^bb22:  // pred: ^bb21
      %153 = llvm.sext %43 : i32 to i64
      %154 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %155 = llvm.getelementptr inbounds|nuw %154[%153] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      %156 = llvm.load %155 : !llvm.ptr<3> -> f32
      %157 = llvm.icmp "slt" %151, %17 : i32
      llvm.cond_br %157, ^bb23, ^bb39
    ^bb23:  // pred: ^bb22
      %158 = llvm.mlir.constant(1 : i32) : i32
      %159 = llvm.mlir.constant(-1 : i32) : i32
      %160 = llvm.mlir.constant(32 : i32) : i32
      %161 = llvm.sub %160, %151 : i32
      %162 = llvm.lshr %159, %161 : i32
      %163 = llvm.sub %151, %158 : i32
      %164 = nvvm.shfl.sync  bfly %162, %156, %16, %163 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
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
      %172 = llvm.sub %171, %151 : i32
      %173 = llvm.lshr %170, %172 : i32
      %174 = llvm.sub %151, %169 : i32
      %175 = nvvm.shfl.sync  bfly %173, %168, %15, %174 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
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
      %183 = llvm.sub %182, %151 : i32
      %184 = llvm.lshr %181, %183 : i32
      %185 = llvm.sub %151, %180 : i32
      %186 = nvvm.shfl.sync  bfly %184, %179, %14, %185 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
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
      %194 = llvm.sub %193, %151 : i32
      %195 = llvm.lshr %192, %194 : i32
      %196 = llvm.sub %151, %191 : i32
      %197 = nvvm.shfl.sync  bfly %195, %190, %13, %196 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
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
      %205 = llvm.sub %204, %151 : i32
      %206 = llvm.lshr %203, %205 : i32
      %207 = llvm.sub %151, %202 : i32
      %208 = nvvm.shfl.sync  bfly %206, %201, %12, %207 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
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
      %216 = llvm.sub %215, %17 : i32
      %217 = llvm.lshr %214, %216 : i32
      %218 = llvm.sub %17, %213 : i32
      %219 = nvvm.shfl.sync  bfly %217, %156, %16, %218 : f32 -> f32
      %220 = llvm.fadd %156, %219 : f32
      %221 = llvm.mlir.constant(1 : i32) : i32
      %222 = llvm.mlir.constant(-1 : i32) : i32
      %223 = llvm.mlir.constant(32 : i32) : i32
      %224 = llvm.sub %223, %17 : i32
      %225 = llvm.lshr %222, %224 : i32
      %226 = llvm.sub %17, %221 : i32
      %227 = nvvm.shfl.sync  bfly %225, %220, %15, %226 : f32 -> f32
      %228 = llvm.fadd %220, %227 : f32
      %229 = llvm.mlir.constant(1 : i32) : i32
      %230 = llvm.mlir.constant(-1 : i32) : i32
      %231 = llvm.mlir.constant(32 : i32) : i32
      %232 = llvm.sub %231, %17 : i32
      %233 = llvm.lshr %230, %232 : i32
      %234 = llvm.sub %17, %229 : i32
      %235 = nvvm.shfl.sync  bfly %233, %228, %14, %234 : f32 -> f32
      %236 = llvm.fadd %228, %235 : f32
      %237 = llvm.mlir.constant(1 : i32) : i32
      %238 = llvm.mlir.constant(-1 : i32) : i32
      %239 = llvm.mlir.constant(32 : i32) : i32
      %240 = llvm.sub %239, %17 : i32
      %241 = llvm.lshr %238, %240 : i32
      %242 = llvm.sub %17, %237 : i32
      %243 = nvvm.shfl.sync  bfly %241, %236, %13, %242 : f32 -> f32
      %244 = llvm.fadd %236, %243 : f32
      %245 = llvm.mlir.constant(1 : i32) : i32
      %246 = llvm.mlir.constant(-1 : i32) : i32
      %247 = llvm.mlir.constant(32 : i32) : i32
      %248 = llvm.sub %247, %17 : i32
      %249 = llvm.lshr %246, %248 : i32
      %250 = llvm.sub %17, %245 : i32
      %251 = nvvm.shfl.sync  bfly %249, %244, %12, %250 : f32 -> f32
      %252 = llvm.fadd %244, %251 : f32
      llvm.br ^bb40(%252 : f32)
    ^bb40(%253: f32):  // 2 preds: ^bb38, ^bb39
      %254 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %255 = llvm.getelementptr inbounds|nuw %254[%11] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      llvm.store %253, %255 : f32, !llvm.ptr<3>
      llvm.br ^bb42
    ^bb41:  // pred: ^bb21
      llvm.br ^bb42
    ^bb42:  // 2 preds: ^bb40, ^bb41
      nvvm.barrier0
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
      %11 = llvm.mlir.constant(0 : index) : i64
      %12 = llvm.mlir.constant(16 : i32) : i32
      %13 = llvm.mlir.constant(8 : i32) : i32
      %14 = llvm.mlir.constant(4 : i32) : i32
      %15 = llvm.mlir.constant(2 : i32) : i32
      %16 = llvm.mlir.constant(32 : i32) : i32
      %17 = llvm.mlir.constant(0 : i32) : i32
      %18 = llvm.mlir.constant(31 : i32) : i32
      %19 = llvm.mlir.constant(1 : i32) : i32
      %20 = nvvm.read.ptx.sreg.ntid.x : i32
      %21 = llvm.sext %20 : i32 to i64
      %22 = llvm.trunc %21 : i64 to i32
      %23 = nvvm.read.ptx.sreg.ntid.y : i32
      %24 = llvm.sext %23 : i32 to i64
      %25 = llvm.trunc %24 : i64 to i32
      %26 = nvvm.read.ptx.sreg.ntid.z : i32
      %27 = llvm.sext %26 : i32 to i64
      %28 = llvm.trunc %27 : i64 to i32
      %29 = nvvm.read.ptx.sreg.tid.x : i32
      %30 = llvm.sext %29 : i32 to i64
      %31 = llvm.trunc %30 : i64 to i32
      %32 = nvvm.read.ptx.sreg.tid.y : i32
      %33 = llvm.sext %32 : i32 to i64
      %34 = llvm.trunc %33 : i64 to i32
      %35 = nvvm.read.ptx.sreg.tid.z : i32
      %36 = llvm.sext %35 : i32 to i64
      %37 = llvm.trunc %36 : i64 to i32
      %38 = llvm.mul %37, %25 : i32
      %39 = llvm.add %38, %34 : i32
      %40 = llvm.mul %39, %22 : i32
      %41 = llvm.mul %22, %25 : i32
      %42 = llvm.add %40, %31 : i32
      %43 = llvm.mul %41, %28 : i32
      %44 = llvm.and %42, %18 : i32
      %45 = llvm.icmp "eq" %44, %17 : i32
      %46 = llvm.sub %42, %44 : i32
      %47 = llvm.sub %43, %46 : i32
      %48 = llvm.icmp "slt" %47, %16 : i32
      llvm.cond_br %48, ^bb1, ^bb22
    ^bb1:  // pred: ^bb0
      %49 = llvm.mlir.constant(1 : i32) : i32
      %50 = llvm.mlir.constant(-1 : i32) : i32
      %51 = llvm.mlir.constant(32 : i32) : i32
      %52 = llvm.sub %51, %47 : i32
      %53 = llvm.lshr %50, %52 : i32
      %54 = llvm.sub %47, %49 : i32
      %55 = nvvm.shfl.sync  bfly %53, %19, %19, %54 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %56 = llvm.extractvalue %55[0] : !llvm.struct<(i32, i1)> 
      %57 = llvm.extractvalue %55[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %57, ^bb2, ^bb4(%19 : i32)
    ^bb2:  // pred: ^bb1
      llvm.br ^bb3
    ^bb3:  // pred: ^bb2
      %58 = llvm.xor %56, %19 : i32
      llvm.br ^bb4(%58 : i32)
    ^bb4(%59: i32):  // 2 preds: ^bb1, ^bb3
      llvm.br ^bb5
    ^bb5:  // pred: ^bb4
      %60 = llvm.mlir.constant(1 : i32) : i32
      %61 = llvm.mlir.constant(-1 : i32) : i32
      %62 = llvm.mlir.constant(32 : i32) : i32
      %63 = llvm.sub %62, %47 : i32
      %64 = llvm.lshr %61, %63 : i32
      %65 = llvm.sub %47, %60 : i32
      %66 = nvvm.shfl.sync  bfly %64, %59, %15, %65 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %67 = llvm.extractvalue %66[0] : !llvm.struct<(i32, i1)> 
      %68 = llvm.extractvalue %66[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %68, ^bb6, ^bb8(%59 : i32)
    ^bb6:  // pred: ^bb5
      llvm.br ^bb7
    ^bb7:  // pred: ^bb6
      %69 = llvm.xor %59, %67 : i32
      llvm.br ^bb8(%69 : i32)
    ^bb8(%70: i32):  // 2 preds: ^bb5, ^bb7
      llvm.br ^bb9
    ^bb9:  // pred: ^bb8
      %71 = llvm.mlir.constant(1 : i32) : i32
      %72 = llvm.mlir.constant(-1 : i32) : i32
      %73 = llvm.mlir.constant(32 : i32) : i32
      %74 = llvm.sub %73, %47 : i32
      %75 = llvm.lshr %72, %74 : i32
      %76 = llvm.sub %47, %71 : i32
      %77 = nvvm.shfl.sync  bfly %75, %70, %14, %76 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %78 = llvm.extractvalue %77[0] : !llvm.struct<(i32, i1)> 
      %79 = llvm.extractvalue %77[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %79, ^bb10, ^bb12(%70 : i32)
    ^bb10:  // pred: ^bb9
      llvm.br ^bb11
    ^bb11:  // pred: ^bb10
      %80 = llvm.xor %70, %78 : i32
      llvm.br ^bb12(%80 : i32)
    ^bb12(%81: i32):  // 2 preds: ^bb9, ^bb11
      llvm.br ^bb13
    ^bb13:  // pred: ^bb12
      %82 = llvm.mlir.constant(1 : i32) : i32
      %83 = llvm.mlir.constant(-1 : i32) : i32
      %84 = llvm.mlir.constant(32 : i32) : i32
      %85 = llvm.sub %84, %47 : i32
      %86 = llvm.lshr %83, %85 : i32
      %87 = llvm.sub %47, %82 : i32
      %88 = nvvm.shfl.sync  bfly %86, %81, %13, %87 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %89 = llvm.extractvalue %88[0] : !llvm.struct<(i32, i1)> 
      %90 = llvm.extractvalue %88[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %90, ^bb14, ^bb16(%81 : i32)
    ^bb14:  // pred: ^bb13
      llvm.br ^bb15
    ^bb15:  // pred: ^bb14
      %91 = llvm.xor %81, %89 : i32
      llvm.br ^bb16(%91 : i32)
    ^bb16(%92: i32):  // 2 preds: ^bb13, ^bb15
      llvm.br ^bb17
    ^bb17:  // pred: ^bb16
      %93 = llvm.mlir.constant(1 : i32) : i32
      %94 = llvm.mlir.constant(-1 : i32) : i32
      %95 = llvm.mlir.constant(32 : i32) : i32
      %96 = llvm.sub %95, %47 : i32
      %97 = llvm.lshr %94, %96 : i32
      %98 = llvm.sub %47, %93 : i32
      %99 = nvvm.shfl.sync  bfly %97, %92, %12, %98 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
      %100 = llvm.extractvalue %99[0] : !llvm.struct<(i32, i1)> 
      %101 = llvm.extractvalue %99[1] : !llvm.struct<(i32, i1)> 
      llvm.cond_br %101, ^bb18, ^bb20(%92 : i32)
    ^bb18:  // pred: ^bb17
      llvm.br ^bb19
    ^bb19:  // pred: ^bb18
      %102 = llvm.xor %92, %100 : i32
      llvm.br ^bb20(%102 : i32)
    ^bb20(%103: i32):  // 2 preds: ^bb17, ^bb19
      llvm.br ^bb21(%103 : i32)
    ^bb21(%104: i32):  // 2 preds: ^bb20, ^bb31
      llvm.br ^bb32
    ^bb22:  // pred: ^bb0
      %105 = llvm.mlir.constant(1 : i32) : i32
      %106 = llvm.mlir.constant(-1 : i32) : i32
      %107 = llvm.mlir.constant(32 : i32) : i32
      %108 = llvm.sub %107, %16 : i32
      %109 = llvm.lshr %106, %108 : i32
      %110 = llvm.sub %16, %105 : i32
      %111 = nvvm.shfl.sync  bfly %109, %19, %19, %110 : i32 -> i32
      llvm.br ^bb23
    ^bb23:  // pred: ^bb22
      %112 = llvm.xor %111, %19 : i32
      llvm.br ^bb24
    ^bb24:  // pred: ^bb23
      %113 = llvm.mlir.constant(1 : i32) : i32
      %114 = llvm.mlir.constant(-1 : i32) : i32
      %115 = llvm.mlir.constant(32 : i32) : i32
      %116 = llvm.sub %115, %16 : i32
      %117 = llvm.lshr %114, %116 : i32
      %118 = llvm.sub %16, %113 : i32
      %119 = nvvm.shfl.sync  bfly %117, %112, %15, %118 : i32 -> i32
      llvm.br ^bb25
    ^bb25:  // pred: ^bb24
      %120 = llvm.xor %112, %119 : i32
      llvm.br ^bb26
    ^bb26:  // pred: ^bb25
      %121 = llvm.mlir.constant(1 : i32) : i32
      %122 = llvm.mlir.constant(-1 : i32) : i32
      %123 = llvm.mlir.constant(32 : i32) : i32
      %124 = llvm.sub %123, %16 : i32
      %125 = llvm.lshr %122, %124 : i32
      %126 = llvm.sub %16, %121 : i32
      %127 = nvvm.shfl.sync  bfly %125, %120, %14, %126 : i32 -> i32
      llvm.br ^bb27
    ^bb27:  // pred: ^bb26
      %128 = llvm.xor %120, %127 : i32
      llvm.br ^bb28
    ^bb28:  // pred: ^bb27
      %129 = llvm.mlir.constant(1 : i32) : i32
      %130 = llvm.mlir.constant(-1 : i32) : i32
      %131 = llvm.mlir.constant(32 : i32) : i32
      %132 = llvm.sub %131, %16 : i32
      %133 = llvm.lshr %130, %132 : i32
      %134 = llvm.sub %16, %129 : i32
      %135 = nvvm.shfl.sync  bfly %133, %128, %13, %134 : i32 -> i32
      llvm.br ^bb29
    ^bb29:  // pred: ^bb28
      %136 = llvm.xor %128, %135 : i32
      llvm.br ^bb30
    ^bb30:  // pred: ^bb29
      %137 = llvm.mlir.constant(1 : i32) : i32
      %138 = llvm.mlir.constant(-1 : i32) : i32
      %139 = llvm.mlir.constant(32 : i32) : i32
      %140 = llvm.sub %139, %16 : i32
      %141 = llvm.lshr %138, %140 : i32
      %142 = llvm.sub %16, %137 : i32
      %143 = nvvm.shfl.sync  bfly %141, %136, %12, %142 : i32 -> i32
      llvm.br ^bb31
    ^bb31:  // pred: ^bb30
      %144 = llvm.xor %136, %143 : i32
      llvm.br ^bb21(%144 : i32)
    ^bb32:  // pred: ^bb21
      llvm.cond_br %45, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %145 = llvm.sdiv %42, %16 : i32
      %146 = llvm.sext %145 : i32 to i64
      %147 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %148 = llvm.getelementptr inbounds|nuw %147[%146] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i32
      llvm.store %104, %148 : i32, !llvm.ptr<3>
      llvm.br ^bb35
    ^bb34:  // pred: ^bb32
      llvm.br ^bb35
    ^bb35:  // 2 preds: ^bb33, ^bb34
      nvvm.barrier0
      %149 = llvm.add %43, %18 : i32
      %150 = llvm.sdiv %149, %16 : i32
      %151 = llvm.icmp "slt" %42, %150 : i32
      llvm.cond_br %151, ^bb36, ^bb69
    ^bb36:  // pred: ^bb35
      %152 = llvm.sext %42 : i32 to i64
      %153 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %154 = llvm.getelementptr inbounds|nuw %153[%152] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i32
      %155 = llvm.load %154 : !llvm.ptr<3> -> i32
      %156 = llvm.icmp "slt" %150, %16 : i32
      llvm.cond_br %156, ^bb37, ^bb58
    ^bb37:  // pred: ^bb36
      %157 = llvm.mlir.constant(1 : i32) : i32
      %158 = llvm.mlir.constant(-1 : i32) : i32
      %159 = llvm.mlir.constant(32 : i32) : i32
      %160 = llvm.sub %159, %150 : i32
      %161 = llvm.lshr %158, %160 : i32
      %162 = llvm.sub %150, %157 : i32
      %163 = nvvm.shfl.sync  bfly %161, %155, %19, %162 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
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
      %171 = llvm.sub %170, %150 : i32
      %172 = llvm.lshr %169, %171 : i32
      %173 = llvm.sub %150, %168 : i32
      %174 = nvvm.shfl.sync  bfly %172, %167, %15, %173 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
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
      %182 = llvm.sub %181, %150 : i32
      %183 = llvm.lshr %180, %182 : i32
      %184 = llvm.sub %150, %179 : i32
      %185 = nvvm.shfl.sync  bfly %183, %178, %14, %184 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
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
      %193 = llvm.sub %192, %150 : i32
      %194 = llvm.lshr %191, %193 : i32
      %195 = llvm.sub %150, %190 : i32
      %196 = nvvm.shfl.sync  bfly %194, %189, %13, %195 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
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
      %204 = llvm.sub %203, %150 : i32
      %205 = llvm.lshr %202, %204 : i32
      %206 = llvm.sub %150, %201 : i32
      %207 = nvvm.shfl.sync  bfly %205, %200, %12, %206 {return_value_and_is_valid} : i32 -> !llvm.struct<(i32, i1)>
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
      %216 = llvm.sub %215, %16 : i32
      %217 = llvm.lshr %214, %216 : i32
      %218 = llvm.sub %16, %213 : i32
      %219 = nvvm.shfl.sync  bfly %217, %155, %19, %218 : i32 -> i32
      llvm.br ^bb59
    ^bb59:  // pred: ^bb58
      %220 = llvm.xor %155, %219 : i32
      llvm.br ^bb60
    ^bb60:  // pred: ^bb59
      %221 = llvm.mlir.constant(1 : i32) : i32
      %222 = llvm.mlir.constant(-1 : i32) : i32
      %223 = llvm.mlir.constant(32 : i32) : i32
      %224 = llvm.sub %223, %16 : i32
      %225 = llvm.lshr %222, %224 : i32
      %226 = llvm.sub %16, %221 : i32
      %227 = nvvm.shfl.sync  bfly %225, %220, %15, %226 : i32 -> i32
      llvm.br ^bb61
    ^bb61:  // pred: ^bb60
      %228 = llvm.xor %220, %227 : i32
      llvm.br ^bb62
    ^bb62:  // pred: ^bb61
      %229 = llvm.mlir.constant(1 : i32) : i32
      %230 = llvm.mlir.constant(-1 : i32) : i32
      %231 = llvm.mlir.constant(32 : i32) : i32
      %232 = llvm.sub %231, %16 : i32
      %233 = llvm.lshr %230, %232 : i32
      %234 = llvm.sub %16, %229 : i32
      %235 = nvvm.shfl.sync  bfly %233, %228, %14, %234 : i32 -> i32
      llvm.br ^bb63
    ^bb63:  // pred: ^bb62
      %236 = llvm.xor %228, %235 : i32
      llvm.br ^bb64
    ^bb64:  // pred: ^bb63
      %237 = llvm.mlir.constant(1 : i32) : i32
      %238 = llvm.mlir.constant(-1 : i32) : i32
      %239 = llvm.mlir.constant(32 : i32) : i32
      %240 = llvm.sub %239, %16 : i32
      %241 = llvm.lshr %238, %240 : i32
      %242 = llvm.sub %16, %237 : i32
      %243 = nvvm.shfl.sync  bfly %241, %236, %13, %242 : i32 -> i32
      llvm.br ^bb65
    ^bb65:  // pred: ^bb64
      %244 = llvm.xor %236, %243 : i32
      llvm.br ^bb66
    ^bb66:  // pred: ^bb65
      %245 = llvm.mlir.constant(1 : i32) : i32
      %246 = llvm.mlir.constant(-1 : i32) : i32
      %247 = llvm.mlir.constant(32 : i32) : i32
      %248 = llvm.sub %247, %16 : i32
      %249 = llvm.lshr %246, %248 : i32
      %250 = llvm.sub %16, %245 : i32
      %251 = nvvm.shfl.sync  bfly %249, %244, %12, %250 : i32 -> i32
      llvm.br ^bb67
    ^bb67:  // pred: ^bb66
      %252 = llvm.xor %244, %251 : i32
      llvm.br ^bb57(%252 : i32)
    ^bb68:  // pred: ^bb57
      %253 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %254 = llvm.getelementptr inbounds|nuw %253[%11] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i32
      llvm.store %212, %254 : i32, !llvm.ptr<3>
      llvm.br ^bb70
    ^bb69:  // pred: ^bb35
      llvm.br ^bb70
    ^bb70:  // 2 preds: ^bb68, ^bb69
      nvvm.barrier0
      llvm.return
    }
  }
  gpu.module @test_module_4 {
    llvm.func @gpu_shuffle() -> !llvm.struct<(f32, f32, f32, f32, i1, i1, i1, i1)> attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
      %1 = llvm.mlir.constant(4 : i32) : i32
      %2 = llvm.mlir.constant(23 : i32) : i32
      %3 = llvm.mlir.constant(1 : i32) : i32
      %4 = llvm.mlir.constant(-1 : i32) : i32
      %5 = llvm.mlir.constant(32 : i32) : i32
      %6 = llvm.sub %5, %2 : i32
      %7 = llvm.lshr %4, %6 : i32
      %8 = llvm.sub %2, %3 : i32
      %9 = nvvm.shfl.sync  bfly %7, %0, %1, %8 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %10 = llvm.extractvalue %9[0] : !llvm.struct<(f32, i1)> 
      %11 = llvm.extractvalue %9[1] : !llvm.struct<(f32, i1)> 
      %12 = llvm.mlir.constant(1 : i32) : i32
      %13 = llvm.mlir.constant(-1 : i32) : i32
      %14 = llvm.mlir.constant(32 : i32) : i32
      %15 = llvm.sub %14, %2 : i32
      %16 = llvm.lshr %13, %15 : i32
      %17 = nvvm.shfl.sync  up %16, %0, %1, %15 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %18 = llvm.extractvalue %17[0] : !llvm.struct<(f32, i1)> 
      %19 = llvm.extractvalue %17[1] : !llvm.struct<(f32, i1)> 
      %20 = llvm.mlir.constant(1 : i32) : i32
      %21 = llvm.mlir.constant(-1 : i32) : i32
      %22 = llvm.mlir.constant(32 : i32) : i32
      %23 = llvm.sub %22, %2 : i32
      %24 = llvm.lshr %21, %23 : i32
      %25 = llvm.sub %2, %20 : i32
      %26 = nvvm.shfl.sync  down %24, %0, %1, %25 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
      %27 = llvm.extractvalue %26[0] : !llvm.struct<(f32, i1)> 
      %28 = llvm.extractvalue %26[1] : !llvm.struct<(f32, i1)> 
      %29 = llvm.mlir.constant(1 : i32) : i32
      %30 = llvm.mlir.constant(-1 : i32) : i32
      %31 = llvm.mlir.constant(32 : i32) : i32
      %32 = llvm.sub %31, %2 : i32
      %33 = llvm.lshr %30, %32 : i32
      %34 = llvm.sub %2, %29 : i32
      %35 = nvvm.shfl.sync  idx %33, %0, %1, %34 {return_value_and_is_valid} : f32 -> !llvm.struct<(f32, i1)>
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
    llvm.func @gpu_shuffle_unused_pred() -> !llvm.struct<(f32, f32, f32, f32)> attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
      %1 = llvm.mlir.constant(4 : i32) : i32
      %2 = llvm.mlir.constant(23 : i32) : i32
      %3 = llvm.mlir.constant(1 : i32) : i32
      %4 = llvm.mlir.constant(-1 : i32) : i32
      %5 = llvm.mlir.constant(32 : i32) : i32
      %6 = llvm.sub %5, %2 : i32
      %7 = llvm.lshr %4, %6 : i32
      %8 = llvm.sub %2, %3 : i32
      %9 = nvvm.shfl.sync  bfly %7, %0, %1, %8 : f32 -> f32
      %10 = llvm.mlir.constant(1 : i32) : i32
      %11 = llvm.mlir.constant(-1 : i32) : i32
      %12 = llvm.mlir.constant(32 : i32) : i32
      %13 = llvm.sub %12, %2 : i32
      %14 = llvm.lshr %11, %13 : i32
      %15 = nvvm.shfl.sync  up %14, %0, %1, %13 : f32 -> f32
      %16 = llvm.mlir.constant(1 : i32) : i32
      %17 = llvm.mlir.constant(-1 : i32) : i32
      %18 = llvm.mlir.constant(32 : i32) : i32
      %19 = llvm.sub %18, %2 : i32
      %20 = llvm.lshr %17, %19 : i32
      %21 = llvm.sub %2, %16 : i32
      %22 = nvvm.shfl.sync  down %20, %0, %1, %21 : f32 -> f32
      %23 = llvm.mlir.constant(1 : i32) : i32
      %24 = llvm.mlir.constant(-1 : i32) : i32
      %25 = llvm.mlir.constant(32 : i32) : i32
      %26 = llvm.sub %25, %2 : i32
      %27 = llvm.lshr %24, %26 : i32
      %28 = llvm.sub %2, %23 : i32
      %29 = nvvm.shfl.sync  idx %27, %0, %1, %28 : f32 -> f32
      %30 = llvm.mlir.poison : !llvm.struct<(f32, f32, f32, f32)>
      %31 = llvm.insertvalue %9, %30[0] : !llvm.struct<(f32, f32, f32, f32)> 
      %32 = llvm.insertvalue %15, %31[1] : !llvm.struct<(f32, f32, f32, f32)> 
      %33 = llvm.insertvalue %22, %32[2] : !llvm.struct<(f32, f32, f32, f32)> 
      %34 = llvm.insertvalue %29, %33[3] : !llvm.struct<(f32, f32, f32, f32)> 
      llvm.return %34 : !llvm.struct<(f32, f32, f32, f32)>
    }
  }
  gpu.module @test_module_5 {
    llvm.func @gpu_sync() attributes {llvm.emit_c_interface} {
      nvvm.barrier0
      llvm.return
    }
  }
  gpu.module @test_module_6 {
    llvm.func @__nv_fabsf(f32) -> f32
    llvm.func @__nv_fabs(f64) -> f64
    llvm.func @gpu_fabs(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_cbrt(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_ceil(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_floor(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_cos(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_exp(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_exp2(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_log(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_log10(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_log1p(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_log2(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_sin(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_tan(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64, f32)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_tanh(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_rsqrt(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_sqrt(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_atan(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_atan2(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_expm1(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_pow(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_unroll(%arg0: vector<4xf32>) -> vector<4xf32> attributes {llvm.emit_c_interface} {
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
    llvm.func @subgroup_reduce_add(%arg0: i32) {
      %0 = llvm.mlir.constant(-1 : i32) : i32
      %1 = nvvm.redux.sync  add %arg0, %0 : i32 -> i32
      llvm.return
    }
    llvm.func @subgroup_reduce_minsi(%arg0: i32) {
      %0 = llvm.mlir.constant(-1 : i32) : i32
      %1 = nvvm.redux.sync  min %arg0, %0 : i32 -> i32
      llvm.return
    }
    llvm.func @subgroup_reduce_maxsi(%arg0: i32) {
      %0 = llvm.mlir.constant(-1 : i32) : i32
      %1 = nvvm.redux.sync  max %arg0, %0 : i32 -> i32
      llvm.return
    }
    llvm.func @subgroup_reduce_and(%arg0: i32) {
      %0 = llvm.mlir.constant(-1 : i32) : i32
      %1 = nvvm.redux.sync  and %arg0, %0 : i32 -> i32
      llvm.return
    }
    llvm.func @subgroup_reduce_or(%arg0: i32) {
      %0 = llvm.mlir.constant(-1 : i32) : i32
      %1 = nvvm.redux.sync  or %arg0, %0 : i32 -> i32
      llvm.return
    }
    llvm.func @subgroup_reduce_xor(%arg0: i32) {
      %0 = llvm.mlir.constant(-1 : i32) : i32
      %1 = nvvm.redux.sync  xor %arg0, %0 : i32 -> i32
      llvm.return
    }
  }
  gpu.module @test_module_31 {
    llvm.func @__nv_fmodf(f32, f32) -> f32
    llvm.func @__nv_fmod(f64, f64) -> f64
    llvm.func @gpu_fmod(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_erf(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @memref_signature(%arg0: !llvm.ptr, %arg1: f32) -> !llvm.struct<(ptr, f32)> {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %2 = llvm.insertvalue %arg0, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %3 = llvm.mlir.constant(0 : index) : i64
      %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.mlir.constant(2 : index) : i64
      %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %7 = llvm.mlir.constant(1 : index) : i64
      %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %9 = llvm.extractvalue %8[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %10 = llvm.mlir.poison : !llvm.struct<(ptr, f32)>
      %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<(ptr, f32)> 
      %12 = llvm.insertvalue %arg1, %11[1] : !llvm.struct<(ptr, f32)> 
      llvm.return %12 : !llvm.struct<(ptr, f32)>
    }
  }
  gpu.module @test_module_35 {
    llvm.func @__nv_acosf(f32) -> f32
    llvm.func @__nv_acos(f64) -> f64
    llvm.func @gpu_acos(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_acosh(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_asin(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_asinh(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_atanh(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_copysign(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_cosh(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_fma(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_round(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_roundeven(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_sinh(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_cosh_with_fastmath(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_sinh_with_fastmath(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_exp_with_fastmath(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64, f32)> attributes {llvm.emit_c_interface} {
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
    llvm.func @explicit_id_bounds() -> !llvm.struct<(i64, i64, i64)> attributes {llvm.emit_c_interface} {
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
    llvm.mlir.global internal constant @assert_file_0("/home/zq/coding/llvm-project/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm.mlir\00") {addr_space = 0 : i32}
    llvm.mlir.global internal constant @assert_message_0("assert message\00") {addr_space = 0 : i32}
    llvm.func @__assertfail(!llvm.ptr, !llvm.ptr, i32, !llvm.ptr, i64) attributes {passthrough = ["noreturn"]}
    llvm.func @test_assert(%arg0: i1) attributes {gpu.kernel, nvvm.kernel} {
      llvm.cond_br %arg0, ^bb2, ^bb1
    ^bb1:  // pred: ^bb0
      %0 = llvm.mlir.addressof @assert_message_0 : !llvm.ptr
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<15 x i8>
      %2 = llvm.mlir.addressof @assert_file_0 : !llvm.ptr
      %3 = llvm.getelementptr %2[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<77 x i8>
      %4 = llvm.mlir.addressof @assert_func_0 : !llvm.ptr
      %5 = llvm.getelementptr %4[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x i8>
      %6 = llvm.mlir.constant(998 : i32) : i32
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
      } {illegal_dialects = ["gpu"], illegal_ops = ["llvm.copysign", "llvm.cos", "llvm.exp", "llvm.exp2", "llvm.fabs", "llvm.fceil", "llvm.ffloor", "llvm.frem", "llvm.log", "llvm.log10", "llvm.log2", "llvm.pow", "llvm.roundeven", "llvm.round", "llvm.sin", "llvm.sqrt"], legal_dialects = ["llvm", "memref", "nvvm", "test"], legal_ops = ["func.func", "gpu.module", "gpu.yield"], partial_conversion} : !transform.any_op
      transform.yield 
    }
  }
  gpu.module @test_module_52 {
    llvm.func @__nv_abs(i32) -> i32
    llvm.func @gpu_abs(%arg0: i32) -> i32 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__nv_abs(%arg0) : (i32) -> i32
      llvm.return %0 : i32
    }
  }
  gpu.module @test_module_53 {
    llvm.func @__nv_powif(f32, i32) -> f32
    llvm.func @__nv_powi(f64, i32) -> f64
    llvm.func @gpu_powi(%arg0: f32, %arg1: f64, %arg2: i32) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @fpclassify(%arg0: f32, %arg1: f64) -> !llvm.struct<(i1, i1, i1, i1, i1, i1)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_erfc(%arg0: f32, %arg1: f64) -> !llvm.struct<(f32, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_sincos(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)> attributes {llvm.emit_c_interface} {
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
    llvm.func @gpu_sincos_fastmath(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f16, f32, f32, f64, f64)> attributes {llvm.emit_c_interface} {
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
}

// -----
module {
  gpu.module @test_module_cluster_size {
    llvm.func @kernel_with_cluster_size() attributes {gpu.kernel, gpu.known_cluster_size = array<i32: 8, 2, 4>, nvvm.cluster_dim = array<i32: 8, 2, 4>, nvvm.kernel} {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module_cluster_block_ops {
    llvm.func @kernel_with_cluster_size(%arg0: !llvm.ptr) attributes {gpu.kernel, gpu.known_cluster_size = array<i32: 8, 4, 2>, nvvm.cluster_dim = array<i32: 8, 4, 2>, nvvm.kernel} {
      %0 = nvvm.read.ptx.sreg.cluster.ctaid.x range <i32, 0, 8> : i32
      %1 = llvm.sext %0 : i32 to i64
      %2 = nvvm.read.ptx.sreg.cluster.ctaid.y range <i32, 0, 4> : i32
      %3 = llvm.sext %2 : i32 to i64
      %4 = nvvm.read.ptx.sreg.cluster.ctaid.z range <i32, 0, 2> : i32
      %5 = llvm.sext %4 : i32 to i64
      %6 = nvvm.read.ptx.sreg.cluster.nctaid.x range <i32, 1, 9> : i32
      %7 = llvm.sext %6 : i32 to i64
      %8 = nvvm.read.ptx.sreg.cluster.nctaid.y range <i32, 1, 5> : i32
      %9 = llvm.sext %8 : i32 to i64
      %10 = nvvm.read.ptx.sreg.cluster.nctaid.z range <i32, 1, 3> : i32
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
}


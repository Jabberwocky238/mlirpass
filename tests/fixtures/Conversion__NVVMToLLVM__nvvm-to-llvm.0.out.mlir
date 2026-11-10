module {
  llvm.func @init_mbarrier(%arg0: !llvm.ptr, %arg1: !llvm.ptr<3>, %arg2: i32, %arg3: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$2 mbarrier.init.shared.b64 [$0], $1;", "r,r,b" %arg1, %arg2, %arg3 : (!llvm.ptr<3>, i32, i1) -> ()
    llvm.inline_asm has_side_effects asm_dialect = att "@$2 mbarrier.init.b64 [$0], $1;", "l,r,b" %arg0, %arg2, %arg3 : (!llvm.ptr, i32, i1) -> ()
    llvm.return
  }
  llvm.func @init_mbarrier_arrive_expect_tx(%arg0: !llvm.ptr<3>, %arg1: i32, %arg2: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$2 mbarrier.arrive.expect_tx.shared.b64 _, [$0], $1;", "r,r,b" %arg0, %arg1, %arg2 : (!llvm.ptr<3>, i32, i1) -> ()
    llvm.return
  }
  llvm.func @init_mbarrier_arrive_expect_tx_generic(%arg0: !llvm.ptr, %arg1: i32, %arg2: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$2 mbarrier.arrive.expect_tx.b64 _, [$0], $1;", "l,r,b" %arg0, %arg1, %arg2 : (!llvm.ptr, i32, i1) -> ()
    llvm.return
  }
  llvm.func @init_mbarrier_try_wait_shared(%arg0: !llvm.ptr<3>, %arg1: i32, %arg2: i32) {
    llvm.inline_asm has_side_effects asm_dialect = att "{\0A\09.reg .pred       P1; \0A\09LAB_WAIT: \0A\09mbarrier.try_wait.parity.shared.b64 P1, [$0], $1, $2; \0A\09@P1 bra.uni DONE; \0A\09bra.uni     LAB_WAIT; \0A\09DONE: \0A\09}", "r,r,r" %arg0, %arg2, %arg1 : (!llvm.ptr<3>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @init_mbarrier_try_wait(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    llvm.inline_asm has_side_effects asm_dialect = att "{\0A\09.reg .pred       P1; \0A\09LAB_WAIT: \0A\09mbarrier.try_wait.parity.b64 P1, [$0], $1, $2; \0A\09@P1 bra.uni DONE; \0A\09bra.uni     LAB_WAIT; \0A\09DONE: \0A\09}", "l,r,r" %arg0, %arg2, %arg1 : (!llvm.ptr, i32, i32) -> ()
    llvm.return
  }
  func.func @async_cp(%arg0: !llvm.ptr<3>, %arg1: !llvm.ptr<1>) {
    nvvm.cp.async.shared.global %arg0, %arg1, 16, cache = ca : !llvm.ptr<3>, !llvm.ptr<1>
    nvvm.cp.async.shared.global %arg0, %arg1, 16, cache = cg : !llvm.ptr<3>, !llvm.ptr<1>
    return
  }
  func.func @async_cp_zfill(%arg0: !llvm.ptr<3>, %arg1: !llvm.ptr<1>, %arg2: i32) {
    nvvm.cp.async.shared.global %arg0, %arg1, 16, cache = cg, %arg2 : !llvm.ptr<3>, !llvm.ptr<1>, i32
    nvvm.cp.async.shared.global %arg0, %arg1, 4, cache = ca, %arg2 : !llvm.ptr<3>, !llvm.ptr<1>, i32
    return
  }
  func.func @cp_async_mbarrier_arrive(%arg0: !llvm.ptr<3>, %arg1: !llvm.ptr) {
    nvvm.cp.async.mbarrier.arrive %arg1 : !llvm.ptr
    nvvm.cp.async.mbarrier.arrive %arg1 {noinc = true} : !llvm.ptr
    nvvm.cp.async.mbarrier.arrive %arg0 : !llvm.ptr<3>
    nvvm.cp.async.mbarrier.arrive %arg0 {noinc = true} : !llvm.ptr<3>
    llvm.return
  }
  func.func @tma_load_3d_all(%arg0: !llvm.ptr, %arg1: !llvm.ptr<7>, %arg2: !llvm.ptr<3>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i16, %arg8: i16, %arg9: i16, %arg10: i64, %arg11: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$9 cp.async.bulk.tensor.3d.shared::cluster.global.mbarrier::complete_tx::bytes.im2col.multicast::cluster.L2::cache_hint [$0], [$1, {$2,$3,$4} ], [$5],{$6}, $7, $8;", "l,l,r,r,r,r,h,h,l,b" %arg1, %arg0, %arg3, %arg4, %arg5, %arg2, %arg7, %arg9, %arg10, %arg11 : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, !llvm.ptr<3>, i16, i16, i64, i1) -> ()
    return
  }
  func.func @tma_load_4d_all(%arg0: !llvm.ptr, %arg1: !llvm.ptr<7>, %arg2: !llvm.ptr<3>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i16, %arg8: i16, %arg9: i16, %arg10: i64, %arg11: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$11 cp.async.bulk.tensor.4d.shared::cluster.global.mbarrier::complete_tx::bytes.im2col.multicast::cluster.L2::cache_hint [$0], [$1, {$2,$3,$4,$5} ], [$6],{$7,$8}, $9, $10;", "l,l,r,r,r,r,r,h,h,h,l,b" %arg1, %arg0, %arg3, %arg4, %arg5, %arg6, %arg2, %arg7, %arg8, %arg9, %arg10, %arg11 : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, !llvm.ptr<3>, i16, i16, i16, i64, i1) -> ()
    return
  }
  func.func @tma_load_5d_all(%arg0: !llvm.ptr, %arg1: !llvm.ptr<7>, %arg2: !llvm.ptr<3>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i16, %arg9: i16, %arg10: i16, %arg11: i16, %arg12: i64, %arg13: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$13 cp.async.bulk.tensor.5d.shared::cluster.global.mbarrier::complete_tx::bytes.im2col.multicast::cluster.L2::cache_hint [$0], [$1, {$2,$3,$4,$5,$6} ], [$7],{$8,$9,$10}, $11, $12;", "l,l,r,r,r,r,r,r,h,h,h,h,l,b" %arg1, %arg0, %arg3, %arg4, %arg5, %arg6, %arg7, %arg2, %arg8, %arg9, %arg10, %arg11, %arg12, %arg13 : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, i32, !llvm.ptr<3>, i16, i16, i16, i16, i64, i1) -> ()
    return
  }
  func.func @tma_load_1d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<7>, %arg2: !llvm.ptr<3>, %arg3: i32, %arg4: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$4 cp.async.bulk.tensor.1d.shared::cluster.global.mbarrier::complete_tx::bytes [$0], [$1, {$2} ], [$3];", "l,l,r,r,b" %arg1, %arg0, %arg3, %arg2, %arg4 : (!llvm.ptr<7>, !llvm.ptr, i32, !llvm.ptr<3>, i1) -> ()
    return
  }
  func.func @tma_load_2d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<7>, %arg2: !llvm.ptr<3>, %arg3: i32, %arg4: i32, %arg5: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$5 cp.async.bulk.tensor.2d.shared::cluster.global.mbarrier::complete_tx::bytes [$0], [$1, {$2,$3} ], [$4];", "l,l,r,r,r,b" %arg1, %arg0, %arg3, %arg4, %arg2, %arg5 : (!llvm.ptr<7>, !llvm.ptr, i32, i32, !llvm.ptr<3>, i1) -> ()
    return
  }
  func.func @tma_load_3d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<7>, %arg2: !llvm.ptr<3>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$6 cp.async.bulk.tensor.3d.shared::cluster.global.mbarrier::complete_tx::bytes [$0], [$1, {$2,$3,$4} ], [$5];", "l,l,r,r,r,r,b" %arg1, %arg0, %arg3, %arg4, %arg5, %arg2, %arg6 : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, !llvm.ptr<3>, i1) -> ()
    return
  }
  func.func @tma_load_4d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<7>, %arg2: !llvm.ptr<3>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$7 cp.async.bulk.tensor.4d.shared::cluster.global.mbarrier::complete_tx::bytes [$0], [$1, {$2,$3,$4,$5} ], [$6];", "l,l,r,r,r,r,r,b" %arg1, %arg0, %arg3, %arg4, %arg5, %arg6, %arg2, %arg7 : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, !llvm.ptr<3>, i1) -> ()
    return
  }
  func.func @tma_load_5d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<7>, %arg2: !llvm.ptr<3>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$8 cp.async.bulk.tensor.5d.shared::cluster.global.mbarrier::complete_tx::bytes [$0], [$1, {$2,$3,$4,$5,$6} ], [$7];", "l,l,r,r,r,r,r,r,b" %arg1, %arg0, %arg3, %arg4, %arg5, %arg6, %arg7, %arg2, %arg8 : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, i32, !llvm.ptr<3>, i1) -> ()
    return
  }
  func.func @tma_load_multicast1d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<7>, %arg2: !llvm.ptr<3>, %arg3: i16, %arg4: i32, %arg5: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$5 cp.async.bulk.tensor.1d.shared::cluster.global.mbarrier::complete_tx::bytes.multicast::cluster [$0], [$1, {$2} ], [$3], $4;", "l,l,r,r,h,b" %arg1, %arg0, %arg4, %arg2, %arg3, %arg5 : (!llvm.ptr<7>, !llvm.ptr, i32, !llvm.ptr<3>, i16, i1) -> ()
    return
  }
  func.func @tma_load_multicast2d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<7>, %arg2: !llvm.ptr<3>, %arg3: i16, %arg4: i32, %arg5: i32, %arg6: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$6 cp.async.bulk.tensor.2d.shared::cluster.global.mbarrier::complete_tx::bytes.multicast::cluster [$0], [$1, {$2,$3} ], [$4], $5;", "l,l,r,r,r,h,b" %arg1, %arg0, %arg4, %arg5, %arg2, %arg3, %arg6 : (!llvm.ptr<7>, !llvm.ptr, i32, i32, !llvm.ptr<3>, i16, i1) -> ()
    return
  }
  func.func @tma_load_multicast3d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<7>, %arg2: !llvm.ptr<3>, %arg3: i16, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$7 cp.async.bulk.tensor.3d.shared::cluster.global.mbarrier::complete_tx::bytes.multicast::cluster [$0], [$1, {$2,$3,$4} ], [$5], $6;", "l,l,r,r,r,r,h,b" %arg1, %arg0, %arg4, %arg5, %arg6, %arg2, %arg3, %arg7 : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, !llvm.ptr<3>, i16, i1) -> ()
    return
  }
  func.func @tma_load_multicast4d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<7>, %arg2: !llvm.ptr<3>, %arg3: i16, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$8 cp.async.bulk.tensor.4d.shared::cluster.global.mbarrier::complete_tx::bytes.multicast::cluster [$0], [$1, {$2,$3,$4,$5} ], [$6], $7;", "l,l,r,r,r,r,r,h,b" %arg1, %arg0, %arg4, %arg5, %arg6, %arg7, %arg2, %arg3, %arg8 : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, !llvm.ptr<3>, i16, i1) -> ()
    return
  }
  func.func @tma_load_multicast5d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<7>, %arg2: !llvm.ptr<3>, %arg3: i16, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$9 cp.async.bulk.tensor.5d.shared::cluster.global.mbarrier::complete_tx::bytes.multicast::cluster [$0], [$1, {$2,$3,$4,$5,$6} ], [$7], $8;", "l,l,r,r,r,r,r,r,h,b" %arg1, %arg0, %arg4, %arg5, %arg6, %arg7, %arg8, %arg2, %arg3, %arg9 : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, i32, !llvm.ptr<3>, i16, i1) -> ()
    return
  }
  func.func @tma_store_1d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<3>, %arg2: i32, %arg3: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$3 cp.async.bulk.tensor.1d.global.shared::cta.bulk_group [$0, {$2} ], [$1];", "l,r,r,b" %arg0, %arg1, %arg2, %arg3 : (!llvm.ptr, !llvm.ptr<3>, i32, i1) -> ()
    return
  }
  func.func @tma_store_2d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<3>, %arg2: i32, %arg3: i32, %arg4: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$4 cp.async.bulk.tensor.2d.global.shared::cta.bulk_group [$0, {$2, $3} ], [$1];", "l,r,r,r,b" %arg0, %arg1, %arg2, %arg3, %arg4 : (!llvm.ptr, !llvm.ptr<3>, i32, i32, i1) -> ()
    return
  }
  func.func @tma_store_3d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<3>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$5 cp.async.bulk.tensor.3d.global.shared::cta.bulk_group [$0, {$2, $3, $4} ], [$1];", "l,r,r,r,r,b" %arg0, %arg1, %arg2, %arg3, %arg4, %arg5 : (!llvm.ptr, !llvm.ptr<3>, i32, i32, i32, i1) -> ()
    return
  }
  func.func @tma_store_4d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<3>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$6 cp.async.bulk.tensor.4d.global.shared::cta.bulk_group [$0, {$2, $3, $4, $5} ], [$1];", "l,r,r,r,r,r,b" %arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6 : (!llvm.ptr, !llvm.ptr<3>, i32, i32, i32, i32, i1) -> ()
    return
  }
  func.func @tma_store_5d(%arg0: !llvm.ptr, %arg1: !llvm.ptr<3>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "@$7 cp.async.bulk.tensor.5d.global.shared::cta.bulk_group [$0, {$2, $3, $4, $5, $6} ], [$1];", "l,r,r,r,r,r,r,b" %arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7 : (!llvm.ptr, !llvm.ptr<3>, i32, i32, i32, i32, i32, i1) -> ()
    return
  }
  func.func @wgmma_execute() {
    nvvm.wgmma.fence.aligned
    nvvm.wgmma.commit.group.sync.aligned
    nvvm.wgmma.wait.group.sync.aligned 0
    nvvm.wgmma.fence.aligned
    nvvm.wgmma.commit.group.sync.aligned
    nvvm.wgmma.wait.group.sync.aligned 5
    return
  }
}

// -----
module {
  func.func @wgmma_f32_f16_f16(%arg0: i64, %arg1: i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %7 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %8 = llvm.extractvalue %0[2] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %9 = llvm.extractvalue %0[3] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %10 = llvm.extractvalue %0[4] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %11 = llvm.extractvalue %0[5] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %12 = llvm.extractvalue %0[6] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %13 = llvm.extractvalue %0[7] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %14 = llvm.extractvalue %0[8] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %15 = llvm.extractvalue %0[9] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %16 = llvm.extractvalue %0[10] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %17 = llvm.extractvalue %0[11] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %18 = llvm.extractvalue %0[12] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %19 = llvm.extractvalue %0[13] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %20 = llvm.extractvalue %0[14] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %21 = llvm.extractvalue %0[15] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %22 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $34, 0;\0Awgmma.mma_async.sync.aligned.m64n32k16.f32.f16.f16 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15}, $32, $33, p, $35,  $36, $37,  $38;\0A}\0A", "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,l,l,n,n,n,n,n" %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19, %20, %21, %arg0, %arg1, %1, %2, %3, %4, %5 : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %23 = llvm.mlir.constant(2 : i64) : i64
    %24 = llvm.add %arg0, %23 : i64
    %25 = llvm.add %arg1, %23 : i64
    %26 = llvm.mlir.constant(0 : i32) : i32
    %27 = llvm.mlir.constant(-1 : i32) : i32
    %28 = llvm.mlir.constant(-1 : i32) : i32
    %29 = llvm.mlir.constant(1 : i32) : i32
    %30 = llvm.mlir.constant(0 : i32) : i32
    %31 = llvm.extractvalue %22[0] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %32 = llvm.extractvalue %22[1] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %33 = llvm.extractvalue %22[2] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %34 = llvm.extractvalue %22[3] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %35 = llvm.extractvalue %22[4] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %36 = llvm.extractvalue %22[5] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %37 = llvm.extractvalue %22[6] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %38 = llvm.extractvalue %22[7] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %39 = llvm.extractvalue %22[8] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %40 = llvm.extractvalue %22[9] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %41 = llvm.extractvalue %22[10] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %42 = llvm.extractvalue %22[11] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %43 = llvm.extractvalue %22[12] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %44 = llvm.extractvalue %22[13] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %45 = llvm.extractvalue %22[14] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %46 = llvm.extractvalue %22[15] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %47 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $34, 0;\0Awgmma.mma_async.sync.aligned.m64n32k16.f32.f16.f16 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15}, $32, $33, p, $35,  $36, $37,  $38;\0A}\0A", "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,l,l,n,n,n,n,n" %31, %32, %33, %34, %35, %36, %37, %38, %39, %40, %41, %42, %43, %44, %45, %46, %24, %25, %26, %27, %28, %29, %30 : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    return %47 : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
  }
}

// -----
module {
  func.func @wgmma_s32_s8_s8_satfinite(%arg0: i64, %arg1: i64) -> !llvm.struct<(i32, i32, i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32, i32, i32)>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i32, i32, i32)> 
    %3 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i32, i32, i32)> 
    %4 = llvm.extractvalue %0[2] : !llvm.struct<(i32, i32, i32, i32)> 
    %5 = llvm.extractvalue %0[3] : !llvm.struct<(i32, i32, i32, i32)> 
    %6 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $10, 0;\0Awgmma.mma_async.sync.aligned.m64n8k32.s32.s8.s8.satfinite {$0, $1, $2, $3}, $8, $9, p;\0A}\0A", "=r,=r,=r,=r,0,1,2,3,l,l,n" %2, %3, %4, %5, %arg0, %arg1, %1 : (i32, i32, i32, i32, i64, i64, i32) -> !llvm.struct<(i32, i32, i32, i32)>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.extractvalue %6[0] : !llvm.struct<(i32, i32, i32, i32)> 
    %9 = llvm.extractvalue %6[1] : !llvm.struct<(i32, i32, i32, i32)> 
    %10 = llvm.extractvalue %6[2] : !llvm.struct<(i32, i32, i32, i32)> 
    %11 = llvm.extractvalue %6[3] : !llvm.struct<(i32, i32, i32, i32)> 
    %12 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $10, 0;\0Awgmma.mma_async.sync.aligned.m64n8k32.s32.s8.s8.satfinite {$0, $1, $2, $3}, $8, $9, p;\0A}\0A", "=r,=r,=r,=r,0,1,2,3,l,l,n" %8, %9, %10, %11, %arg0, %arg1, %7 : (i32, i32, i32, i32, i64, i64, i32) -> !llvm.struct<(i32, i32, i32, i32)>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.extractvalue %12[0] : !llvm.struct<(i32, i32, i32, i32)> 
    %15 = llvm.extractvalue %12[1] : !llvm.struct<(i32, i32, i32, i32)> 
    %16 = llvm.extractvalue %12[2] : !llvm.struct<(i32, i32, i32, i32)> 
    %17 = llvm.extractvalue %12[3] : !llvm.struct<(i32, i32, i32, i32)> 
    %18 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $10, 0;\0Awgmma.mma_async.sync.aligned.m64n8k32.s32.s8.s8.satfinite {$0, $1, $2, $3}, $8, $9, p;\0A}\0A", "=r,=r,=r,=r,0,1,2,3,l,l,n" %14, %15, %16, %17, %arg0, %arg1, %13 : (i32, i32, i32, i32, i64, i64, i32) -> !llvm.struct<(i32, i32, i32, i32)>
    return %18 : !llvm.struct<(i32, i32, i32, i32)>
  }
  func.func @wgmma_s32_u8_u8(%arg0: i64, %arg1: i64) -> !llvm.struct<(i32, i32, i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32, i32, i32)>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i32, i32, i32)> 
    %3 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i32, i32, i32)> 
    %4 = llvm.extractvalue %0[2] : !llvm.struct<(i32, i32, i32, i32)> 
    %5 = llvm.extractvalue %0[3] : !llvm.struct<(i32, i32, i32, i32)> 
    %6 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $10, 0;\0Awgmma.mma_async.sync.aligned.m64n8k32.s32.u8.u8 {$0, $1, $2, $3}, $8, $9, p;\0A}\0A", "=r,=r,=r,=r,0,1,2,3,l,l,n" %2, %3, %4, %5, %arg0, %arg1, %1 : (i32, i32, i32, i32, i64, i64, i32) -> !llvm.struct<(i32, i32, i32, i32)>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.extractvalue %6[0] : !llvm.struct<(i32, i32, i32, i32)> 
    %9 = llvm.extractvalue %6[1] : !llvm.struct<(i32, i32, i32, i32)> 
    %10 = llvm.extractvalue %6[2] : !llvm.struct<(i32, i32, i32, i32)> 
    %11 = llvm.extractvalue %6[3] : !llvm.struct<(i32, i32, i32, i32)> 
    %12 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $10, 0;\0Awgmma.mma_async.sync.aligned.m64n8k32.s32.u8.u8 {$0, $1, $2, $3}, $8, $9, p;\0A}\0A", "=r,=r,=r,=r,0,1,2,3,l,l,n" %8, %9, %10, %11, %arg0, %arg1, %7 : (i32, i32, i32, i32, i64, i64, i32) -> !llvm.struct<(i32, i32, i32, i32)>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.extractvalue %12[0] : !llvm.struct<(i32, i32, i32, i32)> 
    %15 = llvm.extractvalue %12[1] : !llvm.struct<(i32, i32, i32, i32)> 
    %16 = llvm.extractvalue %12[2] : !llvm.struct<(i32, i32, i32, i32)> 
    %17 = llvm.extractvalue %12[3] : !llvm.struct<(i32, i32, i32, i32)> 
    %18 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $10, 0;\0Awgmma.mma_async.sync.aligned.m64n8k32.s32.u8.u8 {$0, $1, $2, $3}, $8, $9, p;\0A}\0A", "=r,=r,=r,=r,0,1,2,3,l,l,n" %14, %15, %16, %17, %arg0, %arg1, %13 : (i32, i32, i32, i32, i64, i64, i32) -> !llvm.struct<(i32, i32, i32, i32)>
    return %18 : !llvm.struct<(i32, i32, i32, i32)>
  }
}

// -----
module {
  func.func @wgmma_f32_tf32_tf32(%arg0: i64, %arg1: i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %6 = llvm.extractvalue %0[2] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %7 = llvm.extractvalue %0[3] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %8 = llvm.extractvalue %0[4] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %9 = llvm.extractvalue %0[5] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %10 = llvm.extractvalue %0[6] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %11 = llvm.extractvalue %0[7] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %12 = llvm.extractvalue %0[8] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %13 = llvm.extractvalue %0[9] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %14 = llvm.extractvalue %0[10] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %15 = llvm.extractvalue %0[11] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %16 = llvm.extractvalue %0[12] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %17 = llvm.extractvalue %0[13] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %18 = llvm.extractvalue %0[14] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %19 = llvm.extractvalue %0[15] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %20 = llvm.extractvalue %0[16] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %21 = llvm.extractvalue %0[17] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %22 = llvm.extractvalue %0[18] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %23 = llvm.extractvalue %0[19] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %24 = llvm.extractvalue %0[20] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %25 = llvm.extractvalue %0[21] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %26 = llvm.extractvalue %0[22] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %27 = llvm.extractvalue %0[23] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %28 = llvm.extractvalue %0[24] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %29 = llvm.extractvalue %0[25] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %30 = llvm.extractvalue %0[26] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %31 = llvm.extractvalue %0[27] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %32 = llvm.extractvalue %0[28] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %33 = llvm.extractvalue %0[29] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %34 = llvm.extractvalue %0[30] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %35 = llvm.extractvalue %0[31] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %36 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $66, 0;\0Awgmma.mma_async.sync.aligned.m64n64k8.f32.tf32.tf32 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31}, $64, $65, p, $67,  $68;\0A}\0A", "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,l,l,n,n,n" %4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19, %20, %21, %22, %23, %24, %25, %26, %27, %28, %29, %30, %31, %32, %33, %34, %35, %arg0, %arg1, %1, %2, %3 : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %37 = llvm.mlir.constant(1 : i32) : i32
    %38 = llvm.mlir.constant(1 : i32) : i32
    %39 = llvm.mlir.constant(1 : i32) : i32
    %40 = llvm.extractvalue %36[0] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %41 = llvm.extractvalue %36[1] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %42 = llvm.extractvalue %36[2] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %43 = llvm.extractvalue %36[3] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %44 = llvm.extractvalue %36[4] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %45 = llvm.extractvalue %36[5] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %46 = llvm.extractvalue %36[6] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %47 = llvm.extractvalue %36[7] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %48 = llvm.extractvalue %36[8] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %49 = llvm.extractvalue %36[9] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %50 = llvm.extractvalue %36[10] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %51 = llvm.extractvalue %36[11] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %52 = llvm.extractvalue %36[12] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %53 = llvm.extractvalue %36[13] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %54 = llvm.extractvalue %36[14] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %55 = llvm.extractvalue %36[15] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %56 = llvm.extractvalue %36[16] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %57 = llvm.extractvalue %36[17] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %58 = llvm.extractvalue %36[18] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %59 = llvm.extractvalue %36[19] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %60 = llvm.extractvalue %36[20] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %61 = llvm.extractvalue %36[21] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %62 = llvm.extractvalue %36[22] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %63 = llvm.extractvalue %36[23] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %64 = llvm.extractvalue %36[24] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %65 = llvm.extractvalue %36[25] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %66 = llvm.extractvalue %36[26] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %67 = llvm.extractvalue %36[27] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %68 = llvm.extractvalue %36[28] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %69 = llvm.extractvalue %36[29] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %70 = llvm.extractvalue %36[30] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %71 = llvm.extractvalue %36[31] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %72 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $66, 0;\0Awgmma.mma_async.sync.aligned.m64n64k8.f32.tf32.tf32 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31}, $64, $65, p, $67,  $68;\0A}\0A", "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,l,l,n,n,n" %40, %41, %42, %43, %44, %45, %46, %47, %48, %49, %50, %51, %52, %53, %54, %55, %56, %57, %58, %59, %60, %61, %62, %63, %64, %65, %66, %67, %68, %69, %70, %71, %arg0, %arg1, %37, %38, %39 : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    return %72 : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
  }
}

// -----
module {
  func.func @wgmma_f32_e4m3_e4m3(%arg0: i64, %arg1: i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %6 = llvm.extractvalue %0[2] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %7 = llvm.extractvalue %0[3] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %8 = llvm.extractvalue %0[4] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %9 = llvm.extractvalue %0[5] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %10 = llvm.extractvalue %0[6] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %11 = llvm.extractvalue %0[7] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %12 = llvm.extractvalue %0[8] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %13 = llvm.extractvalue %0[9] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %14 = llvm.extractvalue %0[10] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %15 = llvm.extractvalue %0[11] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %16 = llvm.extractvalue %0[12] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %17 = llvm.extractvalue %0[13] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %18 = llvm.extractvalue %0[14] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %19 = llvm.extractvalue %0[15] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %20 = llvm.extractvalue %0[16] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %21 = llvm.extractvalue %0[17] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %22 = llvm.extractvalue %0[18] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %23 = llvm.extractvalue %0[19] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %24 = llvm.extractvalue %0[20] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %25 = llvm.extractvalue %0[21] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %26 = llvm.extractvalue %0[22] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %27 = llvm.extractvalue %0[23] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %28 = llvm.extractvalue %0[24] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %29 = llvm.extractvalue %0[25] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %30 = llvm.extractvalue %0[26] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %31 = llvm.extractvalue %0[27] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %32 = llvm.extractvalue %0[28] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %33 = llvm.extractvalue %0[29] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %34 = llvm.extractvalue %0[30] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %35 = llvm.extractvalue %0[31] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %36 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $66, 0;\0Awgmma.mma_async.sync.aligned.m64n64k32.f32.e4m3.e4m3 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31}, $64, $65, p, $67,  $68;\0A}\0A", "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,l,l,n,n,n" %4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19, %20, %21, %22, %23, %24, %25, %26, %27, %28, %29, %30, %31, %32, %33, %34, %35, %arg0, %arg1, %1, %2, %3 : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %37 = llvm.mlir.constant(1 : i32) : i32
    %38 = llvm.mlir.constant(1 : i32) : i32
    %39 = llvm.mlir.constant(1 : i32) : i32
    %40 = llvm.extractvalue %36[0] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %41 = llvm.extractvalue %36[1] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %42 = llvm.extractvalue %36[2] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %43 = llvm.extractvalue %36[3] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %44 = llvm.extractvalue %36[4] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %45 = llvm.extractvalue %36[5] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %46 = llvm.extractvalue %36[6] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %47 = llvm.extractvalue %36[7] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %48 = llvm.extractvalue %36[8] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %49 = llvm.extractvalue %36[9] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %50 = llvm.extractvalue %36[10] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %51 = llvm.extractvalue %36[11] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %52 = llvm.extractvalue %36[12] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %53 = llvm.extractvalue %36[13] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %54 = llvm.extractvalue %36[14] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %55 = llvm.extractvalue %36[15] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %56 = llvm.extractvalue %36[16] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %57 = llvm.extractvalue %36[17] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %58 = llvm.extractvalue %36[18] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %59 = llvm.extractvalue %36[19] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %60 = llvm.extractvalue %36[20] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %61 = llvm.extractvalue %36[21] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %62 = llvm.extractvalue %36[22] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %63 = llvm.extractvalue %36[23] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %64 = llvm.extractvalue %36[24] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %65 = llvm.extractvalue %36[25] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %66 = llvm.extractvalue %36[26] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %67 = llvm.extractvalue %36[27] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %68 = llvm.extractvalue %36[28] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %69 = llvm.extractvalue %36[29] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %70 = llvm.extractvalue %36[30] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %71 = llvm.extractvalue %36[31] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %72 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $66, 0;\0Awgmma.mma_async.sync.aligned.m64n64k32.f32.e4m3.e4m3 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31}, $64, $65, p, $67,  $68;\0A}\0A", "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,l,l,n,n,n" %40, %41, %42, %43, %44, %45, %46, %47, %48, %49, %50, %51, %52, %53, %54, %55, %56, %57, %58, %59, %60, %61, %62, %63, %64, %65, %66, %67, %68, %69, %70, %71, %arg0, %arg1, %37, %38, %39 : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    return %72 : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
  }
}

// -----
module {
  func.func @wgmma_f32_e5m2_e4m3(%arg0: i64, %arg1: i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %6 = llvm.extractvalue %0[2] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %7 = llvm.extractvalue %0[3] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %8 = llvm.extractvalue %0[4] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %9 = llvm.extractvalue %0[5] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %10 = llvm.extractvalue %0[6] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %11 = llvm.extractvalue %0[7] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %12 = llvm.extractvalue %0[8] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %13 = llvm.extractvalue %0[9] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %14 = llvm.extractvalue %0[10] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %15 = llvm.extractvalue %0[11] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %16 = llvm.extractvalue %0[12] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %17 = llvm.extractvalue %0[13] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %18 = llvm.extractvalue %0[14] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %19 = llvm.extractvalue %0[15] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %20 = llvm.extractvalue %0[16] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %21 = llvm.extractvalue %0[17] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %22 = llvm.extractvalue %0[18] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %23 = llvm.extractvalue %0[19] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %24 = llvm.extractvalue %0[20] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %25 = llvm.extractvalue %0[21] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %26 = llvm.extractvalue %0[22] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %27 = llvm.extractvalue %0[23] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %28 = llvm.extractvalue %0[24] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %29 = llvm.extractvalue %0[25] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %30 = llvm.extractvalue %0[26] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %31 = llvm.extractvalue %0[27] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %32 = llvm.extractvalue %0[28] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %33 = llvm.extractvalue %0[29] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %34 = llvm.extractvalue %0[30] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %35 = llvm.extractvalue %0[31] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %36 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $66, 0;\0Awgmma.mma_async.sync.aligned.m64n64k32.f32.e5m2.e4m3 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31}, $64, $65, p, $67,  $68;\0A}\0A", "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,l,l,n,n,n" %4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19, %20, %21, %22, %23, %24, %25, %26, %27, %28, %29, %30, %31, %32, %33, %34, %35, %arg0, %arg1, %1, %2, %3 : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %37 = llvm.mlir.constant(1 : i32) : i32
    %38 = llvm.mlir.constant(1 : i32) : i32
    %39 = llvm.mlir.constant(1 : i32) : i32
    %40 = llvm.extractvalue %36[0] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %41 = llvm.extractvalue %36[1] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %42 = llvm.extractvalue %36[2] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %43 = llvm.extractvalue %36[3] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %44 = llvm.extractvalue %36[4] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %45 = llvm.extractvalue %36[5] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %46 = llvm.extractvalue %36[6] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %47 = llvm.extractvalue %36[7] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %48 = llvm.extractvalue %36[8] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %49 = llvm.extractvalue %36[9] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %50 = llvm.extractvalue %36[10] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %51 = llvm.extractvalue %36[11] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %52 = llvm.extractvalue %36[12] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %53 = llvm.extractvalue %36[13] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %54 = llvm.extractvalue %36[14] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %55 = llvm.extractvalue %36[15] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %56 = llvm.extractvalue %36[16] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %57 = llvm.extractvalue %36[17] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %58 = llvm.extractvalue %36[18] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %59 = llvm.extractvalue %36[19] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %60 = llvm.extractvalue %36[20] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %61 = llvm.extractvalue %36[21] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %62 = llvm.extractvalue %36[22] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %63 = llvm.extractvalue %36[23] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %64 = llvm.extractvalue %36[24] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %65 = llvm.extractvalue %36[25] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %66 = llvm.extractvalue %36[26] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %67 = llvm.extractvalue %36[27] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %68 = llvm.extractvalue %36[28] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %69 = llvm.extractvalue %36[29] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %70 = llvm.extractvalue %36[30] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %71 = llvm.extractvalue %36[31] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> 
    %72 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A.reg .pred p;\0Asetp.ne.b32 p, $66, 0;\0Awgmma.mma_async.sync.aligned.m64n64k32.f32.e5m2.e4m3 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31}, $64, $65, p, $67,  $68;\0A}\0A", "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,l,l,n,n,n" %40, %41, %42, %43, %44, %45, %46, %47, %48, %49, %50, %51, %52, %53, %54, %55, %56, %57, %58, %59, %60, %61, %62, %63, %64, %65, %66, %67, %68, %69, %70, %71, %arg0, %arg1, %37, %38, %39 : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    return %72 : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
  }
}

// -----
module {
  func.func @elect_one_leader_sync() {
    %0 = nvvm.elect.sync -> i1
    return
  }
}

// -----
module {
  llvm.func @test_nvvm_prefetch(%arg0: !llvm.ptr, %arg1: i1) {
    nvvm.prefetch tensormap, %arg0 : !llvm.ptr
    llvm.inline_asm has_side_effects asm_dialect = att "@$1 prefetch.tensormap [$0];", "l,b" %arg0, %arg1 : (!llvm.ptr, i1) -> ()
    llvm.return
  }
}

// -----
module {
  func.func @set_max_register() {
    nvvm.setmaxregister increase 232
    nvvm.setmaxregister decrease 40
    return
  }
}

// -----
module {
  func.func @cp_async_bulk_commit() {
    nvvm.cp.async.bulk.commit.group
    return
  }
}

// -----
module {
  func.func @cp_async_bulk_wait_group() {
    nvvm.cp.async.bulk.wait_group 1
    nvvm.cp.async.bulk.wait_group 0
    nvvm.cp.async.bulk.wait_group 5 {read}
    nvvm.cp.async.bulk.wait_group 0 {read}
    return
  }
}

// -----
module {
  llvm.func @init_mbarrier(%arg0: !llvm.ptr, %arg1: !llvm.ptr<3>, %arg2: i32, %arg3: i1) {
    llvm.inline_asm has_side_effects asm_dialect = att "mbarrier.init.b64 [$0], $1;", "l,r" %arg0, %arg2 : (!llvm.ptr, i32) -> ()
    llvm.inline_asm has_side_effects asm_dialect = att "@$2 mbarrier.init.b64 [$0], $1;", "l,r,b" %arg0, %arg2, %arg3 : (!llvm.ptr, i32, i1) -> ()
    llvm.return
  }
}

// -----
module {
  llvm.func @ex2(%arg0: f32, %arg1: i1) {
    %0 = llvm.inline_asm has_side_effects asm_dialect = att "ex2.approx.ftz.f32 $0, $1;", "=f,f" %arg0 : (f32) -> f32
    %1 = llvm.inline_asm has_side_effects asm_dialect = att "@$2 ex2.approx.ftz.f32 $0, $1;", "=f,f,b" %arg0, %arg1 : (f32, i1) -> f32
    llvm.return
  }
  llvm.func @multi_return_pred(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.inline_asm has_side_effects asm_dialect = att "@$4 {.reg .pred p; setp.ge.s32 p, $2, $3; selp.s32 $0, $2,$3, p; selp.s32 $1, $2,$3, p;}", "=r,=r,r,r,b" %arg0, %arg1, %arg2 : (i32, i32, i1) -> !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.add %1, %2 : i32
    llvm.return %3 : i32
  }
  llvm.func @multi_return(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.inline_asm has_side_effects asm_dialect = att "{.reg .pred p; setp.ge.s32 p, $2, $3; selp.s32 $0, $2,$3, p; selp.s32 $1, $2,$3, p;}", "=r,=r,r,r" %arg0, %arg1 : (i32, i32) -> !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.add %1, %2 : i32
    llvm.return %3 : i32
  }
  llvm.func @inline_ptx_multi_rw(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.inline_asm has_side_effects asm_dialect = att "{.reg .pred p; setp.ge.s32 p, $2, $3; selp.s32 $0, $2,$3, p; selp.s32 $1, $2,$3, p;}", "=f,=f,r,r,0,1" %arg2, %arg3, %arg0, %arg1 : (f32, f32, i32, i32) -> !llvm.struct<(f32, f32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32)> 
    %3 = llvm.fadd %1, %2 : f32
    llvm.return %3 : f32
  }
  llvm.func @inline_ptx_multi_rw_pred(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> f32 {
    %0 = llvm.inline_asm has_side_effects asm_dialect = att "@$4 {.reg .pred p; setp.ge.s32 p, $2, $3; selp.s32 $0, $2,$3, p; selp.s32 $1, $2,$3, p;}", "=f,=f,r,r,b,0,1" %arg2, %arg3, %arg0, %arg1, %arg4 : (f32, f32, i32, i32, i1) -> !llvm.struct<(f32, f32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32)> 
    %3 = llvm.fadd %1, %2 : f32
    llvm.return %3 : f32
  }
  llvm.func @inline_ptx_multi_rw_r(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.inline_asm has_side_effects asm_dialect = att "{.reg .pred p; setp.ge.s32 p, $4, $5; selp.s32 $0, $4,$5, p; selp.s32 $1, $4,$5, p; selp.s32 $2, $4,$5, p; selp.s32 $3, $4,$5, p;}", "=f,=f,=r,=r,r,r,0,1" %arg2, %arg3, %arg0, %arg1 : (f32, f32, i32, i32) -> !llvm.struct<(f32, f32, i32, i32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32, i32, i32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32, i32, i32)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(f32, f32, i32, i32)> 
    %4 = llvm.extractvalue %0[3] : !llvm.struct<(f32, f32, i32, i32)> 
    %5 = llvm.add %3, %4 : i32
    %6 = llvm.sitofp %5 : i32 to f32
    %7 = llvm.fadd %1, %2 : f32
    %8 = llvm.fadd %6, %2 : f32
    llvm.return %8 : f32
  }
  llvm.func @inline_ptx_multi_rw_r_pred(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> f32 {
    %0 = llvm.inline_asm has_side_effects asm_dialect = att "@$6 {.reg .pred p; setp.ge.s32 p, $4, $5; selp.s32 $0, $4,$5, p; selp.s32 $1, $4,$5, p; selp.s32 $2, $4,$5, p; selp.s32 $3, $4,$5, p;}", "=f,=f,=r,=r,r,r,b,0,1" %arg2, %arg3, %arg0, %arg1, %arg4 : (f32, f32, i32, i32, i1) -> !llvm.struct<(f32, f32, i32, i32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32, i32, i32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32, i32, i32)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(f32, f32, i32, i32)> 
    %4 = llvm.extractvalue %0[3] : !llvm.struct<(f32, f32, i32, i32)> 
    %5 = llvm.add %3, %4 : i32
    %6 = llvm.sitofp %5 : i32 to f32
    %7 = llvm.fadd %1, %2 : f32
    %8 = llvm.fadd %6, %2 : f32
    llvm.return %8 : f32
  }
}

// -----
module {
  llvm.func @inline_ptx_pack_4i8(%arg0: vector<4xi8>, %arg1: i32, %arg2: i32) {
    %0 = llvm.inline_asm has_side_effects asm_dialect = att "dp4a.s32.s32 $0, $1, $2, $3;", "=r,r,r,r" %arg0, %arg1, %arg2 : (vector<4xi8>, i32, i32) -> i32
    llvm.return
  }
  llvm.func @inline_ptx_pack_2bf16(%arg0: f32, %arg1: f32) {
    %0 = llvm.inline_asm has_side_effects asm_dialect = att "cvt.rn.satfinite.bf16x2.f32 $0, $1, $2;", "=f,f,f" %arg0, %arg1 : (f32, f32) -> vector<2xbf16>
    llvm.return
  }
  llvm.func @inline_ptx_cvt_rn_e4m3x2_f16x2(%arg0: i16) {
    %0 = llvm.inline_asm has_side_effects asm_dialect = att "cvt.rz.satfinite.ue8m0x2.bf16x2 $0, $1", "=f,h" %arg0 : (i16) -> vector<2xbf16>
    llvm.return
  }
  llvm.func @cvt_i8_bf16(%arg0: i8) {
    %0 = llvm.zext %arg0 : i8 to i16
    %1 = llvm.inline_asm has_side_effects asm_dialect = att "{\0A\09.reg .b16 r;\0A\09.reg .b8 s;\0A\09mov.b16 {s,_}, $0;\0A\09cvt.rn.bf16.s8 r, s;\0A\09mov.b16 $1, r;\0A\09", "=h,h" %0 : (i16) -> i16
    llvm.return
  }
  llvm.func @inline_ptx_single_rw_no_result(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1 : f32
    %1 = llvm.inline_asm has_side_effects asm_dialect = att "asm1 ", "=f,0" %0 : (f32) -> f32
    %2 = llvm.fadd %1, %arg0 : f32
    llvm.return %2 : f32
  }
}

// -----
module {
  llvm.func @inline_ptx_preserves_special_register() -> i32 {
    %0 = llvm.inline_asm has_side_effects asm_dialect = att "mov.u32 $0, %laneid;", "=r"  : () -> i32
    llvm.return %0 : i32
  }
}

// -----
module {
  llvm.func @inline_ptx_special_register_trailing_digit() -> i32 {
    %0 = llvm.inline_asm has_side_effects asm_dialect = att "mov.u32 $0, %pm0;", "=r"  : () -> i32
    llvm.return %0 : i32
  }
}


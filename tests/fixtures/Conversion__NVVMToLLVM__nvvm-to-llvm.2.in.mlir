"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<3>, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "init_mbarrier", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg162: !llvm.ptr, %arg163: !llvm.ptr<3>, %arg164: i32, %arg165: i1):
    "nvvm.mbarrier.init"(%arg163, %arg164, %arg165) : (!llvm.ptr<3>, i32, i1) -> ()
    "nvvm.mbarrier.init"(%arg162, %arg164, %arg165) : (!llvm.ptr, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<3>, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "init_mbarrier_arrive_expect_tx", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg159: !llvm.ptr<3>, %arg160: i32, %arg161: i1):
    "nvvm.mbarrier.arrive.expect_tx"(%arg159, %arg160, %arg161) <{relaxed = false, scope = #nvvm.mem_scope<cta>}> : (!llvm.ptr<3>, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "init_mbarrier_arrive_expect_tx_generic", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg156: !llvm.ptr, %arg157: i32, %arg158: i1):
    "nvvm.mbarrier.arrive.expect_tx"(%arg156, %arg157, %arg158) <{relaxed = false, scope = #nvvm.mem_scope<cta>}> : (!llvm.ptr, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<3>, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "init_mbarrier_try_wait_shared", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg153: !llvm.ptr<3>, %arg154: i32, %arg155: i32):
    "nvvm.mbarrier.try_wait.parity"(%arg153, %arg155, %arg154) : (!llvm.ptr<3>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "init_mbarrier_try_wait", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg150: !llvm.ptr, %arg151: i32, %arg152: i32):
    "nvvm.mbarrier.try_wait.parity"(%arg150, %arg152, %arg151) : (!llvm.ptr, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr<3>, !llvm.ptr<1>) -> (), sym_name = "async_cp"}> ({
  ^bb0(%arg148: !llvm.ptr<3>, %arg149: !llvm.ptr<1>):
    "nvvm.cp.async.shared.global"(%arg148, %arg149) <{modifier = #nvvm<load_cache_modifier ca>, size = 16 : i32}> : (!llvm.ptr<3>, !llvm.ptr<1>) -> ()
    "nvvm.cp.async.shared.global"(%arg148, %arg149) <{modifier = #nvvm<load_cache_modifier cg>, size = 16 : i32}> : (!llvm.ptr<3>, !llvm.ptr<1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr<3>, !llvm.ptr<1>, i32) -> (), sym_name = "async_cp_zfill"}> ({
  ^bb0(%arg145: !llvm.ptr<3>, %arg146: !llvm.ptr<1>, %arg147: i32):
    "nvvm.cp.async.shared.global"(%arg145, %arg146, %arg147) <{modifier = #nvvm<load_cache_modifier cg>, size = 16 : i32}> : (!llvm.ptr<3>, !llvm.ptr<1>, i32) -> ()
    "nvvm.cp.async.shared.global"(%arg145, %arg146, %arg147) <{modifier = #nvvm<load_cache_modifier ca>, size = 4 : i32}> : (!llvm.ptr<3>, !llvm.ptr<1>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr<3>, !llvm.ptr) -> (), sym_name = "cp_async_mbarrier_arrive"}> ({
  ^bb0(%arg143: !llvm.ptr<3>, %arg144: !llvm.ptr):
    "nvvm.cp.async.mbarrier.arrive"(%arg144) <{noinc = false}> : (!llvm.ptr) -> ()
    "nvvm.cp.async.mbarrier.arrive"(%arg144) <{noinc = true}> : (!llvm.ptr) -> ()
    "nvvm.cp.async.mbarrier.arrive"(%arg143) <{noinc = false}> : (!llvm.ptr<3>) -> ()
    "nvvm.cp.async.mbarrier.arrive"(%arg143) <{noinc = true}> : (!llvm.ptr<3>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<7>, !llvm.ptr<3>, i32, i32, i32, i32, i16, i16, i16, i64, i1) -> (), sym_name = "tma_load_3d_all"}> ({
  ^bb0(%arg131: !llvm.ptr, %arg132: !llvm.ptr<7>, %arg133: !llvm.ptr<3>, %arg134: i32, %arg135: i32, %arg136: i32, %arg137: i32, %arg138: i16, %arg139: i16, %arg140: i16, %arg141: i64, %arg142: i1):
    "nvvm.cp.async.bulk.tensor.shared.cluster.global"(%arg132, %arg131, %arg134, %arg135, %arg136, %arg133, %arg138, %arg140, %arg141, %arg142) <{isCTAOnly = false, mode = #nvvm.tma_load_mode<im2col>, operandSegmentSizes = array<i32: 1, 1, 3, 1, 1, 1, 1, 1>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, !llvm.ptr<3>, i16, i16, i64, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<7>, !llvm.ptr<3>, i32, i32, i32, i32, i16, i16, i16, i64, i1) -> (), sym_name = "tma_load_4d_all"}> ({
  ^bb0(%arg119: !llvm.ptr, %arg120: !llvm.ptr<7>, %arg121: !llvm.ptr<3>, %arg122: i32, %arg123: i32, %arg124: i32, %arg125: i32, %arg126: i16, %arg127: i16, %arg128: i16, %arg129: i64, %arg130: i1):
    "nvvm.cp.async.bulk.tensor.shared.cluster.global"(%arg120, %arg119, %arg122, %arg123, %arg124, %arg125, %arg121, %arg126, %arg127, %arg128, %arg129, %arg130) <{isCTAOnly = false, mode = #nvvm.tma_load_mode<im2col>, operandSegmentSizes = array<i32: 1, 1, 4, 1, 2, 1, 1, 1>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, !llvm.ptr<3>, i16, i16, i16, i64, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<7>, !llvm.ptr<3>, i32, i32, i32, i32, i32, i16, i16, i16, i16, i64, i1) -> (), sym_name = "tma_load_5d_all"}> ({
  ^bb0(%arg105: !llvm.ptr, %arg106: !llvm.ptr<7>, %arg107: !llvm.ptr<3>, %arg108: i32, %arg109: i32, %arg110: i32, %arg111: i32, %arg112: i32, %arg113: i16, %arg114: i16, %arg115: i16, %arg116: i16, %arg117: i64, %arg118: i1):
    "nvvm.cp.async.bulk.tensor.shared.cluster.global"(%arg106, %arg105, %arg108, %arg109, %arg110, %arg111, %arg112, %arg107, %arg113, %arg114, %arg115, %arg116, %arg117, %arg118) <{isCTAOnly = false, mode = #nvvm.tma_load_mode<im2col>, operandSegmentSizes = array<i32: 1, 1, 5, 1, 3, 1, 1, 1>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, i32, !llvm.ptr<3>, i16, i16, i16, i16, i64, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<7>, !llvm.ptr<3>, i32, i1) -> (), sym_name = "tma_load_1d"}> ({
  ^bb0(%arg100: !llvm.ptr, %arg101: !llvm.ptr<7>, %arg102: !llvm.ptr<3>, %arg103: i32, %arg104: i1):
    "nvvm.cp.async.bulk.tensor.shared.cluster.global"(%arg101, %arg100, %arg103, %arg102, %arg104) <{isCTAOnly = false, mode = #nvvm.tma_load_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 1, 1, 0, 0, 0, 1>}> : (!llvm.ptr<7>, !llvm.ptr, i32, !llvm.ptr<3>, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<7>, !llvm.ptr<3>, i32, i32, i1) -> (), sym_name = "tma_load_2d"}> ({
  ^bb0(%arg94: !llvm.ptr, %arg95: !llvm.ptr<7>, %arg96: !llvm.ptr<3>, %arg97: i32, %arg98: i32, %arg99: i1):
    "nvvm.cp.async.bulk.tensor.shared.cluster.global"(%arg95, %arg94, %arg97, %arg98, %arg96, %arg99) <{isCTAOnly = false, mode = #nvvm.tma_load_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 2, 1, 0, 0, 0, 1>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, !llvm.ptr<3>, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<7>, !llvm.ptr<3>, i32, i32, i32, i1) -> (), sym_name = "tma_load_3d"}> ({
  ^bb0(%arg87: !llvm.ptr, %arg88: !llvm.ptr<7>, %arg89: !llvm.ptr<3>, %arg90: i32, %arg91: i32, %arg92: i32, %arg93: i1):
    "nvvm.cp.async.bulk.tensor.shared.cluster.global"(%arg88, %arg87, %arg90, %arg91, %arg92, %arg89, %arg93) <{isCTAOnly = false, mode = #nvvm.tma_load_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 3, 1, 0, 0, 0, 1>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, !llvm.ptr<3>, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<7>, !llvm.ptr<3>, i32, i32, i32, i32, i1) -> (), sym_name = "tma_load_4d"}> ({
  ^bb0(%arg79: !llvm.ptr, %arg80: !llvm.ptr<7>, %arg81: !llvm.ptr<3>, %arg82: i32, %arg83: i32, %arg84: i32, %arg85: i32, %arg86: i1):
    "nvvm.cp.async.bulk.tensor.shared.cluster.global"(%arg80, %arg79, %arg82, %arg83, %arg84, %arg85, %arg81, %arg86) <{isCTAOnly = false, mode = #nvvm.tma_load_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 4, 1, 0, 0, 0, 1>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, !llvm.ptr<3>, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<7>, !llvm.ptr<3>, i32, i32, i32, i32, i32, i1) -> (), sym_name = "tma_load_5d"}> ({
  ^bb0(%arg70: !llvm.ptr, %arg71: !llvm.ptr<7>, %arg72: !llvm.ptr<3>, %arg73: i32, %arg74: i32, %arg75: i32, %arg76: i32, %arg77: i32, %arg78: i1):
    "nvvm.cp.async.bulk.tensor.shared.cluster.global"(%arg71, %arg70, %arg73, %arg74, %arg75, %arg76, %arg77, %arg72, %arg78) <{isCTAOnly = false, mode = #nvvm.tma_load_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 5, 1, 0, 0, 0, 1>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, i32, !llvm.ptr<3>, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<7>, !llvm.ptr<3>, i16, i32, i1) -> (), sym_name = "tma_load_multicast1d"}> ({
  ^bb0(%arg64: !llvm.ptr, %arg65: !llvm.ptr<7>, %arg66: !llvm.ptr<3>, %arg67: i16, %arg68: i32, %arg69: i1):
    "nvvm.cp.async.bulk.tensor.shared.cluster.global"(%arg65, %arg64, %arg68, %arg66, %arg67, %arg69) <{isCTAOnly = false, mode = #nvvm.tma_load_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 1, 1, 0, 1, 0, 1>}> : (!llvm.ptr<7>, !llvm.ptr, i32, !llvm.ptr<3>, i16, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<7>, !llvm.ptr<3>, i16, i32, i32, i1) -> (), sym_name = "tma_load_multicast2d"}> ({
  ^bb0(%arg57: !llvm.ptr, %arg58: !llvm.ptr<7>, %arg59: !llvm.ptr<3>, %arg60: i16, %arg61: i32, %arg62: i32, %arg63: i1):
    "nvvm.cp.async.bulk.tensor.shared.cluster.global"(%arg58, %arg57, %arg61, %arg62, %arg59, %arg60, %arg63) <{isCTAOnly = false, mode = #nvvm.tma_load_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 2, 1, 0, 1, 0, 1>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, !llvm.ptr<3>, i16, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<7>, !llvm.ptr<3>, i16, i32, i32, i32, i1) -> (), sym_name = "tma_load_multicast3d"}> ({
  ^bb0(%arg49: !llvm.ptr, %arg50: !llvm.ptr<7>, %arg51: !llvm.ptr<3>, %arg52: i16, %arg53: i32, %arg54: i32, %arg55: i32, %arg56: i1):
    "nvvm.cp.async.bulk.tensor.shared.cluster.global"(%arg50, %arg49, %arg53, %arg54, %arg55, %arg51, %arg52, %arg56) <{isCTAOnly = false, mode = #nvvm.tma_load_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 3, 1, 0, 1, 0, 1>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, !llvm.ptr<3>, i16, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<7>, !llvm.ptr<3>, i16, i32, i32, i32, i32, i1) -> (), sym_name = "tma_load_multicast4d"}> ({
  ^bb0(%arg40: !llvm.ptr, %arg41: !llvm.ptr<7>, %arg42: !llvm.ptr<3>, %arg43: i16, %arg44: i32, %arg45: i32, %arg46: i32, %arg47: i32, %arg48: i1):
    "nvvm.cp.async.bulk.tensor.shared.cluster.global"(%arg41, %arg40, %arg44, %arg45, %arg46, %arg47, %arg42, %arg43, %arg48) <{isCTAOnly = false, mode = #nvvm.tma_load_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 4, 1, 0, 1, 0, 1>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, !llvm.ptr<3>, i16, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<7>, !llvm.ptr<3>, i16, i32, i32, i32, i32, i32, i1) -> (), sym_name = "tma_load_multicast5d"}> ({
  ^bb0(%arg30: !llvm.ptr, %arg31: !llvm.ptr<7>, %arg32: !llvm.ptr<3>, %arg33: i16, %arg34: i32, %arg35: i32, %arg36: i32, %arg37: i32, %arg38: i32, %arg39: i1):
    "nvvm.cp.async.bulk.tensor.shared.cluster.global"(%arg31, %arg30, %arg34, %arg35, %arg36, %arg37, %arg38, %arg32, %arg33, %arg39) <{isCTAOnly = false, mode = #nvvm.tma_load_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 5, 1, 0, 1, 0, 1>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, i32, !llvm.ptr<3>, i16, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<3>, i32, i1) -> (), sym_name = "tma_store_1d"}> ({
  ^bb0(%arg26: !llvm.ptr, %arg27: !llvm.ptr<3>, %arg28: i32, %arg29: i1):
    "nvvm.cp.async.bulk.tensor.global.shared.cta"(%arg26, %arg27, %arg28, %arg29) <{mode = #nvvm.tma_store_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 1, 0, 1>}> : (!llvm.ptr, !llvm.ptr<3>, i32, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<3>, i32, i32, i1) -> (), sym_name = "tma_store_2d"}> ({
  ^bb0(%arg21: !llvm.ptr, %arg22: !llvm.ptr<3>, %arg23: i32, %arg24: i32, %arg25: i1):
    "nvvm.cp.async.bulk.tensor.global.shared.cta"(%arg21, %arg22, %arg23, %arg24, %arg25) <{mode = #nvvm.tma_store_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 2, 0, 1>}> : (!llvm.ptr, !llvm.ptr<3>, i32, i32, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<3>, i32, i32, i32, i1) -> (), sym_name = "tma_store_3d"}> ({
  ^bb0(%arg15: !llvm.ptr, %arg16: !llvm.ptr<3>, %arg17: i32, %arg18: i32, %arg19: i32, %arg20: i1):
    "nvvm.cp.async.bulk.tensor.global.shared.cta"(%arg15, %arg16, %arg17, %arg18, %arg19, %arg20) <{mode = #nvvm.tma_store_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 3, 0, 1>}> : (!llvm.ptr, !llvm.ptr<3>, i32, i32, i32, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<3>, i32, i32, i32, i32, i1) -> (), sym_name = "tma_store_4d"}> ({
  ^bb0(%arg8: !llvm.ptr, %arg9: !llvm.ptr<3>, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i1):
    "nvvm.cp.async.bulk.tensor.global.shared.cta"(%arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14) <{mode = #nvvm.tma_store_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 4, 0, 1>}> : (!llvm.ptr, !llvm.ptr<3>, i32, i32, i32, i32, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr<3>, i32, i32, i32, i32, i32, i1) -> (), sym_name = "tma_store_5d"}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr<3>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i1):
    "nvvm.cp.async.bulk.tensor.global.shared.cta"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7) <{mode = #nvvm.tma_store_mode<tile>, operandSegmentSizes = array<i32: 1, 1, 5, 0, 1>}> : (!llvm.ptr, !llvm.ptr<3>, i32, i32, i32, i32, i32, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "wgmma_execute"}> ({
    "nvvm.wgmma.fence.aligned"() : () -> ()
    "nvvm.wgmma.commit.group.sync.aligned"() : () -> ()
    "nvvm.wgmma.wait.group.sync.aligned"() <{group = 0 : i64}> : () -> ()
    "nvvm.wgmma.fence.aligned"() : () -> ()
    "nvvm.wgmma.commit.group.sync.aligned"() : () -> ()
    "nvvm.wgmma.wait.group.sync.aligned"() <{group = 5 : i64}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>, sym_name = "wgmma_f32_f16_f16"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.undef"() : () -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %1 = "nvvm.wgmma.mma_async"(%0, %arg0, %arg1) <{layoutA = #nvvm.mma_layout<col>, layoutB = #nvvm.mma_layout<col>, scaleA = #nvvm.wgmma_scale_in<neg>, scaleB = #nvvm.wgmma_scale_in<neg>, scaleD = #nvvm.wgmma_scale_out<zero>, shape = #nvvm.shape<m = 64, n = 32, k = 16>, typeA = #nvvm.wgmma_type<f16>, typeB = #nvvm.wgmma_type<f16>, typeD = #nvvm.wgmma_type<f32>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>, i64, i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %2 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %3 = "arith.addi"(%arg0, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %4 = "arith.addi"(%arg1, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %5 = "nvvm.wgmma.mma_async"(%1, %3, %4) <{layoutA = #nvvm.mma_layout<col>, layoutB = #nvvm.mma_layout<col>, scaleA = #nvvm.wgmma_scale_in<neg>, scaleB = #nvvm.wgmma_scale_in<neg>, scaleD = #nvvm.wgmma_scale_out<zero>, shape = #nvvm.shape<m = 64, n = 32, k = 16>, typeA = #nvvm.wgmma_type<f16>, typeB = #nvvm.wgmma_type<f16>, typeD = #nvvm.wgmma_type<f32>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>, i64, i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    "func.return"(%5) : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> !llvm.struct<(i32, i32, i32, i32)>, sym_name = "wgmma_s32_s8_s8_satfinite"}> ({
  ^bb0(%arg2: i64, %arg3: i64):
    %4 = "llvm.mlir.undef"() : () -> !llvm.struct<(i32, i32, i32, i32)>
    %5 = "nvvm.wgmma.mma_async"(%4, %arg2, %arg3) <{layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<col>, satfinite = #nvvm.mma_int_overflow<satfinite>, scaleA = #nvvm.wgmma_scale_in<one>, scaleB = #nvvm.wgmma_scale_in<one>, scaleD = #nvvm.wgmma_scale_out<one>, shape = #nvvm.shape<m = 64, n = 8, k = 32>, typeA = #nvvm.wgmma_type<s8>, typeB = #nvvm.wgmma_type<s8>, typeD = #nvvm.wgmma_type<s32>}> : (!llvm.struct<(i32, i32, i32, i32)>, i64, i64) -> !llvm.struct<(i32, i32, i32, i32)>
    %6 = "nvvm.wgmma.mma_async"(%5, %arg2, %arg3) <{layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<col>, satfinite = #nvvm.mma_int_overflow<satfinite>, scaleA = #nvvm.wgmma_scale_in<one>, scaleB = #nvvm.wgmma_scale_in<one>, scaleD = #nvvm.wgmma_scale_out<one>, shape = #nvvm.shape<m = 64, n = 8, k = 32>, typeA = #nvvm.wgmma_type<s8>, typeB = #nvvm.wgmma_type<s8>, typeD = #nvvm.wgmma_type<s32>}> : (!llvm.struct<(i32, i32, i32, i32)>, i64, i64) -> !llvm.struct<(i32, i32, i32, i32)>
    %7 = "nvvm.wgmma.mma_async"(%6, %arg2, %arg3) <{layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<col>, satfinite = #nvvm.mma_int_overflow<satfinite>, scaleA = #nvvm.wgmma_scale_in<one>, scaleB = #nvvm.wgmma_scale_in<one>, scaleD = #nvvm.wgmma_scale_out<one>, shape = #nvvm.shape<m = 64, n = 8, k = 32>, typeA = #nvvm.wgmma_type<s8>, typeB = #nvvm.wgmma_type<s8>, typeD = #nvvm.wgmma_type<s32>}> : (!llvm.struct<(i32, i32, i32, i32)>, i64, i64) -> !llvm.struct<(i32, i32, i32, i32)>
    "func.return"(%7) : (!llvm.struct<(i32, i32, i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> !llvm.struct<(i32, i32, i32, i32)>, sym_name = "wgmma_s32_u8_u8"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.undef"() : () -> !llvm.struct<(i32, i32, i32, i32)>
    %1 = "nvvm.wgmma.mma_async"(%0, %arg0, %arg1) <{layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<col>, scaleA = #nvvm.wgmma_scale_in<one>, scaleB = #nvvm.wgmma_scale_in<one>, scaleD = #nvvm.wgmma_scale_out<one>, shape = #nvvm.shape<m = 64, n = 8, k = 32>, typeA = #nvvm.wgmma_type<u8>, typeB = #nvvm.wgmma_type<u8>, typeD = #nvvm.wgmma_type<s32>}> : (!llvm.struct<(i32, i32, i32, i32)>, i64, i64) -> !llvm.struct<(i32, i32, i32, i32)>
    %2 = "nvvm.wgmma.mma_async"(%1, %arg0, %arg1) <{layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<col>, scaleA = #nvvm.wgmma_scale_in<one>, scaleB = #nvvm.wgmma_scale_in<one>, scaleD = #nvvm.wgmma_scale_out<one>, shape = #nvvm.shape<m = 64, n = 8, k = 32>, typeA = #nvvm.wgmma_type<u8>, typeB = #nvvm.wgmma_type<u8>, typeD = #nvvm.wgmma_type<s32>}> : (!llvm.struct<(i32, i32, i32, i32)>, i64, i64) -> !llvm.struct<(i32, i32, i32, i32)>
    %3 = "nvvm.wgmma.mma_async"(%2, %arg0, %arg1) <{layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<col>, scaleA = #nvvm.wgmma_scale_in<one>, scaleB = #nvvm.wgmma_scale_in<one>, scaleD = #nvvm.wgmma_scale_out<one>, shape = #nvvm.shape<m = 64, n = 8, k = 32>, typeA = #nvvm.wgmma_type<u8>, typeB = #nvvm.wgmma_type<u8>, typeD = #nvvm.wgmma_type<s32>}> : (!llvm.struct<(i32, i32, i32, i32)>, i64, i64) -> !llvm.struct<(i32, i32, i32, i32)>
    "func.return"(%3) : (!llvm.struct<(i32, i32, i32, i32)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>, sym_name = "wgmma_f32_tf32_tf32"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.undef"() : () -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %1 = "nvvm.wgmma.mma_async"(%0, %arg0, %arg1) <{layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<col>, scaleA = #nvvm.wgmma_scale_in<one>, scaleB = #nvvm.wgmma_scale_in<one>, scaleD = #nvvm.wgmma_scale_out<one>, shape = #nvvm.shape<m = 64, n = 64, k = 8>, typeA = #nvvm.wgmma_type<tf32>, typeB = #nvvm.wgmma_type<tf32>, typeD = #nvvm.wgmma_type<f32>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>, i64, i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %2 = "nvvm.wgmma.mma_async"(%1, %arg0, %arg1) <{layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<col>, scaleA = #nvvm.wgmma_scale_in<one>, scaleB = #nvvm.wgmma_scale_in<one>, scaleD = #nvvm.wgmma_scale_out<one>, shape = #nvvm.shape<m = 64, n = 64, k = 8>, typeA = #nvvm.wgmma_type<tf32>, typeB = #nvvm.wgmma_type<tf32>, typeD = #nvvm.wgmma_type<f32>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>, i64, i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    "func.return"(%2) : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>, sym_name = "wgmma_f32_e4m3_e4m3"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.undef"() : () -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %1 = "nvvm.wgmma.mma_async"(%0, %arg0, %arg1) <{layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<col>, scaleA = #nvvm.wgmma_scale_in<one>, scaleB = #nvvm.wgmma_scale_in<one>, scaleD = #nvvm.wgmma_scale_out<one>, shape = #nvvm.shape<m = 64, n = 64, k = 32>, typeA = #nvvm.wgmma_type<e4m3>, typeB = #nvvm.wgmma_type<e4m3>, typeD = #nvvm.wgmma_type<f32>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>, i64, i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %2 = "nvvm.wgmma.mma_async"(%1, %arg0, %arg1) <{layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<col>, scaleA = #nvvm.wgmma_scale_in<one>, scaleB = #nvvm.wgmma_scale_in<one>, scaleD = #nvvm.wgmma_scale_out<one>, shape = #nvvm.shape<m = 64, n = 64, k = 32>, typeA = #nvvm.wgmma_type<e4m3>, typeB = #nvvm.wgmma_type<e4m3>, typeD = #nvvm.wgmma_type<f32>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>, i64, i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    "func.return"(%2) : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>, sym_name = "wgmma_f32_e5m2_e4m3"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.undef"() : () -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %1 = "nvvm.wgmma.mma_async"(%0, %arg0, %arg1) <{layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<col>, scaleA = #nvvm.wgmma_scale_in<one>, scaleB = #nvvm.wgmma_scale_in<one>, scaleD = #nvvm.wgmma_scale_out<one>, shape = #nvvm.shape<m = 64, n = 64, k = 32>, typeA = #nvvm.wgmma_type<e5m2>, typeB = #nvvm.wgmma_type<e4m3>, typeD = #nvvm.wgmma_type<f32>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>, i64, i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %2 = "nvvm.wgmma.mma_async"(%1, %arg0, %arg1) <{layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<col>, scaleA = #nvvm.wgmma_scale_in<one>, scaleB = #nvvm.wgmma_scale_in<one>, scaleD = #nvvm.wgmma_scale_out<one>, shape = #nvvm.shape<m = 64, n = 64, k = 32>, typeA = #nvvm.wgmma_type<e5m2>, typeB = #nvvm.wgmma_type<e4m3>, typeD = #nvvm.wgmma_type<f32>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>, i64, i64) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    "func.return"(%2) : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "elect_one_leader_sync"}> ({
    %0 = "nvvm.elect.sync"() : () -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i1)>, linkage = #llvm.linkage<external>, sym_name = "test_nvvm_prefetch", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: i1):
    "nvvm.prefetch"(%arg0) <{tensormap}> : (!llvm.ptr) -> ()
    "nvvm.prefetch"(%arg0, %arg1) <{tensormap}> : (!llvm.ptr, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "set_max_register"}> ({
    "nvvm.setmaxregister"() <{action = #nvvm<action increase>, regCount = 232 : i32}> : () -> ()
    "nvvm.setmaxregister"() <{action = #nvvm<action decrease>, regCount = 40 : i32}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "cp_async_bulk_commit"}> ({
    "nvvm.cp.async.bulk.commit.group"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "cp_async_bulk_wait_group"}> ({
    "nvvm.cp.async.bulk.wait_group"() <{group = 1 : i32}> : () -> ()
    "nvvm.cp.async.bulk.wait_group"() <{group = 0 : i32}> : () -> ()
    "nvvm.cp.async.bulk.wait_group"() <{group = 5 : i32, read}> : () -> ()
    "nvvm.cp.async.bulk.wait_group"() <{group = 0 : i32, read}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "llvm_nvvm_barrier_arrive", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    "nvvm.barrier.arrive"(%arg1) : (i32) -> ()
    "nvvm.barrier.arrive"(%arg0, %arg1) : (i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<3>, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "init_mbarrier", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr<3>, %arg2: i32, %arg3: i1):
    "nvvm.inline_ptx"(%arg0, %arg2) <{operandSegmentSizes = array<i32: 2, 0, 0>, ptxCode = "mbarrier.init.b64 [{$r0}], {$r1};"}> : (!llvm.ptr, i32) -> ()
    "nvvm.inline_ptx"(%arg0, %arg2, %arg3) <{operandSegmentSizes = array<i32: 2, 0, 1>, ptxCode = "mbarrier.init.b64 [{$r0}], {$r1};"}> : (!llvm.ptr, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, i1)>, linkage = #llvm.linkage<external>, sym_name = "ex2", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg10: f32, %arg11: i1):
    %8 = "nvvm.inline_ptx"(%arg10) <{operandSegmentSizes = array<i32: 1, 0, 0>, ptxCode = "ex2.approx.ftz.f32 {$w0}, {$r0};"}> : (f32) -> f32
    %9 = "nvvm.inline_ptx"(%arg10, %arg11) <{operandSegmentSizes = array<i32: 1, 0, 1>, ptxCode = "ex2.approx.ftz.f32 {$w0}, {$r0};"}> : (f32, i1) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "multi_return", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg8: i32, %arg9: i32):
    %6:2 = "nvvm.inline_ptx"(%arg8, %arg9) <{operandSegmentSizes = array<i32: 2, 0, 0>, ptxCode = "{.reg .pred p; setp.ge.s32 p, {$r0}, {$r1}; selp.s32 {$w0}, {$r0},{$r1}, p; selp.s32 {$w1}, {$r0},{$r1}, p;}"}> : (i32, i32) -> (i32, i32)
    %7 = "llvm.add"(%6#0, %6#1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (i32, i32, f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "inline_ptx_multi_rw", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg4: i32, %arg5: i32, %arg6: f32, %arg7: f32):
    "nvvm.inline_ptx"(%arg4, %arg5, %arg6, %arg7) <{operandSegmentSizes = array<i32: 2, 2, 0>, ptxCode = "{.reg .pred p; setp.ge.s32 p, {$r0}, {$r1}; selp.s32 {$rw0}, {$r0},{$r1}, p; selp.s32 {$rw1}, {$r0},{$r1}, p;}"}> : (i32, i32, f32, f32) -> ()
    %5 = "llvm.fadd"(%arg6, %arg7) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"(%5) : (f32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (i32, i32, f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "inline_ptx_multi_rw_r", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32):
    %0:2 = "nvvm.inline_ptx"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 2, 2, 0>, ptxCode = "{.reg .pred p; setp.ge.s32 p, {$r0}, {$r1}; selp.s32 {$rw0}, {$r0},{$r1}, p; selp.s32 {$rw1}, {$r0},{$r1}, p; selp.s32 {$w0}, {$r0},{$r1}, p; selp.s32 {$w1}, {$r0},{$r1}, p;}"}> : (i32, i32, f32, f32) -> (i32, i32)
    %1 = "llvm.add"(%0#0, %0#1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %2 = "llvm.sitofp"(%1) : (i32) -> f32
    %3 = "llvm.fadd"(%arg2, %arg3) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %4 = "llvm.fadd"(%2, %arg3) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi8>, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "inline_ptx_pack_4i8", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg4: vector<4xi8>, %arg5: i32, %arg6: i32):
    %4 = "nvvm.inline_ptx"(%arg4, %arg5, %arg6) <{operandSegmentSizes = array<i32: 3, 0, 0>, ptxCode = "dp4a.s32.s32 {$w0}, {$r0}, {$r1}, {$r2};"}> : (vector<4xi8>, i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "inline_ptx_pack_2bf16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %3 = "nvvm.inline_ptx"(%arg2, %arg3) <{operandSegmentSizes = array<i32: 2, 0, 0>, ptxCode = "cvt.rn.satfinite.bf16x2.f32 {$w0}, {$r0}, {$r1};"}> : (f32, f32) -> vector<2xbf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16)>, linkage = #llvm.linkage<external>, sym_name = "inline_ptx_cvt_rn_e4m3x2_f16x2", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg1: i16):
    %2 = "nvvm.inline_ptx"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0>, ptxCode = "cvt.rz.satfinite.ue8m0x2.bf16x2 {$w0}, {$r0}"}> : (i16) -> vector<2xbf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i8)>, linkage = #llvm.linkage<external>, sym_name = "cvt_i8_bf16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i8):
    %0 = "llvm.zext"(%arg0) : (i8) -> i16
    %1 = "nvvm.inline_ptx"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, ptxCode = "{\0A\09.reg .b16 r;\0A\09.reg .b8 s;\0A\09mov.b16 {s,_}, {$w0};\0A\09cvt.rn.bf16.s8 r, s;\0A\09mov.b16 {$r0}, r;\0A\09"}> : (i16) -> i16
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()


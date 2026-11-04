"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<3>, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "init_mbarrier", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg162: !llvm.ptr, %arg163: !llvm.ptr<3>, %arg164: i32, %arg165: i1):
    "llvm.inline_asm"(%arg163, %arg164, %arg165) <{asm_dialect = 0 : i64, asm_string = "@$2 mbarrier.init.shared.b64 [$0], $1;", constraints = "r,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<3>, i32, i1) -> ()
    "llvm.inline_asm"(%arg162, %arg164, %arg165) <{asm_dialect = 0 : i64, asm_string = "@$2 mbarrier.init.b64 [$0], $1;", constraints = "l,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<3>, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "init_mbarrier_arrive_expect_tx", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg159: !llvm.ptr<3>, %arg160: i32, %arg161: i1):
    "llvm.inline_asm"(%arg159, %arg160, %arg161) <{asm_dialect = 0 : i64, asm_string = "@$2 mbarrier.arrive.expect_tx.shared.b64 _, [$0], $1;", constraints = "r,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<3>, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "init_mbarrier_arrive_expect_tx_generic", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg156: !llvm.ptr, %arg157: i32, %arg158: i1):
    "llvm.inline_asm"(%arg156, %arg157, %arg158) <{asm_dialect = 0 : i64, asm_string = "@$2 mbarrier.arrive.expect_tx.b64 _, [$0], $1;", constraints = "l,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<3>, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "init_mbarrier_try_wait_shared", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg153: !llvm.ptr<3>, %arg154: i32, %arg155: i32):
    "llvm.inline_asm"(%arg153, %arg155, %arg154) <{asm_dialect = 0 : i64, asm_string = "{\0A\09.reg .pred       P1; \0A\09LAB_WAIT: \0A\09mbarrier.try_wait.parity.shared.b64 P1, [$0], $1, $2; \0A\09@P1 bra.uni DONE; \0A\09bra.uni     LAB_WAIT; \0A\09DONE: \0A\09}", constraints = "r,r,r", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<3>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "init_mbarrier_try_wait", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg150: !llvm.ptr, %arg151: i32, %arg152: i32):
    "llvm.inline_asm"(%arg150, %arg152, %arg151) <{asm_dialect = 0 : i64, asm_string = "{\0A\09.reg .pred       P1; \0A\09LAB_WAIT: \0A\09mbarrier.try_wait.parity.b64 P1, [$0], $1, $2; \0A\09@P1 bra.uni DONE; \0A\09bra.uni     LAB_WAIT; \0A\09DONE: \0A\09}", constraints = "l,r,r", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<3>, ptr<1>)>, linkage = #llvm.linkage<external>, sym_name = "async_cp", visibility_ = 0 : i64}> ({
  ^bb0(%arg148: !llvm.ptr<3>, %arg149: !llvm.ptr<1>):
    "nvvm.cp.async.shared.global"(%arg148, %arg149) <{modifier = #nvvm<load_cache_modifier ca>, size = 16 : i32}> : (!llvm.ptr<3>, !llvm.ptr<1>) -> ()
    "nvvm.cp.async.shared.global"(%arg148, %arg149) <{modifier = #nvvm<load_cache_modifier cg>, size = 16 : i32}> : (!llvm.ptr<3>, !llvm.ptr<1>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<3>, ptr<1>, i32)>, linkage = #llvm.linkage<external>, sym_name = "async_cp_zfill", visibility_ = 0 : i64}> ({
  ^bb0(%arg145: !llvm.ptr<3>, %arg146: !llvm.ptr<1>, %arg147: i32):
    "nvvm.cp.async.shared.global"(%arg145, %arg146, %arg147) <{modifier = #nvvm<load_cache_modifier cg>, size = 16 : i32}> : (!llvm.ptr<3>, !llvm.ptr<1>, i32) -> ()
    "nvvm.cp.async.shared.global"(%arg145, %arg146, %arg147) <{modifier = #nvvm<load_cache_modifier ca>, size = 4 : i32}> : (!llvm.ptr<3>, !llvm.ptr<1>, i32) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<3>, ptr)>, linkage = #llvm.linkage<external>, sym_name = "cp_async_mbarrier_arrive", visibility_ = 0 : i64}> ({
  ^bb0(%arg143: !llvm.ptr<3>, %arg144: !llvm.ptr):
    "nvvm.cp.async.mbarrier.arrive"(%arg144) <{noinc = false}> : (!llvm.ptr) -> ()
    "nvvm.cp.async.mbarrier.arrive"(%arg144) <{noinc = true}> : (!llvm.ptr) -> ()
    "nvvm.cp.async.mbarrier.arrive"(%arg143) <{noinc = false}> : (!llvm.ptr<3>) -> ()
    "nvvm.cp.async.mbarrier.arrive"(%arg143) <{noinc = true}> : (!llvm.ptr<3>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<7>, ptr<3>, i32, i32, i32, i32, i16, i16, i16, i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_load_3d_all", visibility_ = 0 : i64}> ({
  ^bb0(%arg131: !llvm.ptr, %arg132: !llvm.ptr<7>, %arg133: !llvm.ptr<3>, %arg134: i32, %arg135: i32, %arg136: i32, %arg137: i32, %arg138: i16, %arg139: i16, %arg140: i16, %arg141: i64, %arg142: i1):
    "llvm.inline_asm"(%arg132, %arg131, %arg134, %arg135, %arg136, %arg133, %arg138, %arg140, %arg141, %arg142) <{asm_dialect = 0 : i64, asm_string = "@$9 cp.async.bulk.tensor.3d.shared::cluster.global.mbarrier::complete_tx::bytes.im2col.multicast::cluster.L2::cache_hint [$0], [$1, {$2,$3,$4} ], [$5],{$6}, $7, $8;", constraints = "l,l,r,r,r,r,h,h,l,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, !llvm.ptr<3>, i16, i16, i64, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<7>, ptr<3>, i32, i32, i32, i32, i16, i16, i16, i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_load_4d_all", visibility_ = 0 : i64}> ({
  ^bb0(%arg119: !llvm.ptr, %arg120: !llvm.ptr<7>, %arg121: !llvm.ptr<3>, %arg122: i32, %arg123: i32, %arg124: i32, %arg125: i32, %arg126: i16, %arg127: i16, %arg128: i16, %arg129: i64, %arg130: i1):
    "llvm.inline_asm"(%arg120, %arg119, %arg122, %arg123, %arg124, %arg125, %arg121, %arg126, %arg127, %arg128, %arg129, %arg130) <{asm_dialect = 0 : i64, asm_string = "@$11 cp.async.bulk.tensor.4d.shared::cluster.global.mbarrier::complete_tx::bytes.im2col.multicast::cluster.L2::cache_hint [$0], [$1, {$2,$3,$4,$5} ], [$6],{$7,$8}, $9, $10;", constraints = "l,l,r,r,r,r,r,h,h,h,l,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, !llvm.ptr<3>, i16, i16, i16, i64, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<7>, ptr<3>, i32, i32, i32, i32, i32, i16, i16, i16, i16, i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_load_5d_all", visibility_ = 0 : i64}> ({
  ^bb0(%arg105: !llvm.ptr, %arg106: !llvm.ptr<7>, %arg107: !llvm.ptr<3>, %arg108: i32, %arg109: i32, %arg110: i32, %arg111: i32, %arg112: i32, %arg113: i16, %arg114: i16, %arg115: i16, %arg116: i16, %arg117: i64, %arg118: i1):
    "llvm.inline_asm"(%arg106, %arg105, %arg108, %arg109, %arg110, %arg111, %arg112, %arg107, %arg113, %arg114, %arg115, %arg116, %arg117, %arg118) <{asm_dialect = 0 : i64, asm_string = "@$13 cp.async.bulk.tensor.5d.shared::cluster.global.mbarrier::complete_tx::bytes.im2col.multicast::cluster.L2::cache_hint [$0], [$1, {$2,$3,$4,$5,$6} ], [$7],{$8,$9,$10}, $11, $12;", constraints = "l,l,r,r,r,r,r,r,h,h,h,h,l,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, i32, !llvm.ptr<3>, i16, i16, i16, i16, i64, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<7>, ptr<3>, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_load_1d", visibility_ = 0 : i64}> ({
  ^bb0(%arg100: !llvm.ptr, %arg101: !llvm.ptr<7>, %arg102: !llvm.ptr<3>, %arg103: i32, %arg104: i1):
    "llvm.inline_asm"(%arg101, %arg100, %arg103, %arg102, %arg104) <{asm_dialect = 0 : i64, asm_string = "@$4 cp.async.bulk.tensor.1d.shared::cluster.global.mbarrier::complete_tx::bytes [$0], [$1, {$2} ], [$3];", constraints = "l,l,r,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<7>, !llvm.ptr, i32, !llvm.ptr<3>, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<7>, ptr<3>, i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_load_2d", visibility_ = 0 : i64}> ({
  ^bb0(%arg94: !llvm.ptr, %arg95: !llvm.ptr<7>, %arg96: !llvm.ptr<3>, %arg97: i32, %arg98: i32, %arg99: i1):
    "llvm.inline_asm"(%arg95, %arg94, %arg97, %arg98, %arg96, %arg99) <{asm_dialect = 0 : i64, asm_string = "@$5 cp.async.bulk.tensor.2d.shared::cluster.global.mbarrier::complete_tx::bytes [$0], [$1, {$2,$3} ], [$4];", constraints = "l,l,r,r,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, !llvm.ptr<3>, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<7>, ptr<3>, i32, i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_load_3d", visibility_ = 0 : i64}> ({
  ^bb0(%arg87: !llvm.ptr, %arg88: !llvm.ptr<7>, %arg89: !llvm.ptr<3>, %arg90: i32, %arg91: i32, %arg92: i32, %arg93: i1):
    "llvm.inline_asm"(%arg88, %arg87, %arg90, %arg91, %arg92, %arg89, %arg93) <{asm_dialect = 0 : i64, asm_string = "@$6 cp.async.bulk.tensor.3d.shared::cluster.global.mbarrier::complete_tx::bytes [$0], [$1, {$2,$3,$4} ], [$5];", constraints = "l,l,r,r,r,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, !llvm.ptr<3>, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<7>, ptr<3>, i32, i32, i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_load_4d", visibility_ = 0 : i64}> ({
  ^bb0(%arg79: !llvm.ptr, %arg80: !llvm.ptr<7>, %arg81: !llvm.ptr<3>, %arg82: i32, %arg83: i32, %arg84: i32, %arg85: i32, %arg86: i1):
    "llvm.inline_asm"(%arg80, %arg79, %arg82, %arg83, %arg84, %arg85, %arg81, %arg86) <{asm_dialect = 0 : i64, asm_string = "@$7 cp.async.bulk.tensor.4d.shared::cluster.global.mbarrier::complete_tx::bytes [$0], [$1, {$2,$3,$4,$5} ], [$6];", constraints = "l,l,r,r,r,r,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, !llvm.ptr<3>, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<7>, ptr<3>, i32, i32, i32, i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_load_5d", visibility_ = 0 : i64}> ({
  ^bb0(%arg70: !llvm.ptr, %arg71: !llvm.ptr<7>, %arg72: !llvm.ptr<3>, %arg73: i32, %arg74: i32, %arg75: i32, %arg76: i32, %arg77: i32, %arg78: i1):
    "llvm.inline_asm"(%arg71, %arg70, %arg73, %arg74, %arg75, %arg76, %arg77, %arg72, %arg78) <{asm_dialect = 0 : i64, asm_string = "@$8 cp.async.bulk.tensor.5d.shared::cluster.global.mbarrier::complete_tx::bytes [$0], [$1, {$2,$3,$4,$5,$6} ], [$7];", constraints = "l,l,r,r,r,r,r,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, i32, !llvm.ptr<3>, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<7>, ptr<3>, i16, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_load_multicast1d", visibility_ = 0 : i64}> ({
  ^bb0(%arg64: !llvm.ptr, %arg65: !llvm.ptr<7>, %arg66: !llvm.ptr<3>, %arg67: i16, %arg68: i32, %arg69: i1):
    "llvm.inline_asm"(%arg65, %arg64, %arg68, %arg66, %arg67, %arg69) <{asm_dialect = 0 : i64, asm_string = "@$5 cp.async.bulk.tensor.1d.shared::cluster.global.mbarrier::complete_tx::bytes.multicast::cluster [$0], [$1, {$2} ], [$3], $4;", constraints = "l,l,r,r,h,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<7>, !llvm.ptr, i32, !llvm.ptr<3>, i16, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<7>, ptr<3>, i16, i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_load_multicast2d", visibility_ = 0 : i64}> ({
  ^bb0(%arg57: !llvm.ptr, %arg58: !llvm.ptr<7>, %arg59: !llvm.ptr<3>, %arg60: i16, %arg61: i32, %arg62: i32, %arg63: i1):
    "llvm.inline_asm"(%arg58, %arg57, %arg61, %arg62, %arg59, %arg60, %arg63) <{asm_dialect = 0 : i64, asm_string = "@$6 cp.async.bulk.tensor.2d.shared::cluster.global.mbarrier::complete_tx::bytes.multicast::cluster [$0], [$1, {$2,$3} ], [$4], $5;", constraints = "l,l,r,r,r,h,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, !llvm.ptr<3>, i16, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<7>, ptr<3>, i16, i32, i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_load_multicast3d", visibility_ = 0 : i64}> ({
  ^bb0(%arg49: !llvm.ptr, %arg50: !llvm.ptr<7>, %arg51: !llvm.ptr<3>, %arg52: i16, %arg53: i32, %arg54: i32, %arg55: i32, %arg56: i1):
    "llvm.inline_asm"(%arg50, %arg49, %arg53, %arg54, %arg55, %arg51, %arg52, %arg56) <{asm_dialect = 0 : i64, asm_string = "@$7 cp.async.bulk.tensor.3d.shared::cluster.global.mbarrier::complete_tx::bytes.multicast::cluster [$0], [$1, {$2,$3,$4} ], [$5], $6;", constraints = "l,l,r,r,r,r,h,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, !llvm.ptr<3>, i16, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<7>, ptr<3>, i16, i32, i32, i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_load_multicast4d", visibility_ = 0 : i64}> ({
  ^bb0(%arg40: !llvm.ptr, %arg41: !llvm.ptr<7>, %arg42: !llvm.ptr<3>, %arg43: i16, %arg44: i32, %arg45: i32, %arg46: i32, %arg47: i32, %arg48: i1):
    "llvm.inline_asm"(%arg41, %arg40, %arg44, %arg45, %arg46, %arg47, %arg42, %arg43, %arg48) <{asm_dialect = 0 : i64, asm_string = "@$8 cp.async.bulk.tensor.4d.shared::cluster.global.mbarrier::complete_tx::bytes.multicast::cluster [$0], [$1, {$2,$3,$4,$5} ], [$6], $7;", constraints = "l,l,r,r,r,r,r,h,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, !llvm.ptr<3>, i16, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<7>, ptr<3>, i16, i32, i32, i32, i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_load_multicast5d", visibility_ = 0 : i64}> ({
  ^bb0(%arg30: !llvm.ptr, %arg31: !llvm.ptr<7>, %arg32: !llvm.ptr<3>, %arg33: i16, %arg34: i32, %arg35: i32, %arg36: i32, %arg37: i32, %arg38: i32, %arg39: i1):
    "llvm.inline_asm"(%arg31, %arg30, %arg34, %arg35, %arg36, %arg37, %arg38, %arg32, %arg33, %arg39) <{asm_dialect = 0 : i64, asm_string = "@$9 cp.async.bulk.tensor.5d.shared::cluster.global.mbarrier::complete_tx::bytes.multicast::cluster [$0], [$1, {$2,$3,$4,$5,$6} ], [$7], $8;", constraints = "l,l,r,r,r,r,r,r,h,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr<7>, !llvm.ptr, i32, i32, i32, i32, i32, !llvm.ptr<3>, i16, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<3>, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_store_1d", visibility_ = 0 : i64}> ({
  ^bb0(%arg26: !llvm.ptr, %arg27: !llvm.ptr<3>, %arg28: i32, %arg29: i1):
    "llvm.inline_asm"(%arg26, %arg27, %arg28, %arg29) <{asm_dialect = 0 : i64, asm_string = "@$3 cp.async.bulk.tensor.1d.global.shared::cta.bulk_group [$0, {$2} ], [$1];", constraints = "l,r,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr, !llvm.ptr<3>, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<3>, i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_store_2d", visibility_ = 0 : i64}> ({
  ^bb0(%arg21: !llvm.ptr, %arg22: !llvm.ptr<3>, %arg23: i32, %arg24: i32, %arg25: i1):
    "llvm.inline_asm"(%arg21, %arg22, %arg23, %arg24, %arg25) <{asm_dialect = 0 : i64, asm_string = "@$4 cp.async.bulk.tensor.2d.global.shared::cta.bulk_group [$0, {$2, $3} ], [$1];", constraints = "l,r,r,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr, !llvm.ptr<3>, i32, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<3>, i32, i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_store_3d", visibility_ = 0 : i64}> ({
  ^bb0(%arg15: !llvm.ptr, %arg16: !llvm.ptr<3>, %arg17: i32, %arg18: i32, %arg19: i32, %arg20: i1):
    "llvm.inline_asm"(%arg15, %arg16, %arg17, %arg18, %arg19, %arg20) <{asm_dialect = 0 : i64, asm_string = "@$5 cp.async.bulk.tensor.3d.global.shared::cta.bulk_group [$0, {$2, $3, $4} ], [$1];", constraints = "l,r,r,r,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr, !llvm.ptr<3>, i32, i32, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<3>, i32, i32, i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_store_4d", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: !llvm.ptr, %arg9: !llvm.ptr<3>, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i1):
    "llvm.inline_asm"(%arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14) <{asm_dialect = 0 : i64, asm_string = "@$6 cp.async.bulk.tensor.4d.global.shared::cta.bulk_group [$0, {$2, $3, $4, $5} ], [$1];", constraints = "l,r,r,r,r,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr, !llvm.ptr<3>, i32, i32, i32, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<3>, i32, i32, i32, i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "tma_store_5d", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr<3>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i1):
    "llvm.inline_asm"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7) <{asm_dialect = 0 : i64, asm_string = "@$7 cp.async.bulk.tensor.5d.global.shared::cta.bulk_group [$0, {$2, $3, $4, $5, $6} ], [$1];", constraints = "l,r,r,r,r,r,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr, !llvm.ptr<3>, i32, i32, i32, i32, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "wgmma_execute", visibility_ = 0 : i64}> ({
    "nvvm.wgmma.fence.aligned"() : () -> ()
    "nvvm.wgmma.commit.group.sync.aligned"() : () -> ()
    "nvvm.wgmma.wait.group.sync.aligned"() <{group = 0 : i64}> : () -> ()
    "nvvm.wgmma.fence.aligned"() : () -> ()
    "nvvm.wgmma.commit.group.sync.aligned"() : () -> ()
    "nvvm.wgmma.wait.group.sync.aligned"() <{group = 5 : i64}> : () -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "wgmma_f32_f16_f16", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.undef"() : () -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
    %4 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %11 = "llvm.extractvalue"(%0) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %12 = "llvm.extractvalue"(%0) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %13 = "llvm.extractvalue"(%0) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %14 = "llvm.extractvalue"(%0) <{position = array<i64: 8>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %15 = "llvm.extractvalue"(%0) <{position = array<i64: 9>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %16 = "llvm.extractvalue"(%0) <{position = array<i64: 10>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %17 = "llvm.extractvalue"(%0) <{position = array<i64: 11>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %18 = "llvm.extractvalue"(%0) <{position = array<i64: 12>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %19 = "llvm.extractvalue"(%0) <{position = array<i64: 13>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %20 = "llvm.extractvalue"(%0) <{position = array<i64: 14>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %21 = "llvm.extractvalue"(%0) <{position = array<i64: 15>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %22 = "llvm.inline_asm"(%6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19, %20, %21, %arg0, %arg1, %1, %2, %3, %4, %5) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $34, 0;\0Awgmma.mma_async.sync.aligned.m64n32k16.f32.f16.f16 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15}, $32, $33, p, $35,  $36, $37,  $38;\0A}\0A", constraints = "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,l,l,n,n,n,n,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %23 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %24 = "llvm.add"(%arg0, %23) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %25 = "llvm.add"(%arg1, %23) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %26 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %27 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
    %28 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
    %29 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %30 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %31 = "llvm.extractvalue"(%22) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %32 = "llvm.extractvalue"(%22) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %33 = "llvm.extractvalue"(%22) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %34 = "llvm.extractvalue"(%22) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %35 = "llvm.extractvalue"(%22) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %36 = "llvm.extractvalue"(%22) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %37 = "llvm.extractvalue"(%22) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %38 = "llvm.extractvalue"(%22) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %39 = "llvm.extractvalue"(%22) <{position = array<i64: 8>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %40 = "llvm.extractvalue"(%22) <{position = array<i64: 9>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %41 = "llvm.extractvalue"(%22) <{position = array<i64: 10>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %42 = "llvm.extractvalue"(%22) <{position = array<i64: 11>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %43 = "llvm.extractvalue"(%22) <{position = array<i64: 12>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %44 = "llvm.extractvalue"(%22) <{position = array<i64: 13>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %45 = "llvm.extractvalue"(%22) <{position = array<i64: 14>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %46 = "llvm.extractvalue"(%22) <{position = array<i64: 15>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %47 = "llvm.inline_asm"(%31, %32, %33, %34, %35, %36, %37, %38, %39, %40, %41, %42, %43, %44, %45, %46, %24, %25, %26, %27, %28, %29, %30) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $34, 0;\0Awgmma.mma_async.sync.aligned.m64n32k16.f32.f16.f16 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15}, $32, $33, p, $35,  $36, $37,  $38;\0A}\0A", constraints = "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,l,l,n,n,n,n,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    "llvm.return"(%47) : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i32, i32, i32, i32)> (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "wgmma_s32_s8_s8_satfinite", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: i64, %arg3: i64):
    %19 = "llvm.mlir.undef"() : () -> !llvm.struct<(i32, i32, i32, i32)>
    %20 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %21 = "llvm.extractvalue"(%19) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %22 = "llvm.extractvalue"(%19) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %23 = "llvm.extractvalue"(%19) <{position = array<i64: 2>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %24 = "llvm.extractvalue"(%19) <{position = array<i64: 3>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %25 = "llvm.inline_asm"(%21, %22, %23, %24, %arg2, %arg3, %20) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $10, 0;\0Awgmma.mma_async.sync.aligned.m64n8k32.s32.s8.s8.satfinite {$0, $1, $2, $3}, $8, $9, p;\0A}\0A", constraints = "=r,=r,=r,=r,0,1,2,3,l,l,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (i32, i32, i32, i32, i64, i64, i32) -> !llvm.struct<(i32, i32, i32, i32)>
    %26 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %27 = "llvm.extractvalue"(%25) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %28 = "llvm.extractvalue"(%25) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %29 = "llvm.extractvalue"(%25) <{position = array<i64: 2>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %30 = "llvm.extractvalue"(%25) <{position = array<i64: 3>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %31 = "llvm.inline_asm"(%27, %28, %29, %30, %arg2, %arg3, %26) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $10, 0;\0Awgmma.mma_async.sync.aligned.m64n8k32.s32.s8.s8.satfinite {$0, $1, $2, $3}, $8, $9, p;\0A}\0A", constraints = "=r,=r,=r,=r,0,1,2,3,l,l,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (i32, i32, i32, i32, i64, i64, i32) -> !llvm.struct<(i32, i32, i32, i32)>
    %32 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %33 = "llvm.extractvalue"(%31) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %34 = "llvm.extractvalue"(%31) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %35 = "llvm.extractvalue"(%31) <{position = array<i64: 2>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %36 = "llvm.extractvalue"(%31) <{position = array<i64: 3>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %37 = "llvm.inline_asm"(%33, %34, %35, %36, %arg2, %arg3, %32) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $10, 0;\0Awgmma.mma_async.sync.aligned.m64n8k32.s32.s8.s8.satfinite {$0, $1, $2, $3}, $8, $9, p;\0A}\0A", constraints = "=r,=r,=r,=r,0,1,2,3,l,l,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (i32, i32, i32, i32, i64, i64, i32) -> !llvm.struct<(i32, i32, i32, i32)>
    "llvm.return"(%37) : (!llvm.struct<(i32, i32, i32, i32)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i32, i32, i32, i32)> (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "wgmma_s32_u8_u8", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.undef"() : () -> !llvm.struct<(i32, i32, i32, i32)>
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %6 = "llvm.inline_asm"(%2, %3, %4, %5, %arg0, %arg1, %1) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $10, 0;\0Awgmma.mma_async.sync.aligned.m64n8k32.s32.u8.u8 {$0, $1, $2, $3}, $8, $9, p;\0A}\0A", constraints = "=r,=r,=r,=r,0,1,2,3,l,l,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (i32, i32, i32, i32, i64, i64, i32) -> !llvm.struct<(i32, i32, i32, i32)>
    %7 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %8 = "llvm.extractvalue"(%6) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %9 = "llvm.extractvalue"(%6) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %10 = "llvm.extractvalue"(%6) <{position = array<i64: 2>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %11 = "llvm.extractvalue"(%6) <{position = array<i64: 3>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %12 = "llvm.inline_asm"(%8, %9, %10, %11, %arg0, %arg1, %7) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $10, 0;\0Awgmma.mma_async.sync.aligned.m64n8k32.s32.u8.u8 {$0, $1, $2, $3}, $8, $9, p;\0A}\0A", constraints = "=r,=r,=r,=r,0,1,2,3,l,l,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (i32, i32, i32, i32, i64, i64, i32) -> !llvm.struct<(i32, i32, i32, i32)>
    %13 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %14 = "llvm.extractvalue"(%12) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %15 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %16 = "llvm.extractvalue"(%12) <{position = array<i64: 2>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %17 = "llvm.extractvalue"(%12) <{position = array<i64: 3>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
    %18 = "llvm.inline_asm"(%14, %15, %16, %17, %arg0, %arg1, %13) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $10, 0;\0Awgmma.mma_async.sync.aligned.m64n8k32.s32.u8.u8 {$0, $1, $2, $3}, $8, $9, p;\0A}\0A", constraints = "=r,=r,=r,=r,0,1,2,3,l,l,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (i32, i32, i32, i32, i64, i64, i32) -> !llvm.struct<(i32, i32, i32, i32)>
    "llvm.return"(%18) : (!llvm.struct<(i32, i32, i32, i32)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "wgmma_f32_tf32_tf32", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.undef"() : () -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %6 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %11 = "llvm.extractvalue"(%0) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %12 = "llvm.extractvalue"(%0) <{position = array<i64: 8>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %13 = "llvm.extractvalue"(%0) <{position = array<i64: 9>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %14 = "llvm.extractvalue"(%0) <{position = array<i64: 10>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %15 = "llvm.extractvalue"(%0) <{position = array<i64: 11>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %16 = "llvm.extractvalue"(%0) <{position = array<i64: 12>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %17 = "llvm.extractvalue"(%0) <{position = array<i64: 13>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %18 = "llvm.extractvalue"(%0) <{position = array<i64: 14>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %19 = "llvm.extractvalue"(%0) <{position = array<i64: 15>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %20 = "llvm.extractvalue"(%0) <{position = array<i64: 16>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %21 = "llvm.extractvalue"(%0) <{position = array<i64: 17>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %22 = "llvm.extractvalue"(%0) <{position = array<i64: 18>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %23 = "llvm.extractvalue"(%0) <{position = array<i64: 19>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %24 = "llvm.extractvalue"(%0) <{position = array<i64: 20>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %25 = "llvm.extractvalue"(%0) <{position = array<i64: 21>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %26 = "llvm.extractvalue"(%0) <{position = array<i64: 22>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %27 = "llvm.extractvalue"(%0) <{position = array<i64: 23>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %28 = "llvm.extractvalue"(%0) <{position = array<i64: 24>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %29 = "llvm.extractvalue"(%0) <{position = array<i64: 25>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %30 = "llvm.extractvalue"(%0) <{position = array<i64: 26>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %31 = "llvm.extractvalue"(%0) <{position = array<i64: 27>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %32 = "llvm.extractvalue"(%0) <{position = array<i64: 28>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %33 = "llvm.extractvalue"(%0) <{position = array<i64: 29>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %34 = "llvm.extractvalue"(%0) <{position = array<i64: 30>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %35 = "llvm.extractvalue"(%0) <{position = array<i64: 31>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %36 = "llvm.inline_asm"(%4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19, %20, %21, %22, %23, %24, %25, %26, %27, %28, %29, %30, %31, %32, %33, %34, %35, %arg0, %arg1, %1, %2, %3) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $66, 0;\0Awgmma.mma_async.sync.aligned.m64n64k8.f32.tf32.tf32 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31}, $64, $65, p, $67,  $68;\0A}\0A", constraints = "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,l,l,n,n,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %37 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %38 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %39 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %40 = "llvm.extractvalue"(%36) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %41 = "llvm.extractvalue"(%36) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %42 = "llvm.extractvalue"(%36) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %43 = "llvm.extractvalue"(%36) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %44 = "llvm.extractvalue"(%36) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %45 = "llvm.extractvalue"(%36) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %46 = "llvm.extractvalue"(%36) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %47 = "llvm.extractvalue"(%36) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %48 = "llvm.extractvalue"(%36) <{position = array<i64: 8>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %49 = "llvm.extractvalue"(%36) <{position = array<i64: 9>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %50 = "llvm.extractvalue"(%36) <{position = array<i64: 10>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %51 = "llvm.extractvalue"(%36) <{position = array<i64: 11>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %52 = "llvm.extractvalue"(%36) <{position = array<i64: 12>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %53 = "llvm.extractvalue"(%36) <{position = array<i64: 13>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %54 = "llvm.extractvalue"(%36) <{position = array<i64: 14>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %55 = "llvm.extractvalue"(%36) <{position = array<i64: 15>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %56 = "llvm.extractvalue"(%36) <{position = array<i64: 16>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %57 = "llvm.extractvalue"(%36) <{position = array<i64: 17>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %58 = "llvm.extractvalue"(%36) <{position = array<i64: 18>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %59 = "llvm.extractvalue"(%36) <{position = array<i64: 19>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %60 = "llvm.extractvalue"(%36) <{position = array<i64: 20>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %61 = "llvm.extractvalue"(%36) <{position = array<i64: 21>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %62 = "llvm.extractvalue"(%36) <{position = array<i64: 22>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %63 = "llvm.extractvalue"(%36) <{position = array<i64: 23>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %64 = "llvm.extractvalue"(%36) <{position = array<i64: 24>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %65 = "llvm.extractvalue"(%36) <{position = array<i64: 25>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %66 = "llvm.extractvalue"(%36) <{position = array<i64: 26>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %67 = "llvm.extractvalue"(%36) <{position = array<i64: 27>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %68 = "llvm.extractvalue"(%36) <{position = array<i64: 28>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %69 = "llvm.extractvalue"(%36) <{position = array<i64: 29>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %70 = "llvm.extractvalue"(%36) <{position = array<i64: 30>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %71 = "llvm.extractvalue"(%36) <{position = array<i64: 31>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %72 = "llvm.inline_asm"(%40, %41, %42, %43, %44, %45, %46, %47, %48, %49, %50, %51, %52, %53, %54, %55, %56, %57, %58, %59, %60, %61, %62, %63, %64, %65, %66, %67, %68, %69, %70, %71, %arg0, %arg1, %37, %38, %39) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $66, 0;\0Awgmma.mma_async.sync.aligned.m64n64k8.f32.tf32.tf32 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31}, $64, $65, p, $67,  $68;\0A}\0A", constraints = "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,l,l,n,n,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    "llvm.return"(%72) : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "wgmma_f32_e4m3_e4m3", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.undef"() : () -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %6 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %11 = "llvm.extractvalue"(%0) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %12 = "llvm.extractvalue"(%0) <{position = array<i64: 8>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %13 = "llvm.extractvalue"(%0) <{position = array<i64: 9>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %14 = "llvm.extractvalue"(%0) <{position = array<i64: 10>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %15 = "llvm.extractvalue"(%0) <{position = array<i64: 11>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %16 = "llvm.extractvalue"(%0) <{position = array<i64: 12>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %17 = "llvm.extractvalue"(%0) <{position = array<i64: 13>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %18 = "llvm.extractvalue"(%0) <{position = array<i64: 14>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %19 = "llvm.extractvalue"(%0) <{position = array<i64: 15>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %20 = "llvm.extractvalue"(%0) <{position = array<i64: 16>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %21 = "llvm.extractvalue"(%0) <{position = array<i64: 17>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %22 = "llvm.extractvalue"(%0) <{position = array<i64: 18>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %23 = "llvm.extractvalue"(%0) <{position = array<i64: 19>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %24 = "llvm.extractvalue"(%0) <{position = array<i64: 20>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %25 = "llvm.extractvalue"(%0) <{position = array<i64: 21>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %26 = "llvm.extractvalue"(%0) <{position = array<i64: 22>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %27 = "llvm.extractvalue"(%0) <{position = array<i64: 23>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %28 = "llvm.extractvalue"(%0) <{position = array<i64: 24>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %29 = "llvm.extractvalue"(%0) <{position = array<i64: 25>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %30 = "llvm.extractvalue"(%0) <{position = array<i64: 26>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %31 = "llvm.extractvalue"(%0) <{position = array<i64: 27>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %32 = "llvm.extractvalue"(%0) <{position = array<i64: 28>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %33 = "llvm.extractvalue"(%0) <{position = array<i64: 29>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %34 = "llvm.extractvalue"(%0) <{position = array<i64: 30>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %35 = "llvm.extractvalue"(%0) <{position = array<i64: 31>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %36 = "llvm.inline_asm"(%4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19, %20, %21, %22, %23, %24, %25, %26, %27, %28, %29, %30, %31, %32, %33, %34, %35, %arg0, %arg1, %1, %2, %3) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $66, 0;\0Awgmma.mma_async.sync.aligned.m64n64k32.f32.e4m3.e4m3 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31}, $64, $65, p, $67,  $68;\0A}\0A", constraints = "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,l,l,n,n,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %37 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %38 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %39 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %40 = "llvm.extractvalue"(%36) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %41 = "llvm.extractvalue"(%36) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %42 = "llvm.extractvalue"(%36) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %43 = "llvm.extractvalue"(%36) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %44 = "llvm.extractvalue"(%36) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %45 = "llvm.extractvalue"(%36) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %46 = "llvm.extractvalue"(%36) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %47 = "llvm.extractvalue"(%36) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %48 = "llvm.extractvalue"(%36) <{position = array<i64: 8>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %49 = "llvm.extractvalue"(%36) <{position = array<i64: 9>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %50 = "llvm.extractvalue"(%36) <{position = array<i64: 10>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %51 = "llvm.extractvalue"(%36) <{position = array<i64: 11>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %52 = "llvm.extractvalue"(%36) <{position = array<i64: 12>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %53 = "llvm.extractvalue"(%36) <{position = array<i64: 13>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %54 = "llvm.extractvalue"(%36) <{position = array<i64: 14>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %55 = "llvm.extractvalue"(%36) <{position = array<i64: 15>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %56 = "llvm.extractvalue"(%36) <{position = array<i64: 16>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %57 = "llvm.extractvalue"(%36) <{position = array<i64: 17>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %58 = "llvm.extractvalue"(%36) <{position = array<i64: 18>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %59 = "llvm.extractvalue"(%36) <{position = array<i64: 19>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %60 = "llvm.extractvalue"(%36) <{position = array<i64: 20>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %61 = "llvm.extractvalue"(%36) <{position = array<i64: 21>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %62 = "llvm.extractvalue"(%36) <{position = array<i64: 22>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %63 = "llvm.extractvalue"(%36) <{position = array<i64: 23>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %64 = "llvm.extractvalue"(%36) <{position = array<i64: 24>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %65 = "llvm.extractvalue"(%36) <{position = array<i64: 25>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %66 = "llvm.extractvalue"(%36) <{position = array<i64: 26>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %67 = "llvm.extractvalue"(%36) <{position = array<i64: 27>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %68 = "llvm.extractvalue"(%36) <{position = array<i64: 28>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %69 = "llvm.extractvalue"(%36) <{position = array<i64: 29>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %70 = "llvm.extractvalue"(%36) <{position = array<i64: 30>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %71 = "llvm.extractvalue"(%36) <{position = array<i64: 31>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %72 = "llvm.inline_asm"(%40, %41, %42, %43, %44, %45, %46, %47, %48, %49, %50, %51, %52, %53, %54, %55, %56, %57, %58, %59, %60, %61, %62, %63, %64, %65, %66, %67, %68, %69, %70, %71, %arg0, %arg1, %37, %38, %39) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $66, 0;\0Awgmma.mma_async.sync.aligned.m64n64k32.f32.e4m3.e4m3 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31}, $64, $65, p, $67,  $68;\0A}\0A", constraints = "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,l,l,n,n,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    "llvm.return"(%72) : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)> (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "wgmma_f32_e5m2_e4m3", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.undef"() : () -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %6 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %11 = "llvm.extractvalue"(%0) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %12 = "llvm.extractvalue"(%0) <{position = array<i64: 8>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %13 = "llvm.extractvalue"(%0) <{position = array<i64: 9>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %14 = "llvm.extractvalue"(%0) <{position = array<i64: 10>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %15 = "llvm.extractvalue"(%0) <{position = array<i64: 11>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %16 = "llvm.extractvalue"(%0) <{position = array<i64: 12>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %17 = "llvm.extractvalue"(%0) <{position = array<i64: 13>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %18 = "llvm.extractvalue"(%0) <{position = array<i64: 14>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %19 = "llvm.extractvalue"(%0) <{position = array<i64: 15>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %20 = "llvm.extractvalue"(%0) <{position = array<i64: 16>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %21 = "llvm.extractvalue"(%0) <{position = array<i64: 17>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %22 = "llvm.extractvalue"(%0) <{position = array<i64: 18>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %23 = "llvm.extractvalue"(%0) <{position = array<i64: 19>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %24 = "llvm.extractvalue"(%0) <{position = array<i64: 20>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %25 = "llvm.extractvalue"(%0) <{position = array<i64: 21>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %26 = "llvm.extractvalue"(%0) <{position = array<i64: 22>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %27 = "llvm.extractvalue"(%0) <{position = array<i64: 23>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %28 = "llvm.extractvalue"(%0) <{position = array<i64: 24>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %29 = "llvm.extractvalue"(%0) <{position = array<i64: 25>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %30 = "llvm.extractvalue"(%0) <{position = array<i64: 26>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %31 = "llvm.extractvalue"(%0) <{position = array<i64: 27>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %32 = "llvm.extractvalue"(%0) <{position = array<i64: 28>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %33 = "llvm.extractvalue"(%0) <{position = array<i64: 29>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %34 = "llvm.extractvalue"(%0) <{position = array<i64: 30>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %35 = "llvm.extractvalue"(%0) <{position = array<i64: 31>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %36 = "llvm.inline_asm"(%4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19, %20, %21, %22, %23, %24, %25, %26, %27, %28, %29, %30, %31, %32, %33, %34, %35, %arg0, %arg1, %1, %2, %3) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $66, 0;\0Awgmma.mma_async.sync.aligned.m64n64k32.f32.e5m2.e4m3 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31}, $64, $65, p, $67,  $68;\0A}\0A", constraints = "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,l,l,n,n,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    %37 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %38 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %39 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %40 = "llvm.extractvalue"(%36) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %41 = "llvm.extractvalue"(%36) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %42 = "llvm.extractvalue"(%36) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %43 = "llvm.extractvalue"(%36) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %44 = "llvm.extractvalue"(%36) <{position = array<i64: 4>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %45 = "llvm.extractvalue"(%36) <{position = array<i64: 5>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %46 = "llvm.extractvalue"(%36) <{position = array<i64: 6>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %47 = "llvm.extractvalue"(%36) <{position = array<i64: 7>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %48 = "llvm.extractvalue"(%36) <{position = array<i64: 8>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %49 = "llvm.extractvalue"(%36) <{position = array<i64: 9>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %50 = "llvm.extractvalue"(%36) <{position = array<i64: 10>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %51 = "llvm.extractvalue"(%36) <{position = array<i64: 11>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %52 = "llvm.extractvalue"(%36) <{position = array<i64: 12>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %53 = "llvm.extractvalue"(%36) <{position = array<i64: 13>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %54 = "llvm.extractvalue"(%36) <{position = array<i64: 14>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %55 = "llvm.extractvalue"(%36) <{position = array<i64: 15>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %56 = "llvm.extractvalue"(%36) <{position = array<i64: 16>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %57 = "llvm.extractvalue"(%36) <{position = array<i64: 17>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %58 = "llvm.extractvalue"(%36) <{position = array<i64: 18>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %59 = "llvm.extractvalue"(%36) <{position = array<i64: 19>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %60 = "llvm.extractvalue"(%36) <{position = array<i64: 20>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %61 = "llvm.extractvalue"(%36) <{position = array<i64: 21>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %62 = "llvm.extractvalue"(%36) <{position = array<i64: 22>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %63 = "llvm.extractvalue"(%36) <{position = array<i64: 23>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %64 = "llvm.extractvalue"(%36) <{position = array<i64: 24>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %65 = "llvm.extractvalue"(%36) <{position = array<i64: 25>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %66 = "llvm.extractvalue"(%36) <{position = array<i64: 26>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %67 = "llvm.extractvalue"(%36) <{position = array<i64: 27>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %68 = "llvm.extractvalue"(%36) <{position = array<i64: 28>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %69 = "llvm.extractvalue"(%36) <{position = array<i64: 29>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %70 = "llvm.extractvalue"(%36) <{position = array<i64: 30>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %71 = "llvm.extractvalue"(%36) <{position = array<i64: 31>}> : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> f32
    %72 = "llvm.inline_asm"(%40, %41, %42, %43, %44, %45, %46, %47, %48, %49, %50, %51, %52, %53, %54, %55, %56, %57, %58, %59, %60, %61, %62, %63, %64, %65, %66, %67, %68, %69, %70, %71, %arg0, %arg1, %37, %38, %39) <{asm_dialect = 0 : i64, asm_string = "{\0A.reg .pred p;\0Asetp.ne.b32 p, $66, 0;\0Awgmma.mma_async.sync.aligned.m64n64k32.f32.e5m2.e4m3 {$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31}, $64, $65, p, $67,  $68;\0A}\0A", constraints = "=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,=f,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,l,l,n,n,n", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, i64, i64, i32, i32, i32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>
    "llvm.return"(%72) : (!llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "elect_one_leader_sync", visibility_ = 0 : i64}> ({
    %0 = "nvvm.elect.sync"() : () -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i1)>, linkage = #llvm.linkage<external>, sym_name = "test_nvvm_prefetch", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: i1):
    "nvvm.prefetch"(%arg0) <{tensormap}> : (!llvm.ptr) -> ()
    "llvm.inline_asm"(%arg0, %arg1) <{asm_dialect = 0 : i64, asm_string = "@$1 prefetch.tensormap [$0];", constraints = "l,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "set_max_register", visibility_ = 0 : i64}> ({
    "nvvm.setmaxregister"() <{action = #nvvm<action increase>, regCount = 232 : i32}> : () -> ()
    "nvvm.setmaxregister"() <{action = #nvvm<action decrease>, regCount = 40 : i32}> : () -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "cp_async_bulk_commit", visibility_ = 0 : i64}> ({
    "nvvm.cp.async.bulk.commit.group"() : () -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "cp_async_bulk_wait_group", visibility_ = 0 : i64}> ({
    "nvvm.cp.async.bulk.wait_group"() <{group = 1 : i32}> : () -> ()
    "nvvm.cp.async.bulk.wait_group"() <{group = 0 : i32}> : () -> ()
    "nvvm.cp.async.bulk.wait_group"() <{group = 5 : i32, read}> : () -> ()
    "nvvm.cp.async.bulk.wait_group"() <{group = 0 : i32, read}> : () -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "llvm_nvvm_barrier_arrive", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    "llvm.inline_asm"(%arg1) <{asm_dialect = 0 : i64, asm_string = "bar.arrive 0, $0;", constraints = "r", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (i32) -> ()
    "llvm.inline_asm"(%arg0, %arg1) <{asm_dialect = 0 : i64, asm_string = "bar.arrive $0, $1;", constraints = "r,r", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr<3>, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "init_mbarrier", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr<3>, %arg2: i32, %arg3: i1):
    "llvm.inline_asm"(%arg0, %arg2) <{asm_dialect = 0 : i64, asm_string = "mbarrier.init.b64 [$0], $1;", constraints = "l,r", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr, i32) -> ()
    "llvm.inline_asm"(%arg0, %arg2, %arg3) <{asm_dialect = 0 : i64, asm_string = "@$2 mbarrier.init.b64 [$0], $1;", constraints = "l,r,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (!llvm.ptr, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, i1)>, linkage = #llvm.linkage<external>, sym_name = "ex2", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg10: f32, %arg11: i1):
    %17 = "llvm.inline_asm"(%arg10) <{asm_dialect = 0 : i64, asm_string = "ex2.approx.ftz.f32 $0, $1;", constraints = "=f,f", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (f32) -> f32
    %18 = "llvm.inline_asm"(%arg10, %arg11) <{asm_dialect = 0 : i64, asm_string = "@$1 ex2.approx.ftz.f32 $0, $1;", constraints = "=f,f,b", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (f32, i1) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "multi_return", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg8: i32, %arg9: i32):
    %13 = "llvm.inline_asm"(%arg8, %arg9) <{asm_dialect = 0 : i64, asm_string = "{.reg .pred p; setp.ge.s32 p, $2, $3; selp.s32 $0, $2,$3, p; selp.s32 $1, $2,$3, p;}", constraints = "=r,=r,r,r", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %14 = "llvm.extractvalue"(%13) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %15 = "llvm.extractvalue"(%13) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %16 = "llvm.add"(%14, %15) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%16) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (i32, i32, f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "inline_ptx_multi_rw", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg4: i32, %arg5: i32, %arg6: f32, %arg7: f32):
    %9 = "llvm.inline_asm"(%arg6, %arg7, %arg4, %arg5) <{asm_dialect = 0 : i64, asm_string = "{.reg .pred p; setp.ge.s32 p, $2, $3; selp.s32 $0, $2,$3, p; selp.s32 $1, $2,$3, p;}", constraints = "=f,=f,r,r,0,1", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (f32, f32, i32, i32) -> !llvm.struct<(f32, f32)>
    %10 = "llvm.extractvalue"(%9) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %11 = "llvm.extractvalue"(%9) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %12 = "llvm.fadd"(%10, %11) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"(%12) : (f32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (i32, i32, f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "inline_ptx_multi_rw_r", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32):
    %0 = "llvm.inline_asm"(%arg2, %arg3, %arg0, %arg1) <{asm_dialect = 0 : i64, asm_string = "{.reg .pred p; setp.ge.s32 p, $4, $5; selp.s32 $0, $4,$5, p; selp.s32 $1, $4,$5, p; selp.s32 $2, $4,$5, p; selp.s32 $3, $4,$5, p;}", constraints = "=f,=f,=r,=r,r,r,0,1", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (f32, f32, i32, i32) -> !llvm.struct<(f32, f32, i32, i32)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, i32, i32)>) -> f32
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, i32, i32)>) -> f32
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, i32, i32)>) -> i32
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, i32, i32)>) -> i32
    %5 = "llvm.add"(%3, %4) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %6 = "llvm.sitofp"(%5) : (i32) -> f32
    %7 = "llvm.fadd"(%1, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %8 = "llvm.fadd"(%6, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"(%8) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi8>, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "inline_ptx_pack_4i8", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg4: vector<4xi8>, %arg5: i32, %arg6: i32):
    %4 = "llvm.inline_asm"(%arg4, %arg5, %arg6) <{asm_dialect = 0 : i64, asm_string = "dp4a.s32.s32 $0, $1, $2, $3;", constraints = "=r,r,r,r", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (vector<4xi8>, i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "inline_ptx_pack_2bf16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %3 = "llvm.inline_asm"(%arg2, %arg3) <{asm_dialect = 0 : i64, asm_string = "cvt.rn.satfinite.bf16x2.f32 $0, $1, $2;", constraints = "=f,f,f", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (f32, f32) -> vector<2xbf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16)>, linkage = #llvm.linkage<external>, sym_name = "inline_ptx_cvt_rn_e4m3x2_f16x2", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg1: i16):
    %2 = "llvm.inline_asm"(%arg1) <{asm_dialect = 0 : i64, asm_string = "cvt.rz.satfinite.ue8m0x2.bf16x2 $0, $1", constraints = "=f,h", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (i16) -> vector<2xbf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i8)>, linkage = #llvm.linkage<external>, sym_name = "cvt_i8_bf16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i8):
    %0 = "llvm.zext"(%arg0) : (i8) -> i16
    %1 = "llvm.inline_asm"(%0) <{asm_dialect = 0 : i64, asm_string = "{\0A\09.reg .b16 r;\0A\09.reg .b8 s;\0A\09mov.b16 {s,_}, $0;\0A\09cvt.rn.bf16.s8 r, s;\0A\09mov.b16 $1, r;\0A\09", constraints = "=h,h", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (i16) -> i16
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()


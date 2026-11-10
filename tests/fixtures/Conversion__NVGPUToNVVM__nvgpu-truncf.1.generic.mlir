"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "cvt_float_f32_to_f16"}> ({
  ^bb0(%arg34: vector<4xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_f16_v8"}> ({
  ^bb0(%arg33: vector<8xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "cvt_float_f32_to_bf16"}> ({
  ^bb0(%arg32: vector<4xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_e4m3"}> ({
  ^bb0(%arg31: vector<8xf32>):
    %602 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %603 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %604 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %605 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %606 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %607 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %608 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %609 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %610 = "llvm.bitcast"(%arg31) : (vector<8xf32>) -> vector<8xi32>
    %611 = "llvm.extractelement"(%610, %608) : (vector<8xi32>, i64) -> i32
    %612 = "llvm.extractelement"(%610, %607) : (vector<8xi32>, i64) -> i32
    %613 = "llvm.bitcast"(%611) : (i32) -> f32
    %614 = "llvm.bitcast"(%612) : (i32) -> f32
    %615 = "nvvm.convert.f32x2.to.f8x2"(%614, %613) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %616 = "llvm.extractelement"(%610, %609) : (vector<8xi32>, i64) -> i32
    %617 = "llvm.extractelement"(%610, %606) : (vector<8xi32>, i64) -> i32
    %618 = "llvm.bitcast"(%616) : (i32) -> f32
    %619 = "llvm.bitcast"(%617) : (i32) -> f32
    %620 = "nvvm.convert.f32x2.to.f8x2"(%619, %618) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %621 = "llvm.extractelement"(%610, %605) : (vector<8xi32>, i64) -> i32
    %622 = "llvm.extractelement"(%610, %604) : (vector<8xi32>, i64) -> i32
    %623 = "llvm.bitcast"(%621) : (i32) -> f32
    %624 = "llvm.bitcast"(%622) : (i32) -> f32
    %625 = "nvvm.convert.f32x2.to.f8x2"(%624, %623) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %626 = "llvm.extractelement"(%610, %603) : (vector<8xi32>, i64) -> i32
    %627 = "llvm.extractelement"(%610, %602) : (vector<8xi32>, i64) -> i32
    %628 = "llvm.bitcast"(%626) : (i32) -> f32
    %629 = "llvm.bitcast"(%627) : (i32) -> f32
    %630 = "nvvm.convert.f32x2.to.f8x2"(%629, %628) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf16>) -> (), sym_name = "cvt_float_f16_to_e2m3"}> ({
  ^bb0(%arg30: vector<8xf16>):
    %585 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %586 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %587 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %588 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %589 = "llvm.bitcast"(%arg30) : (vector<8xf16>) -> vector<4xi32>
    %590 = "llvm.extractelement"(%589, %587) : (vector<4xi32>, i64) -> i32
    %591 = "llvm.bitcast"(%590) : (i32) -> vector<2xf16>
    %592 = "nvvm.convert.f16x2.to.f6x2"(%591) <{dstTy = f6E2M3FN, relu = false}> : (vector<2xf16>) -> i16
    %593 = "llvm.extractelement"(%589, %588) : (vector<4xi32>, i64) -> i32
    %594 = "llvm.bitcast"(%593) : (i32) -> vector<2xf16>
    %595 = "nvvm.convert.f16x2.to.f6x2"(%594) <{dstTy = f6E2M3FN, relu = false}> : (vector<2xf16>) -> i16
    %596 = "llvm.extractelement"(%589, %586) : (vector<4xi32>, i64) -> i32
    %597 = "llvm.bitcast"(%596) : (i32) -> vector<2xf16>
    %598 = "nvvm.convert.f16x2.to.f6x2"(%597) <{dstTy = f6E2M3FN, relu = false}> : (vector<2xf16>) -> i16
    %599 = "llvm.extractelement"(%589, %585) : (vector<4xi32>, i64) -> i32
    %600 = "llvm.bitcast"(%599) : (i32) -> vector<2xf16>
    %601 = "nvvm.convert.f16x2.to.f6x2"(%600) <{dstTy = f6E2M3FN, relu = false}> : (vector<2xf16>) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xbf16>) -> (), sym_name = "cvt_float_bf16_to_e3m2"}> ({
  ^bb0(%arg29: vector<8xbf16>):
    %568 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %569 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %570 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %571 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %572 = "llvm.bitcast"(%arg29) : (vector<8xbf16>) -> vector<4xi32>
    %573 = "llvm.extractelement"(%572, %570) : (vector<4xi32>, i64) -> i32
    %574 = "llvm.bitcast"(%573) : (i32) -> vector<2xbf16>
    %575 = "nvvm.convert.bf16x2.to.f6x2"(%574) <{dstTy = f6E3M2FN, relu = false}> : (vector<2xbf16>) -> i16
    %576 = "llvm.extractelement"(%572, %571) : (vector<4xi32>, i64) -> i32
    %577 = "llvm.bitcast"(%576) : (i32) -> vector<2xbf16>
    %578 = "nvvm.convert.bf16x2.to.f6x2"(%577) <{dstTy = f6E3M2FN, relu = false}> : (vector<2xbf16>) -> i16
    %579 = "llvm.extractelement"(%572, %569) : (vector<4xi32>, i64) -> i32
    %580 = "llvm.bitcast"(%579) : (i32) -> vector<2xbf16>
    %581 = "nvvm.convert.bf16x2.to.f6x2"(%580) <{dstTy = f6E3M2FN, relu = false}> : (vector<2xbf16>) -> i16
    %582 = "llvm.extractelement"(%572, %568) : (vector<4xi32>, i64) -> i32
    %583 = "llvm.bitcast"(%582) : (i32) -> vector<2xbf16>
    %584 = "nvvm.convert.bf16x2.to.f6x2"(%583) <{dstTy = f6E3M2FN, relu = false}> : (vector<2xbf16>) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_e2m3"}> ({
  ^bb0(%arg28: vector<8xf32>):
    %539 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %540 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %541 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %542 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %543 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %544 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %545 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %546 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %547 = "llvm.bitcast"(%arg28) : (vector<8xf32>) -> vector<8xi32>
    %548 = "llvm.extractelement"(%547, %545) : (vector<8xi32>, i64) -> i32
    %549 = "llvm.extractelement"(%547, %544) : (vector<8xi32>, i64) -> i32
    %550 = "llvm.bitcast"(%548) : (i32) -> f32
    %551 = "llvm.bitcast"(%549) : (i32) -> f32
    %552 = "nvvm.convert.f32x2.to.f6x2"(%551, %550) <{dstTy = f6E2M3FN, relu = false}> : (f32, f32) -> i16
    %553 = "llvm.extractelement"(%547, %546) : (vector<8xi32>, i64) -> i32
    %554 = "llvm.extractelement"(%547, %543) : (vector<8xi32>, i64) -> i32
    %555 = "llvm.bitcast"(%553) : (i32) -> f32
    %556 = "llvm.bitcast"(%554) : (i32) -> f32
    %557 = "nvvm.convert.f32x2.to.f6x2"(%556, %555) <{dstTy = f6E2M3FN, relu = false}> : (f32, f32) -> i16
    %558 = "llvm.extractelement"(%547, %542) : (vector<8xi32>, i64) -> i32
    %559 = "llvm.extractelement"(%547, %541) : (vector<8xi32>, i64) -> i32
    %560 = "llvm.bitcast"(%558) : (i32) -> f32
    %561 = "llvm.bitcast"(%559) : (i32) -> f32
    %562 = "nvvm.convert.f32x2.to.f6x2"(%561, %560) <{dstTy = f6E2M3FN, relu = false}> : (f32, f32) -> i16
    %563 = "llvm.extractelement"(%547, %540) : (vector<8xi32>, i64) -> i32
    %564 = "llvm.extractelement"(%547, %539) : (vector<8xi32>, i64) -> i32
    %565 = "llvm.bitcast"(%563) : (i32) -> f32
    %566 = "llvm.bitcast"(%564) : (i32) -> f32
    %567 = "nvvm.convert.f32x2.to.f6x2"(%566, %565) <{dstTy = f6E2M3FN, relu = false}> : (f32, f32) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_e8m0_rz"}> ({
  ^bb0(%arg27: vector<8xf32>):
    %510 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %511 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %512 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %513 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %514 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %515 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %516 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %517 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %518 = "llvm.bitcast"(%arg27) : (vector<8xf32>) -> vector<8xi32>
    %519 = "llvm.extractelement"(%518, %516) : (vector<8xi32>, i64) -> i32
    %520 = "llvm.extractelement"(%518, %515) : (vector<8xi32>, i64) -> i32
    %521 = "llvm.bitcast"(%519) : (i32) -> f32
    %522 = "llvm.bitcast"(%520) : (i32) -> f32
    %523 = "nvvm.convert.f32x2.to.f8x2"(%522, %521) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %524 = "llvm.extractelement"(%518, %517) : (vector<8xi32>, i64) -> i32
    %525 = "llvm.extractelement"(%518, %514) : (vector<8xi32>, i64) -> i32
    %526 = "llvm.bitcast"(%524) : (i32) -> f32
    %527 = "llvm.bitcast"(%525) : (i32) -> f32
    %528 = "nvvm.convert.f32x2.to.f8x2"(%527, %526) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %529 = "llvm.extractelement"(%518, %513) : (vector<8xi32>, i64) -> i32
    %530 = "llvm.extractelement"(%518, %512) : (vector<8xi32>, i64) -> i32
    %531 = "llvm.bitcast"(%529) : (i32) -> f32
    %532 = "llvm.bitcast"(%530) : (i32) -> f32
    %533 = "nvvm.convert.f32x2.to.f8x2"(%532, %531) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %534 = "llvm.extractelement"(%518, %511) : (vector<8xi32>, i64) -> i32
    %535 = "llvm.extractelement"(%518, %510) : (vector<8xi32>, i64) -> i32
    %536 = "llvm.bitcast"(%534) : (i32) -> f32
    %537 = "llvm.bitcast"(%535) : (i32) -> f32
    %538 = "nvvm.convert.f32x2.to.f8x2"(%537, %536) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_e8m0_rp"}> ({
  ^bb0(%arg26: vector<8xf32>):
    %481 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %482 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %483 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %484 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %485 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %486 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %487 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %488 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %489 = "llvm.bitcast"(%arg26) : (vector<8xf32>) -> vector<8xi32>
    %490 = "llvm.extractelement"(%489, %487) : (vector<8xi32>, i64) -> i32
    %491 = "llvm.extractelement"(%489, %486) : (vector<8xi32>, i64) -> i32
    %492 = "llvm.bitcast"(%490) : (i32) -> f32
    %493 = "llvm.bitcast"(%491) : (i32) -> f32
    %494 = "nvvm.convert.f32x2.to.f8x2"(%493, %492) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %495 = "llvm.extractelement"(%489, %488) : (vector<8xi32>, i64) -> i32
    %496 = "llvm.extractelement"(%489, %485) : (vector<8xi32>, i64) -> i32
    %497 = "llvm.bitcast"(%495) : (i32) -> f32
    %498 = "llvm.bitcast"(%496) : (i32) -> f32
    %499 = "nvvm.convert.f32x2.to.f8x2"(%498, %497) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %500 = "llvm.extractelement"(%489, %484) : (vector<8xi32>, i64) -> i32
    %501 = "llvm.extractelement"(%489, %483) : (vector<8xi32>, i64) -> i32
    %502 = "llvm.bitcast"(%500) : (i32) -> f32
    %503 = "llvm.bitcast"(%501) : (i32) -> f32
    %504 = "nvvm.convert.f32x2.to.f8x2"(%503, %502) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %505 = "llvm.extractelement"(%489, %482) : (vector<8xi32>, i64) -> i32
    %506 = "llvm.extractelement"(%489, %481) : (vector<8xi32>, i64) -> i32
    %507 = "llvm.bitcast"(%505) : (i32) -> f32
    %508 = "llvm.bitcast"(%506) : (i32) -> f32
    %509 = "nvvm.convert.f32x2.to.f8x2"(%508, %507) <{dstTy = f8E8M0FNU, relu = false, rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f16, sym_name = "fptrunc_scalar_f32_to_f16"}> ({
  ^bb0(%arg25: f32):
    %461 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %462 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %463 = "llvm.mlir.undef"() : () -> vector<1xi32>
    %464 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2xf32>}> : () -> vector<2xf32>
    %465 = "llvm.mlir.poison"() : () -> vector<1xf32>
    %466 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %467 = "llvm.insertelement"(%465, %arg25, %466) : (vector<1xf32>, f32, i32) -> vector<1xf32>
    %468 = "llvm.shufflevector"(%467, %467) <{mask = array<i32: 0, 0>}> : (vector<1xf32>, vector<1xf32>) -> vector<2xf32>
    %469 = "llvm.shufflevector"(%468, %464) <{mask = array<i32: 0, 3>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %470 = "llvm.bitcast"(%469) : (vector<2xf32>) -> vector<2xi32>
    %471 = "llvm.extractelement"(%470, %462) : (vector<2xi32>, i64) -> i32
    %472 = "llvm.extractelement"(%470, %461) : (vector<2xi32>, i64) -> i32
    %473 = "llvm.bitcast"(%471) : (i32) -> f32
    %474 = "llvm.bitcast"(%472) : (i32) -> f32
    %475 = "nvvm.convert.f32x2.to.f16x2"(%474, %473) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %476 = "llvm.bitcast"(%475) : (vector<2xf16>) -> i32
    %477 = "llvm.insertelement"(%463, %476, %462) : (vector<1xi32>, i32, i64) -> vector<1xi32>
    %478 = "llvm.bitcast"(%477) : (vector<1xi32>) -> vector<2xf16>
    %479 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %480 = "llvm.extractelement"(%478, %479) : (vector<2xf16>, i64) -> f16
    "func.return"(%480) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> bf16, sym_name = "fptrunc_scalar_f32_to_bf16"}> ({
  ^bb0(%arg24: f32):
    %441 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %442 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %443 = "llvm.mlir.undef"() : () -> vector<1xi32>
    %444 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2xf32>}> : () -> vector<2xf32>
    %445 = "llvm.mlir.poison"() : () -> vector<1xf32>
    %446 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %447 = "llvm.insertelement"(%445, %arg24, %446) : (vector<1xf32>, f32, i32) -> vector<1xf32>
    %448 = "llvm.shufflevector"(%447, %447) <{mask = array<i32: 0, 0>}> : (vector<1xf32>, vector<1xf32>) -> vector<2xf32>
    %449 = "llvm.shufflevector"(%448, %444) <{mask = array<i32: 0, 3>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %450 = "llvm.bitcast"(%449) : (vector<2xf32>) -> vector<2xi32>
    %451 = "llvm.extractelement"(%450, %442) : (vector<2xi32>, i64) -> i32
    %452 = "llvm.extractelement"(%450, %441) : (vector<2xi32>, i64) -> i32
    %453 = "llvm.bitcast"(%451) : (i32) -> f32
    %454 = "llvm.bitcast"(%452) : (i32) -> f32
    %455 = "nvvm.convert.f32x2.to.bf16x2"(%454, %453) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xbf16>
    %456 = "llvm.bitcast"(%455) : (vector<2xbf16>) -> i32
    %457 = "llvm.insertelement"(%443, %456, %442) : (vector<1xi32>, i32, i64) -> vector<1xi32>
    %458 = "llvm.bitcast"(%457) : (vector<1xi32>) -> vector<2xbf16>
    %459 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %460 = "llvm.extractelement"(%458, %459) : (vector<2xbf16>, i64) -> bf16
    "func.return"(%460) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> f32, sym_name = "fptrunc_scalar_f64_to_f32"}> ({
  ^bb0(%arg23: f64):
    %432 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2xf64>}> : () -> vector<2xf64>
    %433 = "llvm.mlir.poison"() : () -> vector<1xf64>
    %434 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %435 = "llvm.insertelement"(%433, %arg23, %434) : (vector<1xf64>, f64, i32) -> vector<1xf64>
    %436 = "llvm.shufflevector"(%435, %435) <{mask = array<i32: 0, 0>}> : (vector<1xf64>, vector<1xf64>) -> vector<2xf64>
    %437 = "llvm.shufflevector"(%436, %432) <{mask = array<i32: 0, 3>}> : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    %438 = "llvm.fptrunc"(%437) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf64>) -> vector<2xf32>
    %439 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %440 = "llvm.extractelement"(%438, %439) : (vector<2xf32>, i64) -> f32
    "func.return"(%440) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf32>) -> vector<2x4xf16>, sym_name = "fptrunc_v2x4_f32_to_f16"}> ({
  ^bb0(%arg22: vector<2x4xf32>):
    %378 = "builtin.unrealized_conversion_cast"(%arg22) : (vector<2x4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %379 = "ub.poison"() <{value = #ub.poison}> : () -> vector<2x4xf16>
    %380 = "builtin.unrealized_conversion_cast"(%379) : (vector<2x4xf16>) -> !llvm.array<2 x vector<4xf16>>
    %381 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %382 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %383 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %384 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %385 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %386 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %387 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %388 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %389 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %390 = "ub.poison"() <{value = #ub.poison}> : () -> vector<8xf32>
    %391 = "llvm.extractvalue"(%378) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %392 = "llvm.shufflevector"(%391, %391) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xf32>, vector<4xf32>) -> vector<8xf32>
    %393 = "llvm.shufflevector"(%392, %390) <{mask = array<i32: 0, 1, 2, 3, -1, -1, -1, -1>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %394 = "llvm.extractvalue"(%378) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %395 = "llvm.shufflevector"(%394, %394) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xf32>, vector<4xf32>) -> vector<8xf32>
    %396 = "llvm.shufflevector"(%395, %393) <{mask = array<i32: 8, 9, 10, 11, 0, 1, 2, 3>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %397 = "llvm.bitcast"(%396) : (vector<8xf32>) -> vector<8xi32>
    %398 = "llvm.extractelement"(%397, %388) : (vector<8xi32>, i64) -> i32
    %399 = "llvm.extractelement"(%397, %387) : (vector<8xi32>, i64) -> i32
    %400 = "llvm.bitcast"(%398) : (i32) -> f32
    %401 = "llvm.bitcast"(%399) : (i32) -> f32
    %402 = "nvvm.convert.f32x2.to.f16x2"(%401, %400) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %403 = "llvm.bitcast"(%402) : (vector<2xf16>) -> i32
    %404 = "llvm.insertelement"(%389, %403, %388) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %405 = "llvm.extractelement"(%397, %386) : (vector<8xi32>, i64) -> i32
    %406 = "llvm.extractelement"(%397, %385) : (vector<8xi32>, i64) -> i32
    %407 = "llvm.bitcast"(%405) : (i32) -> f32
    %408 = "llvm.bitcast"(%406) : (i32) -> f32
    %409 = "nvvm.convert.f32x2.to.f16x2"(%408, %407) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %410 = "llvm.bitcast"(%409) : (vector<2xf16>) -> i32
    %411 = "llvm.insertelement"(%404, %410, %387) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %412 = "llvm.extractelement"(%397, %384) : (vector<8xi32>, i64) -> i32
    %413 = "llvm.extractelement"(%397, %383) : (vector<8xi32>, i64) -> i32
    %414 = "llvm.bitcast"(%412) : (i32) -> f32
    %415 = "llvm.bitcast"(%413) : (i32) -> f32
    %416 = "nvvm.convert.f32x2.to.f16x2"(%415, %414) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %417 = "llvm.bitcast"(%416) : (vector<2xf16>) -> i32
    %418 = "llvm.insertelement"(%411, %417, %386) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %419 = "llvm.extractelement"(%397, %382) : (vector<8xi32>, i64) -> i32
    %420 = "llvm.extractelement"(%397, %381) : (vector<8xi32>, i64) -> i32
    %421 = "llvm.bitcast"(%419) : (i32) -> f32
    %422 = "llvm.bitcast"(%420) : (i32) -> f32
    %423 = "nvvm.convert.f32x2.to.f16x2"(%422, %421) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %424 = "llvm.bitcast"(%423) : (vector<2xf16>) -> i32
    %425 = "llvm.insertelement"(%418, %424, %385) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %426 = "llvm.bitcast"(%425) : (vector<4xi32>) -> vector<8xf16>
    %427 = "llvm.shufflevector"(%426, %426) <{mask = array<i32: 0, 1, 2, 3>}> : (vector<8xf16>, vector<8xf16>) -> vector<4xf16>
    %428 = "llvm.insertvalue"(%380, %427) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf16>>, vector<4xf16>) -> !llvm.array<2 x vector<4xf16>>
    %429 = "llvm.shufflevector"(%426, %426) <{mask = array<i32: 4, 5, 6, 7>}> : (vector<8xf16>, vector<8xf16>) -> vector<4xf16>
    %430 = "llvm.insertvalue"(%428, %429) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf16>>, vector<4xf16>) -> !llvm.array<2 x vector<4xf16>>
    %431 = "builtin.unrealized_conversion_cast"(%430) : (!llvm.array<2 x vector<4xf16>>) -> vector<2x4xf16>
    "func.return"(%431) : (vector<2x4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4x2xf32>) -> vector<4x2xf8E4M3FN>, sym_name = "fptrunc_v4x2_f32_to_f8"}> ({
  ^bb0(%arg21: vector<4x2xf32>):
    %312 = "builtin.unrealized_conversion_cast"(%arg21) : (vector<4x2xf32>) -> !llvm.array<4 x vector<2xf32>>
    %313 = "ub.poison"() <{value = #ub.poison}> : () -> vector<4x2xf8E4M3FN>
    %314 = "builtin.unrealized_conversion_cast"(%313) : (vector<4x2xf8E4M3FN>) -> !llvm.array<4 x vector<2xi8>>
    %315 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %316 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %317 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %318 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %319 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %320 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %321 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %322 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %323 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %324 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %325 = "ub.poison"() <{value = #ub.poison}> : () -> vector<8xf32>
    %326 = "llvm.extractvalue"(%312) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<2xf32>>) -> vector<2xf32>
    %327 = "llvm.shufflevector"(%326, %326) <{mask = array<i32: 0, 1, 0, 0, 0, 0, 0, 0>}> : (vector<2xf32>, vector<2xf32>) -> vector<8xf32>
    %328 = "llvm.shufflevector"(%327, %325) <{mask = array<i32: 0, 1, -1, -1, -1, -1, -1, -1>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %329 = "llvm.extractvalue"(%312) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<2xf32>>) -> vector<2xf32>
    %330 = "llvm.shufflevector"(%329, %329) <{mask = array<i32: 0, 1, 0, 0, 0, 0, 0, 0>}> : (vector<2xf32>, vector<2xf32>) -> vector<8xf32>
    %331 = "llvm.shufflevector"(%330, %328) <{mask = array<i32: 8, 9, 0, 1, 12, 13, 14, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %332 = "llvm.extractvalue"(%312) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<2xf32>>) -> vector<2xf32>
    %333 = "llvm.shufflevector"(%332, %332) <{mask = array<i32: 0, 1, 0, 0, 0, 0, 0, 0>}> : (vector<2xf32>, vector<2xf32>) -> vector<8xf32>
    %334 = "llvm.shufflevector"(%333, %331) <{mask = array<i32: 8, 9, 10, 11, 0, 1, 14, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %335 = "llvm.extractvalue"(%312) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<2xf32>>) -> vector<2xf32>
    %336 = "llvm.shufflevector"(%335, %335) <{mask = array<i32: 0, 1, 0, 0, 0, 0, 0, 0>}> : (vector<2xf32>, vector<2xf32>) -> vector<8xf32>
    %337 = "llvm.shufflevector"(%336, %334) <{mask = array<i32: 8, 9, 10, 11, 12, 13, 0, 1>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %338 = "llvm.bitcast"(%337) : (vector<8xf32>) -> vector<8xi32>
    %339 = "llvm.extractelement"(%338, %321) : (vector<8xi32>, i64) -> i32
    %340 = "llvm.extractelement"(%338, %320) : (vector<8xi32>, i64) -> i32
    %341 = "llvm.bitcast"(%339) : (i32) -> f32
    %342 = "llvm.bitcast"(%340) : (i32) -> f32
    %343 = "nvvm.convert.f32x2.to.f8x2"(%342, %341) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %344 = "llvm.insertelement"(%322, %343, %319) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %345 = "llvm.extractelement"(%338, %323) : (vector<8xi32>, i64) -> i32
    %346 = "llvm.extractelement"(%338, %319) : (vector<8xi32>, i64) -> i32
    %347 = "llvm.bitcast"(%345) : (i32) -> f32
    %348 = "llvm.bitcast"(%346) : (i32) -> f32
    %349 = "nvvm.convert.f32x2.to.f8x2"(%348, %347) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %350 = "llvm.insertelement"(%344, %349, %323) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %351 = "llvm.bitcast"(%350) : (vector<2xi16>) -> i32
    %352 = "llvm.insertelement"(%324, %351, %323) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %353 = "llvm.extractelement"(%338, %318) : (vector<8xi32>, i64) -> i32
    %354 = "llvm.extractelement"(%338, %317) : (vector<8xi32>, i64) -> i32
    %355 = "llvm.bitcast"(%353) : (i32) -> f32
    %356 = "llvm.bitcast"(%354) : (i32) -> f32
    %357 = "nvvm.convert.f32x2.to.f8x2"(%356, %355) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %358 = "llvm.insertelement"(%322, %357, %319) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %359 = "llvm.extractelement"(%338, %316) : (vector<8xi32>, i64) -> i32
    %360 = "llvm.extractelement"(%338, %315) : (vector<8xi32>, i64) -> i32
    %361 = "llvm.bitcast"(%359) : (i32) -> f32
    %362 = "llvm.bitcast"(%360) : (i32) -> f32
    %363 = "nvvm.convert.f32x2.to.f8x2"(%362, %361) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %364 = "llvm.insertelement"(%358, %363, %323) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %365 = "llvm.bitcast"(%364) : (vector<2xi16>) -> i32
    %366 = "llvm.insertelement"(%352, %365, %319) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %367 = "llvm.bitcast"(%366) : (vector<2xi32>) -> vector<8xi8>
    %368 = "builtin.unrealized_conversion_cast"(%367) : (vector<8xi8>) -> vector<8xf8E4M3FN>
    %369 = "llvm.shufflevector"(%367, %367) <{mask = array<i32: 0, 1>}> : (vector<8xi8>, vector<8xi8>) -> vector<2xi8>
    %370 = "llvm.insertvalue"(%314, %369) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<2xi8>>, vector<2xi8>) -> !llvm.array<4 x vector<2xi8>>
    %371 = "llvm.shufflevector"(%367, %367) <{mask = array<i32: 2, 3>}> : (vector<8xi8>, vector<8xi8>) -> vector<2xi8>
    %372 = "llvm.insertvalue"(%370, %371) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<2xi8>>, vector<2xi8>) -> !llvm.array<4 x vector<2xi8>>
    %373 = "llvm.shufflevector"(%367, %367) <{mask = array<i32: 4, 5>}> : (vector<8xi8>, vector<8xi8>) -> vector<2xi8>
    %374 = "llvm.insertvalue"(%372, %373) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<2xi8>>, vector<2xi8>) -> !llvm.array<4 x vector<2xi8>>
    %375 = "llvm.shufflevector"(%367, %367) <{mask = array<i32: 6, 7>}> : (vector<8xi8>, vector<8xi8>) -> vector<2xi8>
    %376 = "llvm.insertvalue"(%374, %375) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<2xi8>>, vector<2xi8>) -> !llvm.array<4 x vector<2xi8>>
    %377 = "builtin.unrealized_conversion_cast"(%376) : (!llvm.array<4 x vector<2xi8>>) -> vector<4x2xf8E4M3FN>
    "func.return"(%377) : (vector<4x2xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>) -> vector<1xf16>, sym_name = "fptrunc_v1f32_to_v1f16"}> ({
  ^bb0(%arg20: vector<1xf32>):
    %296 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %297 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %298 = "llvm.mlir.undef"() : () -> vector<1xi32>
    %299 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2xf32>}> : () -> vector<2xf32>
    %300 = "llvm.shufflevector"(%arg20, %arg20) <{mask = array<i32: 0, 0>}> : (vector<1xf32>, vector<1xf32>) -> vector<2xf32>
    %301 = "llvm.shufflevector"(%300, %299) <{mask = array<i32: 0, 3>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %302 = "llvm.bitcast"(%301) : (vector<2xf32>) -> vector<2xi32>
    %303 = "llvm.extractelement"(%302, %297) : (vector<2xi32>, i64) -> i32
    %304 = "llvm.extractelement"(%302, %296) : (vector<2xi32>, i64) -> i32
    %305 = "llvm.bitcast"(%303) : (i32) -> f32
    %306 = "llvm.bitcast"(%304) : (i32) -> f32
    %307 = "nvvm.convert.f32x2.to.f16x2"(%306, %305) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %308 = "llvm.bitcast"(%307) : (vector<2xf16>) -> i32
    %309 = "llvm.insertelement"(%298, %308, %297) : (vector<1xi32>, i32, i64) -> vector<1xi32>
    %310 = "llvm.bitcast"(%309) : (vector<1xi32>) -> vector<2xf16>
    %311 = "llvm.shufflevector"(%310, %310) <{mask = array<i32: 0>}> : (vector<2xf16>, vector<2xf16>) -> vector<1xf16>
    "func.return"(%311) : (vector<1xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf16>) -> vector<3xf8E4M3FN>, sym_name = "fptrunc_v3f16_to_v3f8"}> ({
  ^bb0(%arg19: vector<3xf16>):
    %274 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %275 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %276 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %277 = "llvm.mlir.undef"() : () -> vector<1xi32>
    %278 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf16>}> : () -> vector<4xf16>
    %279 = "llvm.shufflevector"(%arg19, %arg19) <{mask = array<i32: 0, 1, 2, 0>}> : (vector<3xf16>, vector<3xf16>) -> vector<4xf16>
    %280 = "llvm.shufflevector"(%279, %278) <{mask = array<i32: 0, 1, 2, 7>}> : (vector<4xf16>, vector<4xf16>) -> vector<4xf16>
    %281 = "llvm.bitcast"(%280) : (vector<4xf16>) -> vector<2xi32>
    %282 = "llvm.extractelement"(%281, %274) : (vector<2xi32>, i64) -> i32
    %283 = "llvm.bitcast"(%282) : (i32) -> vector<2xf16>
    %284 = "nvvm.convert.f16x2.to.f8x2"(%283) <{dstTy = f8E4M3FN, relu = false}> : (vector<2xf16>) -> i16
    %285 = "llvm.insertelement"(%275, %284, %274) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %286 = "llvm.extractelement"(%281, %276) : (vector<2xi32>, i64) -> i32
    %287 = "llvm.bitcast"(%286) : (i32) -> vector<2xf16>
    %288 = "nvvm.convert.f16x2.to.f8x2"(%287) <{dstTy = f8E4M3FN, relu = false}> : (vector<2xf16>) -> i16
    %289 = "llvm.insertelement"(%285, %288, %276) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %290 = "llvm.bitcast"(%289) : (vector<2xi16>) -> i32
    %291 = "llvm.insertelement"(%277, %290, %276) : (vector<1xi32>, i32, i64) -> vector<1xi32>
    %292 = "llvm.bitcast"(%291) : (vector<1xi32>) -> vector<4xi8>
    %293 = "builtin.unrealized_conversion_cast"(%292) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    %294 = "llvm.shufflevector"(%292, %292) <{mask = array<i32: 0, 1, 2>}> : (vector<4xi8>, vector<4xi8>) -> vector<3xi8>
    %295 = "builtin.unrealized_conversion_cast"(%294) : (vector<3xi8>) -> vector<3xf8E4M3FN>
    "func.return"(%295) : (vector<3xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3x1xf32>) -> vector<3x1xf16>, sym_name = "fptrunc_v3x1_f32_to_f16"}> ({
  ^bb0(%arg18: vector<3x1xf32>):
    %212 = "builtin.unrealized_conversion_cast"(%arg18) : (vector<3x1xf32>) -> !llvm.array<3 x vector<1xf32>>
    %213 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x1xf16>
    %214 = "builtin.unrealized_conversion_cast"(%213) : (vector<3x1xf16>) -> !llvm.array<3 x vector<1xf16>>
    %215 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %216 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %217 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %218 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %219 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %220 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %221 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3xf32>
    %222 = "llvm.extractvalue"(%212) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<1xf32>>) -> vector<1xf32>
    %223 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %224 = "llvm.extractelement"(%222, %223) : (vector<1xf32>, i64) -> f32
    %225 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %226 = "llvm.insertelement"(%221, %224, %225) : (vector<3xf32>, f32, i64) -> vector<3xf32>
    %227 = "llvm.extractvalue"(%212) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<1xf32>>) -> vector<1xf32>
    %228 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %229 = "llvm.extractelement"(%227, %228) : (vector<1xf32>, i64) -> f32
    %230 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %231 = "llvm.insertelement"(%226, %229, %230) : (vector<3xf32>, f32, i64) -> vector<3xf32>
    %232 = "llvm.extractvalue"(%212) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<1xf32>>) -> vector<1xf32>
    %233 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %234 = "llvm.extractelement"(%232, %233) : (vector<1xf32>, i64) -> f32
    %235 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %236 = "llvm.insertelement"(%231, %234, %235) : (vector<3xf32>, f32, i64) -> vector<3xf32>
    %237 = "llvm.shufflevector"(%236, %236) <{mask = array<i32: 0, 1, 2, 0>}> : (vector<3xf32>, vector<3xf32>) -> vector<4xf32>
    %238 = "llvm.shufflevector"(%237, %220) <{mask = array<i32: 0, 1, 2, 7>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %239 = "llvm.bitcast"(%238) : (vector<4xf32>) -> vector<4xi32>
    %240 = "llvm.extractelement"(%239, %218) : (vector<4xi32>, i64) -> i32
    %241 = "llvm.extractelement"(%239, %217) : (vector<4xi32>, i64) -> i32
    %242 = "llvm.bitcast"(%240) : (i32) -> f32
    %243 = "llvm.bitcast"(%241) : (i32) -> f32
    %244 = "nvvm.convert.f32x2.to.f16x2"(%243, %242) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %245 = "llvm.bitcast"(%244) : (vector<2xf16>) -> i32
    %246 = "llvm.insertelement"(%219, %245, %218) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %247 = "llvm.extractelement"(%239, %216) : (vector<4xi32>, i64) -> i32
    %248 = "llvm.extractelement"(%239, %215) : (vector<4xi32>, i64) -> i32
    %249 = "llvm.bitcast"(%247) : (i32) -> f32
    %250 = "llvm.bitcast"(%248) : (i32) -> f32
    %251 = "nvvm.convert.f32x2.to.f16x2"(%250, %249) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %252 = "llvm.bitcast"(%251) : (vector<2xf16>) -> i32
    %253 = "llvm.insertelement"(%246, %252, %217) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %254 = "llvm.bitcast"(%253) : (vector<2xi32>) -> vector<4xf16>
    %255 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %256 = "llvm.extractelement"(%254, %255) : (vector<4xf16>, i64) -> f16
    %257 = "llvm.extractvalue"(%214) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<1xf16>>) -> vector<1xf16>
    %258 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %259 = "llvm.insertelement"(%257, %256, %258) : (vector<1xf16>, f16, i64) -> vector<1xf16>
    %260 = "llvm.insertvalue"(%214, %259) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<1xf16>>, vector<1xf16>) -> !llvm.array<3 x vector<1xf16>>
    %261 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %262 = "llvm.extractelement"(%254, %261) : (vector<4xf16>, i64) -> f16
    %263 = "llvm.extractvalue"(%260) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<1xf16>>) -> vector<1xf16>
    %264 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %265 = "llvm.insertelement"(%263, %262, %264) : (vector<1xf16>, f16, i64) -> vector<1xf16>
    %266 = "llvm.insertvalue"(%260, %265) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<1xf16>>, vector<1xf16>) -> !llvm.array<3 x vector<1xf16>>
    %267 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %268 = "llvm.extractelement"(%254, %267) : (vector<4xf16>, i64) -> f16
    %269 = "llvm.extractvalue"(%266) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<1xf16>>) -> vector<1xf16>
    %270 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %271 = "llvm.insertelement"(%269, %268, %270) : (vector<1xf16>, f16, i64) -> vector<1xf16>
    %272 = "llvm.insertvalue"(%266, %271) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<1xf16>>, vector<1xf16>) -> !llvm.array<3 x vector<1xf16>>
    %273 = "builtin.unrealized_conversion_cast"(%272) : (!llvm.array<3 x vector<1xf16>>) -> vector<3x1xf16>
    "func.return"(%273) : (vector<3x1xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf64>) -> vector<4xf32>, sym_name = "fptrunc_f64_to_f32"}> ({
  ^bb0(%arg17: vector<4xf64>):
    %211 = "llvm.fptrunc"(%arg17) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf64>) -> vector<4xf32>
    "func.return"(%211) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf64>) -> vector<2xf16>, sym_name = "fptrunc_f64_to_f16"}> ({
  ^bb0(%arg16: vector<2xf64>):
    %206 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf64>}> : () -> vector<4xf64>
    %207 = "llvm.shufflevector"(%arg16, %arg16) <{mask = array<i32: 0, 1, 0, 0>}> : (vector<2xf64>, vector<2xf64>) -> vector<4xf64>
    %208 = "llvm.shufflevector"(%207, %206) <{mask = array<i32: 0, 1, 6, 7>}> : (vector<4xf64>, vector<4xf64>) -> vector<4xf64>
    %209 = "llvm.fptrunc"(%208) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf64>) -> vector<4xf16>
    %210 = "llvm.shufflevector"(%209, %209) <{mask = array<i32: 0, 1>}> : (vector<4xf16>, vector<4xf16>) -> vector<2xf16>
    "func.return"(%210) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf64>) -> vector<2xbf16>, sym_name = "fptrunc_f64_to_bf16"}> ({
  ^bb0(%arg15: vector<2xf64>):
    %201 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf64>}> : () -> vector<4xf64>
    %202 = "llvm.shufflevector"(%arg15, %arg15) <{mask = array<i32: 0, 1, 0, 0>}> : (vector<2xf64>, vector<2xf64>) -> vector<4xf64>
    %203 = "llvm.shufflevector"(%202, %201) <{mask = array<i32: 0, 1, 6, 7>}> : (vector<4xf64>, vector<4xf64>) -> vector<4xf64>
    %204 = "llvm.fptrunc"(%203) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf64>) -> vector<4xbf16>
    %205 = "llvm.shufflevector"(%204, %204) <{mask = array<i32: 0, 1>}> : (vector<4xbf16>, vector<4xbf16>) -> vector<2xbf16>
    "func.return"(%205) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf64>) -> vector<4xf8E4M3FN>, sym_name = "fptrunc_f64_to_f8"}> ({
  ^bb0(%arg14: vector<4xf64>):
    %154 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %155 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %156 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %157 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %158 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %159 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %160 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %161 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %162 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %163 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %164 = "arith.constant"() <{value = dense<0.000000e+00> : vector<8xf64>}> : () -> vector<8xf64>
    %165 = "llvm.shufflevector"(%arg14, %arg14) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xf64>, vector<4xf64>) -> vector<8xf64>
    %166 = "llvm.shufflevector"(%165, %164) <{mask = array<i32: 0, 1, 2, 3, 12, 13, 14, 15>}> : (vector<8xf64>, vector<8xf64>) -> vector<8xf64>
    %167 = "llvm.fptrunc"(%166) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf64>) -> vector<8xf32>
    %168 = "llvm.bitcast"(%167) : (vector<8xf32>) -> vector<8xi32>
    %169 = "llvm.extractelement"(%168, %160) : (vector<8xi32>, i64) -> i32
    %170 = "llvm.extractelement"(%168, %159) : (vector<8xi32>, i64) -> i32
    %171 = "llvm.bitcast"(%169) : (i32) -> f32
    %172 = "llvm.bitcast"(%170) : (i32) -> f32
    %173 = "nvvm.convert.f32x2.to.f8x2"(%172, %171) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %174 = "llvm.insertelement"(%161, %173, %158) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %175 = "llvm.extractelement"(%168, %162) : (vector<8xi32>, i64) -> i32
    %176 = "llvm.extractelement"(%168, %158) : (vector<8xi32>, i64) -> i32
    %177 = "llvm.bitcast"(%175) : (i32) -> f32
    %178 = "llvm.bitcast"(%176) : (i32) -> f32
    %179 = "nvvm.convert.f32x2.to.f8x2"(%178, %177) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %180 = "llvm.insertelement"(%174, %179, %162) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %181 = "llvm.bitcast"(%180) : (vector<2xi16>) -> i32
    %182 = "llvm.insertelement"(%163, %181, %162) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %183 = "llvm.extractelement"(%168, %157) : (vector<8xi32>, i64) -> i32
    %184 = "llvm.extractelement"(%168, %156) : (vector<8xi32>, i64) -> i32
    %185 = "llvm.bitcast"(%183) : (i32) -> f32
    %186 = "llvm.bitcast"(%184) : (i32) -> f32
    %187 = "nvvm.convert.f32x2.to.f8x2"(%186, %185) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %188 = "llvm.insertelement"(%161, %187, %158) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %189 = "llvm.extractelement"(%168, %155) : (vector<8xi32>, i64) -> i32
    %190 = "llvm.extractelement"(%168, %154) : (vector<8xi32>, i64) -> i32
    %191 = "llvm.bitcast"(%189) : (i32) -> f32
    %192 = "llvm.bitcast"(%190) : (i32) -> f32
    %193 = "nvvm.convert.f32x2.to.f8x2"(%192, %191) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %194 = "llvm.insertelement"(%188, %193, %162) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %195 = "llvm.bitcast"(%194) : (vector<2xi16>) -> i32
    %196 = "llvm.insertelement"(%182, %195, %158) : (vector<2xi32>, i32, i64) -> vector<2xi32>
    %197 = "llvm.bitcast"(%196) : (vector<2xi32>) -> vector<8xi8>
    %198 = "builtin.unrealized_conversion_cast"(%197) : (vector<8xi8>) -> vector<8xf8E4M3FN>
    %199 = "llvm.shufflevector"(%197, %197) <{mask = array<i32: 0, 1, 2, 3>}> : (vector<8xi8>, vector<8xi8>) -> vector<4xi8>
    %200 = "builtin.unrealized_conversion_cast"(%199) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%200) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "fptrunc_f32_to_f8_satfinite"}> ({
  ^bb0(%arg13: vector<8xf32>):
    %125 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %126 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %127 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %128 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %129 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %130 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %131 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %132 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %133 = "llvm.bitcast"(%arg13) : (vector<8xf32>) -> vector<8xi32>
    %134 = "llvm.extractelement"(%133, %131) : (vector<8xi32>, i64) -> i32
    %135 = "llvm.extractelement"(%133, %130) : (vector<8xi32>, i64) -> i32
    %136 = "llvm.bitcast"(%134) : (i32) -> f32
    %137 = "llvm.bitcast"(%135) : (i32) -> f32
    %138 = "nvvm.convert.f32x2.to.f8x2"(%137, %136) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %139 = "llvm.extractelement"(%133, %132) : (vector<8xi32>, i64) -> i32
    %140 = "llvm.extractelement"(%133, %129) : (vector<8xi32>, i64) -> i32
    %141 = "llvm.bitcast"(%139) : (i32) -> f32
    %142 = "llvm.bitcast"(%140) : (i32) -> f32
    %143 = "nvvm.convert.f32x2.to.f8x2"(%142, %141) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %144 = "llvm.extractelement"(%133, %128) : (vector<8xi32>, i64) -> i32
    %145 = "llvm.extractelement"(%133, %127) : (vector<8xi32>, i64) -> i32
    %146 = "llvm.bitcast"(%144) : (i32) -> f32
    %147 = "llvm.bitcast"(%145) : (i32) -> f32
    %148 = "nvvm.convert.f32x2.to.f8x2"(%147, %146) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %149 = "llvm.extractelement"(%133, %126) : (vector<8xi32>, i64) -> i32
    %150 = "llvm.extractelement"(%133, %125) : (vector<8xi32>, i64) -> i32
    %151 = "llvm.bitcast"(%149) : (i32) -> f32
    %152 = "llvm.bitcast"(%150) : (i32) -> f32
    %153 = "nvvm.convert.f32x2.to.f8x2"(%152, %151) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_f16_relu"}> ({
  ^bb0(%arg12: vector<4xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "fptrunc_f32_to_f8_default_sat"}> ({
  ^bb0(%arg11: vector<8xf32>):
    %96 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %97 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %98 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %99 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %100 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %101 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %102 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %103 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %104 = "llvm.bitcast"(%arg11) : (vector<8xf32>) -> vector<8xi32>
    %105 = "llvm.extractelement"(%104, %102) : (vector<8xi32>, i64) -> i32
    %106 = "llvm.extractelement"(%104, %101) : (vector<8xi32>, i64) -> i32
    %107 = "llvm.bitcast"(%105) : (i32) -> f32
    %108 = "llvm.bitcast"(%106) : (i32) -> f32
    %109 = "nvvm.convert.f32x2.to.f8x2"(%108, %107) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %110 = "llvm.extractelement"(%104, %103) : (vector<8xi32>, i64) -> i32
    %111 = "llvm.extractelement"(%104, %100) : (vector<8xi32>, i64) -> i32
    %112 = "llvm.bitcast"(%110) : (i32) -> f32
    %113 = "llvm.bitcast"(%111) : (i32) -> f32
    %114 = "nvvm.convert.f32x2.to.f8x2"(%113, %112) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %115 = "llvm.extractelement"(%104, %99) : (vector<8xi32>, i64) -> i32
    %116 = "llvm.extractelement"(%104, %98) : (vector<8xi32>, i64) -> i32
    %117 = "llvm.bitcast"(%115) : (i32) -> f32
    %118 = "llvm.bitcast"(%116) : (i32) -> f32
    %119 = "nvvm.convert.f32x2.to.f8x2"(%118, %117) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    %120 = "llvm.extractelement"(%104, %97) : (vector<8xi32>, i64) -> i32
    %121 = "llvm.extractelement"(%104, %96) : (vector<8xi32>, i64) -> i32
    %122 = "llvm.bitcast"(%120) : (i32) -> f32
    %123 = "llvm.bitcast"(%121) : (i32) -> f32
    %124 = "nvvm.convert.f32x2.to.f8x2"(%123, %122) <{dstTy = f8E4M3FN, relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_f16_default_sat"}> ({
  ^bb0(%arg10: vector<4xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_f16_explicit_none"}> ({
  ^bb0(%arg9: vector<4xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, i32) -> (), sym_name = "fptrunc_f32_to_f16_rs"}> ({
  ^bb0(%arg7: vector<4xf32>, %arg8: i32):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, i32) -> (), sym_name = "fptrunc_f32_to_bf16_rs"}> ({
  ^bb0(%arg5: vector<4xf32>, %arg6: i32):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_f16_rz"}> ({
  ^bb0(%arg4: vector<4xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_bf16_rz"}> ({
  ^bb0(%arg3: vector<4xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f16, sym_name = "e2e_scalar_f32_to_f16"}> ({
  ^bb0(%arg2: f32):
    %76 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %77 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %78 = "llvm.mlir.undef"() : () -> vector<1xi32>
    %79 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2xf32>}> : () -> vector<2xf32>
    %80 = "llvm.mlir.poison"() : () -> vector<1xf32>
    %81 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %82 = "llvm.insertelement"(%80, %arg2, %81) : (vector<1xf32>, f32, i32) -> vector<1xf32>
    %83 = "llvm.shufflevector"(%82, %82) <{mask = array<i32: 0, 0>}> : (vector<1xf32>, vector<1xf32>) -> vector<2xf32>
    %84 = "llvm.shufflevector"(%83, %79) <{mask = array<i32: 0, 3>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %85 = "llvm.bitcast"(%84) : (vector<2xf32>) -> vector<2xi32>
    %86 = "llvm.extractelement"(%85, %77) : (vector<2xi32>, i64) -> i32
    %87 = "llvm.extractelement"(%85, %76) : (vector<2xi32>, i64) -> i32
    %88 = "llvm.bitcast"(%86) : (i32) -> f32
    %89 = "llvm.bitcast"(%87) : (i32) -> f32
    %90 = "nvvm.convert.f32x2.to.f16x2"(%89, %88) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %91 = "llvm.bitcast"(%90) : (vector<2xf16>) -> i32
    %92 = "llvm.insertelement"(%78, %91, %77) : (vector<1xi32>, i32, i64) -> vector<1xi32>
    %93 = "llvm.bitcast"(%92) : (vector<1xi32>) -> vector<2xf16>
    %94 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %95 = "llvm.extractelement"(%93, %94) : (vector<2xf16>, i64) -> f16
    "func.return"(%95) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf32>) -> vector<2x4xf16>, sym_name = "e2e_v2x4_f32_to_f16"}> ({
  ^bb0(%arg1: vector<2x4xf32>):
    %22 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<2x4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %23 = "ub.poison"() <{value = #ub.poison}> : () -> vector<2x4xf16>
    %24 = "builtin.unrealized_conversion_cast"(%23) : (vector<2x4xf16>) -> !llvm.array<2 x vector<4xf16>>
    %25 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
    %26 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
    %27 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
    %28 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %29 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %30 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %31 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %32 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %33 = "llvm.mlir.undef"() : () -> vector<4xi32>
    %34 = "ub.poison"() <{value = #ub.poison}> : () -> vector<8xf32>
    %35 = "llvm.extractvalue"(%22) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %36 = "llvm.shufflevector"(%35, %35) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xf32>, vector<4xf32>) -> vector<8xf32>
    %37 = "llvm.shufflevector"(%36, %34) <{mask = array<i32: 0, 1, 2, 3, -1, -1, -1, -1>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %38 = "llvm.extractvalue"(%22) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %39 = "llvm.shufflevector"(%38, %38) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xf32>, vector<4xf32>) -> vector<8xf32>
    %40 = "llvm.shufflevector"(%39, %37) <{mask = array<i32: 8, 9, 10, 11, 0, 1, 2, 3>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %41 = "llvm.bitcast"(%40) : (vector<8xf32>) -> vector<8xi32>
    %42 = "llvm.extractelement"(%41, %32) : (vector<8xi32>, i64) -> i32
    %43 = "llvm.extractelement"(%41, %31) : (vector<8xi32>, i64) -> i32
    %44 = "llvm.bitcast"(%42) : (i32) -> f32
    %45 = "llvm.bitcast"(%43) : (i32) -> f32
    %46 = "nvvm.convert.f32x2.to.f16x2"(%45, %44) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %47 = "llvm.bitcast"(%46) : (vector<2xf16>) -> i32
    %48 = "llvm.insertelement"(%33, %47, %32) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %49 = "llvm.extractelement"(%41, %30) : (vector<8xi32>, i64) -> i32
    %50 = "llvm.extractelement"(%41, %29) : (vector<8xi32>, i64) -> i32
    %51 = "llvm.bitcast"(%49) : (i32) -> f32
    %52 = "llvm.bitcast"(%50) : (i32) -> f32
    %53 = "nvvm.convert.f32x2.to.f16x2"(%52, %51) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %54 = "llvm.bitcast"(%53) : (vector<2xf16>) -> i32
    %55 = "llvm.insertelement"(%48, %54, %31) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %56 = "llvm.extractelement"(%41, %28) : (vector<8xi32>, i64) -> i32
    %57 = "llvm.extractelement"(%41, %27) : (vector<8xi32>, i64) -> i32
    %58 = "llvm.bitcast"(%56) : (i32) -> f32
    %59 = "llvm.bitcast"(%57) : (i32) -> f32
    %60 = "nvvm.convert.f32x2.to.f16x2"(%59, %58) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %61 = "llvm.bitcast"(%60) : (vector<2xf16>) -> i32
    %62 = "llvm.insertelement"(%55, %61, %30) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %63 = "llvm.extractelement"(%41, %26) : (vector<8xi32>, i64) -> i32
    %64 = "llvm.extractelement"(%41, %25) : (vector<8xi32>, i64) -> i32
    %65 = "llvm.bitcast"(%63) : (i32) -> f32
    %66 = "llvm.bitcast"(%64) : (i32) -> f32
    %67 = "nvvm.convert.f32x2.to.f16x2"(%66, %65) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32, f32) -> vector<2xf16>
    %68 = "llvm.bitcast"(%67) : (vector<2xf16>) -> i32
    %69 = "llvm.insertelement"(%62, %68, %29) : (vector<4xi32>, i32, i64) -> vector<4xi32>
    %70 = "llvm.bitcast"(%69) : (vector<4xi32>) -> vector<8xf16>
    %71 = "llvm.shufflevector"(%70, %70) <{mask = array<i32: 0, 1, 2, 3>}> : (vector<8xf16>, vector<8xf16>) -> vector<4xf16>
    %72 = "llvm.insertvalue"(%24, %71) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf16>>, vector<4xf16>) -> !llvm.array<2 x vector<4xf16>>
    %73 = "llvm.shufflevector"(%70, %70) <{mask = array<i32: 4, 5, 6, 7>}> : (vector<8xf16>, vector<8xf16>) -> vector<4xf16>
    %74 = "llvm.insertvalue"(%72, %73) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf16>>, vector<4xf16>) -> !llvm.array<2 x vector<4xf16>>
    %75 = "builtin.unrealized_conversion_cast"(%74) : (!llvm.array<2 x vector<4xf16>>) -> vector<2x4xf16>
    "func.return"(%75) : (vector<2x4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf16>) -> vector<3xf8E4M3FN>, sym_name = "e2e_v3f16_to_v3f8"}> ({
  ^bb0(%arg0: vector<3xf16>):
    %0 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %1 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %2 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %3 = "llvm.mlir.undef"() : () -> vector<1xi32>
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf16>}> : () -> vector<4xf16>
    %5 = "llvm.shufflevector"(%arg0, %arg0) <{mask = array<i32: 0, 1, 2, 0>}> : (vector<3xf16>, vector<3xf16>) -> vector<4xf16>
    %6 = "llvm.shufflevector"(%5, %4) <{mask = array<i32: 0, 1, 2, 7>}> : (vector<4xf16>, vector<4xf16>) -> vector<4xf16>
    %7 = "llvm.bitcast"(%6) : (vector<4xf16>) -> vector<2xi32>
    %8 = "llvm.extractelement"(%7, %0) : (vector<2xi32>, i64) -> i32
    %9 = "llvm.bitcast"(%8) : (i32) -> vector<2xf16>
    %10 = "nvvm.convert.f16x2.to.f8x2"(%9) <{dstTy = f8E4M3FN, relu = false}> : (vector<2xf16>) -> i16
    %11 = "llvm.insertelement"(%1, %10, %0) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %12 = "llvm.extractelement"(%7, %2) : (vector<2xi32>, i64) -> i32
    %13 = "llvm.bitcast"(%12) : (i32) -> vector<2xf16>
    %14 = "nvvm.convert.f16x2.to.f8x2"(%13) <{dstTy = f8E4M3FN, relu = false}> : (vector<2xf16>) -> i16
    %15 = "llvm.insertelement"(%11, %14, %2) : (vector<2xi16>, i16, i64) -> vector<2xi16>
    %16 = "llvm.bitcast"(%15) : (vector<2xi16>) -> i32
    %17 = "llvm.insertelement"(%3, %16, %2) : (vector<1xi32>, i32, i64) -> vector<1xi32>
    %18 = "llvm.bitcast"(%17) : (vector<1xi32>) -> vector<4xi8>
    %19 = "builtin.unrealized_conversion_cast"(%18) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    %20 = "llvm.shufflevector"(%18, %18) <{mask = array<i32: 0, 1, 2>}> : (vector<4xi8>, vector<4xi8>) -> vector<3xi8>
    %21 = "builtin.unrealized_conversion_cast"(%20) : (vector<3xi8>) -> vector<3xf8E4M3FN>
    "func.return"(%21) : (vector<3xf8E4M3FN>) -> ()
  }) : () -> ()
}) : () -> ()


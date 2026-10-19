"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_global_id", visibility_ = 0 : i64}> ({
      %0 = "rocdl.workgroup.id.x"() : () -> i32
      %1 = "llvm.sext"(%0) : (i32) -> i64
      %2 = "rocdl.workgroup.dim.x"() : () -> i32
      %3 = "llvm.sext"(%2) : (i32) -> i64
      %4 = "llvm.mul"(%1, %3) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %5 = "rocdl.workitem.id.x"() : () -> i32
      %6 = "llvm.sext"(%5) : (i32) -> i64
      %7 = "llvm.add"(%6, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.return"(%7) : (i64) -> ()
    }) : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()


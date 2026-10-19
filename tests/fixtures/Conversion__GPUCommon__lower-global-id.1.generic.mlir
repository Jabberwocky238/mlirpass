"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_global_id", visibility_ = 0 : i64}> ({
      %0 = "nvvm.read.ptx.sreg.ctaid.x"() : () -> i32
      %1 = "llvm.sext"(%0) : (i32) -> i64
      %2 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %3 = "llvm.sext"(%2) : (i32) -> i64
      %4 = "llvm.mul"(%1, %3) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %5 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %6 = "llvm.sext"(%5) : (i32) -> i64
      %7 = "llvm.add"(%6, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.return"(%7) : (i64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()


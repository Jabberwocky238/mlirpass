"builtin.module"() ({
  "gpu.module"() <{sym_name = "nvvm_module", targets = [#nvvm.target]}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "kernel_0", visibility_ = 0 : i64}> ({
      %5 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %6 = "llvm.sext"(%5) : (i32) -> i64
      %7 = "nvvm.read.ptx.sreg.laneid"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %8 = "llvm.sext"(%7) : (i32) -> i64
      %9 = "llvm.add"(%6, %8) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.return"(%9) : (i64) -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, ptr<1>, i64)>, linkage = #llvm.linkage<external>, sym_name = "kernel_1", visibility_ = 0 : i64}> ({
    ^bb0(%arg1: !llvm.ptr<1>, %arg2: !llvm.ptr<1>, %arg3: i64):
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_block_size = array<i32: 128, 1, 1>, nvvm.kernel, nvvm.maxntid = array<i32: 128, 1, 1>} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "nvvm_module_2"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "kernel_0", visibility_ = 0 : i64}> ({
      %0 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "builtin.unrealized_conversion_cast"(%0) : (index) -> i64
      %2 = "gpu.lane_id"() : () -> index
      %3 = "builtin.unrealized_conversion_cast"(%2) : (index) -> i64
      %4 = "llvm.add"(%1, %3) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.return"(%4) : (i64) -> ()
    }) : () -> ()
    "gpu.func"() <{function_type = (memref<f32, #gpu.address_space<global>>) -> (), kernel, known_block_size = array<i32: 128, 1, 1>}> ({
    ^bb0(%arg0: memref<f32, #gpu.address_space<global>>):
      "gpu.return"() : () -> ()
    }) {sym_name = "kernel_1"} : () -> ()
  }) : () -> ()
}) : () -> ()


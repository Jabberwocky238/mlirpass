module attributes {gpu.container_module} {
  llvm.func @set_default_device(%arg0: i32) {
    llvm.call @mgpuSetDefaultDevice(%arg0) : (i32) -> ()
    llvm.return
  }
  llvm.func @mgpuSetDefaultDevice(i32)
}


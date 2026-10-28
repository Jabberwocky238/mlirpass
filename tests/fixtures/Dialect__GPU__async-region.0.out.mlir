module attributes {gpu.container_module} {
  gpu.module @kernels {
    gpu.func @kernel() kernel {
      gpu.return
    }
  }
  func.func private @foo()
  func.func @async(%arg0: index) {
    %0 = gpu.wait async
    %1 = gpu.launch_func async [%0] @kernels::@kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  
    %2 = gpu.launch_func async [%1] @kernels::@kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  
    %memref, %asyncToken = gpu.alloc async [%2] () : memref<7xf32>
    %3 = gpu.dealloc async [%asyncToken] %memref : memref<7xf32>
    gpu.wait [%3]
    call @foo() : () -> ()
    return
  }
  func.func @defer_wait(%arg0: index) {
    %token, %bodyResults = async.execute -> !async.value<!gpu.async.token> {
      %1 = gpu.wait async
      %2 = gpu.launch_func async [%1] @kernels::@kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  
      async.yield %2 : !gpu.async.token
    }
    %token_0, %bodyResults_1 = async.execute [%token] (%bodyResults as %arg1: !async.value<!gpu.async.token>) -> !async.value<!gpu.async.token> {
      %1 = gpu.wait async [%arg1]
      %2 = gpu.launch_func async [%1] @kernels::@kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  
      async.yield %2 : !gpu.async.token
    }
    async.await %token_0 : !async.token
    %0 = async.await %bodyResults_1 : !async.value<!gpu.async.token>
    gpu.wait [%0]
    return
  }
  func.func @defer_wait_blocked_by_side_effect(%arg0: index) {
    %token = async.execute {
      %0 = gpu.wait async
      %1 = gpu.launch_func async [%0] @kernels::@kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  
      gpu.wait [%1]
      func.call @foo() : () -> ()
      async.yield
    }
    async.await %token : !async.token
    return
  }
  func.func @defer_wait_pass_through(%arg0: index) {
    %token, %bodyResults = async.execute -> !async.value<!gpu.async.token> {
      %1 = gpu.wait async
      %2 = gpu.launch_func async [%1] @kernels::@kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  
      async.yield %2 : !gpu.async.token
    }
    %token_0, %bodyResults_1 = async.execute [%token] (%bodyResults as %arg1: !async.value<!gpu.async.token>) -> !async.value<!gpu.async.token> {
      async.yield %arg1 : !gpu.async.token
    }
    async.await %token_0 : !async.token
    %0 = async.await %bodyResults_1 : !async.value<!gpu.async.token>
    gpu.wait [%0]
    return
  }
  func.func @async_execute_with_result(%arg0: index) -> index {
    %token, %bodyResults:2 = async.execute -> (!async.value<index>, !async.value<!gpu.async.token>) {
      %2 = gpu.wait async
      %3 = gpu.launch_func async [%2] @kernels::@kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  
      async.yield %arg0, %3 : index, !gpu.async.token
    }
    async.await %token : !async.token
    %0 = async.await %bodyResults#1 : !async.value<!gpu.async.token>
    gpu.wait [%0]
    %1 = async.await %bodyResults#0 : !async.value<index>
    return %1 : index
  }
  func.func @async_execute_no_use(%arg0: index) {
    %token = async.execute {
      %0 = gpu.wait async
      %1 = gpu.launch_func async [%0] @kernels::@kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  
      gpu.wait [%1]
      async.yield
    }
    return
  }
  func.func @async_execute_fork(%arg0: index) {
    %token, %bodyResults:2 = async.execute -> (!async.value<!gpu.async.token>, !async.value<!gpu.async.token>) {
      %0 = gpu.wait async
      %1 = gpu.launch_func async [%0] @kernels::@kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  
      async.yield %1, %1 : !gpu.async.token, !gpu.async.token
    }
    %token_0 = async.execute [%token] (%bodyResults#0 as %arg1: !async.value<!gpu.async.token>) {
      %0 = gpu.wait async [%arg1]
      %1 = gpu.launch_func async [%0] @kernels::@kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  
      gpu.wait [%1]
      async.yield
    }
    %token_1 = async.execute [%token] (%bodyResults#1 as %arg1: !async.value<!gpu.async.token>) {
      %0 = gpu.wait async [%arg1]
      %1 = gpu.launch_func async [%0] @kernels::@kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  
      gpu.wait [%1]
      async.yield
    }
    return
  }
  func.func @existing_tokens() {
    %0 = gpu.wait async
    %1 = gpu.wait async [%0]
    %memref, %asyncToken = gpu.alloc async [%1, %0] () : memref<7xf32>
    %2 = gpu.dealloc async [%asyncToken] %memref : memref<7xf32>
    gpu.wait [%2]
    gpu.wait 
    return
  }
}


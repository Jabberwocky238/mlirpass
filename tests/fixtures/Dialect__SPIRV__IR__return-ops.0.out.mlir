module {
  spirv.func @preserve_return_value(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> "None" {
    %0 = spirv.Bitcast %arg1 : vector<2xi32> to vector<2xf32>
    %1 = spirv.Bitcast %0 : vector<2xf32> to vector<2xi32>
    spirv.ReturnValue %1 : vector<2xi32>
  }
}


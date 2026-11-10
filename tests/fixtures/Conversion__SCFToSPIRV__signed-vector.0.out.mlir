module {
  spirv.func @main() "None" {
    %cst-5_si32 = spirv.Constant -5 : si32
    %0 = vector.from_elements %cst-5_si32 : vector<1xsi32>
    spirv.Return
  }
}


"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "constant_dense_resource"}> ({
    %0 = "arith.constant"() <{value = dense_resource<dense_resource_test_5xf32> : tensor<5xf32>}> : () -> tensor<5xf32>
    %1 = "arith.constant"() <{value = dense_resource<dense_resource_test_2xi32> : vector<2xi32>}> : () -> vector<2xi32>
    %2 = "arith.constant"() <{value = dense_resource<dense_resource_test_2x2xf32> : tensor<1x2x2xf32>}> : () -> tensor<1x2x2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

{-#
  dialect_resources: {
    builtin: {
      dense_resource_test_5xf32: "0x08000000041A503E183382BEFCEEBABE7A3AF0BE0E9DEE3E",
      dense_resource_test_2xi32: "0x400000000100000002000000",
      dense_resource_test_2x2xf32: "0x0800000054A3B53ED6C0B33E55D1A2BDE5D2BB3E"
    }
  }
#-}


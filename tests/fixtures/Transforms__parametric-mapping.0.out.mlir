#map = affine_map<()[s0, s1] -> (s0 * s1)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @map1d(%arg0: index, %arg1: index, %arg2: index) {
    %0:2 = "new_processor_id_and_range"() : () -> (index, index)
    %1 = affine.apply #map()[%0#0, %arg2]
    %2 = affine.apply #map1()[%1, %arg0]
    %3 = affine.apply #map()[%0#1, %arg2]
    scf.for %arg3 = %2 to %arg1 step %3 {
    }
    return
  }
  func.func @map2d(%arg0: index, %arg1: index, %arg2: index) {
    %0:2 = "new_processor_id_and_range"() : () -> (index, index)
    %1:2 = "new_processor_id_and_range"() : () -> (index, index)
    %2 = affine.apply #map()[%0#0, %1#1]
    %3 = affine.apply #map1()[%2, %1#0]
    %4 = affine.apply #map()[%3, %arg2]
    %5 = affine.apply #map1()[%4, %arg0]
    %6 = affine.apply #map()[%0#1, %arg2]
    %7 = affine.apply #map()[%1#1, %6]
    scf.for %arg3 = %5 to %arg1 step %7 {
    }
    return
  }
}


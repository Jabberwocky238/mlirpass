module {
  pdl.pattern @operation_op : benefit(1) {
    %0 = operation "foo.op" 
    rewrite %0 {
      %1 = operation "bar.unused" 
      erase %0
    }
  }
}


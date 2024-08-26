class alu_seq_item extends uvm_sequence_item;
  rand data_t      a_in;
  rand data_t      b_in;
  rand operation_t op_in;
  bit              in_valid;
       data_t      out;
  bit              out_valid;

  constraint b_c {
    a_in >= b_in;
    solve a_in before b_in;
  }

  constraint op_limit_c {
    op_in dist {add :=20, sub:=20, mul:=50, nop:=10};
  }

  `uvm_object_utils_begin(alu_seq_item)
    `uvm_field_enum(operation_t, op_in, UVM_DEFAULT)
    `uvm_field_int(in_valid, UVM_DEFAULT)
    `uvm_field_int(a_in, UVM_DEFAULT | UVM_DEC)
    `uvm_field_int(b_in, UVM_DEFAULT | UVM_DEC)
  `uvm_object_utils_end

  function new(string name ="alu_seq_item");
    super.new(name);
  endfunction

  virtual function string convert2string();
    convert2string = {convert2string, $sformatf("operation = %s, a_in = %0d, b_in =%0d \n",
                      op_in.name(), a_in, b_in)};
  endfunction

endclass

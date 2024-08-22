class alu_coverage extends uvm_subscriber#(alu_seq_item);
  `uvm_component_utils (alu_coverage);

  alu_seq_item trans;

  function new(string name = "alu_coverage", uvm_component parent);
    super.new(name, parent);
    alu_covergroup = new();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    trans = alu_seq_item::type_id::create("trans", this);
  endfunction

  // Define the covergroup
  covergroup alu_covergroup;
    opin : coverpoint trans.op_in;
    ain : coverpoint trans.a_in;
    bin : coverpoint trans.b_in;
    invalid : coverpoint trans.in_valid;
  endgroup

  function void write(alu_seq_item t);
    trans = t;
    // Sample the covergroup here
    alu_covergroup.sample();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("Coverage of ALU = %0f", \
              alu_covergroup.get_coverage()), UVM_LOW);
  endfunction

endclass

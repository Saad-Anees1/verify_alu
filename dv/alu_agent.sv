class alu_agent extends uvm_agent;
  `uvm_component_utils(alu_agent)

  alu_seqr seqr;
  alu_drv  drv;
  alu_mon  mon;

  `uvm_component_new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr = alu_seqr::type_id::create("seqr",this);
    drv = alu_drv::type_id::create("drv",this);
    mon = alu_mon::type_id::create("mon",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (get_is_active() == UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction

endclass

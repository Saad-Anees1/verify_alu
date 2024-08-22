class alu_scb extends uvm_scoreboard;
  `uvm_component_utils(alu_scb)

  `uvm_component_new

  uvm_tlm_analysis_fifo #(alu_seq_item) scb_port;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_port = new("scb_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    alu_seq_item item;
    forever begin
      scb_port.get(item);
      `uvm_info(`gfn, $sformatf("scb :\n%0s", item.sprint()), UVM_LOW)
    end
  endtask

endclass

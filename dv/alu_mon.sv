class alu_mon extends uvm_monitor;
  `uvm_component_utils(alu_mon)

  alu_env_cfg cfg;
  virtual interface alu_interface alu_intf_i;
  uvm_analysis_port#(alu_seq_item) mon_port;

  `uvm_component_new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_port = new("mon_port",this);
    cfg = alu_env_cfg::type_id::create("cfg", this);
    if(!uvm_config_db#(alu_env_cfg)::get(this, "", "vif", cfg))
      `uvm_fatal(get_type_name(), "Didn't get env_cfg");
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    alu_intf_i = cfg.vif;
  endfunction

  virtual task run_phase(uvm_phase phase);
    alu_seq_item item;

    wait(!alu_intf_i.mon_cb.rst);

    forever begin
      item = alu_seq_item::type_id::create("item", this);

      wait(alu_intf_i.mon_cb.in_valid == 1);
      @(alu_intf_i.mon_cb);

      item.op_in = operation_t'(alu_intf_i.mon_cb.op_in);
      item.a_in = alu_intf_i.mon_cb.a_in;
      item.b_in = alu_intf_i.mon_cb.b_in;
      item.in_valid = alu_intf_i.mon_cb.in_valid;
      item.out = alu_intf_i.mon_cb.out;

      repeat(2) @(alu_intf_i.mon_cb);
      mon_port.write(item);

      `uvm_info(get_type_name(),$sformatf("Result : %0d", alu_intf_i.mon_cb.out), UVM_LOW)
    end
  endtask

endclass

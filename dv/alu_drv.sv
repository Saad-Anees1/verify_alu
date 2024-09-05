class alu_drv extends uvm_driver #(alu_seq_item);
  `uvm_component_utils(alu_drv)

  virtual interface alu_interface_if alu_intf_i;
  alu_seq_item item;
  alu_seq_item rsp_item;
  alu_env_cfg cfg;
  operation_t op_in;

  `uvm_component_new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item = alu_seq_item::type_id::create("item",this);
    rsp_item = alu_seq_item::type_id::create("rsp_item",this);
    cfg = alu_env_cfg::type_id::create("cfg", this);

    if(!uvm_config_db#(alu_env_cfg)::get(this, "", "vif", cfg))
      `uvm_fatal(get_type_name(),"Didn't get env_cfg");
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    alu_intf_i = cfg.vif;
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    reset_mode();

    @(negedge alu_intf_i.drv_cb.rst);
    `uvm_info(get_type_name(), "Design come out of reset", UVM_LOW)
    @(alu_intf_i.drv_cb);

    forever begin
      fork
        drive_data();
      join_none

      @(posedge alu_intf_i.drv_cb.rst);
      disable fork;
    end
  endtask

  task reset_mode();
    `uvm_info(`gfn, "Reseting the driving Signals....", UVM_LOW)
    alu_intf_i.drv_cb.a_in <= '0;
    alu_intf_i.drv_cb.b_in <= 0;
    alu_intf_i.drv_cb.in_valid <= '0;
    alu_intf_i.drv_cb.op_in <= operation_t'(nop);
  endtask

  virtual task drive_data();
    forever begin
      seq_item_port.try_next_item(item);
      if (item == null) begin
        alu_intf_i.drv_cb.in_valid <= 1'b0;
        seq_item_port.get_next_item(item);
        @(alu_intf_i.drv_cb);
      end
      /*$cast(rsp_item, item.clone());
      rsp_item.set_id_info(item);*/

      alu_intf_i.drv_cb.in_valid <= 1'b1;
      alu_intf_i.drv_cb.op_in <= item.op_in;
      alu_intf_i.drv_cb.a_in <= item.a_in;
      alu_intf_i.drv_cb.b_in <= item.b_in;

      @(alu_intf_i.drv_cb);
      alu_intf_i.drv_cb.in_valid <= 1'b0;
      repeat (2) @(alu_intf_i.drv_cb);
      `uvm_info(`gfn, $sformatf("DRV : %s", item.convert2string()), UVM_LOW)
      //get_dut_response(rsp_item);
      seq_item_port.item_done();
    end

  endtask

  /*task get_dut_response(alu_seq_item response_item);

    response_item.out_valid = 1;
    response_item.out = 55;
  endtask*/

endclass

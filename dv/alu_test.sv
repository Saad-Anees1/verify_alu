class alu_test extends uvm_test;
  `uvm_component_utils(alu_test)

  alu_seq seq;
  alu_env env;
  alu_env_cfg cfg;
  string sequence_name;

  `uvm_component_new

  function void build_phase(uvm_phase phase);
    //uvm_factory factory = uvm_factory::get();
    super.build_phase(phase);
    //set_type_override_by_type(alu_seq::get_type(), div0_seq_c::get_type());
    //set_inst_override_by_type("*", alu_seq::get_type(), div0_seq_c::get_type());
    //factory.print();

    seq = alu_seq::type_id::create("seq", this);
    env = alu_env::type_id::create("env", this);
    cfg = alu_env_cfg::type_id::create("cfg", this);

    if(!uvm_config_db#(virtual alu_interface_if)::get(this, "", "vif", cfg.vif))
      `uvm_fatal(get_type_name(),"Didn't get handle to virtual interface alu_intf_i")

    // Retrieve the sequence name from the command line
    void'($value$plusargs("UVM_TEST_SEQ=%s", sequence_name));
    // Enable scoreboard via plusarg
    void'($value$plusargs("en_scb=%0b", cfg.en_scb));
    uvm_config_db#(alu_env_cfg)::set(this, "*", "vif", cfg);
  endfunction

  virtual task run_phase(uvm_phase phase);
    uvm_object obj;

    `uvm_info(`gfn, $sformatf("Running sequence: %s", sequence_name), UVM_LOW)

    // Create the sequence from its name
    obj = uvm_factory::get().create_object_by_name(sequence_name, "");
    if(obj != null) begin
      if (!$cast(seq, obj)) begin
        `uvm_fatal("SEQ_CAST_FAIL", $sformatf("Failed to cast %s to sequence", sequence_name))
      end
    end
    phase.raise_objection(this);
    seq.start(env.agent.seqr);
    #50;
    phase.drop_objection(this);
  endtask

endclass

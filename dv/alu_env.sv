class alu_env extends uvm_env;
  `uvm_component_utils(alu_env)

  alu_agent agent;
  alu_scb   scb;
  alu_env_cfg cfg;
  alu_coverage cov;

  `uvm_component_new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg = alu_env_cfg::type_id::create("cfg", this);
    agent = alu_agent::type_id::create("agent", this);
    scb = alu_scb::type_id::create("scb", this);
    cov = alu_coverage::type_id::create("cov", this);

    if(!uvm_config_db#(alu_env_cfg)::get(this, "", "vif", cfg))
      `uvm_fatal(get_type_name(),"Didn't get env_cfg");
  endfunction

  function void connect_phase(uvm_phase phase);
    if (cfg.en_scb) begin
      agent.mon.mon_port.connect(scb.scb_port.analysis_export);
    end
    agent.mon.mon_port.connect(cov.analysis_export);
  endfunction

endclass

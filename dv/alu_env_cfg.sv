class alu_env_cfg extends uvm_object;
  `uvm_object_utils(alu_env_cfg)

  `uvm_object_new

  bit en_scb = 1'b1;
  virtual interface alu_interface vif;
  event ev;
endclass

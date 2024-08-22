class alu_nop extends alu_seq;
  `uvm_object_utils(alu_nop)

  `uvm_object_new

 virtual task body();
  req = alu_seq_item::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {
  req.op_in==nop;});
  finish_item(req);
 endtask

endclass

class alu_sub extends alu_seq;
  `uvm_object_utils(alu_sub)

  `uvm_object_new

 virtual task body();
   repeat(100) begin
     req = alu_seq_item::type_id::create("req");
     start_item(req);
     assert(req.randomize() with {
     req.op_in==sub;});
     finish_item(req);
   end
 endtask

endclass

class alu_add extends alu_seq;
  `uvm_object_utils(alu_add)

  `uvm_object_new

 virtual task body();
   repeat(100) begin
     req = alu_seq_item::type_id::create("req");
     rsp = alu_seq_item::type_id::create("rsp");
     start_item(req);
     assert(req.randomize() with {req.op_in==add;});
     finish_item(req);
     /*get_response(rsp);
     `uvm_info(`gfn,$sformatf("Resp Data : %0d",rsp.out),UVM_LOW)*/
   end
 endtask

endclass

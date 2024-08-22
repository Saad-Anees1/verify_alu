class alu_seq extends uvm_sequence #(alu_seq_item);
  `uvm_object_utils(alu_seq)

  `uvm_object_new

 virtual task body();
   repeat(100) begin
     req = alu_seq_item::type_id::create("req");
     start_item(req);
     assert(req.randomize());
     finish_item(req);
   end
 endtask

endclass

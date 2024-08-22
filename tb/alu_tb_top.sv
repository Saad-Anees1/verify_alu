parameter WIDTH = 6;
module alu_tb_top;
  import uvm_pkg::*;
  import alu_pkg::*;
  bit clk;
  bit rst;

  //operation_t op_t;

  initial begin
    rst = 1'b1;
    #5
    rst = 1'b0;
    #5
    rst = 1'b1;
    #5
    rst =1'b0;
  end

  always #5 clk = ~clk;

  alu_interface #(.WIDTH(WIDTH)) alu_intf_i(.clk(clk), .rst(rst));

  alu alu (
      // Outputs
      .out         (alu_intf_i.out),
      .out_valid   (alu_intf_i.out_valid),
      // Inputs
      .clk         (clk),
      .rst         (rst),
      .op_in       (alu_intf_i.op_in),
      .a_in        (alu_intf_i.a_in),
      .b_in        (alu_intf_i.b_in),
      .in_valid    (alu_intf_i.in_valid)
  );

  initial begin
    uvm_config_db#(virtual alu_interface)::set(null, "*", "vif",alu_intf_i);
  end

  initial begin
    run_test();
  end

  initial begin
    $fsdbDumpfile("alu.fsdb");
    $fsdbDumpvars (0, alu_tb_top);
    #200;
  end
endmodule

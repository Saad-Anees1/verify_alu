interface alu_interface #(parameter WIDTH = 6)(input logic clk, input logic rst);
  //---------------------------------------------------------------------
  //Group: Signals
  import alu_types_pkg::*;

  operation_t 	    op_in;
  logic [WIDTH-1:0] a_in;
  logic [WIDTH-1:0] b_in;
  logic             in_valid;
  logic [WIDTH:0]   out;
  logic             out_valid;

  //--------------------------------------------------------------------
  //Group: Clocking blocks

  clocking drv_cb @(posedge clk);
    default input #1 output #1;
    input rst;
    input out;
    input out_valid;
    output op_in;
    output a_in;
    output b_in;
    output in_valid;
  endclocking

  clocking mon_cb @(posedge clk);
    default input #1 output #1;
    input rst;
    input out;
    input out_valid;
    input op_in;
    input a_in;
    input b_in;
    input in_valid;
  endclocking

  /*//---------------------------------------------------------------------
  //Group: Modports

  modport drv_mp(clocking drv_cb);
  modport mon_cb(clocking mon_cb);*/

endinterface

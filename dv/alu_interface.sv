interface alu_interface_if #(parameter WIDTH = 6)(input logic clk, input logic rst);
  //---------------------------------------------------------------------
  //Group: Signals
  import alu_types::*;

  operation_t       op_in;
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

  // Ensure that outputs are reset correctly
  reset: assert property (@(posedge clk) disable iff (!rst)
         (rst |-> (out == 0) && (out_valid == 0)))
         else $error($time," ASSERTION FAILED: Initially out & out_valid should be at known \
                     state -> '0");

  // Ensure that inputs are valid only when in_valid is high
  operations: assert property (@(posedge clk) disable iff (rst)
              (in_valid |-> (op_in inside {nop,add, sub, mul})))
              else $error($time, " ASSERTION FAILED: No such operation in the design");

  // Check for nop
  no_operation: assert property (@(posedge clk) disable iff (rst)
                (out_valid == 1 && op_in == nop |-> out == 0))
                else $error($time, " ASSERTION FAILED: nop mismatch | op_in: %0s | a_in: %0d, \
                            b_in: %0d | Expected: 0, Got: %0d |",
                             op_in.name(), a_in, b_in, out);


  // Check for addition
  addition: assert property (@(posedge clk) disable iff (rst)
            (out_valid == 1 && op_in == add |-> out == (a_in + b_in)))
            else $error($time," ASSERTION FAILED: Addition mismatch | op_in: %0s | a_in: %0d, \
            b_in: %0d | Expected: %0d, Got: %0d |, ", op_in.name(), a_in, b_in, a_in + b_in, out);

  // Check for subtraction
  subtraction: assert property (@(posedge clk) disable iff (rst)
               (out_valid == 1 && op_in == sub |-> out == (a_in - b_in)))
               else $error($time," ASSERTION FAILED: subtract mismatch | op_in: %0s | a_in: %0d, \
               b_in: %0d | Expected: %0d, Got: %0d |, ", op_in.name(),a_in,b_in,a_in - b_in, out);

  // Check for multiplication
  multiplication: assert property (@(posedge clk) disable iff (rst)
                  (out_valid == 1 && op_in == mul |-> out == (a_in * b_in)))
                  else $error($time," ASSERTION FAILED: multiplication mismatch | op_in: %0s | \
                  a_in: %0d, b_in: %0d | Expected: %0d, Got: %0d |",
                  op_in.name(), a_in, b_in, a_in * b_in, out);



endinterface

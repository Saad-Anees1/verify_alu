package alu_types;
  localparam DATA_WIDTH = 6;

  typedef bit [DATA_WIDTH-1:0] data_t;

  typedef enum logic [1:0] {
    add     = 2'h1,
    sub     = 2'h2,
    mul     = 2'h3,
    nop     = 2'h0
  }operation_t;

endpackage

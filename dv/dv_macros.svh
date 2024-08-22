`ifndef gfn
  `define gfn get_full_name()
`endif

`ifndef gtn
  `define gtn get_type_name()
`endif

`ifndef uvm_object_new
  `define uvm_object_new \
  function new(string name = ""); \
    super.new(name); \
  endfunction : new
`endif

`ifndef uvm_component_new
  `define uvm_component_new \
  function new(string name = "", uvm_component parent = null); \
    super.new(name, parent); \
  endfunction : new
`endif

`ifndef DV_CHECK_EQ
  `define DV_CHECK_EQ(ACT, EXP, MSG = "", SEV=error, ID=`gfn) \
  begin \
      if ((ACT) == (EXP)) ; else begin \
        `dv_``SEV($sformatf("Check failed %s == %s (%0d [0x%0h] vs %0d [0x%0h]) %s", \
                             `"ACT`", `"EXP`", ACT, ACT, EXP, EXP, MSG), ID) \
      end \
    end
`endif

`ifndef DV_CHECK_NE
  `define DV_CHECK_NE(ACT, EXP, MSG = "", SEV=error, ID=`gfn) \
  begin \
      if ((ACT) != (EXP)) ; else begin \
        `dv_``SEV($sformatf("Check failed %s != %s (%0d [0x%0h] vs %0d [0x%0h]) %s", \
                             `"ACT`", `"EXP`", ACT, ACT, EXP, EXP, MSG), ID) \
      end \
    end
`endif

`ifndef DV_CHECK_EQ_FATAL
  `define DV_CHECK_EQ_FATAL(ACT, EXP, MSG="", ID=`gfn) \
    `DV_CHECK_EQ(ACT, EXP, MSG, fatal, ID)
`endif

`ifndef dv_info
  `define dv_info(MSG,  VERBOSITY = uvm_pkg::UVM_LOW, ID = $sformatf("%m")) \
    if (uvm_pkg::uvm_report_enabled(VERBOSITY, uvm_pkg::UVM_INFO, ID)) begin \
        uvm_pkg::uvm_report_info(ID, MSG, VERBOSITY, `uvm_file, `uvm_line, "", 1); \
    end
`endif

`ifndef dv_warning
  `define dv_warning(MSG, ID = $sformatf("%m")) \
    if (uvm_pkg::uvm_report_enabled(uvm_pkg::UVM_NONE, uvm_pkg::UVM_WARNING, ID)) begin \
        uvm_pkg::uvm_report_warning(ID, MSG, uvm_pkg::UVM_NONE, `uvm_file, `uvm_line, "", 1); \
    end
`endif

`ifndef dv_error
  `define dv_error(MSG, ID = $sformatf("%m")) \
    if (uvm_pkg::uvm_report_enabled(uvm_pkg::UVM_NONE, uvm_pkg::UVM_ERROR, ID)) begin \
        uvm_pkg::uvm_report_error(ID, MSG, uvm_pkg::UVM_NONE, `uvm_file, `uvm_line, "", 1); \
    end
`endif

`ifndef dv_fatal
  `define dv_fatal(MSG, ID = $sformatf("%m")) \
    if (uvm_pkg::uvm_report_enabled(uvm_pkg::UVM_NONE, uvm_pkg::UVM_FATAL, ID)) begin \
        uvm_pkg::uvm_report_fatal(ID, MSG, uvm_pkg::UVM_NONE, `uvm_file, `uvm_line, "", 1); \
    end
`endif

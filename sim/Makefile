UVM_VERBOSITY = UVM_MEDIUM
RTLFILE = ../rtl/alu.sv
FLISTS= alu.flist
TBTOP= ../tb/alu_tb_top.sv

COVERAGE_DIR = ../coverage

$(COVERAGE_DIR):
	mkdir -p $(COVERAGE_DIR)

VCS =  vcs -sverilog -ntb_opts uvm-1.2 -debug_access+all -lca -kdb \
       -cm line+cond+fsm+branch+tgl

SIMV = ./simv +UVM_TESTNAME=alu_test +UVM_TEST_SEQ=alu_seq -l alu.log +UVM_VERBOSITY=$(UVM_VERBOSITY) +en_scb=1\
       -cm line+cond+fsm+tgl +ntb_random_seed_automatic


comp:
	$(VCS) -f $(FLISTS) $(RTLFILE) $(TBTOP)

run:
	$(SIMV)

cov_rep:
	urg -dir simv.vdb -report $(COVERAGE_DIR)

comp_run:  comp run

comp_run_covr:  comp run cov_rep

clean:
	rm -fr work csrc DVEfiles simv* uvm* *.log $(COVERAGE_DIR) covhtmlreport coverage.ucdb dump.vcd transcript \
	coverage.vdb csrc DVEfiles inter.vpd simv simv.daidir ../merged_dir.vdb ../all_seqs_logs.txt ../novas.rc ucli.key vc_hdrs.h \
        alu.log .inter.vpd.uvm vcdplus.vpd alu.fsdb tr_db.log verdi_config_file

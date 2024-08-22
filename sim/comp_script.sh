#!/bin/bash

RTLFILE="/remote/usrhome/saadanees/muvm/ALU/rtl/alu.sv"
FLISTS="/remote/usrhome/saadanees/muvm/ALU/dv/alu.flist"
TBTOP="/remote/usrhome/saadanees/muvm/ALU/tb/alu_tb_top.sv"

VCS_CMD="vcs +vcs+lic+wait -sverilog -full64 -ntb_opts uvm-1.2 -timescale=1ns/1ps -debug_access -lca -kdb -cm line+cond+fsm+tgl+branch -cm_hier cov_cfg.cfg -f $FLISTS $RTLFILE $TBTOP +libext+.sv+.svh -l alu.log"


echo "Compiling ALU RTL files..."
eval $VCS_CMD
echo "RTL compilation completed!"

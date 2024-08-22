#!/bin/bash

# Define variables
NUM_RUNS=5  # Number of times to run each test sequence
SEQUENCES_FILE="seqs_list.f"  # File containing test sequences
MASTER_LOG_FILE="../all_seqs_logs.txt"  # File to store all log outputs

# Check if the sequences file exists
if [ ! -f "$SEQUENCES_FILE" ]; then
    echo "Error: Test sequences file not found: $SEQUENCES_FILE"
    exit 1
fi

# Remove existing workspace and create necessary directories
rm -rf ../coverage
mkdir -p ../coverage/cov_merge
mkdir -p ../coverage/cov_report

# Clear the master log file if it already exists
> "$MASTER_LOG_FILE"

# Loop over each test sequence in the file
while IFS= read -r seq; do
    echo "-------------------------------------------------------"
    echo "Running test sequence: $seq"
    for ((i=1; i<=$NUM_RUNS; i++)); do
        # Log the iteration details
        echo "Run $i for sequence: $seq"

        # Invoke your simulation tool with appropriate arguments and append the output to the master log file
	output=$(./simv +UVM_TESTNAME=alu_test +UVM_TEST_SEQ="$seq" +en_scb=1 +UVM_VERBOSITY=LOW -cm line+cond+fsm+tgl+branch -cm_hier "alu_tb_top.alu" -l alu.log +ntb_random_seed_automatic -no_save | tee -a "$MASTER_LOG_FILE")

        # Copy the VDB directory with a unique name
        cp -r simv.vdb "../coverage/cov_merge/${seq}_${i}.vdb"

    done
done < "$SEQUENCES_FILE"

echo "All test sequences completed" | tee -a "$MASTER_LOG_FILE"
echo "------------------------------------" | tee -a "$MASTER_LOG_FILE"


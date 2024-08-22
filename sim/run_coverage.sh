#!/bin/bash

MERGED_COV="urg -lca -full64 +urg+lic+wait -show tests -dir ../coverage/cov_merge/*.vdb -dbname ../merged_dir"
RUN_COV="urg -lca -full64 +urg+lic+wait -show tests -grade index testfile -group ratio -group lrm_bin_name -group instcov_for_score -dir ../merged_dir.vdb -line nocasedef -format both -report ../coverage/cov_report"

echo "Merging Coverage..."
eval $MERGED_COV

rm -rf urgReport

echo "Running Coverage..."
eval $RUN_COV

#rm -rf merged_dir.vdb


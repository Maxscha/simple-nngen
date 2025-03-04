#! /bin/bash

set -e

rm -rf files/data/resuls

# Commitgen
# python3 nngen.py main files/data/original/train.26208.diff \
# files/data/original/train.26208.msg  \
# files/data/original/train.26208.repos \
# files/data/original/test.3000.diff \
# files/data/original/test.3000.repos \
# --output_path files/data/original/results \

# mv files/data/results files/data/original/results
# mkdir -p files/data/results

# Commitgen Cleaned
#  mkdir -p files/data/results
# python3 nngen.py main files/data/train.diff files/data/train.msg files/data/train.projectIds files/data/test.diff files/data/test.projectIds --output_path files/data/commitgen_cleaned/results/
# mv files/data/results files/data/commitgen_cleaned/results


# CommitBench
# python3 nngen_optimized.py main files/data/commitbench/train.1165213.diff files/data/commitbench/train.1165213.msg files/data/commitbench/train.1165213.diff files/data/commitbench/test.249688.diff files/data/commitbench/test.249688.diff --output_path files/data/commitbench/results/
# mv files/data/results files/data/commitbench/results

# Commitbench Small
python3 nngen_optimized.py main files/data/commitbench_java_26208/train.26208.diff files/data/commitbench_java_26208/train.26208.msg files/data/commitbench_java_26208/train.26208.diff files/data/commitbench_java_26208/test.3000.diff files/data/commitbench_java_26208/test.3000.diff --output_path files/data/commitbench_java_26208/results/
# mv files/data/results files/data/commitbench_java_26208/results

# MCMD
#  mkdir -p files/data/results
# python3 nngen_optimized.py main files/data/mcmd/train.diff files/data/mcmd/train.msg files/data/mcmd/train.repo files/data/mcmd/test.diff files/data/mcmd/test.repo --output_path files/data/mcmd/results/
# mv files/data/results files/data/mcmd/results

python3 nngen_optimized.py main files/data/mcmd_java_26208/train.26208.diff files/data/mcmd_java_26208/train.26208.msg files/data/mcmd_java_26208/train.26208.diff files/data/mcmd_java_26208/test.3000.diff files/data/mcmd_java_26208/test.3000.diff --output_path files/data/mcmd_java_26208/results/

# mv files/data/results files/data/mcmd_java_26208/results
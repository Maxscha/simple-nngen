#! /bin/bash

set -e

# rm -rf files/data/resuls

# We have three test and three training datasetes

declare -a TRAIN
declare -a NAMES
declare -a TEST

NAMES=(
    commitgen
    commitbench_java
    mcmd_java
    gold_java
)

TRAINS=(
    files/data/original/train.26208
    files/data/commitbench_java/train.106894
    files/data/mcmd_java/train.360000
)

TEST=(
    files/data/original/test.3000.diff
    # files/data/commitbench_java/test.23012.diff
    # files/data/mcmd_java/test.45000.diff
    files/data/gold_java/test.3000.diff
)

# for loop with 3
for i in 0 1 2
do
    P=${TRAINS[$i]}
    TRAIN_MODEL=${NAMES[$i]}
    TRAIN_DIFF=$P.diff
    TRAIN_MSG=$P.msg

    for j in 0 3
    do
        TEST_DIFF=${TEST[$j]}
        TEST_MODEL=${NAMES[$j]}
        echo $TRAIN_MODEL $TEST_MODEL
        python3 nngen.py main $TRAIN_DIFF \
        $TRAIN_MSG  \
        $TRAIN_DIFF \
        $TEST_DIFF\
        $TEST_DIFF \
        --output_path files/eval/$TRAIN_MODEL/$TEST_MODEL/
    done
done

# Commitgen

# TRAIN_DIFF=files/data/original/train.26208.diff
# TRAIN_MSG=files/data/original/train.26208.msg

# TEST_DIFF=files/data/original/test.3000.diff

# python3 nngen.py main $TRAIN_DIFF \
# $TRAIN_MSG  \
# $TRAIN_DIFF \
# $TEST_DIFF\
# $TEST_DIFF \
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

# # Commitbench Small
# python3 nngen_optimized.py main files/data/commitbench_java_26208/train.26208.diff files/data/commitbench_java_26208/train.26208.msg files/data/commitbench_java_26208/train.26208.diff files/data/commitbench_java_26208/test.3000.diff files/data/commitbench_java_26208/test.3000.diff --output_path files/data/commitbench_java_26208/results/
# mv files/data/results files/data/commitbench_java_26208/results

# MCMD
#  mkdir -p files/data/results
# python3 nngen_optimized.py main files/data/mcmd/train.diff files/data/mcmd/train.msg files/data/mcmd/train.repo files/data/mcmd/test.diff files/data/mcmd/test.repo --output_path files/data/mcmd/results/
# mv files/data/results files/data/mcmd/results

# python3 nngen_optimized.py main files/data/mcmd_java_26208/train.26208.diff files/data/mcmd_java_26208/train.26208.msg files/data/mcmd_java_26208/train.26208.diff files/data/mcmd_java_26208/test.3000.diff files/data/mcmd_java_26208/test.3000.diff --output_path files/data/mcmd_java_26208/results/

# mv files/data/results files/data/mcmd_java_26208/results
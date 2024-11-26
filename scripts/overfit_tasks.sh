#!/bin/bash

# Usage: ./script.sh START_INDEX NUM_TASKS

# Check for correct number of arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 START_INDEX NUM_TASKS"
  exit 1
fi

# Get input arguments
START_INDEX=$1
NUM_TASKS=$2

# Read tasks into an array
mapfile -t TASKS < tasks.txt

TOTAL_TASKS=${#TASKS[@]}

# Validate START_INDEX
if [ "$START_INDEX" -lt 0 ] || [ "$START_INDEX" -ge "$TOTAL_TASKS" ]; then
  echo "Error: START_INDEX is out of range."
  exit 1
fi

# Calculate END_INDEX
END_INDEX=$((START_INDEX + NUM_TASKS - 1))

# Validate END_INDEX
if [ "$END_INDEX" -ge "$TOTAL_TASKS" ]; then
  echo "Error: The range exceeds the number of tasks."
  exit 1
fi

# Loop over the specified range of tasks
for (( i=START_INDEX; i<=END_INDEX; i++ ))
do
  TASK_ID=${TASKS[$i]}
  echo "Processing task ID: $TASK_ID"
  python src/train.py --config-path=configs/nick --config-name=overfit-general training.task_generator.overfit_task="$TASK_ID"
done

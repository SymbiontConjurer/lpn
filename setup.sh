#!/bin/bash

# Check if the "venv" directory exists
if [ -d "venv" ]; then
    # Remove the "venv" directory
    rm -rf venv
fi

# Create a new virtual environment in the "venv" directory
python -m venv venv

# Activate the virtual environment
source venv/bin/activate

pip install -e .

wandb login
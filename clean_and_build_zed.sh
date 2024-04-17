#!/bin/bash

# Create or ensure the logs directory exists
mkdir -p ~/automations/logs

# Capture date and time for the log filename
LOG_DATE=$(date "+%Y-%m-%d_%H-%M-%S")
LOG_FILE=~/automations/logs/update_${LOG_DATE}.log

echo "Starting update process, logging to $LOG_FILE"

{
    # Update Rust toolchain
    echo "Updating Rust toolchain..."
    rustup update

    cd ~/Code/zed/zed/ || exit

    # Update the zed repo
    echo "Pulling down latest main..."
    git checkout main && git pull

    # Build project
    echo "Cleaning & building zed..."
    cargo clean && cargo build

} &> "$LOG_FILE"

echo "Log saved to $LOG_FILE"

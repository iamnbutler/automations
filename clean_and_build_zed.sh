#!/bin/bash

# The zed target dir grows pretty quickly, and Rust Analyzer
# seems to do better when the project is cleaned frequently.
#
# This script checks for any rust updates, pulls down the latest
# main branch, cleans the project, and builds it when run.
#
# I run this as a cron job to keep my zed project up to date
#
# Basically just add this to your crontab:
# 0 3 * * * /bin/bash ~/automations/clean_and_build_zed.sh
#
# I keep all my automation scripts in a directory called `automations`,
# but you can put this wherever you like, just adjust the path and scrupt
# as needed.

# Create or ensure the logs directory exists
mkdir -p ~/automations/logs

# Capture date and time for the log filename
LOG_DATE=$(date "+%Y-%m-%d_%H-%M-%S")
LOG_FILE=~/automations/logs/clean_and_build_zed_${LOG_DATE}.log

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

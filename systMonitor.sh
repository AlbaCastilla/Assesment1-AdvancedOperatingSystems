#!/bin/bash

LOG_FILE="syst_monitor_log.txt"
ARCHIVE_DIR="ArchiveLogs"

log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

while true; do
    echo " UNI DATA CENTRE SYST"
    echo "1. Display CPU and Memory Usage"
    echo "2. Show Top 10 Memory Consuming Processes"
    echo "3. Terminate a Process"
    echo "4. Disk Inspection and Log Archiving"
    echo "5. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1) ;;
        2) ;;
        3) ;;
        4) ;;
        5) ;;
        *) echo "Invalid selection. Please try again." ;;
    esac
done

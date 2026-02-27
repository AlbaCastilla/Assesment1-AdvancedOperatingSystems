#!/bin/bash

LOG_FILE="syst_monitor_log.txt"
ARCHIVE_DIR="ArchiveLogs"



see_usage() {
    echo "CPU USAGE"
    top -bn1 | grep "Cpu"
    echo "MEMORY USAGE"
    free -h
    log_action "CPU and memory usage displayed"
}

see_top_processes() {
    echo "TOP 10 MEMORY PROCESSES"
    ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -n 11
    log_action "top 10 memory consuming processes displayed"
}





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
        1) see_usage ;;
        2) see_top_processes;;
        3) ;;
        4) ;;
        5) ;;
        *) echo "Invalid selection. Please try again." ;;
    esac
done

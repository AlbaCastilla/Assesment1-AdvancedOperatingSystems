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

terminate_process() {
    read -p "Enter PID to terminate: " pid

    if ! [[ "$pid" =~ ^[0-9]+$ ]]; then
        echo "Invalid PID."
        return
    fi

    if [ "$pid" -eq 1 ]; then
        echo "Critical system process cannot be terminated."
        log_action "Attempt to terminate PID 1 blocked"
        return
    fi

    if ps -p $pid > /dev/null; then
        read -p "Are you sure? (Y/N): " confirm
        if [[ "$confirm" == "Y" || "$confirm" == "y" ]]; then
            kill $pid
            echo "Process terminated."
            log_action "Terminated process PID $pid"
        else
            echo "Termination cancelled."
            log_action "Cancelled termination PID $pid"
        fi
    else
        echo "Process does not exist."
    fi
}

disk_and_logs() {
    read -p "Enter directory to inspect: " dir

    if [ ! -d "$dir" ]; then
        echo "Directory does not exist."
        return
    fi

    du -sh "$dir"
    log_action "Inspected disk usage for $dir"

    mkdir -p $ARCHIVE_DIR

    large_logs=$(find "$dir" -type f -name "*.log" -size +50M)

    for file in $large_logs; do
        timestamp=$(date '+%Y%m%d_%H%M%S')
        filename=$(basename "$file")
        tar -czf "$ARCHIVE_DIR/${filename}_$timestamp.tar.gz" "$file"
        log_action "Archived $file"
    done

    archive_size=$(du -sm $ARCHIVE_DIR | cut -f1)
    if [ "$archive_size" -gt 1024 ]; then
        echo "WARNING: ArchiveLogs exceeds 1GB"
        log_action "ArchiveLogs exceeded 1GB warning"
    fi
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
        3) terminate_process;;
        4) disk_and_logs;;
        5) ;;
        *) echo "Invalid selection. Please try again." ;;
    esac
done

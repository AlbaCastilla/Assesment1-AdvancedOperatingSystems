# University Data Centre Process and Resource Management System

## Overview
This Bash-based system administration tool simulates an intelligent monitoring system for a University Data Centre.

It provides:
- Process monitoring
- Safe process termination
- Disk inspection
- Log archiving
- System action logging
- Secure exit mechanism

## Requirements
- Ubuntu/Linux OS
- Bash
- Git (optional)

## How to Execute

1. Clone repository:
   git clone https://github.com/YOUR_USERNAME/university-data-centre-system.git

2. Navigate into folder:
   cd university-data-centre-system

3. Make executable:
   chmod +x system_monitor.sh

4. Run:
   ./system_monitor.sh

## Testing Log Archiving

Create test logs:
fallocate -l 60M test_logs/app.log
fallocate -l 75M test_logs/server.log

Select option 4 and enter:
test_logs

## Logging

All administrative actions are stored in:
system_monitor_log.txt

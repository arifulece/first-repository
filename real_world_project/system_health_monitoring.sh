#!/bin/bash

# ==============================
# System Health Monitoring Script
# Author : Ariful Islam (DevOps Practice)
# ==============================

# Log file location
LOGFILE="/var/log/system_health.log"
HOSTNAME=$(hostname)
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "==========================================" >> $LOGFILE
echo "System Health Report - $DATE ($HOSTNAME)" >> $LOGFILE
echo "==========================================" >> $LOGFILE

# --- CPU Usage ---
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
echo "CPU Usage       : $CPU_USAGE" >> $LOGFILE

# --- Memory Usage ---
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
echo "Memory (MB)     : Total=$MEM_TOTAL | Used=$MEM_USED | Free=$MEM_FREE" >> $LOGFILE

# --- Disk Usage ---
echo "Disk Usage      :" >> $LOGFILE
df -h --exclude-type=tmpfs --exclude-type=devtmpfs >> $LOGFILE

# --- Uptime ---
UPTIME=$(uptime -p)
echo "Uptime          : $UPTIME" >> $LOGFILE

# --- Load Average ---
LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}')
echo "Load Average    : $LOAD_AVG" >> $LOGFILE

# --- Top 5 Memory Consuming Processes ---
echo "Top 5 Memory Consuming Processes:" >> $LOGFILE
ps -eo pid,comm,%mem,%cpu --sort=-%mem | head -n 6 >> $LOGFILE

# --- Top 5 CPU Consuming Processes ---
echo "Top 5 CPU Consuming Processes:" >> $LOGFILE
ps -eo pid,comm,%mem,%cpu --sort=-%cpu | head -n 6 >> $LOGFILE

# --- Users Logged In ---
USERS=$(who | wc -l)
echo "Logged In Users : $USERS" >> $LOGFILE

# --- Network Info ---
IP_ADDRESS=$(hostname -I | awk '{print $1}')
echo "IP Address      : $IP_ADDRESS" >> $LOGFILE

echo "" >> $LOGFILE

# --- Optional: Send report by email ---
# mailx -s "System Health Report - $HOSTNAME" admin@example.com < $LOGFILE


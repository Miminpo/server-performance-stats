#!bin/bash

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Project: Server Performance Stats
# Author: Lebron Malabanan
# Description: Simple Linux server monitoring
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++


echo "+++++++++++++++++++++++++++++++++++++++++++++++++"
echo "              Server Performance Stats"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "CPU USAGE"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++"

CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')

CPU_USAGE=$(awk -v idle="$CPU_IDLE" 'BEGIN {printf "%.2f", 100-idle}')

echo "Total CPU Usage: $CPU_USAGE%"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++"

echo "MEMORY USAGE"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++"

free -m | awk 'NR==2 {
     total = $2
     used = $3
     free = $4
    
     printf "Total Memory: %d MB\n", total
     printf "Used Memory: %d MB (%.2f%%)\n", used, (used/total)*100
     printf "Free Memory: %d MB (%.2f%%)\n", free, (free/total)*100

}'
echo "+++++++++++++++++++++++++++++++++++++++++++++++++"
echo "DISK USAGE"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++"

df -h / | awk 'NR==2 {
  printf "Total Disk Space: %s\n", $2
  printf "Used Disk Space: %s\n", $3
  printf "Available Disk Space: %s\n", $4
  printf "Disk Usage: %s\n", $5
}'

echo "++++++++++++++++++++++++++++++++++++++++++++++++"
echo "TOP 5 PROCESSES BY CPU USAGE"
echo "++++++++++++++++++++++++++++++++++++++++++++++++"

ps aux --sort=-%cpu | head -n 6

echo "+++++++++++++++++++++++++++++++++++++++++++++++"
echo "TOP 5 PROCESSES BY MEMORY USAGE"
echo "+++++++++++++++++++++++++++++++++++++++++++++++"

ps aux --sort=-%mem | head -n 6

echo ""


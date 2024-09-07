#!/bin/bash

# 获取传入的参数，用于确定 shard 范围的起始值
ipv6=$1
gateway_mac=$2
input_file_path=$3
# 定义常量
LOG_DIRECTORY="$HOME/doq/data/20240904/scan_logs"

# 创建日志目录（如果不存在）
mkdir -p "$LOG_DIRECTORY"

for ((i=1; i<6; i++)); do
    SHARD=$i
    LOG_FILE="$LOG_DIRECTORY/segment_${SHARD}_log.txt"
    OUTPUT_FILE="/home/wuyue/doq/data/20240904/zmap-output-v2/${SHARD}.csv"
    INPUT_FILE="${input_file_path}/input_0${SHARD}"
    
    echo "Starting scan for shard $SHARD" > "$LOG_FILE"
    echo "Scan started at $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
    echo "Starting scan for shard $SHARD"

    # 执行 zmap 扫描
    SCAN_COMMAND="sudo /home/wuyue/doq/doq6-scripts/zmap -r 500 -M ipv6_udp -p 853 --probe-args=file:initial_qscanner_1a1a1a1a.pkt -o $OUTPUT_FILE --interface=eth0 --ipv6-source-ip=$ipv6 --ipv6-target-file=$INPUT_FILE --gateway-mac=$gateway_mac"
    echo "$SCAN_COMMAND"
    eval "$SCAN_COMMAND" 2>&1 | tail -n 10 -f >> "$LOG_FILE" &

    wait $!

    echo "Scan completed at $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
done

echo "All scans completed."
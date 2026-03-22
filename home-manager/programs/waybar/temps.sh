#!/usr/bin/env bash
cpu=$(( $(cat /sys/class/hwmon/hwmon5/temp1_input) / 1000 ))
gpu=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)
echo "{\"text\": \"${cpu}°C \", \"tooltip\": \"CPU: ${cpu}°C\nGPU: ${gpu}°C\"}"

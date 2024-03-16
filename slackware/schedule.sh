#!/bin/bash

task_path="$1"
periodicity="$2"

case "$periodicity" in
    daily)
        cp "$task_path" /etc/cron.daily
        ;;
    weekly)
        cp "$task_path" /etc/cron.weekly
        ;;
    monthly)
        cp "$task_path" /etc/cron.monthly
        ;;
esac

echo "Task scheduled"
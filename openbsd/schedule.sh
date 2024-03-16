#!/bin/sh

if [ $# -lt 2 ]; then
    echo "Usage: $0 script_path periodicity"
    exit 1
fi

$script_path="$1"
$periodicity="$2"

case "$periodicity" in
    daily | weekly | monthly)
        ;;
    *)
        echo "Periodicity: daily | weekly | monthly"
        exit 1
    ;;
esac

case "$periodicity" in
    daily)
        cron_file="/etc/daily"
        ;;
    weekly)
        cron_file="/etc/weekly"
        ;;
    monthly)
        cron_file="/etc/monthly"
        ;;
esac

if [ ! -f "$cron_file" ]; then
    echo "Creating file $cron_file"
    touch "$cron_file"
fi

echo "$script_path" >> "$cron_file"

echo "Task programmerd."
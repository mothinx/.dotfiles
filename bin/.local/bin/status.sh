#!/bin/bash

is_laptop() {
    if lspci | grep -q "GP108M"; then
        return 0
    else 
        return 1
    fi
}

while true; do
    DATE=$(date +'%Y-%m-%d %X')
    STATUS="🕒 $DATE"

    if is_laptop; then
        BATTERY=$(acpi -b | awk '{print $4}' | sed 's/,$//')
        STATUS="$STATUS | 🔋 $BATTERY"
    fi

    echo "$STATUS"
    sleep 1
done

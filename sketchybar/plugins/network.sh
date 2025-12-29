#!/bin/bash

# Simple network monitor - shows upload/download speeds

# Get primary network interface
INTERFACE=$(route get default 2>/dev/null | grep interface | awk '{print $2}' | head -n1)
[ -z "$INTERFACE" ] && INTERFACE="en0"

# Cache file
CACHE_FILE="/tmp/sketchybar_network_${INTERFACE}"

# Format bytes
format_bytes() {
    local bytes=$1
    if [ $bytes -lt 1024 ]; then
        echo "${bytes}B/s"
    elif [ $bytes -lt 1048576 ]; then
        echo "$((bytes / 1024))KB/s"
    else
        echo "$((bytes / 1048576))MB/s"
    fi
}

# Get current network stats
STATS=$(netstat -ibn -I $INTERFACE 2>/dev/null | awk 'NR==2 {print $7, $10}')
if [ -z "$STATS" ]; then
    sketchybar --set network.upload label="N/A" --set network.download label="N/A"
    exit 0
fi

CURRENT_RX=$(echo $STATS | awk '{print $1}')
CURRENT_TX=$(echo $STATS | awk '{print $2}')
CURRENT_TIME=$(date +%s)

# Read previous values
if [ -f "$CACHE_FILE" ]; then
    read PREV_RX PREV_TX PREV_TIME < "$CACHE_FILE"
    
    TIME_DIFF=$((CURRENT_TIME - PREV_TIME))
    
    if [ $TIME_DIFF -gt 0 ]; then
        RX_DIFF=$((CURRENT_RX - PREV_RX))
        TX_DIFF=$((CURRENT_TX - PREV_TX))
        
        [ $RX_DIFF -lt 0 ] && RX_DIFF=0
        [ $TX_DIFF -lt 0 ] && TX_DIFF=0
        
        RX_SPEED=$((RX_DIFF / TIME_DIFF))
        TX_SPEED=$((TX_DIFF / TIME_DIFF))
        
        DOWNLOAD_LABEL=$(format_bytes $RX_SPEED)
        UPLOAD_LABEL=$(format_bytes $TX_SPEED)
        
        # Set colors based on activity
        if [ $TX_SPEED -eq 0 ]; then
            UP_COLOR=0xff939ab7
        else
            UP_COLOR=0xffed8796
        fi
        
        if [ $RX_SPEED -eq 0 ]; then
            DOWN_COLOR=0xff939ab7
        else
            DOWN_COLOR=0xff8aadf4
        fi
        
        sketchybar --set network.upload \
                   label="$UPLOAD_LABEL" \
                   icon.color=$UP_COLOR \
                   label.color=$UP_COLOR \
                   --set network.download \
                   label="$DOWNLOAD_LABEL" \
                   icon.color=$DOWN_COLOR \
                   label.color=$DOWN_COLOR
    fi
fi

# Save current values
echo "$CURRENT_RX $CURRENT_TX $CURRENT_TIME" > "$CACHE_FILE"

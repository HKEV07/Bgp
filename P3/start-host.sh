#!/bin/sh

export PATH=/usr/sbin:/sbin:/usr/bin:/bin:/gns3/bin:$PATH

echo "=== host starting ==="

sleep 2

if [ -f /etc/network/interfaces ]; then
    echo "=== applying network config ==="
    grep -E "^\s*(up )" /etc/network/interfaces \
        | sed 's/^\s*up //' \
        | sh 2>/dev/null || true
fi

echo "=== host ready ==="
tail -f /dev/null

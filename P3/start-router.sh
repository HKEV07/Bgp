#!/bin/sh

export PATH=/usr/sbin:/sbin:/usr/bin:/bin:/gns3/bin:$PATH

echo "=== router starting, hostname: $HOSTNAME ==="

case "$HOSTNAME" in
    *wil-1*)
        echo "=== loading RR config ==="
        cp /etc/frr/configs/frr-rr.conf /etc/frr/frr.conf
        ;;
    *wil-2*)
        echo "=== loading leaf2 config ==="
        cp /etc/frr/configs/frr-leaf2.conf /etc/frr/frr.conf
        ;;
    *wil-3*)
        echo "=== loading leaf3 config ==="
        cp /etc/frr/configs/frr-leaf3.conf /etc/frr/frr.conf
        ;;
    *wil-4*)
        echo "=== loading leaf4 config ==="
        cp /etc/frr/configs/frr-leaf4.conf /etc/frr/frr.conf
        ;;
    *)
        echo "=== unknown hostname, using default config ==="
        ;;
esac

chown frr:frr /etc/frr/frr.conf
chmod 640 /etc/frr/frr.conf

sleep 2

if [ -f /etc/network/interfaces ]; then
    echo "=== applying network config ==="
    grep -E "^\s*(up )" /etc/network/interfaces \
        | sed 's/^\s*up //' \
        | sh 2>/dev/null || true
fi

echo "=== starting FRR ==="
/usr/lib/frr/frrinit.sh start

echo "=== router ready ==="
tail -f /dev/null

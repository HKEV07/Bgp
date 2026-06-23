#!/bin/sh

echo "=== starting ==="

# GNS3 appends the startup config to /etc/network/interfaces
# we extract ONLY the lines that are actual shell commands
# and ignore everything that is interfaces file syntax
if [ -f /etc/network/interfaces ]; then
    echo "=== reading /etc/network/interfaces ==="
    
    # extract lines starting with ip, route, bridge, echo commands
    # skip comment lines, blank lines, and interfaces file keywords
    grep -E "^(ip |route |bridge |echo |brctl |vxlan)" \
        /etc/network/interfaces | sh
    
    echo "=== commands executed ==="
fi

# keep container alive
tail -f /dev/null
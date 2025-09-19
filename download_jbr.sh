#!/bin/sh

# Script to download JBR (JetBrains Runtime) to /root
set -e

cd /root

echo "Downloading JBR to /root..."

# URL for JBR download
JBR_URL="https://cache-redirector.jetbrains.com/intellij-jbr/jbr_jcef-21.0.8-linux-x64-b1115.48.tar.gz"
JBR_FILE="jbr_jcef-21.0.8-linux-x64-b1115.48.tar.gz"

# Check if curl is available
if command -v curl >/dev/null 2>&1; then
    echo "Using curl to download..."
    if curl -L --retry 3 --retry-delay 5 --connect-timeout 30 --max-time 300 -o "$JBR_FILE" "$JBR_URL"; then
        echo "JBR download completed successfully using curl"
        DOWNLOAD_SUCCESS=1
    fi
fi

# If curl failed or is not available, try wget
if [ -z "$DOWNLOAD_SUCCESS" ] && command -v wget >/dev/null 2>&1; then
    echo "Using wget to download..."
    if wget --retry-connrefused --waitretry=5 --read-timeout=30 --timeout=30 -t 3 -O "$JBR_FILE" "$JBR_URL"; then
        echo "JBR download completed successfully using wget"
        DOWNLOAD_SUCCESS=1
    fi
fi

# If neither worked, try with basic wget (Alpine's built-in)
if [ -z "$DOWNLOAD_SUCCESS" ]; then
    echo "Trying basic wget..."
    if wget -O "$JBR_FILE" "$JBR_URL"; then
        echo "JBR download completed successfully using basic wget"
        DOWNLOAD_SUCCESS=1
    fi
fi

# Check if download was successful
if [ -z "$DOWNLOAD_SUCCESS" ]; then
    echo "JBR download failed with all available methods"
    exit 1
fi

# Verify the file was downloaded
if [ -f "$JBR_FILE" ]; then
    echo "JBR file verification:"
    ls -la "$JBR_FILE"
    # Use stat if available, otherwise just ls
    if command -v stat >/dev/null 2>&1; then
        echo "File size: $(stat -c %s "$JBR_FILE") bytes"
    fi
else
    echo "JBR download failed - file not found"
    exit 1
fi

echo "JBR download completed successfully!"
echo "File location: /root/$JBR_FILE"
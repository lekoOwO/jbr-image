#!/bin/bash

# Script to download JBR (JetBrains Runtime) to /root
set -e

cd /root

echo "Downloading JBR to /root..."

# URL for JBR download
JBR_URL="https://cache-redirector.jetbrains.com/intellij-jbr/jbr_jcef-21.0.8-linux-x64-b1115.48.tar.gz"
JBR_FILE="jbr_jcef-21.0.8-linux-x64-b1115.48.tar.gz"

# Try downloading with curl first
if curl -L --retry 3 --retry-delay 5 --connect-timeout 30 --max-time 300 -o "$JBR_FILE" "$JBR_URL"; then
    echo "JBR download completed successfully using curl"
elif wget --retry-connrefused --waitretry=5 --read-timeout=30 --timeout=30 -t 3 -O "$JBR_FILE" "$JBR_URL"; then
    echo "JBR download completed successfully using wget"
else
    echo "JBR download failed with both curl and wget"
    exit 1
fi

# Verify the file was downloaded
if [ -f "$JBR_FILE" ]; then
    echo "JBR file verification:"
    ls -la "$JBR_FILE"
    echo "File size: $(stat -c %s "$JBR_FILE") bytes"
else
    echo "JBR download failed - file not found"
    exit 1
fi

echo "JBR download completed successfully!"
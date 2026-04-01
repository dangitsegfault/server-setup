#!/bin/sh

# Exit immediately if a command fails
set -e

echo "Starting WireGuard..."

# Bring up the interface using the config file
wg-quick up wg0

echo "WireGuard is running."

# Keep the container alive by tailing the null device
tail -f /dev/null

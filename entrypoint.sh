#!/bin/bash

# Check if ROOT_PASSWORD is provided
if [ -z "${ROOT_PASSWORD}" ]; then
    echo "ERROR: ROOT_PASSWORD environment variable is not set"
    exit 1
fi

# Set root password
echo "root:${ROOT_PASSWORD}" | chpasswd

# Start SSH daemon
exec /usr/sbin/sshd -D

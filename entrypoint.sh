#!/bin/bash

# Check if either ROOT_PASSWORD or SSH_AUTHORIZED_KEYS is provided
if [ -z "${ROOT_PASSWORD}" ] && [ -z "${SSH_AUTHORIZED_KEYS}" ]; then
    echo "ERROR: Either ROOT_PASSWORD or SSH_AUTHORIZED_KEYS environment variable must be set"
    exit 1
fi

# Set up SSH authorized_keys if provided
if [ ! -z "${SSH_AUTHORIZED_KEYS}" ]; then
    mkdir -p /root/.ssh
    echo "${SSH_AUTHORIZED_KEYS}" > /root/.ssh/authorized_keys
    chmod 700 /root/.ssh
    chmod 600 /root/.ssh/authorized_keys
fi

# Set root password if provided
if [ ! -z "${ROOT_PASSWORD}" ]; then
    echo "root:${ROOT_PASSWORD}" | chpasswd
fi

# Start SSH daemon
exec /usr/sbin/sshd -D

#!/usr/bin/env bash

set -e

echo "root:${SSH_ROOT_PASSWORD}" | chpasswd

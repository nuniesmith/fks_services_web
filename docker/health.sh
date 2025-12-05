#!/bin/sh
# Health check script for fks_web service

curl -f http://localhost:3001/health > /dev/null 2>&1 || exit 1

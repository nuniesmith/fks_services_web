#!/bin/bash
# Startup script for fks_web service

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Building fks_web service..."

# First, build the Kotlin Multiplatform web app
cd ../../clients
echo "Building Kotlin Multiplatform web app..."
./gradlew :web:jsBrowserWebpack

# Return to service directory
cd ../services/web

echo "Starting fks_web service..."
docker-compose up -d

echo "fks_web service started"
echo "Check status: docker-compose ps"
echo "View logs: docker-compose logs -f"

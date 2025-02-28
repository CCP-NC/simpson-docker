#!/bin/bash

# Define the container engine (podman or docker)
CONTAINER_ENGINE="docker"

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <simpson-input-file> [additional-options]"
  exit 1
fi

# Execute simpson in the container, mounting current directory to /workspace
$CONTAINER_ENGINE run --rm -v "$(pwd):/workspace" simpson simpson "$@"

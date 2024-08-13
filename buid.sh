#!/bin/bash

name=$(basename "$PWD")

if [ -z "$name" ]; then
	echo "Could not determine the current directory name"
    exit 1
fi

if [ ! -f "Containerfile" ]; then
	echo "Could not find Containerfile"
	exit 1
fi

echo "Deleting existing image (if any)"
podman stop $name
podman rmi $name

echo "Building image '$name'"
podman build --file Containerfile --tag "$name"

echo "Creating toolbox '$name'"
toolbox create --image "$name" --container "$name"

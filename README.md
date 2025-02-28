# simpson-docker
Dockerfile for the Simpson code. This image will be pushed to Docker Hub as jkshenton/simpson:



## Overview
This project provides a Docker/Podman container for running the SIMPSON (SIMulation Package for SOlid-state NMR) application without installing it directly on your system.


## Running the Container

To run the container directly from Docker Hub:

```bash
# Pull the image from Docker Hub
docker pull jkshenton/simpson

# Using Docker: Run the image directly
docker run -v $(pwd):/workspace jkshenton/simpson simpson test.in

# Using Podman
podman run -v $(pwd):/workspace jkshenton/simpson simpson test.in
``` 

## Instructions for Windows Users

When using PowerShell, replace $(pwd) with ${PWD} or use an absolute path.

```powershell
# Pull the image from Docker Hub
docker pull jkshenton/simpson

# Run using Docker in PowerShell
docker run -v ${PWD}:/workspace jkshenton/simpson simpson test.in
```

## Building and running the container locally

```bash
# Using Docker
docker build -t simpson .

# Using Podman
podman build -t simpson .
```


### Running the Container

```bash
# Using Docker
docker run -v $(pwd):/workspace simpson simpson test.in

# Using Podman
podman run -v $(pwd):/workspace simpson simpson test.in

```

### Using the wrapper script

1. Make the script executable
```bash
chmod +x simpson.sh
```

2. Run the script
```bash
./simpson.sh test.in
```

The script will automatically mount the current directory to the `/workspace` directory in the container and run the `simpson` command with the provided input file.

You can add the script to your PATH to run it from anywhere. For example, you can copy the script to `/usr/local/bin` and rename it to `simpson`:
```bash
sudo cp simpson.sh /usr/local/bin/simpson
```


## Disclaimer
This repository is not affiliated with the SIMPSON development team. This Docker container is an independent project created to simplify the installation and usage of SIMPSON.

The SIMPSON software is developed and maintained by the NMR group at Aarhus University. For the official SIMPSON software, support, and documentation, please visit https://inano.au.dk/about/research-centers-and-projects/nmr/software/simpson.

This Docker container is provided "as is", without warranty of any kind. While efforts have been made to ensure compatibility, I am not responsible for any issues that may arise from using this container in your research or production environment. Use at your own risk.
# APISIX Custom Image

This example shows how to make a custom APISIX Docker image, building the code from source.

## Setup

Build the Docker image by running the following command:

```bash
./docker_build.sh
```

Start APISIX in Docker by running the following command:

```bash
docker compose up
```

Run the following script to create some simple test resources (Upstreams, Consumers, Routes):

```bash
./create_resources.sh
```

## Test Routes

### Base Route

```bash
curl -i "localhost:9080/anything"
```
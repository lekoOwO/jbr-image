# jbr-image

An Alpine Linux Docker container that downloads JetBrains Runtime (JBR) to `/root`.

## What it does

This container:
- Uses Alpine Linux as the base image
- Downloads `jbr_jcef-21.0.8-linux-x64-b1115.48.tar.gz` from JetBrains CDN
- Saves the file to `/root` directory
- Provides both `curl` and `wget` with retry mechanisms for reliable downloads

## Usage

### Pull from GitHub Container Registry

```bash
docker pull ghcr.io/lekoowo/jbr-image:latest
```

### Run the container

```bash
docker run --rm ghcr.io/lekoowo/jbr-image:latest
```

The container will automatically download the JBR file when started.

### Interactive mode

To access the container with a shell after download:

```bash
docker run -it --rm ghcr.io/lekoowo/jbr-image:latest bash
```

Then run the download script manually:
```bash
/download_jbr.sh
```

## Building locally

```bash
docker build -t jbr-image .
```

## Files

- `Dockerfile` - Container definition
- `download_jbr.sh` - Download script with retry logic
- `.github/workflows/docker-publish.yml` - GitHub Actions workflow for publishing to GHCR
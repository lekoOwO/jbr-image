FROM alpine:latest

# Update package index and install necessary packages
RUN apk update && apk add --no-cache \
    curl \
    ca-certificates \
    bash \
    wget

# Copy download script
COPY download_jbr.sh /download_jbr.sh
RUN chmod +x /download_jbr.sh

# Set working directory
WORKDIR /root

# Run the download script on container startup
CMD ["/download_jbr.sh"]
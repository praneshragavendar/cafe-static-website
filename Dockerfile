FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

# Ensure a stable and reachable Ubuntu mirror
RUN sed -i 's/http:\/\/archive.ubuntu.com\//http:\/\/us.archive.ubuntu.com\//g' /etc/apt/sources.list

# Install apache2 with retries and clean up to reduce image size
RUN apt-get update -o Acquire::Retries=5 -y && \
    apt-get install -y apache2 apache2-bin apache2-utils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy website files into the container's web directory
ADD . /var/www/html/

# Expose port 80 to access the web server
EXPOSE 80

# Keep Apache running in the foreground
ENTRYPOINT ["apachectl", "-D", "FOREGROUND"]


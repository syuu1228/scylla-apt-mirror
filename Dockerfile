# Pull base image.
FROM ubuntu:xenial

# Install apt-mirror
RUN \
    apt-get update && \
    apt-get install -y apt-mirror

# Copy mirror.list to /etc/apt
ADD mirror.list /etc/apt/mirror.list

# Install Nginx.
RUN \
  apt-get install -y nginx && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Run apt-mirror
RUN \
  apt-mirror && \
  ln -sf /var/spool/apt-mirror/mirror/s3.amazonaws.com/downloads.scylladb.com /var/www/html

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443

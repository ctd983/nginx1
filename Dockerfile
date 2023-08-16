# Use a base image with Nginx pre-installed
FROM nginx:latest

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz

# Copy a custom HTML file to the default Nginx document root
COPY /docs/html/index.html /usr/share/nginx/html/

# Expose the default Nginx port
EXPOSE 80


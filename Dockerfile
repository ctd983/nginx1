# Use a base image with Nginx pre-installed
FROM nginx:latest

# Copy a custom HTML file to the default Nginx document root
COPY index.html /usr/share/nginx/html/

# Expose the default Nginx port
EXPOSE 80


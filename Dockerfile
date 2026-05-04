# Use Nginx to serve the static frontend files
FROM nginx:alpine

# Copy all your frontend files (index.html, styles, etc.) to the Nginx folder
COPY . /usr/share/nginx/html

# Expose port 80 (standard for Nginx)
EXPOSE 80
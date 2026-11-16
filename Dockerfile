# Use the official lightweight Nginx image as the base
FROM nginx:alpine

# Remove the default Nginx welcome page
RUN rm -rf /usr/share/nginx/html/*

# Copy our static website files into Nginx's default serving directory
COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/

# Inform Docker that the container listens on port 80
EXPOSE 80

# Start Nginx in the foreground (required so the container keeps running)
CMD ["nginx", "-g", "daemon off;"]

FROM nginx:alpine
COPY webb.html /usr/share/nginx/html/index.html
EXPOSE 80

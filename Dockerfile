FROM nginx:latest AS prod

COPY index.html /usr/share/nginx/html/index.html

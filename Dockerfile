FROM nginx:alpine

# Copie la page vitrine dans le dossier servi par Nginx
COPY index.nginx-debian.html /usr/share/nginx/html/index.html

EXPOSE 80

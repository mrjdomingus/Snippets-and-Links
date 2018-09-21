FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir /etc/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
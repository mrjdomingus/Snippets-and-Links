FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir /etc/nginx/html

RUN mkdir /etc/nginx/ssl
COPY mynuxt.com.crt /etc/nginx/ssl/mynuxt.com.crt
COPY mynuxt.com_server_key.pem /etc/nginx/ssl/mynuxt.com_server_key.pem

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
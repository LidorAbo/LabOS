FROM nginx:latest
ARG nginx_conf_file_path=/etc/nginx/conf.d/default.conf
RUN rm $nginx_conf_file_path
COPY reverse-proxy.conf $nginx_conf_file_path
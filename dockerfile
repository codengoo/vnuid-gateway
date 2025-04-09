FROM openresty/openresty:alpine

COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY lua/ /usr/local/openresty/nginx/lua/

EXPOSE 80
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
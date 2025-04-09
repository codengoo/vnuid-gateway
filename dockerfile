FROM openresty/openresty:alpine-fat AS builder

COPY conf/ /usr/local/openresty/nginx/conf/
COPY lua/ /usr/local/openresty/nginx/lua/

RUN luarocks install lua-resty-jwt && rm -rf /root/.cache/luarocks

EXPOSE 80
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
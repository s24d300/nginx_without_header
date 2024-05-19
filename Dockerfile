ARG ARG_NGINX_VERSION=1.21.4

FROM alpine:latest AS build-stage

ARG ARG_NGINX_VERSION
ENV NGINX_VERSION=$ARG_NGINX_VERSION

RUN apk add wget git tar

RUN wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
RUN tar -zxvf nginx-${NGINX_VERSION}.tar.gz

RUN git clone https://github.com/openresty/headers-more-nginx-module.git

RUN apk add gcc g++ make
RUN apk add zlib-dev pcre-dev openssl-dev gd-dev

RUN cd nginx-${NGINX_VERSION} \
    && ./configure --with-compat --add-dynamic-module=/headers-more-nginx-module\
    && make modules

FROM nginx:1.21.4-alpine

ARG ARG_NGINX_VERSION
ENV NGINX_VERSION=$ARG_NGINX_VERSION

COPY --from=build-stage /nginx-${NGINX_VERSION}/objs/ngx_http_headers_more_filter_module.so /etc/nginx/modules

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
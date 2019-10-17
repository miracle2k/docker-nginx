FROM nginx:1.17
ENV DOCKERIZE_VERSION=v0.6.1
ENV FOO=1
MAINTAINER Kyle Mathews "mathews.kyle@gmail.com 

RUN rm /etc/nginx/nginx.conf /etc/nginx/mime.types
COPY nginx.conf /etc/nginx/nginx.conf
COPY basic.conf /etc/nginx/basic.conf
COPY mime.types /etc/nginx/mime.types
RUN mkdir /etc/nginx/ssl
COPY default /etc/nginx/sites-enabled/default
COPY default-ssl /etc/nginx/sites-available/default-ssl
COPY directive-only /etc/nginx/directive-only
COPY location /etc/nginx/location

ADD https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz ./
RUN tar -C /bin/ -xzf dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz && rm dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz

# expose both the HTTP (80) and HTTPS (443) ports
EXPOSE 80 443


ENTRYPOINT ["dockerize", "-template", "/etc/nginx/sites-enabled/default:/etc/nginx/sites-enabled/default"]
CMD ["nginx"]

FROM alpine:3.17
MAINTAINER Sabbir_khan
WORKDIR /home/node/

RUN apk add nodejs npm nginx apache2-ssl && \
        npm install pm2 -g && \
        rm -rf /var/cache/apk/* && \
        addgroup -S node && \
	adduser -S node -G node && \
	echo '/usr/sbin/nginx -c /etc/nginx/nginx.conf'>/opt/start.sh && \
	echo 'pm2-runtime index.js'>>/opt/start.sh && chmod +x /opt/start.sh

COPY default.conf /etc/nginx/http.d/default.conf
COPY index.js .
EXPOSE 80 443
CMD /bin/sh /opt/start.sh





FROM alpine:3.5

ENV UUID=6b7d0950-17fc-450e-aeeb-2c573df92b82
ENV ALTERID=64
ENV V2RAY_PORT=9199
ENV V2RAY_PATH=ray
ENV LOGLEVEL=debug
#-H "Cache-Control: no-cache"

RUN apk add --no-cache --virtual ca-certificates curl \
&& curl -L -o /v2ray.zip https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip \ 
&& mkdir /usr/bin/v2ray /etc/v2ray \
&& touch /etc/v2ray/config.json \
&& unzip /v2ray.zip -d /usr/bin/v2ray \
&& rm -rf /v2ray.zip /usr/bin/v2ray/*.sig /usr/bin/v2ray/doc /usr/bin/v2ray/*.json /usr/bin/v2ray/*.dat /usr/bin/v2ray/sys* \
&& chgrp -R 0 /etc/v2ray \
&& chmod -R g+rwX /etc/v2ray

ADD run.sh /run.sh
RUN chmod +x /run.sh


EXPOSE ${V2RAY_PORT}
ENTRYPOINT /bin/sh /run.sh



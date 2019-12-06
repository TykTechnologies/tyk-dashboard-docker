FROM debian:buster-slim

ENV TYKVERSION 1.8.6
ENV TYKLISTENPORT 3000

LABEL Description="Tyk Dashboard docker image" Vendor="Tyk" Version=$TYKVERSION

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
            curl ca-certificates apt-transport-https gnupg \
            build-essential \
 && curl -L https://packagecloud.io/tyk/tyk-dashboard/gpgkey | apt-key add - \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get install -y --no-install-recommends --allow-downgrades nodejs=8.16.2-1nodesource1 python-dev \
 && npm config set user 0 && npm config set unsafe-perm true \
 && npm install -g aglio \
 && apt-get purge -y build-essential gnupg python-dev \
 && apt-get autoremove -y \
 && rm -rf /root/.npm && rm -rf /root/.node-gyp

RUN echo "deb https://packagecloud.io/tyk/tyk-dashboard/debian/ jessie main" | tee /etc/apt/sources.list.d/tyk_tyk-dashboard.list \
 && apt-get update \
 && apt-get install --allow-unauthenticated -f --force-yes -y tyk-dashboard=$TYKVERSION \
 && rm -rf /var/lib/apt/lists/*


COPY ./tyk_analytics.with_mongo_and_gateway.conf /opt/tyk-dashboard/tyk_analytics.conf
VOLUME ["/opt/tyk-dashboard"]
WORKDIR /opt/tyk-dashboard

EXPOSE $TYKLISTENPORT
EXPOSE 5000

ENTRYPOINT ["/opt/tyk-dashboard/tyk-analytics", "--conf=/opt/tyk-dashboard/tyk_analytics.conf"]

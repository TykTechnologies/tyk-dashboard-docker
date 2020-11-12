FROM debian:jessie-slim

ENV TYKLISTENPORT 3000
ENV TYKVERSION 3.1.1~224.16a8061

LABEL Description="Tyk Dashboard docker image" Vendor="Tyk" Version=$TYKVERSION

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
            curl ca-certificates apt-transport-https \
 && curl https://packagecloud.io/gpg.key | apt-key add - \
 && apt-get autoremove -y

RUN echo "deb https://packagecloud.io/tyk/tyk-dashboard-unstable/debian/ jessie main" | tee /etc/apt/sources.list.d/tyk_tyk-dashboard.list \
 && apt-get update \
 && apt-get install --allow-unauthenticated -f --force-yes -y tyk-dashboard=$TYKVERSION \
 && rm -rf /var/lib/apt/lists/*


COPY ./tyk_analytics.with_mongo_and_gateway.conf /opt/tyk-dashboard/tyk_analytics.conf
VOLUME ["/opt/tyk-dashboard"]
WORKDIR /opt/tyk-dashboard

EXPOSE $TYKLISTENPORT
EXPOSE 5000

ENTRYPOINT ["/opt/tyk-dashboard/tyk-analytics", "--conf=/opt/tyk-dashboard/tyk_analytics.conf"]

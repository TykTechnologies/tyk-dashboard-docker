FROM debian:buster-slim

ENV TYKVERSION 3.0.4
ENV TYKLISTENPORT 3000
ARG TYKVERSION=3.1.2~257.a9f5267

LABEL Description="Tyk Dashboard docker image" Vendor="Tyk" Version=$TYKVERSION

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
            curl ca-certificates apt-transport-https gnupg \
 && curl -L https://packagecloud.io/tyk/tyk-dashboard/gpgkey | apt-key add - \
 && apt-get purge -y gnupg \
 && apt-get autoremove -y \
 && rm -rf /root/.cache

RUN echo "deb https://packagecloud.io/tyk/tyk-dashboard/debian/ jessie main" | tee /etc/apt/sources.list.d/tyk_tyk-dashboard.list \
 && apt-get update \
 && apt-get install --allow-unauthenticated -f --force-yes -y tyk-dashboard=$TYKVERSION \
 && rm -rf /var/lib/apt/lists/*


COPY ./tyk_analytics.with_mongo_and_gateway.conf /opt/tyk-dashboard/tyk_analytics.conf
VOLUME ["/opt/tyk-dashboard"]
WORKDIR /opt/tyk-dashboard

ENTRYPOINT ["/opt/tyk-dashboard/tyk-analytics", "--conf=/opt/tyk-dashboard/tyk_analytics.conf"]

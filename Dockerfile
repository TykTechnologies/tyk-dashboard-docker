FROM ubuntu:14.04

ENV TYKVERSION 1.3.2
ENV NODESOURCE_URL https://deb.nodesource.com/setup_6.x

LABEL Description="Tyk Dashboard docker image" Vendor="Tyk" Version=$TYKVERSION

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
            wget curl ca-certificates apt-transport-https gnupg build-essential python \
 && curl https://packagecloud.io/gpg.key | apt-key add - \
 && echo "deb     https://packagecloud.io/tyk/tyk-dashboard/ubuntu/ trusty main" | tee    /etc/apt/sources.list.d/tyk_tyk-dashboard.list \
 && echo "deb-src https://packagecloud.io/tyk/tyk-dashboard/ubuntu/ trusty main" | tee -a /etc/apt/sources.list.d/tyk_tyk-dashboard.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends tyk-dashboard=$TYKVERSION \
 && curl -sL $NODESOURCE_URL | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && npm install -g aglio \
 && apt-get purge -y build-essential \
 && apt-get autoremove -y \
 && rm -vf /opt/tyk-dashboard/tyk-dashboard_${TYKVERSION}_i386.deb   \
 && rm -vf /opt/tyk-dashboard/tyk-dashboard-${TYKVERSION}-1.i386.rpm \
 && rm -rf /var/lib/apt/lists/*

COPY ./tyk_analytics.with_mongo_and_gateway.conf /opt/tyk-dashboard/tyk_analytics.conf

VOLUME ["/opt/tyk-dashboard"]

WORKDIR /opt/tyk-dashboard

CMD ["/opt/tyk-dashboard/tyk-analytics", "--conf=/opt/tyk-dashboard/tyk_analytics.conf"]

EXPOSE 3000
EXPOSE 5000

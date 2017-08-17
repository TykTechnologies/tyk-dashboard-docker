FROM ubuntu:14.04
RUN apt-get update

RUN apt-get install -y wget curl build-essential python

RUN curl https://packagecloud.io/gpg.key | apt-key add -
RUN apt-get update

RUN apt-get install -y apt-transport-https

RUN echo "deb https://packagecloud.io/tyk/tyk-dashboard/ubuntu/ trusty main" | tee /etc/apt/sources.list.d/tyk_tyk-dashboard.list

RUN echo "deb-src https://packagecloud.io/tyk/tyk-dashboard/ubuntu/ trusty main" | tee -a /etc/apt/sources.list.d/tyk_tyk-dashboard.list

RUN apt-get update

RUN apt-get install -y tyk-dashboard=1.3.8

# Install Aglio (API Blueprint) - This is horrible
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs
RUN npm install -g aglio

COPY ./tyk_analytics.with_mongo_and_gateway.conf /opt/tyk-dashboard/tyk_analytics.conf
VOLUME ["/opt/tyk-dashboard"]
WORKDIR /opt/tyk-dashboard

CMD ["/opt/tyk-dashboard/tyk-analytics", "--conf=/opt/tyk-dashboard/tyk_analytics.conf"]

EXPOSE 3000
EXPOSE 5000

FROM ubuntu
RUN apt-get update

RUN apt-get install -y wget curl build-essential python

RUN curl https://packagecloud.io/gpg.key | sudo apt-key add -
RUN apt-get update

RUN apt-get install -y apt-transport-https

RUN echo "deb https://packagecloud.io/tyk/tyk-dashboard/ubuntu/ trusty main" | sudo tee /etc/apt/sources.list.d/tyk_tyk-dashboard.list

RUN echo "deb-src https://packagecloud.io/tyk/tyk-dashboard/ubuntu/ trusty main" | sudo tee -a /etc/apt/sources.list.d/tyk_tyk-dashboard.list

RUN apt-get update

RUN apt-get install -y tyk-dashboard=1.1.0.0

# Install Aglio (API Blueprint) - This is horrible
RUN curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN apt-get install -y nodejs
RUN npm install -g aglio

COPY ./tyk_analytics.with_mongo_and_gateway.conf /opt/tyk-dashboard/tyk_analytics.conf
VOLUME ["/opt/tyk-dashboard"]
WORKDIR /opt/tyk-dashboard

CMD ["/opt/tyk-dashboard/tyk-analytics", "--conf=/opt/tyk-dashboard/tyk_analytics.conf"]

EXPOSE 3000

FROM ubuntu

RUN sudo apt-get install -y wget curl build-essential python

RUN curl https://packagecloud.io/gpg.key | sudo apt-key add -
RUN sudo apt-get update

RUN sudo apt-get install -y apt-transport-https

RUN echo "deb https://packagecloud.io/tyk/tyk-dashboard/ubuntu/ trusty main" | sudo tee /etc/apt/sources.list.d/tyk_tyk-dashboard.list

RUN echo "deb-src https://packagecloud.io/tyk/tyk-dashboard/ubuntu/ trusty main" | sudo tee -a /etc/apt/sources.list.d/tyk_tyk-dashboard.list

sudo apt-get update

sudo apt-get install -y tyk-dashboard

# AWFULL
RUN curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN sudo apt-get install -y nodejs
RUN sudo npm install -g aglio

VOLUME ["/opt/tyk-dashboard"]
WORKDIR /opt/tyk-dashboard

CMD ["./tyk-analytics --conf=/opt/tyk-dashboard/tyk_analytics.conf"]

EXPOSE 3000

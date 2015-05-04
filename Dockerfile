FROM ubuntu

RUN sudo apt-get install -y wget
RUN sudo apt-get install -y curl

# AWFULL
RUN curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN sudo apt-get install -y nodejs

RUN sudo sudo apt-get install -y build-essential
RUN sudo apt-get install -y python
RUN sudo npm install -g aglio

RUN wget https://github.com/lonelycode/tyk/releases/download/1.6/tyk-dashboard-amd64-v0.9.4.2.tar.gz
RUN sudo tar -xvzf tyk-dashboard-amd64-v0.9.4.1.tar.gz -C /opt
RUN sudo mv /opt/tyk-analytics-v0.9.4.1 /opt/tyk-dashboard
COPY tyk_dash_local.conf /opt/tyk-dashboard/tyk_analytics.conf
RUN cd /opt/tyk-dashboard

VOLUME ["/opt/tyk-dashboard"]

WORKDIR /opt/tyk-dashboard

CMD ["./tyk-analytics"]
EXPOSE 3000

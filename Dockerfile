FROM dockerfile/ubuntu
RUN wget https://github.com/lonelycode/tyk/releases/download/1.5/tyk-dashboard-amd64-v0.9.3.tar.gz
RUN sudo tar -xvzf tyk-dashboard-amd64-v0.9.3.tar.gz -C /opt
RUN sudo mv /opt/tyk-analytics-v0.9.3 /opt/tyk-dashboard
RUN cd /opt/tyk-dashboard

VOLUME ["/opt/tyk-dashboard"]

WORKDIR /opt/tyk-dashboard

CMD ["./tyk-analytics"]
EXPOSE 3000
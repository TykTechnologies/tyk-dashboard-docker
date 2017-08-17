Official Tyk Dashboard Docker Build
===================================

This container only contains the Tyk Dashboard, the Tyk Gateway is provided as a seperate
container and needs to be set up and running (with dashboard enabled) before it will work with this
container.

Quickstart
----------

1. Ensure you have set up Redis, Mongo and Tyk Gateway containers

2. Set up the docker instance IP as the dashboard hostname (in your /etc/hosts file or as a DNS):

    127.0.0.1 dashboard.tyk.docker

3. Run the dashboard

	`docker run -d --name tyk_dashboard -p 3000:3000 --link tyk_redis:redis --link tyk_mongo:mongo--link tyk_gateway:tyk_gateway tykio/tyk-dashboard`

4. You should now be able to access your Dashboard at `http://dashboard.tyk.docker:3000/` (note for OSX users, replace 127.0.0.1 with whatever IP address your docker VM runs)

5. Grab the bootstrap script from our tyk-dashboard github repo and run:

    ./bootstrap.sh dashboard.tyk.docker

To use an external configuration files, use the `-v` option to mount
it over `/opt/tyk-dashboard/tyk_analytics.conf`

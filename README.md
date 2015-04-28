Official Tyk Dashboard Docker Build (v0.9.4)
============================================

This container only contains the Tyk Dashboard, the gateway and host manager are provided as seperate containers and need to be configured differently.

Quickstart
----------

1. Ensure you have set up Redis, Mongo and Tyk Gateway

2. Run Tyk Dashboard One-Off Setup:

	`docker run -i --name tyk_dashboard -p 3000:3000 --link tyk_redis:redis --link tyk_gateway:tyk_gateway -v /home/foo/custom.dashboard.conf:/opt/tyk-dashboard/tyk_analytics.conf tykio/tyk-dashboard:v0.9.3 /bin/bash`

3. run the setup command, add the relative users and exit (remember to make note of the organisation ID!):
	
	`./tyk-analytics --neworg --newuser`

4. Kill the container and remove it
	
	`docker stop tyk_dashboard`

5. Run the dashboard

	`docker run -d --name tyk_dashboard -p 3000:3000 --link tyk_redis:redis --link tyk_gateway:tyk_gateway -v /home/foo/custom.dashboard.conf:/opt/tyk-dashboard/tyk_analytics.conf tykio/tyk-dashboard:v0.9.3`

Here we are assuming you are using an externalised mongo instance that is configured in your custom setup file, if you have mongo set up uing docker, you can just link it in using the `--link` option and configure tyk (and analytics) appropriately to use the containerised version.

Included with 0.9.4 are two nginx configuration files ot get the portal up and running.

An example run command with nginx and the portal would be to get the nginx docker container, replace the OrgId tag in the portal.conf file with the Organisation ID you grabbed earlier and then run:

	`docker run --name tyk_nginx -p 8888:80 -v /Users/martinbuhr/src/tykio/tyk_dashboard/sites-enabled:/etc/nginx/sites-enabled:ro -v /Users/martinbuhr/src/tykio/tyk_dashboard/nginx.conf:/etc/nginx/nginx.conf:ro --link tyk_gateway:tyk_gateway --link tyk_dashboard:tyk_dashboard -d nginx`


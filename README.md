Official Tyk Dashboard Docker Build
===================================

This container only contains the Tyk Dashboard, the gateway and host manager are provided as seperate containers and need to be configured differently.

Quickstart
----------

1. Ensure you have set up Redis, Mongo and Tyk Gateway

2. Run Tyk Dashboard One-Off Setup, you'll need to start the container with interactive access:

	`docker run --name tyk_dashboard -p 3000:3000 --link tyk_redis:redis --link tyk_gateway:tyk_gateway --link tyk_mongo:mongo tykio/tyk-dashboard /bin/bash`

3. There won;t be a prompt, just run the setup command, add a user, organisation, organisation slug and then kill the container:
	
	`./tyk-analytics --neworg --newuser`

4. Kill the container and remove it (either via CTRL-C or run the below in another shell)
	
	`docker stop tyk_dashboard`

5. Run the dashboard

	`docker run -d --name tyk_dashboard -p 3000:3000 --link tyk_redis:redis --link tyk_gateway:tyk_gateway tykio/tyk-dashboard`

6. You should now be able to access your Dashbaord at `http://127.0.0.1:3000/` (note for OSX users, replace 127.0.0.1 with whatever IP address your docker VM runs)

This setup assumes that all of the main dependencies are docker containers and makes it eay to link them using the `mongo` and `redis` internal names.

To use an external configuration files, use the `-v` option to mount it over `/opt/tyk-dashboard/tyk_analytics.conf`

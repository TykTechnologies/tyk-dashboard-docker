We would like to deprecate this repo as the release automation builds official images from the repo itself.

If you'd like this repo to keep going, please do describe your use case in an issue and we can work something out.

# ~~Official~~ Tyk Dashboard Docker Build

This container only contains the Tyk Dashboard, the Tyk Gateway is provided as a separate container and needs to be set up and running (with the Dashboard enabled) before it will work with this container.

The following ports are required to be open:

For Redis: 6379
For MongoDB: 27017

# Building a specific version of the dashboard

Assuming you want to build an image called `tykdb`, tagged `test` with version 3.2.1 of the dashboard:

```
% docker build --build-arg=TYKVERSION=3.2.1 -t tykdb:test . 
```

# Quickstart

1. Ensure you have set up Redis, Mongo and Tyk Gateway containers
2. Set up the docker instance IP as the dashboard hostname (in your /etc/hosts file or as a DNS):
    127.0.0.1 dashboard.tyk.docker

3. Run the Dashboard

	`docker run -d --name tyk_dashboard -p 3000:3000 --link tyk_redis:redis --link tyk_mongo:mongo --link tyk_gateway:tyk_gateway tykio/tyk-dashboard`

4. You should now be able to access your Dashboard at `http://dashboard.tyk.docker:3000/` (note for OSX users, replace 127.0.0.1 with whatever IP address your docker VM runs)

5. Enter your Dashboard License. Go to `http://dashboard.tyk.docker:3000/`. You will see a screen asking for a license, enter it in the section marked “**Already have a license?**” and click `Use this license`.

6. Grab the bootstrap script from our [tyk-dashboard github repo](https://github.com/TykTechnologies/tyk-dashboard-docker) and run:

    ./bootstrap.sh dashboard.tyk.docker

To use an external configuration files, use the `-v` option to mount
it over `/opt/tyk-dashboard/tyk_analytics.conf`

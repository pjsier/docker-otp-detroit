# OpenTripPlanner Docker Install - Newark
Docker setup for a Newark OpenTripPlanner instance, including OpenStreetMap and GTFS data

## How to setup (Mac OS X)
Clone the repo, `cd` into it
```
docker-machine create -d virtualbox --virtualbox-memory 8192 newark-otp
eval $(docker-machine env newark-otp)
docker build -t newark-otp .
```

Then, after it finishes, run
`docker run -p 80:8080 newark-otp --autoScan --server`

You can also run with the `--analyst` option to use OTP Analyst features

Open a separate terminal window and run `docker-machine ls` to get the IP address for the container

Now you should be able to access it in your browser at that IP address

In order to add a pointset for analysis, run `docker-machine ssh newark-otp` and
from inside the VM, run `docker ps -a`, get the container id, and run
`docker cp FILENAME CONTAINER-ID:/var/otp/pointsets`

## How to setup (Linux)
Similar to the OSX instructions, but without the extra docker-machine steps at the beginning.
```
docker build -t newark-otp .
docker run -p 80:8080 newark-otp --autoScan --server
```

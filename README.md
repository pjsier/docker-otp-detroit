# OpenTripPlanner Docker Install - Detroit
Docker setup for a Detroit OpenTripPlanner instance, including OpenStreetMap and GTFS data
from the [Detroit Open Data Portal](http://data.detroitmi.gov/).

## How to setup (Mac OS X)
Clone the repo, `cd` into it
```
docker-machine create -d virtualbox --virtualbox-memory 8192 detroit-otp
eval $(docker-machine env detroit-otp)
docker build -t detroit-otp .
```

Then, after it finishes, run
`docker run -p 80:8080 detroit-otp --autoScan --server`

You can also run with the `--analyst` option to use OTP Analyst features

Open a separate terminal window and run `docker-machine ip detroit-otp` to get the IP address for the container

Now you should be able to access it in your browser at that IP address

## How to setup (Linux)
Similar to the OSX instructions, but without the extra docker-machine steps at the beginning.
```
docker build -t detroit-otp .
docker run -p 80:8080 detroit-otp --autoScan --server
```

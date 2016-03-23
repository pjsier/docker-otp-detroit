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
`docker run -p 80:8080 detroit-otp --router detroit --server`

You can also run with the `--analyst` option to use OTP Analyst features

Open a separate terminal window and run `docker-machine ip detroit-otp` to get the IP address for the container

Now you should be able to access it in your browser at that IP address.

## How to setup (Linux)
Similar to the OSX instructions, but without the extra docker-machine steps at the beginning.
```
docker build -t detroit-otp .
docker run -p 80:8080 detroit-otp --router detroit --server
```

## Scripting with Data Volumes

In order to sync data and scripts from your host machine to the Docker container
for the scripting API, you'll need to just add pick a directory on your host machine,
and sync it to `var/otp/scripting` on the container.

Jython has already been added to the classpath by default in the Dockerfile, so it
will be enabled for scripting through either the `--script` or
`--enableScriptingWebService` options.

Example: `docker run -v /host/machine/dir:/var/otp/scripting`

In your script file, if you refer to any synced data (i.e. a population data CSV
for transportation analysis), you'll need to refer to the full file path on the
Docker container and not your host machine.

So if you would run `otp.loadCSVPopulation("/Users/me/test.csv")` in a Jython script,
you would have to change this to `otp.loadCSVPopulation("/var/otp/scripting/test.csv")`.
The same goes for output files, which means that `testCsv.save("/Users/me/test_output.csv")`
would become `testCsv.save("/var/otp/scripting/test_output.csv")`.

The output file will show up in your host machine at the location of the synced volume
as well as in the location in the container.

Here is a full example of running this command against the container:

`docker run -v /Users/me:/var/otp/scripting detroit-otp --router detroit --script /var/otp/scripting/script.py`

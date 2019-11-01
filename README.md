# dmod-docker
This repository contains the docker files and information for running dmod containerized in a cluster.

The docker images are available under `matthiaskoenig/dmod` from https://cloud.docker.com/repository/docker/matthiaskoenig/dmod

## Requirements
For running the docker container install on your target system 
- `docker`: https://docs.docker.com/install/linux/docker-ce/ubuntu/

To check that docker and docker-compose are setup correctly you have to be able to execute the following commands
```bash
docker run hello-world
```

## Start dmod docker container
To get a running dmod system just start a dmod container in detached mode via
```
docker run -p 50001:22 --name dmod -d matthiaskoenig/dmod
```
This will pull the latest dmod container from https://cloud.docker.com/repository/docker/matthiaskoenig/dmod
and start the container. The internal SSH port was mapped to port `50001`.

You can see the dmod container running via
```
docker container ls --all
```
which contains a dmod line
```
CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                              NAMES
d2ee87c9721e        matthiaskoenig/dmod   "/usr/sbin/sshd -D"      3 minutes ago       Up 3 minutes        0.0.0.0:50001->22/tcp              dmod
```

To check that everything is working we start a shell in the container.
```
docker exec -it dmod bash
```

We can now start R and import dmod from within the container (this allows us to check that everything is there)
```
R
> library('dMod')
```
So we have a full dmod system up and running within one line of code.

To stop the container use
```
docker container stop dmod
```

## Build the docker container
To build the dmod image from the `Dockerfile` use
```
docker build -t matthiaskoenig/dmod:latest .
```
This will take quit some time because it has to compile a lot of code.

To not have to build the image every time (which takes very long time due to the compilation) the images are available from the dockerhub at 
This allows simply to pull the image on a new computer without the need for rebuilding.

The images can be pushed to the hub via
```
docker push matthiaskoenig/dmod:latest
```

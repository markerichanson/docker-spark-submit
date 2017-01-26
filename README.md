# docker-spark-submit
Image with which to run spark-submit.  Works with mesos 0.28.0, at least, but expected to for cluster-mode deployment.

* [`2.0.2-2.7`](https://hub.docker.com/r/markerichanson/docker-spark-submit/)

## Pulling
```sh
docker pull markerichanson/docker-spark-submit:2.0.2-2.7 
```

## Building
```sh
$ git clone https://github.com/markerichanson/docker-spark-submit.git

$ docker build -t "markerichanson/docker-spark-submit:2.0.2-2.7" \
--build-arg SPARK_VERSION=2.0.2 \
--build-arg HADOOP_VERSION_MAJOR=2.7 \
--build-arg EXECUTOR_URI_PATH=${ORG_SPECIFIC_RUNTIME_DIR} \
.
```

# docker run parms

## /root/project
The root directory of the files you are working with
```sh
-v $PWD:/root/project
```

# Suggested aliases
The --net="host" is to enable the container to access ports on the host (for ssh tunnels to your cluster, for example).  The address of the host is needed when you issue the spark-submit call.  The address is apparently not consistent across docker hosts.  Try this to get the correct address for your container and change the spark-submit command:
```sh
$ docker run -it --net="host" -v $PWD:/root/project markerichanson/docker-spark-submit:2.0.2-2.7 ip route | awk '/default/{print $3}'
192.168.65.1
```


```sh
# for direct invocation of spark-submit on your command line
alias spark-submit='docker run -it --net="host"-v $PWD:/root/project markerichanson/docker-spark-submit:2.0.2-2.7  spark-submit'
# for a bash session in the spark-client environment, though this isn't likely needed except for debuging the image
alias spark-submit-bash='docker run -it --net="host" -v $PWD:/root/project markerichanson/docker-spark-submit:2.0.2-2.7'
```


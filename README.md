Deploy flink in docker swarm mode

# Preconditions
- You need docker-swarm running on your nodes
- If you don't have an appropriate network on your swarm create it with
`docker network create -d overlay --attachable --scope=swarm flink` (if your network is named differently you have to adjust `deploy.sh`)
- You are on your master node

# Running
Build the images with
`cd worker && docker build -t docker-swarm-flink-worker .`
and
`cd master && docker build -t docker-swarm-flink-master .`


Adjust `deploy.sh` by setting `MASTER_NODE` to the address of your master node

Deploy using `deploy.sh up` 

Remove using `deploy.sh down`

# Notes
- Flink has problems with dockers routing mesh, therefore you have to use `--endpoint-mode dnsrr` in the script and because you cannot to this with `stack deploy` this deploy script is necessary in the first place.
- There are a lot environment variables you can set, but I would recommend to set the garbage collection to G1GC using `deploy.sh --javaopts "-XX:+UseG1GC" up`, because I've encountered some problems using java's default garbage collection.

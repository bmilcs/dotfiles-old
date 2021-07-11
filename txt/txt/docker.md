# bmilcs:docker

## overlay networks

1. create swarm

```sh
# host #1
docker swarm init

# host #2
<paste output command from host #1>
```

2. create network

```sh
# standalone containers & swarm
docker network create -d overlay --attachable nginx

# encrypted
docker network create --opt encrypted --driver overlay --attachable ssl-nginx

```

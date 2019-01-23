# Docker deploy
Deploying as a swarm service.

```bash
# docker stack deploy -c docker-compose.yml dmod
ssh head
sudo ln -s $HOME/.ssh/authorized_keys /data/nfs/authorized_keys

docker service create --name dmod --network host -p "50001:22" -d --replicas 8 --mount type=bind,src="/data/nfs/authorized_keys",dst="/tmp/authorized_keys" --mount type=bind,src="/data/nfs",dst="/root" matthiaskoenig/dmod:latest


docker service create --name dmod --network host -p "50001:22" -d --replicas 3 --mount type=bind,src="/home/mkoenig/.ssh/authorized_keys",dst="/tmp/authorized_keys" matthiaskoenig/dmod:latest



docker service update --force --image matthiaskoenig/dmod:latest dmod_dmod
```

## ansible deploy
Manual deploy via starting docker containers on the various hosts.
```
ansible nodes -m shell -a "mkdir /home/mkoenig/git"
ansible nodes -m shell -a "cd /home/mkoenig && git clone https://github.com/matthiaskoenig/dmod-docker.git"
ansible nodes -m shell -a "cd /home/mkoenig/dmod-docker && git pull"
ansible nodes -m shell -a "cd /home/mkoenig/dmod-docker && docker-compose up -d"
# stop the containers
ansible nodes -m shell -a "docker container rm -f dmod-docker_dmod_1"

ansible nodes -m shell -a "mkdir /home/ubuntu/git"
ansible nodes -m shell -a "cd /home/ubuntu && git clone https://github.com/matthiaskoenig/dmod-docker.git"
ansible nodes -m shell -a "cd /home/ubuntu/dmod-docker && git pull"
ansible nodes -m shell -a "cd /home/ubuntu/dmod-docker && docker-compose up -d"

dmod-docker_dmod_1
```
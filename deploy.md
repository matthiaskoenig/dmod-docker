# Docker deploy
Deploying as a swarm service.

```
# docker stack deploy -c docker-compose.yml dmod

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

ansible nodes -m shell -a "mkdir /home/ubuntu/git"
ansible nodes -m shell -a "cd /home/ubuntu && git clone https://github.com/matthiaskoenig/dmod-docker.git"
ansible nodes -m shell -a "cd /home/ubuntu/dmod-docker && git pull"
ansible nodes -m shell -a "cd /home/ubuntu/dmod-docker && docker-compose up -d"
```
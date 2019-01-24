# Docker deploy
Deploying as a swarm service.

```bash
# The SSH keys are made available by copying the key in the NFS folder
ssh head
sudo mkdir /data/nfs/.ssh
sudo cp $HOME/.ssh/authorized_keys /data/nfs/.ssh/authorized_keys

# Start the service (the service is started on every node once)
docker service create --name dmod \
    --publish published=50001,target=22,protocol=tcp,mode=host \
    --mode global \
    --mount type=bind,src="$HOME/.ssh/authorized_keys",dst="/tmp/authorized_keys" \
    --mount type=bind,src="/data/nfs",dst="/root" \
    matthiaskoenig/dmod:latest


`--mode global`
The service mode determines whether this is a replicated service or a global service. A replicated service runs as many tasks as specified, while a global service runs on each active node in the swarm.



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

## monitoring
- swarm prometheus
https://www.weave.works/blog/swarmprom-prometheus-monitoring-for-docker-swarm
cd git
git clone https://github.com/stefanprodan/swarmprom.git
cd git/swarmprom

ADMIN_USER=admin \
ADMIN_PASSWORD=swarmmon \
SLACK_URL=https://hooks.slack.com/services/TOKEN \
SLACK_CHANNEL=devops-alerts \
SLACK_USER=alertmanager \
docker stack deploy -c docker-compose.yml mon

sudo ufw allow 3000
# Docker deploy
Deploying as a swarm service.

```bash
# The SSH keys are made available by copying the key in the NFS folder
ssh head
sudo mkdir /data/nfs/.ssh
sudo cp /home/ubuntu/.ssh/authorized_keys /data/nfs/.ssh/authorized_keys

# Start the service (number of replicas corresponding to machines) without mesh network
docker service create --name dmod \
    --publish published=50001,target=22,protocol=tcp,mode=host \
    --replicas 8 \
    --mount type=bind,src="/home/ubuntu/.ssh/authorized_keys",dst="/tmp/authorized_keys" \
    --mount type=bind,src="/data/nfs",dst="/root" \
    matthiaskoenig/dmod:latest






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
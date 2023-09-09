SWARM_TOKEN={{SWARM_TOKEN}}
for i in 1 2
do
  # create the node
  docker-machine create \
	--driver amazonec2 \
	--amazonec2-open-port 80 \
	--amazonec2-region us-east-1 \
	aws-worker-$i

# add ubuntu user to `docker` group
docker-machine ssh aws-worker-$i \
  'sudo usermod -a -G docker $USER'
# join the swarm
docker-machine ssh aws-worker-$i \
  "docker swarm join --token $SWARM_TOKEN {{INTERNAL_IP}}:2377"
done
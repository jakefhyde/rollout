#!/bin/bash

INTERVAL=60
DOCKER_IMAGE=$REPO:$VERSION

while true;
do

OLD=$(docker inspect --format='{{index .RepoDigests 0}}' $DOCKER_IMAGE)

docker pull $DOCKER_IMAGE

NEW=$(docker inspect --format='{{index .RepoDigests 0}}' $DOCKER_IMAGE)

if [ "${OLD,,}" == "${NEW,,}" ]; then
    echo "Up to date. Skipping..."
else
    echo "Updating Rancher:${OLD} to ${NEW}"

    kubectl -n $NAMESPACE rollout restart $DEPLOYMENT
fi

sleep $INTERVAL

done

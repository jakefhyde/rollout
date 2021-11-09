#!/bin/bash

kubectl version

kubectl -n $NAMESPACE rollout status deploy/$DEPLOYMENT

OLD=$(crictl inspecti -o go-template --template='{{index .status "repoDigests" 0}}' $IMAGE)

crictl pull $IMAGE

NEW=$(crictl inspecti -o go-template --template='{{index .status "repoDigests" 0}}' $IMAGE)

if [ "${OLD,,}" == "${NEW,,}" ]; then
    echo "Up to date. Skipping..."
else
    echo "Updating $DEPLOYMENT from ${OLD} to ${NEW}"

    kubectl -n $NAMESPACE rollout restart deploy/$DEPLOYMENT
fi

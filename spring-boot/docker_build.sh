#!/bin/bash -e

repository_base=$1
repository_name=$2
version=$3
dockerfile=$4

repository=$repository_base/$repository_name
image=$repository:$version

docker build -f $dockerfile -t $image .
old_images=$(docker image ls $repository -a -q -f before=$image)
if [ -n "$old_images" ]; then
  docker image rm -f $old_images
fi
docker push $image
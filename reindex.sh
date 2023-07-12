#!/bin/sh

set -x

cat datasets/pl_pep*.json | grep -v '^$' | sort | uniq > datasets/pl_peps.entities.ftm.json

docker-compose exec digger yente reindex


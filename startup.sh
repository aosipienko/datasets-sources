#!/bin/sh

set -x

rm datasets/pl_peps.entities.ftm.json

cat datasets/pl_pep*.json | grep -v '^$' | sort | uniq >datasets/pl_peps.entities.ftm.json

docker-compose up -d
docker-compose logs -f --tail 200

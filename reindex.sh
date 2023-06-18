#!/bin/sh

set -x

cat datasets/pl_pep*.json | grep -v '^$' | sort | uniq > datasets/pl_peps.entities.ftm.json
cat datasets/pl_knf_warnings.entities.ftm.json \
    datasets/pl_mswia_sanctions.entities.ftm.json | grep -v '^$' > datasets/pl_sanctions.entities.ftm.json

docker-compose exec digger yente reindex


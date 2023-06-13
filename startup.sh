#!/bin/sh

set -x

cat datasets/pl_pep*.json | grep -v '^$' > datasets/pl_peps.entities.ftm.json
cat datasets/pl_knf_warnings.entities.ftm.json \
    datasets/pl_mswia_sanctions.entities.ftm.json | grep -v '^$' > datasets/pl_sanctions.entities.ftm.json

docker-compose up -d
docker-compose logs -f --tail 200


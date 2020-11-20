#!/bin/bash
PROJECT="Run_caca"
docker run --rm -ti -e MY_CONFIG_NAME=$PROJECT -v $(pwd)/$PROJECT:/opt/croco/$PROJECT --name croco micho/croco /bin/bash
#!/bin/bash
PROJECT="Run_config"

if [ $1 ]
then
    PROJECT=Run_$1
    echo You will create a config named $PROJECT
fi
echo Running Docker...
docker run --rm -ti -e MY_CONFIG_NAME=$PROJECT -v $(pwd)/$PROJECT:/opt/croco/$PROJECT --name croco micho/croco /bin/bash
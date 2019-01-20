#!/bin/bash
export VERSION=6.7.6
docker build . -t docker.io/wkulhanek/sonarqube:${VERSION}
#docker tag docker.io/wkulhanek/sonarqube:${VERSION} docker.io/wkulhanek/sonarqube:latest
docker push docker.io/wkulhanek/sonarqube:${VERSION}
#docker push docker.io/wkulhanek/sonarqube:latest

#!/bin/bash
export VERSION=7.4
docker build -f Dockerfile7 . -t docker.io/wkulhanek/sonarqube:${VERSION}
docker tag docker.io/wkulhanek/sonarqube:${VERSION} docker.io/wkulhanek/sonarqube:latest
docker push docker.io/wkulhanek/sonarqube:${VERSION}
docker push docker.io/wkulhanek/sonarqube:latest

#!/bin/bash
export VERSION=6.7.4
docker build . -t wkulhanek/sonarqube:${VERSION}
#docker tag wkulhanek/sonarqube:${VERSION} wkulhanek/sonarqube:latest
docker push wkulhanek/sonarqube:${VERSION}
#docker push wkulhanek/sonarqube:latest

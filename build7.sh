#!/bin/bash
export VERSION=7.9.1
docker build -f Dockerfile7 . -t quay.io/gpte-devops-automation/sonarqube:${VERSION}
docker tag quay.io/gpte-devops-automation/sonarqube:${VERSION} quay.io/gpte-devops-automation/sonarqube:latest
docker push quay.io/gpte-devops-automation/sonarqube:${VERSION}
docker push quay.io/gpte-devops-automation/sonarqube:latest

# SonarQube on OpenShift
This repo contains all of the resources required to build an OpenShift-specific
Docker image of SonarQube 6.2.

It is inspired by the upstream SonarQube Docker image:
https://github.com/SonarSource/docker-sonarqube/tree/master/5.5

## Quick usage
You can do something like the following, assuming you are in an existing
OpenShift project:

    oc new-app postgresql-persistent \
    --param POSTGRESQL_USER=sonar --param POSTGRESQL_PASSWORD=sonar --param POSTGRESQL_DATABASE=sonar --param VOLUME_CAPACITY=5Gi -lapp=sonarqube_db
    oc new-app docker.io/wkulhanek/sonarqube \
    -e SONARQUBE_JDBC_USERNAME=sonar -e SONARQUBE_JDBC_PASSWORD=sonar -e SONARQUBE_JDBC_URL=jdbc:postgresql://postgresql/sonar
    oc expose service sonarqube

This will result in your OpenShift environment deploying the included PostgreSQL
database with persistent storage and then deploying the SonarQube image directly
from DockerHub.

## Probes
If you want to you can create Readiness and Liveness Probes:

    oc set probe dc/sonarqube --liveness --failure-threshold 3 --initial-delay-seconds 60 -- echo ok
    oc set probe dc/sonarqube --readiness --failure-threshold 3 --initial-delay-seconds 60 --get-url=http://:9000/about

## ToDos
* Write an OpenShift template

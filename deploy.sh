#!/bin/bash
oc new-project wk2-sonarqube
oc new-app mysql-persistent -p MYSQL_DATABASE=sonar -p VOLUME_CAPACITY=4Gi -p MYSQL_USER=sonar -p MYSQL_PASSWORD=sonar
sleep 12
oc new-app wkulhanek/sonarqube:latest -e SONARQUBE_JDBC_USERNAME=sonar -e SONARQUBE_JDBC_PASSWORD=sonar -e SONARQUBE_JDBC_URL=jdbc:mysql://mysql:3306/sonar?useUnicode=true\&characterEncoding=utf8\&rewriteBatchedStatements=true\&useConfigs=maxPerformance\&useSSL=false -lapp=sonarqube

oc expose service sonarqube
oc rollout pause dc sonarqube
echo "apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: sonarqube-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 4Gi" | oc create -f -
oc set volume dc/sonarqube --add --overwrite --name=sonarqube-volume-1 --mount-path=/opt/sonarqube/data/ --type persistentVolumeClaim --claim-name=sonarqube-pvc
oc set probe dc/sonarqube --liveness --failure-threshold 3 --initial-delay-seconds 40 -- echo ok
oc set probe dc/sonarqube --readiness --failure-threshold 3 --initial-delay-seconds 20 --get-url=http://:9000/about
oc set resources dc/sonarqube --limits=memory=3Gi --requests=memory=3Gi
oc set resources dc/sonarqube --limits=cpu=1 --requests=cpu=1
oc patch dc sonarqube --patch='{ "spec": { "strategy": { "type": "Recreate" }}}'
oc rollout resume dc sonarqube

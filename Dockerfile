FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift:latest
MAINTAINER Wolfgang Kulhanek <wkulhane@redhat.com>

ENV SONAR_VERSION=6.6 \
    SONARQUBE_HOME=/opt/sonarqube

USER root
EXPOSE 9000
RUN cd /tmp \
    && curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && cd /opt \
    && unzip /tmp/sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && rm /tmp/sonarqube.zip*
ADD root /

RUN useradd -r sonar \
    && chmod 775 $SONARQUBE_HOME/bin/run_sonarqube.sh \
    && /usr/bin/fix-permissions /opt/sonarqube

USER sonar
WORKDIR $SONARQUBE_HOME
VOLUME $SONARQUBE_HOME/data

ENTRYPOINT ["./bin/run_sonarqube.sh"]

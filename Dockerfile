FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift:latest
MAINTAINER Wolfgang Kulhanek <wkulhane@redhat.com>

ENV SONAR_VERSION=6.3.1 \
    SONARQUBE_HOME=/opt/sonarqube

USER root
EXPOSE 9000
ADD root /
RUN cd /tmp \
    && curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && cd /opt \
    && unzip /tmp/sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && rm /tmp/sonarqube.zip*
COPY run.sh $SONARQUBE_HOME/bin/

RUN useradd -r sonar \
    && /usr/bin/fix-permissions /opt/sonarqube \
    && chmod 775 $SONARQUBE_HOME/bin/run.sh

USER sonar
WORKDIR $SONARQUBE_HOME
ENTRYPOINT ["./bin/run.sh"]

FROM ubuntu:18.04
RUN  apt update \
 &&  apt install -y  openjdk-8-jdk wget unzip \
 &&  wget https://services.gradle.org/distributions/gradle-5.0-bin.zip -P /tmp \
 &&  unzip -d /opt/gradle /tmp/gradle-*.zip

ENV GRADLE_HOME /opt/gradle/gradle-5.0
ENV PATH ${GRADLE_HOME}/bin:${PATH}

ADD ControlCenter.zip /app/

WORKDIR /app

RUN unzip ControlCenter.zip \
 && rm -rf ControlCenter.zip

ADD application.properties /app/src/main/resources/application.properties

RUN gradle clean build

CMD ["gradle", "bootrun"]

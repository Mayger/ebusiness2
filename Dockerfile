FROM openjdk:8

ENV PROJECT_HOME /usr/src
ENV SBT_VERSION 1.1.1

RUN mkdir -p $PROJECT_HOME/activator $PROJECT_HOME/app

WORKDIR $PROJECT_HOME/activator
RUN wget http://downloads.typesafe.com/typesafe-activator/1.3.10/typesafe-activator-1.3.10.zip && \
    unzip typesafe-activator-1.3.10.zip

ENV PATH $PROJECT_HOME/activator/activator-dist-1.3.10/bin:$PATH
ENV PATH $PROJECT_WORKPLACE/build/target/universal/stage/bin:$PATH

COPY . $PROJECT_HOME/app

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion


WORKDIR $PROJECT_HOME/app

EXPOSE 8888



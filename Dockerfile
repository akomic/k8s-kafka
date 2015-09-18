FROM relateiq/oracle-java7

MAINTAINER Alen Komic <akomic@gmail.com>

ENV KAFKA_RELEASE_ARCHIVE kafka_2.10-0.8.1.1.tgz
ENV PATH /kafka/bin:$PATH

RUN \
  mkdir /kafka /data /logs && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates && \
  useradd -d /kafka -s /bin/false -m kafka && \
  chown -R kafka. /kafka

USER kafka

WORKDIR /tmp

RUN \
  wget https://dist.apache.org/repos/dist/release/kafka/0.8.1.1/${KAFKA_RELEASE_ARCHIVE} && \
  tar -zx -C /kafka --strip-components=1 -f ${KAFKA_RELEASE_ARCHIVE} && \
  rm -rf kafka_* && \
  wget http://repo1.maven.org/maven2/org/slf4j/slf4j-log4j12/1.7.6/slf4j-log4j12-1.7.6.jar -P /kafka/libs

COPY config/* /kafka/config/
COPY config-and-run.sh /kafka/

WORKDIR /kafka

EXPOSE 9092 7203

VOLUME [ "/data", "/logs" ]

CMD /kafka/config-and-run.sh

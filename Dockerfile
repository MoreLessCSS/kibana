#Docker default CentosJava image
FROM nimmis/java-centos

MAINTAINER me <me@me.com>
LABEL Description="kibana 5.4"
ENV KIBANA_VERSION=5.4.0 \
    KIBANA_SERVER_PORT=5601 \
    KIBANA_SERVER_HOST="0.0.0.0" \
    KIBANA_SERVER_NAME=kibana1 \
    KIBANA_ES_URL=http://elasticsearch:9200 \
    JAVA_HOME="/usr/java/jre1.8.0_131/" \
    HEAP_SIZE="1g"

WORKDIR /opt

RUN useradd -ms /bin/bash elasticsearch \
        && yum install -y net-tools wget which openssl

RUN cd /opt

RUN curl -L -O https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz \
    && tar -xzf kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz \
    && rm kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz \
    && ln -s kibana-${KIBANA_VERSION}-linux-x86_64 kibana

COPY /config/*.* /opt/kibana/config/

RUN chown -R elasticsearch:elasticsearch /opt/

USER elasticsearch

CMD ["/opt/kibana/bin/kibana"]

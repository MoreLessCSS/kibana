#dockerfile for ES_54 based on Deutsche Bahn vendo-st-docker-prod-local.bahnhub.tech.rz.db.de/vendo-base-image-jre:1.8.0.131
FROM vendo-st-docker-prod-local.bahnhub.tech.rz.db.de/vendo-base-image-jre:1.8.0.131

MAINTAINER Robert Franjkovic <robert.franjkovic@deutschebahn.com>
LABEL Description="kibana 5.4"

ENV KIBANA_VERSION=5.4.0 \
    https_proxy=https://webproxy.aws.db.de:8080 \
    http_proxy=http://webproxy.aws.db.de:8080 \
    KIBANA_SERVER_PORT=5601 \
    KIBANA_SERVER_HOST="0" \
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

COPY /config/*.* /opt/kibana/conig/


RUN chown -R elasticsearch:elasticsearch /opt/

USER elasticsearch

CMD ["/opt/kibana/bin/kibana"]

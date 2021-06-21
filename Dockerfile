FROM openjdk:8-jre-alpine

ENV ACTIVEMQ_VERSION 5.14.3
ENV ACTIVEMQ activemq-all-$ACTIVEMQ_VERSION.jar
ENV ACTIVEMQ_HOME /opt/activemq
COPY ./$ACTIVEMQ $ACTIVEMQ_HOME
RUN apk add --update curl && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /opt && \
    addgroup -S activemq && \
    adduser -S -H -G activemq -h $ACTIVEMQ_HOME activemq && \
    chown -R activemq:activemq /opt/$ACTIVEMQ && \
    chown -h activemq:activemq $ACTIVEMQ_HOME

EXPOSE 1883
EXPOSE 5672
EXPOSE 8161
EXPOSE 61613
EXPOSE 61614
EXPOSE 61616

USER activemq
WORKDIR $ACTIVEMQ_HOME

CMD ["/bin/sh", "-c", "bin/activemq console"]
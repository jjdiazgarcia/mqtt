FROM alpine:3.12.1

LABEL maintainer="Jeronimo Diaz <jeronimo.telec@gmail.com>"

RUN apk update \
    && apk add mosquitto \
    && mkdir -p /mosquitto/data \
    && mkdir -p /mosquitto/config \
    && mkdir -p /mosquitto/log \
    && chown -R mosquitto:mosquitto /mosquitto

COPY config/mosquitto.conf /mosquitto/config

COPY docker-entrypoint.sh /

RUN chown mosquitto:mosquitto /docker-entrypoint.sh && \
    chmod ug+x /docker-entrypoint.sh

USER mosquitto

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]

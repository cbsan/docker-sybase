FROM debian:jessie-slim

LABEL description="Debian Jessie Slim + SQLAnywhere16"
LABEL version="1.0"
LABEL name="Server SQLAnywhere16"

ENV DIR_SQLANY16 /opt/sqlanywhere16
ENV VERSION_SQLANY sa16

RUN apt update \
    && apt install -y \
       ca-certificates \
       git \
    --no-install-recommends --no-install-suggests \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p $DIR_SQLANY16 \
    && ls /opt \
    && git clone -b $VERSION_SQLANY https://github.com/cbsan/server-sqlanywhere.git $DIR_SQLANY16 \
    && chmod a+x /opt/sqlanywhere16/bin64/dbsrv16 \
    && echo "$DIR_SQLANY16/lib64" >> /etc/ld.so.conf.d/sqlanywhere16.conf \
    && ldconfig \
    && apt purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
       git ca-certificates

COPY ./docker-entrypoint.sh /usr/local/bin/
ENV SQLANY_FILE_DB /opt/sqlanywhere16/demo.db

RUN mkdir -p /db

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

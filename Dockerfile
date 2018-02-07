FROM debian:jessie-slim

LABEL description="Debian Jessie Slim + SQLAnywhere16"
LABEL version="1.0"
LABEL name="Server SQLAnywhere16"

ARG SQLANY_PORT=2638
ENV SQLANY_PORT=$SQLANY_PORT

ARG SQLANY_SERVERNAME=demo
ENV SQLANY_SERVERNAME=$SQLANY_SERVERNAME

ARG DIR_SQLANY16=/opt/sqlanywhere16
ENV DIR_SQLANY16=$DIR_SQLANY16

ARG SQLANY_FILE_DB=/opt/sqlanywhere16/demo.db
ENV SQLANY_FILE_DB=$SQLANY_FILE_DB

ARG VERSION_SQLANY=sa16
ENV VERSION_SQLANY=$VERSION_SQLANY

RUN apt update \
    && apt install -y \
       ca-certificates \
       git \
    --no-install-recommends --no-install-suggests \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p $DIR_SQLANY16 \
    && mkdir -p /db \
    && git clone -b $VERSION_SQLANY https://github.com/cbsan/server-sqlanywhere.git $DIR_SQLANY16 \
    && cd $DIR_SQLANY16/lib64 \
    && ln -s ./libdbicu16.so.1 libdbicu16.so \
    && ln -s ./libdbicu16_r.so.1 libdbicu16_r.so \
    && ln -s ./libdbicudt16.so.1 libdbicudt16.so \
    && ln -s ./libdbcis16.so.1 libdbcis16.so \
    && ln -s ./libdbserv16_r.so.1 libdbserv16_r.so \
    && ln -s ./libdbtasks16_r.so.1 libdbtasks16_r.so \
    && ln -s ./libdboftsp_r.so.1 libdboftsp_r.so \
    && ln -s ./libdbodbc16_n.so.1 libdbodbc16_n.so \
    && ln -s ./libdbodbcansi16_r.so.1 libdbodbcansi16_r.so \
    && ln -s ./libdbodm16.so.1 libdbodm16.so \
    && echo "$DIR_SQLANY16/lib64" >> /etc/ld.so.conf.d/sqlanywhere16.conf \
    && ldconfig \
    && chmod a+x /opt/sqlanywhere16/bin64/dbsrv16 \
    && apt purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
       git ca-certificates

COPY ./docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

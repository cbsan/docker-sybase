#!/bin/bash

if [ -z "$SQLANY_PORT"]; then
    echo >&2 'ERROR: Favor informar a porta do servidor "SQLANY_PORT" '
    exit 1
fi

if [ -z "$SQLANY_SERVERNAME"]; then
    echo >&2 'ERROR: Favor informar nome do servidor "SQLANY_SERVERNAME" '
    exit 2
fi

/opt/sqlanywhere16/bin64/dbsrv16 -x "tcpip(ServerPort=$SQLANY_PORT)" -n $SQLANY_SERVERNAME $SQLANY_FILE_DB

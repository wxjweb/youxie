#! /bin/bash

CURDIR=$(cd "$(dirname $0)"; pwd)
TOPDIR=`dirname $(dirname $CURDIR)`

echo $TOPDIR

SQLDIR=$CURDIR
DEFDIR="$CURDIR/default"
COMDIR="$TOPDIR/youxiehaowan/common"

echo $SQLDIR
echo $DEFDIR
echo $COMDIR

export LANG="en_US.UTF-8"

export PGPORT=5432
export PGDATABASE=pipeline
export PGUSER=postgres
export PGPASSWORD=youxie@2018
export PGOPTIONS='--client-min-messages=warning --log_min_messages=warning'

# create database, tables and views for config
psql -q -f $SQLDIR/youxie_data.sql || exit 1

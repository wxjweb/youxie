#! /bin/bash

CURDIR1="$0"
CURDIR2="$(dirname $0)"
CURDIR3=$(cd "$(dirname $0)")
CURDIR4=$(cd "$(dirname $0)"; pwd)

echo $CURDIR1
echo $CURDIR2
echo $CURDIR3
echo $CURDIR4

echo "---1---"

TOPDIR=`dirname $CURDIR4`
TOPDIR1=`dirname $(dirname $CURDIR4)`

echo $TOPDIR
echo $TOPDIR1

echo "---2---"

SQLDIR=$CURDIR4
DEFDIR="$CURDIR4/default"
COMDIR="$TOPDIR1/smacsite/common"



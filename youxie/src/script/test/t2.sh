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

DEST_DIR="/youxie"

if [ ! -d $DEST_DIR ]; then
    echo "---3---"
    mkdir $DEST_DIR
fi

echo "---3---"

if [ "dd$ROOTDIR" == "dd" ]; then
	ROOTDIR=`dirname $(cd "$(dirname $0)"; pwd)`
	echo $ROOTDIR
	echo "1111111"
else
	ROOTDIR=$ROOTDIR
	echo $ROOTDIR
	echo "22222222"
fi

echo "---4---"

CFGDIR1=`cd \`echo $0 | sed -e 's,[^/]*$,,;s,/$,,;s,^$,.,'\`; ${PWDCMD-pwd}`
SRCDIR1=`cd \`echo ${CFGDIR1} | sed -e 's,[^/]*$,,;s,/$,,;s,^$,.,'\`; ${PWDCMD-pwd}`
TOPDIR1=`${PWDCMD-pwd}`

echo $0
echo $CFGDIR1
echo $SRCDIR1
echo $TOPDIR1

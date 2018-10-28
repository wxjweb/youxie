#!/usr/bin/env bash

DSTDIR_DF=/youxie
SYSTEM_DF=x86
SYSTEM_BITS_DF=64
CROSS_HOME_DF=/usr/local/Cavium_Networks/OCTEON-SDK/tools
OSTYPE_DF=LINUX
LINUX_DIR=/usr/src/linux
LINUX_VER=3.10
VENDOR_OID=32328
PYTHON_DIR=/usr/local/anaconda3
PYTHON_INCLUDE=/usr/local/anaconda3/bin/python
PYTHON_CONF=/usr/local/anaconda3/lib/python3.6/config
PYTHON_LIB=/usr/local/anaconda3/lib/libpython3.6m.so

CONFIG_FILE=config.status

readconfig()
{
    OEM_DIR = $SRCDIR/oem
    OEM_INFO = `ls $OEM_DIR | grep -v mk.inf | grep -v oem.mk`

    echo "Please set the OEM [No OEM]:
    $OEM_INFO"

    read OEM
    if [ ${#OEM} -eq 0 ]; then
        OEM=youxie
        echo "No OEM"
        echo ""
    else
        if [ ! -d $OEM_DIR/$OEM ]; then
            echo $OEM not exist;
            exit 1
        fi
        echo "SET OEM to $OEM"
    fi

    #echo "Please set the SYSTEM type [$SYSTEM_DF,or mips64-octeon-linux-gnu]:"
	#read SYSTEM
	#if [ ${#SYSTEM} -eq 0 ]; then
	#	SYSTEM=$SYSTEM_DF
	#	echo "SET SYSTEM type to $SYSTEM"
	#	echo ""
	#fi
    SYSTEM = $SYSTEM_DF

    #echo "Please set the SYSTEM bits [$SYSTEM_BITS_DF,or 32]:"
	#read SYSTEM_BITS
	#if [ ${#SYSTEM_BITS} -eq 0 ]; then
	#	SYSTEM_BITS=$SYSTEM_BITS_DF
	#	echo "SET SYSTEM type to $SYSTEM_BITS"
	#	echo ""
	#fi
    SYSTEM_BITS = $SYSTEM_BITS_DF

    #echo "Do you want running in VM [YES,or NO]:"
	#read READ_VM
	#if [ ${#READ_VM} -eq 0 ]; then
	#	VM=1
	#else
	#	if [ "$READ_VM" = "YES" ]; then
	#		VM=1
	#	else
	#		VM=0
	#	fi
	#fi
	#echo "SET RUNNING IN VM=$VM"
	#echo ""
	VM=0

	echo "Do you want running in DEBUG mode [YES or NO]:"
	read READ_DEBUG
	if [ ${#READ_DEBUG} -eq 0 ]; then
	    DEBUG = 1
    else
        if [ "$READ_DEBUG" = "YES" ]; then
            DEBUG = 1
        else
            DEBUG = 0
        fi
	fi
	echo "SET RUNNING DEBUG MODE=$DEBUG"
	echo ""

    #echo "Please set the SYSTEM kernel dir[$LINUX_DIR]:"
	#read LINUX
	#if [ ${#LINUX} -eq 0 ]; then
	#	LINUX_DIR=$LINUX_DIR
	#	echo "SET kernel dir to $LINUX_DIR"
	#	echo ""
	#else
	#	LINUX_DIR=$LINUX
	#	echo "SET kernel dir to $LINUX_DIR"
	#	echo ""
	#fi

	echo "Please set dest directory, default[$DSTDIR_DF]"
	read DSTDIR
	if [ ${#DSTDIR} -eq 0 ]; then
	    DSTDIR = $DSTDIR_DF
	    echo "SET DSTDIR TO $DSTDIR"
	    echo ""
	fi

    #if [ $SYSTEM != "x86" ]; then
	#	echo "Please set the CROSS_HOME,default[$CROSS_HOME_DF]:"
	#	read CROSS_HOME
	#	if [ ${#CROSS_HOME} -eq 0 ]; then
	#		CROSS_HOME=$CROSS_HOME_DF
	#		echo "SET CROSS_HOME to $CROSS_HOME"
	#		echo ""
	#	fi
	#fi
#	CROSS_HOME=$CROSS_HOME_DF

    #echo "Please set OS TYPE,default[$OSTYPE_DF]:"
	#read OSTYPE
	#if [ ${#OSTYPE} -eq 0 ]; then
	#	OSTYPE=$OSTYPE_DF
	#	echo "SET OSTYPE to $OSTYPE"
	#	echo ""
	#fi
#	OSTYPE=$OSTYPE_DF

}


write_config_file()
{
    if [ $SYSTEM = "x86" ]; then
        cat > $CONFIG_FILE << EOF
        ## Public settings by config ##

        SRCDIR = $SRCDIR
        TOPDIR = $TOPDIR
        DSTDIR = $DSTDIR
        OEM = $OEM
        ARCH= x86
        LINUX_DIR = $LINUX_DIR
        LINUX_VER = $LINUX_VER
        SYSTEM = $SYSTEM
        SYSTEM_BITS = $SYSTEM_BITS
        OSTYPE = $OSTYPE_DF
        VM = $VM
        DEBUG = $DEBUG
        OS_RUNNING_DIR = $DSTDIR
        FLASH_SYSTEM = $DSTDIR/etc/config
        BASE_INCLUDE := $TOPDIR/include
        CROSS_INCLUDE = $SRCDIR/openpkg/x86/include
        CROSS_LIB = $SRCDIR/openpkg/x86/lib
        INCFLAGS := -DSYSTEM_X86

        PYTHON_DIR = $PYTHON_DIR
        PYTHON_INCLUDE = $PYTHON_INCLUDE
        PYTHON_LIB = $PYTHON_LIB

        export SRCDIR TOPDIR DSTDIR OEM OSTYPE CROSS_INCLUDE CROSS_LIB VM DEBUG SYSTEM SYSTEM_BITS OS_RUNNING_DIR FLASH_SYSTEM PYTHON_DIR
EOF
    else
        cat > $CONFIG_FILE << EOF

        ## Public Settings by config ##

        SRCDIR = $SRCDIR
        TOPDIR = $TOPDIR
        DSTDIR = $DSTDIR
        OSTYPE = $OSTYPE
        OEM = $OEM
        VM = $VM
        DEBUG = $DEBUG
        OS_RUNNING_DIR=$DSTDIR
        FLASH_SYSTEM=$DSTDIR/etc/config
        BASE_INCLUDE := $TOPDIR/include
        CROSS_INCLUDE=$SRCDIR/openpkg/mips64/include
        CROSS_LIB=$SRCDIR/openpkg/mips64/lib
        INCFLAGS := -DSYSTEM_MIPS

        PYTHON_DIR=$PYTHON_DIR
        PYTHON_INCLUDE=$PYTHON_INCLUDE
        PYTHON_LIB=$PYTHON_LIB

        ARCH = mips64
        LINUX_DIR = $LINUX_DIR
        LINUX_VER = $LINUX_VER
        SYSTEM = $SYSTEM
        SYSTEM_BITS = $SYSTEM_BITS
        CROSS_HOME = $CROSS_HOME
        MIPS64_HOME = $CROSS_HOME/$SYSTEM
        CROSS_COMPILE = $SYSTEM-
        COMPILER_PREFIX = $SYSTEM-
        PATH=$CROSS_HOME/bin:$PATH

        export SRCDIR TOPDIR DSTDIR OEM OSTYPE LINUX_DIR ARCH SYSTEM CROSS_HOME MIPS64_HOME CROSS_COMPILE COMPILER_PREFIX PATH CROSS_INCLUDE CROSS_LIB VM DEBUG SYSTEM_BITS OS_RUNNING_DIR FLASH_SYSTEM PYTHON_DIR
EOF
    fi
}


if [ "$1" = "-c" ]; then
    # read PUBLIC CONFIG
    readconfig
    # setconfig

    # write config to CONFIG_FILE
    write_config_file

#    ln -sf "$SRCDIR"/config/linux.mak "$TOPDIR"/rules.mak
    exit 0
fi

exit 0


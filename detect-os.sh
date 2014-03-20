#!/bin/bash
#
# A script for detecting the OS of the machine it is running on.
# Borrowed heavily from https://github.com/coto/server-easy-install
#
# Defines following variables:
# OS: $OS
# Distribution: $DIST
# Distribution Based on $DistroBasedOn
# Psuedoname: $PSUEDONAME
# Rev: $REV
# Kernel: $KERNEL
# Machine Arch.: $MACH
#
# v0.1 by bill@wellingtonnet.net

lowercase(){
    echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

detect() {
	OS=`lowercase \`uname\``
	KERNEL=`uname -r`
	MACH=`uname -m`

	if [ "${OS}" = "windowsnt" ]; then
		OS=windows
	elif [ "${OS}" = "darwin" ]; then
		OS=mac
	else
		OS=`uname`
		if [ "${OS}" = "SunOS" ] ; then
			OS=Solaris
			ARCH=`uname -p`
			OSSTR="${OS} ${REV}(${ARCH} `uname -v`)"
		elif [ "${OS}" = "AIX" ] ; then
			OSSTR="${OS} `oslevel` (`oslevel -r`)"
		elif [ "${OS}" = "Linux" ] ; then
			if [ -f /etc/redhat-release ] ; then
				DistroBasedOn='RedHat'
				DIST=`cat /etc/redhat-release |sed s/\ release.*//`
				PSUEDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
				REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
			elif [ -f /etc/SuSE-release ] ; then
				DistroBasedOn='SuSe'
				PSUEDONAME=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
				REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
			elif [ -f /etc/mandrake-release ] ; then
				DistroBasedOn='Mandrake'
				PSUEDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
				REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
			elif [ -f /etc/debian_version ] ; then
				DistroBasedOn='Debian'
				DIST=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
				PSUEDONAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F=  '{ print $2 }'`
				REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }'`
			fi
			if [ -f /etc/UnitedLinux-release ] ; then
				DIST="${DIST}[`cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//`]"
			fi
			OS=`lowercase $OS`
			DistroBasedOn=`lowercase $DistroBasedOn`
			readonly OS
			readonly DIST
			readonly DistroBasedOn
			readonly PSUEDONAME
			readonly REV
			readonly KERNEL
			readonly MACH
		fi

	fi

	# echo 'OS: '$OS
	# echo 'Distribution: '$DIST
	# echo 'Distribution Based on '$DistroBasedOn
	# echo 'Psuedoname: '$PSUEDONAME
	# echo 'Rev: '$REV
	# echo 'Kernel: '$KERNEL
	# echo 'Machine Arch.: '$MACH
}

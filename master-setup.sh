#!/bin/bash
#
# puppet-master-setup
#
# This is a bootstrap for getting anew master up and running
# using the setup at Fulcrum Technologies Inc.
#
# 2014-03-07 bwellington@fulcrum.net
#
# This is the shell script that does all the work.
#

# let's set some variables

# $DIST comes from the detect-os script
source detect-os.sh
detect

# and these variables will be necessary as well
PUPPET_VER='3.2.1'
PUPPET_URL="https://s3.amazonaws.com/pe-builds/released/${PUPPET_VER}"

if [ "${DIST}" = "Ubuntu" ]; then
	TARBALL="puppet-enterprise-${PUPPET_VER}-ubuntu-12.04-amd64.tar.gz"
	DOWNLOAD_DIR='/root'
	DEST_DIR="puppet-enterprise-${PUPPET_VER}-ubuntu-12.04-amd64"

elif [ "${DIST}" = "CentOS" ]; then
	TARBALL="puppet-enterprise-${PUPPET_VER}-el-6-x86_64.tar.gz"
	DOWNLOAD_DIR='/root/Downloads'
	DEST_DIR="puppet-enterprise-${PUPPET_VER}-el-6-x86_64"

else
	echo "Sorry, this script only works for Ubuntu and CentOS."
	exit
fi


# okay, let's get to work!
echo "Downloading Puppet Enterprise for ${DIST}."

#curl "${PUPPET_URL}/${TARBALL}" -o "${DOWNLOAD_DIR}/${TARBALL}"

#tar -xzf "${DOWNLOAD_DIR}/${TARBALL}" -C "${DOWNLOAD_DIR}"

$DOWNLOAD_DIR/$DEST_DIR/puppet-enterprise-installer -a $PWD/answerfile.txt

puppet module install zack/r10k

FACTER_hierapath=$PWD puppet apply $PWD/master-setup.pp

r10k deploy environment -pv

FACTER_app_env=prod puppet apply -e "include roles::puppet_master"


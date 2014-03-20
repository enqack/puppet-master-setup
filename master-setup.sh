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


# Get some more variables from the detect function
source detect-os.sh
detect

# let's set some more variables
PUPPET_URL="https://s3.amazonaws.com/pe-builds/released/3.2.1"

if [ "${OS}" = "linux" + "${DIST}" = "Ubuntu"]; then
	TARBALL='puppet-enterprise-3.2.1-ubuntu-12.04-amd64.tar.gz'
	DOWNLOAD_DIR='/home/local_admin/'
	DEST_DIR='puppet-enterprise-3.2.1-ubuntu-12.04-amd64.tar.gz'

elif [ "${OS}" = "linux" + "${DIST}" = "CentOS"]
	TARBALL='puppet-enterprise-3.2.1-el-6-x86_64.tar.gz'
	DOWNLOAD_DIR='/root/Downloads'
	DEST_DIR='puppet-enterprise-3.2.1-el-6-x86_64'

else
	echo "Sorry, this script only works for Ubuntu and CentOS."
fi


# okay, let's get to work!
curl "${PUPPET_URL}/${TARBALL}" -o "${DOWNLOAD_DIR}/${TARBALL}"

tar -xzf "${DOWNLOAD_DIR}/${TARBALL}" -C "${DOWNLOAD_DIR}"

$DOWNLOAD_DIR/$DEST_DIR/puppet-enterprise-installer -a $PWD/answerfile.txt

puppet module install zack/r10k

FACTER_hierapath=$PWD puppet apply $PWD/master-setup.pp

r10k deploy environment -pv

FACTER_app_env=prod puppet apply -e "include roles::puppet_master"

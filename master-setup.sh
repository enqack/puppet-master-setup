#!/bin/bash
#
#

# lets set some variables
PUPPET_URL="https://s3.amazonaws.com/pe-builds/released/3.2.0"
TARBALL='puppet-enterprise-3.2.0-el-6-x86_64.tar.gz'
DOWNLOAD_DIR='/root/Downloads'
DEST_DIR='puppet-enterprise-3.2.0-el-6-x86_64'


# okay, lets get to work!
curl "${PUPPET_URL}/${TARBALL}" -o "${DOWNLOAD_DIR}/${TARBALL}"

tar -xzf "${DOWNLOAD_DIR}/${TARBALL}" -C "${DOWNLOAD_DIR}"

$DOWNLOAD_DIR/$DEST_DIR/puppet-enterprise-installer -a $PWD/answerfile.txt

puppet module install zack/r10k

FACTER_hierapath=$PWD puppet apply $PWD/master-setup.pp

r10k deploy environment -pv

FACTER_app_env=prod puppet apply -e "include roles::puppet_master"
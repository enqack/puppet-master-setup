#!/bin/bash

curl https://s3.amazonaws.com/pe-builds/released/3.2.0/puppet-enterprise-3.2.0-el-6-x86_64.tar.gz -o /root/Downloads/puppet-enterprise-3.2.0-el-6-x86_64.tar.gz

tar -xzf /root/Downloads/puppet-enterprise-3.2.0-el-6-x86_64.tar.gz

/root/Downloads/puppet-enterprise-3.2.0-el-6-x86_64/puppet-enterprise-installer -a /root/puppet-master-setup/answerfile.txt

puppet module install zack/r10k

puppet apply /root/puppet-master-setup/master-setup.pp
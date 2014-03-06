puppet-master-setup
===================

Takes a mint CentOS box and turns it into a puppet master, using Fulcrum's repositories.

1. Set hostname: `vi /etc/sysconfig/network`
2. create entry for hostname in /etc/hosts
3. reboot
4. `yum git install`
5. clone this repo
6. run setup-master.sh

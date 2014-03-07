puppet-master-setup
===================

Takes a fresh CentOS box and turns it into a puppet master, using Fulcrum's repositories.

##Manual Steps
1. Set hostname: `vi /etc/sysconfig/network`
2. create entry for hostname in /etc/hosts:  `<ip_address> <fqdn>`
3. reboot
4. Install git: `yum git install`
5. clone this repo to the new machine `[ git clone git@github.com:FulcrumIT/puppet-master-setup.git | git clone https://github.com/FulcrumIT/puppet-master-setup.git ]` (You will either need to generate and ssh-key and provide it to github, or use your git credentials to get this repo, and the others that this will pull down.)
6. run `./setup-master.sh`

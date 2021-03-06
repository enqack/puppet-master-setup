# puppet-master-setup
#
# This is a bootstrap for getting anew master up and running
# using the setup at Fulcrum Technologies Inc.
#
# 2014-03-07 bwellington@fulcrum.net
#
# This file is the puppet manifest to setup r10k, and eyaml on the new system.
#

class { 'r10k':
  version           => '1.1.4',
  sources           => {
    'puppet' => {
      'remote'  => 'git@github.com:FulcrumIT/puppet-environments.git',
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => false,
    },
    'hiera' => {
      'remote'  => 'git@github.com:FulcrumIT/puppet-hieradata.git',
      'basedir' => '/etc/puppetlabs/puppet/hieradata',
      'prefix'  => false,
    }
  },
  purgedirs         => ["${::settings::confdir}/environments"],
  manage_modulepath => true,
  modulepath        => "${::settings::confdir}/environments/\$environment/modules:/opt/puppet/share/puppet/modules",
}

package {'hiera-eyaml':
  ensure => present,
  provider => 'pe_gem',
}

# ::hierapath is passed in by master-setup.sh - the only way this .pp should ever be called
file {'/etc/puppetlabs/puppet/hiera.yaml':
  ensure => file,
  source => "${::hierapath}/hiera.yaml",
}

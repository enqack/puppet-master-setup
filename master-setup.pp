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

file {'/etc/puppetlabs/puppet/hiera.yaml':
  ensure => file
  source => '/root/puppet-master-setup/hiera.yaml'
}
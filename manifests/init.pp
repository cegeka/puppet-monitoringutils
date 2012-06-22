# Class: monitoringutils
#
# This module manages monitoringutils
# include it to install handy monitoring like scripts
#
# Sample Usage:
# class { 'monitoringutils':
#    scriptpath => '/usr/local/scripts',
# }
#
class monitoringutils($scriptpath = '/usr/local/scripts') {
  file { $scriptpath:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  file { "${scriptpath}/fsck-ro.sh":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    source  => "puppet:///modules/${module_name}/fsck-ro.sh",
    require => File[$scriptpath],
  }
  file { "${scriptpath}/fsck-ro.rb":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    source  => "puppet:///modules/${module_name}/fsck-ro.rb",
    require => File[$scriptpath],
  }
}

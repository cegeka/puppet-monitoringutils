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

  @file { 'fsck-ro.rb':
    ensure  => present,
    path    => "${scriptpath}/fsck-ro.rb",
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    source  => "puppet:///modules/${module_name}/fsck-ro.rb",
    require => File[$scriptpath],
  }

  @file { 'appserver-threads-mon.sh':
    ensure  => present,
    path    => "${scriptpath}/appserver-threads-mon.sh",
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    source  => "puppet:///modules/${module_name}/appserver-threads-mon.sh",
    require => File[$scriptpath],
  }

  @file { 'scriptura-threads-mon.sh':
    ensure  => present,
    path    => "${scriptpath}/scriptura-threads-mon.sh",
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    source  => "puppet:///modules/${module_name}/scriptura-threads-mon.sh",
    require => File[$scriptpath],
  }

  @file { 'activemq-failover-mon.sh':
    ensure  => present,
    path    => "${scriptpath}/activemq-failover-mon.sh",
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    source  => "puppet:///modules/${module_name}/activemq-failover-mon.sh",
    require => File[$scriptpath],
  }
}

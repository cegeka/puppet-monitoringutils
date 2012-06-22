# Class: monitoringutils
#
# This module manages monitoringutils
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class monitoringutils($scriptpath = '/usr/local/scripts') {
  file { $scriptpath:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  file { 'fsck-ro.sh':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    path    => "${scriptpath}/fsck-ro.sh",
    source  => 'puppet:///monitoringutils/fsck-ro.sh',
    require => File[$scriptpath],
  }
  file { 'fsck-ro.rb':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    path    => "${scriptpath}/fsck-ro.rb",
    source  => 'puppet:///monitoringutils/fsck-ro.rb',
    require => File[$scriptpath],
  }
}

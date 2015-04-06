# == Class: dmesgs
#
# Full description of class dmesgs here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'dmesgs':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Sebastian Reitenbach <sebastia@l00-bugdead-prods.de>
#
# === Copyright
#
# Copyright 2015 Sebastian Reitenbach, unless otherwise noted.
#
class dmesgs (
  $webroot = '/var/www/htdocs',
  $webdir  = 'dmesg',
  $webdirowner = 'nobody',
  $aliases_file = '/etc/aliases',
  $dmesg_alias = 'dmesg',
  $ensure  = 'present',
  $script  = '/usr/bin/process_dmesgs.sh',
){

  file { $script:
    owner   => 'root',
    group   => '0',
    mode    => '0755',
    content => template("${module_name}/dmesgs.sh.erb"),
  }

  file { "${$webroot}/${webdir}":
    ensure => 'directory',
    owner  => $webdirowner,
  }

  mailalias { $dmesg_alias:
    recipient => "|${script}",
    target    => $aliases_file,
  }

}

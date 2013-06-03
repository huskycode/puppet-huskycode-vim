# == Class: vim
#
# Full description of class vim here.
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
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { vim:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class huskycode-vim( $user, $home_dir ) {
  include wget 
 
  package { 'vim':
    ensure => installed
  }
  file { ["${home_dir}/.vim/autoload","${home_dir}/.vim/bundle"] : 
    ensure => "directory",
    owner => $user
  }
  wget::fetch { "DownloadPathogen":
    source => "https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim",
    destination => "${home_dir}/.vim/autoload/pathogen.vim",
    verbose => true 
  }
  file { "${home_dir}/.vim/autoload/pathogen.vim":
    owner => $user
  }
  file { "${home_dir}/.vimrc": 
    owner => $user,
    content => "execute pathogen#infect()\nsyntax on"
  }
  package { 'git': 
    ensure => installed,  
  }

  Package['vim'] -> File["${home_dir}/.vim/autoload","${home_dir}/.vim/bundle"] -> Wget::Fetch["DownloadPathogen"] -> File["${home_dir}/.vim/autoload/pathogen.vim"] -> File["${home_dir}/.vimrc"]

}

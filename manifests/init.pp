class vim($user, $home_dir) {
  include wget 

  case $operatingsystem {
    CentOS,RedHat: { $vim_package = 'vim-enhanced' }
    default: { $vim_package = 'vim' }
  }

  package { 'vim':
    name   => $vim_package,
    ensure => installed,
  }

  file { ["${home_dir}/.vim","${home_dir}/.vim/autoload","${home_dir}/.vim/bundle"] : 
    ensure => "directory",
    owner  => $user
  }

  wget::fetch { "DownloadPathogen":
    source      => "https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim",
    destination => "${home_dir}/.vim/autoload/pathogen.vim",
    verbose     => true
  }

  file { "${home_dir}/.vim/autoload/pathogen.vim":
    owner => $user
  }

  file { "${home_dir}/.vimrc": 
    owner   => $user,
    content => "execute pathogen#infect()\ncall pathogen#helptags()"
  }

  Package['vim'] 
  -> File["${home_dir}/.vim", "${home_dir}/.vim/autoload","${home_dir}/.vim/bundle"] 
  -> Wget::Fetch["DownloadPathogen"] 
  -> File["${home_dir}/.vim/autoload/pathogen.vim"] 
  -> File["${home_dir}/.vimrc"]

}

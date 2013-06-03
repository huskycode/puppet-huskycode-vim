class huskycode-vim( $user, $home_dir, $plugin1="NONE", $plugin1_name="NONE") {
  include wget 
 
  package { 'vim':
    ensure => installed
  }
  file { ["${home_dir}/.vim","${home_dir}/.vim/autoload","${home_dir}/.vim/bundle"] : 
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
  
  if $plugin1 != "NONE" and $plugin1_name != "NONE" {
    vcsrepo { "${home_dir}/.vim/bundle/${plugin1_name}": 
      ensure => present,
      provider => git,
      user => $user, 
      source => $plugin1
   }
  } 


  Package['vim'] -> File["${home_dir}/.vim", "${home_dir}/.vim/autoload","${home_dir}/.vim/bundle"] -> Wget::Fetch["DownloadPathogen"] -> File["${home_dir}/.vim/autoload/pathogen.vim"] -> File["${home_dir}/.vimrc"]

}

define vim::plugin ($source) {
  $user = $::id ? {
    $vim::user => undef,
    default    => $vim::user,
  }
  vcsrepo { "${vim::home_dir}/.vim/bundle/${name}": 
    ensure   => present,
    provider => git,
    user     => $user,
    source   => $source,
  }
}

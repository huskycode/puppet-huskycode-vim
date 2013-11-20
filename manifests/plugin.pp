define vim::plugin ($source) {
  $user = inline_template('<%= ENV["USER"] %>') ? {
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

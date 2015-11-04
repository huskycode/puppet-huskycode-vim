define vim::plugin ($source, $ensure=present) {
  vcsrepo { "${vim::home_dir}/.vim/bundle/${name}":
    ensure   => $ensure,
    provider => git,
    user     => $vim::user,
    source   => $source,
  }
}

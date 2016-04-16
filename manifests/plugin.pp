define vim::plugin ($source, $ensure=present) {
  # See https://tickets.puppetlabs.com/browse/MODULES-731
  # ensure => absent runs every time and says
  # Notice: /Stage[main]/Profile::Root::Vim/Amantes::Vim[root]/Vim::Plugin[root:vim-session]/Vcsrepo[/root/.vim/bundle/vim-session]/ensure: created
  # wrap it in an if instead
  if $ensure != 'absent' {
    vcsrepo { "${vim::home_dir}/.vim/bundle/${name}":
      ensure   => $ensure,
      provider => git,
      user     => $vim::user,
      source   => $source,
    }
  } else {
    file { "${vim::home_dir}/.vim/bundle/${name}":
      ensure => absent
    }
  }
}

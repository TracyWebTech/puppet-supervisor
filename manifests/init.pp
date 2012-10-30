class supervisor {
  package { "supervisor":
    ensure => installed,
  }

  service { "supervisor":
    ensure  => running,
    enable  => true,
    require => Package['supervisor'],
    stop    => '/etc/init.d/supervisord stop',
    start   => '/etc/init.d/supervisord start',
    restart => 'supervisorctl update',
  }

  file { '/etc/supervisor/conf.d/':
    ensure  => directory,
    recurse => true,
    purge   => true,
    notify  => Service['supervisor'],
    require => Package['supervisor']
  }
}

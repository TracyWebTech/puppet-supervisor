class supervisor {
  package { "supervisor":
    ensure => installed,
  }

  service { "supervisor":
    ensure  => running,
    enable  => true,
    require => Package['supervisor'],
    stop    => 'test -e /etc/init.d/supervisord && /etc/init.d/supervisord stop || /etc/init.d/supervisor stop',
    start   => 'test -e /etc/init.d/supervisord && /etc/init.d/supervisord start || /etc/init.d/supervisor start',
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

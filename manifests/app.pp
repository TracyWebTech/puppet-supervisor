define supervisor::app (
  $app_name = $title,
  $command,
  $directory,
  $user = 'root',
  $numprocs = undef,
  $startsecs = undef,
  $stopwaitsecs = undef,
  $priority = undef,
  $environment = undef,
  $stopsignal = undef,
  $stopasgroup = undef,
  $killasgroup = undef,
  $additional_options = {},
) {

  $conf_file = "supervisor_${app_name}"
  $service_name = $conf_file

  file { $conf_file:
    path    => "/etc/supervisor/conf.d/${app_name}.conf",
    ensure  => present,
    content => template('supervisor/supervisor.conf.erb'),
    require => Pip::Install['supervisor'],
    notify  => Service['supervisord'],
  }

  service { $service_name:
    ensure     => running,
    path       =>  ['/usr/bin'],
    start      => "supervisorctl start $app_name",
    restart    => "supervisorctl restart $app_name",
    stop       => "supervisorctl stop $app_name",
    status     => "supervisorctl status | awk '/^${name}[: ]/{print \$2}' | grep '^RUNNING$'",
    subscribe  => File[$conf_file],
    hasrestart => false,
    hasstatus  => false,
    provider   => base
  }
}

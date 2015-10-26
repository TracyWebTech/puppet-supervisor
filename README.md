Puppet Supervisor
=================

Install and manage apps in supervisord


Usage
=================

Include supervisor class
```puppet
include supervisor
```

Install your app using defined type supervisor::app

```puppet
supervisor::app { 'your-app-title':
  app_name     => 'your-app-name' # Defaults to 'your-app-title',
  command      => 'The command that will be run this app', # required
  directory    => 'Path where your command will be run', # required
  user         => 'User to execute this app', # Defaults to root
  environment  => 'Hash map of environment variables to be used by your program', # Defaults to undef
  numprocs     => 'Number of processes to start', # Defaults to undef
  startsecs    => 'The total number of seconds which the program needs to stay running after a startup to consider the start successful', # Defaults to undef
  stopwaitsecs => 'The number of seconds to wait for the OS to return a SIGCHILD to supervisord after the program has been sent a stopsignal', # Defaults to undef
  priority     => 'The relative priority of the program in the start and shutdown ordering', # Defaults to undef
  stopsignal   => 'The signal used to kill the program when a stop is requested. This can be any of TERM, HUP, INT, QUIT, KILL, USR1, or USR2.', # Defaults to undef
}
```

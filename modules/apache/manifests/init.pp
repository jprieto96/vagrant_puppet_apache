class apache {

  exec { 'apt-update':
    command => '/usr/bin/apt-get update'
  }
  Exec["apt-update"] -> Package <| |>

  package { 'apache2':
    ensure => installed
  }

  file { 'Remove index.html to be able to show wordpress blog':
    path => "/var/www/html/index.html",
    ensure => absent,
    require => Package['apache2']
  }

  service { 'apache2':
    ensure => running,
    enable => true,
    hasstatus  => true,
    restart => "/usr/sbin/apachectl configtest && /usr/sbin/service apache2 reload",
    require => File['Remove index.html to be able to show wordpress blog']
  }

  notify {'apache2 installed':
    message => "apache2 package installed and running",
    require => Service['apache2']
  }
  
}

class phpmysql {

  package { ['mysql-server', 'php8.1', 'libapache2-mod-php8.1', 'php-mysql']:
    ensure => installed
  }

  service { 'mysql service is up':
    name => 'mysql',
    ensure  => true,
    enable  => true,
    require => Package[['php8.1', 'mysql-server', 'libapache2-mod-php8.1', 'php-mysql']],
    restart => "service mysql reload",
    path => ['/usr/sbin/']
  }

  exec { "set-mysql-password":
    unless => "mysqladmin -u root -p root status",
    command => "mysqladmin -u root password root",
    require => Service["mysql service is up"],
    path => ['/bin']
  }

  file { 'copy sql file': 
    path => "${document_root}/script.sql",
    ensure  => present,
    content => template('phpmysql/script.sql.erb'),
    require => Exec['set-mysql-password']
  }

  exec { 'run sql file':
    command => "mysql -h localhost -u root -D mysql < ${document_root}/script.sql",
    require => File["copy sql file"],
    path => ['/bin']
  }

  notify {'php and mysql server installed':
    message => "php and mysql server installed"
  }

}

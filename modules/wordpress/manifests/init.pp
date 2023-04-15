class wordpress {

  exec { 'download wordpress':
    command => "wget https://wordpress.org/wordpress-6.2.tar.gz",
    cwd => $document_root,
    path => ['/bin']
  }

  exec { "extract wordpress": 
    command => "tar -xvzf ${document_root}/wordpress-6.2.tar.gz",
    cwd => $document_root,
    path => ['/bin'],
    require => Exec['download wordpress']
  }

  file { 'copy wp-config': 
    path => "${document_root}/wordpress/wp-config.php",
    ensure  => present,
    content => template('wordpress/wp-config.php.erb'),
    require => Exec["extract wordpress"]
  }

  # Copy to /var/www/html
  exec { 'copy wordpress folder':
    command => "cp -r ${document_root}/wordpress/* /var/www/html",
    path => ['/bin'],
    require => File['copy wp-config']
  }

  # Reload apache server again
  exec { 'restart apache2 service':
    command => 'systemctl reload apache2',
    path => ['/bin'],
    require => Package['apache2']
  }

  # ----------------------------------------------------------------------

  # Install wordpress

  # create files directory
  file { 'create files directory in wordpress module':
    path => "${document_root}/modules/wordpress/files",
    ensure => 'directory',
    require => Exec['copy wordpress folder']
  }

  # First step: install wordpress CLI
  exec { 'download wp-cli.phar':
    command => "curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar",
    cwd => "${document_root}/modules/wordpress/files",
    path => ['/bin'],
    require => File['create files directory in wordpress module']
  }

  file { 'copy wp cli to be able to use ir as a command':
    path => "/bin/wp",
    ensure  => present,
    source => "${document_root}/modules/wordpress/files/wp-cli.phar",
    owner => 'vagrant',
    group => 'vagrant',
    mode => "u+x",
    require => Exec['download wp-cli.phar']
  }

  # Second step: install wordpress

  exec { 'install wordpress':
    command => "wp core install --url=localhost:8080 --title='Jose Prieto' --admin_user=admin --admin_password=root --admin_email=joseprieto9657@gmail.com --allow-root --path=/var/www/html",
    path => ['/bin'],
    require => File['copy wp cli to be able to use ir as a command'],
  }

  notify {'wordpress installed':
    message => "wordpress installed"
  }

}

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

  notify {'restart apache2 service':
    message => "wordpress installed",
    require => Exec['restart apache2 service']
  }

}

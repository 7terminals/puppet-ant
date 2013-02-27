define ant::setup ($source = undef, $deploymentdir = undef, $user = undef, $cachedir = "/var/lib/puppet/working-ant-${name}") {
  # working directory to untar ant
  file { $cachedir:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '644',
  }

  # resource defaults for Exec
  Exec {
    path => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'], }

  file { "${cachedir}/${source}":
    source  => "puppet:///modules/${caller_module_name}/${source}",
    require => File[$cachedir],
  }

  exec { "extract_ant-${name}":
    cwd     => $cachedir,
    command => "mkdir extracted; tar -C extracted -xzf ${source} && touch .ant_extracted",
    creates => "${cachedir}/.ant_extracted",
    require => File["${cachedir}/${source}"],
  }

  exec { "create_target_ant-${name}":
    cwd     => '/',
    command => "mkdir -p ${deploymentdir}",
    creates => $deploymentdir,
    require => Exec["extract_ant-${name}"],
  }

  exec { "move_ant-${name}":
    cwd     => $cachedir,
    command => "cp -r extracted/apache-ant*/* ${deploymentdir} && chown -R ${user}:${user} ${deploymentdir}",
    creates => "${deploymentdir}/bin/ant",
    require => Exec["create_target_ant-${name}"],
  }
}

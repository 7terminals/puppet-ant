define ant::setup (
  $source        = undef,
  $deploymentdir = undef,
  $user          = undef,
  $pathfile      = '/etc/bashrc',
  $cachedir      = "/var/lib/puppet/working-ant-${name}",
  $ensure        = 'present') {
  # we support only Debian and RedHat
  case $::osfamily {
    Debian  : { $supported = true }
    RedHat  : { $supported = true }
    default : { fail("The ${module_name} module is not supported on ${::osfamily} based systems") }
  }

  # validate parameters

  if ($source == undef) {
    fail('source parameter must be set')
  }

  if ($deploymentdir == undef) {
    fail('deploymentdir parameter must be set')
  }

  if ($user == undef) {
    fail('user parameter must be set')
  }

  if !($ensure in ['absent', 'present']) {
    fail('ensure parameter must be either absent or present')
  }
  

  if ($caller_module_name == undef) {
    $mod_name = $module_name
  } else {
    $mod_name = $caller_module_name
  }

  if ($ensure == 'present') {
    # working directory to untar ant
    file { $cachedir:
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '644',
    }

    # resource defaults for Exec
    Exec {
      path => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
    }

    file { "${cachedir}/${source}":
      source  => "puppet:///modules/${mod_name}/${source}",
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

    exec { "update_path-${name}":
      cwd     => '/',
      command => "echo 'export PATH=\$PATH:${deploymentdir}/bin' >> ${pathfile}",
      unless  => "grep 'export PATH=\$PATH:${deploymentdir}/bin' ${pathfile}",
      require => Exec["move_ant-${name}"],
    }
  } else {
    file { $deploymentdir:
      ensure  => 'absent',
      recurse => true,
      force   => true,
    }

    file { $cachedir:
      ensure  => 'absent',
      recurse => true,
      force   => true,
    }
  }
}


ant::setup { "ant":
  source        => "apache-ant-1.9.0-bin.tar.gz",
  deploymentdir => "/home/jude/ant",
  user          => "jude",
  pathfile      => '/home/jude/.bashrc',
  cachedir      => "/var/lib/puppet/working-ant-${name}",
  ensure        => 'present'
}


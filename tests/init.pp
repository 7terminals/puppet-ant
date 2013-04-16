
ant::setup { "ant":
  source        => "apache-ant-1.9.0-bin.tar.gz",
  deploymentdir => "/root/ant",
  user          => "root",
  pathfile      => '/root/.bashrc',
  ensure        => 'present'
}


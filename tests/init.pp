
ant::setup { 'ant':
  ensure        => 'present',
  source        => 'apache-ant-1.9.0-bin.tar.gz',
  deploymentdir => '/root/ant',
  user          => 'root',
  pathfile      => '/root/.bashrc',
}

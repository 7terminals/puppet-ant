# Class: ant
#
# The Apache Ant module allows Puppet to install ant and update the bashrc file to include ant in the path.
#
# Parameters: ensure, source, deploymentdir, user, pathfile
#
# Sample Usage:
#    ant::setup { "example.com-ant":
#      ensure        => 'present',
#      source        => 'apache-ant-1.9.0-bin.tar.gz',
#      deploymentdir => '/home/example.com/apps/apache-ant',
#      user          => 'example.com',
#      pathfile      => '/home/example.com/.bashrc'
#    }
class ant {

}

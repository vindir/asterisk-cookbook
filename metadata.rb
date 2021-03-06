name             'asterisk'
maintainer       'Mojo Lingo'
maintainer_email 'ops@mojolingo.com'
license          'Apache 2.0'
description      'Installs/Configures Asterisk'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.6'

recipe 'asterisk', 'Install Asterisk and configure'
recipe 'asterisk::unimrcp', 'Install Asterisk UniMRCP plugin and configure'

depends 'apt', '~> 2.2'

supports 'debian', '>= 7.1'
supports 'ubuntu', '>= 10.04'

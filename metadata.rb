name              'COOKBOOK_NAME'
maintainer        'Jonathan Hartman'
maintainer_email  'j@p4nt5.com'
license           'Apache v2.0'
description       'COOKBOOK_DESCRIPTION'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.0.0'

depends           'COOKBOOK'

supports          'redhat', '>= 5.0'
supports          'centos', '>= 5.0'
supports          'scientific', '>= 5.0'
supports          'amazon', '>= 5.0'
supports          'ubuntu', '>= 12.04'

# vim: ai et ts=2 sts=2 sw=2 ft=ruby

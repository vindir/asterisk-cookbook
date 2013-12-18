default['asterisk']['source']['packages'] = %w{build-essential libssl-dev libcurl4-openssl-dev libncurses5-dev libnewt-dev libxml2-dev libsqlite3-dev uuid-dev}
default['asterisk']['source']['version']  = '11-current'
default['asterisk']['source']['checksum'] = nil

# An full download url can be supplied to specify an alternative source tarball location
default['asterisk']['source']['url'] = nil

# Should the sample config files be installed?
default['asterisk']['source']['install_samples'] = true

# Default attributes for hammock cookbook.
# 2015-10-05 ~elw 

default['hammock']['install_type'] = "git" # git | file
default['hammock']['git']['url'] = "https://github.com/tinyspeck/hammock"
default['hammock']['git']['branch'] = "master"
default['hammock']['git']['type'] = "sync" # checkout | sync
default['hammock']['file']['type'] = "zip" # zip
default['hammock']['file']['version'] = '0.0.1'

default['hammock']['file']['url'] = "http://there-is-no-actual-file-based-hammock-release.tinyspeck.com/hammock-#{f['version']}.#{f['type']}"
default['hammock']['file']['checksum'] = "fee7334efba967142955be2fa39ecae7bca0cc9b7a76c301430746be4fc7ec6d" # sha256 ( shasum -a 256 FILENAME )

case node['hammock']['install_type']
when 'git'
  default['hammock']['web_dir'] = "#{node['hammock']['install_dir']}/current/src"
when 'file'
  default['hammock']['web_dir'] = node['hammock']['install_dir']
end

default['hammock']['hammock_user'] = 'hammock'
default['hammock']['config_template'] = 'config.php.erb'
default['hammock']['config_cookbook'] = 'chef-hammock'

default['hammock']['somevar'] = [ ]
default['hammock']['allowlist'] = [ ]


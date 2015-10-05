#
# Cookbook Name:: chef-hammock
# Recipe:: default
#
# Copyright 2015, ~elw
#
# All rights reserved - Do Not Redistribute
#

hammock_user = node['hammock']['user']

group hammock_user do
  action :create
  system true
end

user hammock_user do
  comment "Hammock User"
  home    "/home/#{hammock_user}"
  shell   "/sbin/nologin"
  gid     hammock_user
  action  :create
  system true
end

directory node['hammock']['install_dir'] do
  owner hammock_user
  mode "0755"
end

case  node['hammock']['install_type']
  when "git"
    include_recipe 'hammock::install_git'
  when "file"
    include_recipe 'hammock::install_file'
end

# package "redis" <-- here we need to use the CP redis cookbook, what's in yum is 2.4.x where we need 2.7.2+
package "hiredis"
package "python-daemon"
package "python-flask"
package "python-simplejson"
package "python-unittest2"
package "python-mock"
# package "python-simple-hipchat"

template "#{node['hammock']['web_dir']}/lib/config.php" do
  source node['hammock']['config_template']
  cookbook node['hammock']['config_cookbook']
  mode "0750"
  user hammock_user
  variables(
  :somevar => node['hammock']['somevar']
  )
end

template "/etc/httpd/sites-available/hammock.conf" do
  source "hammock.conf.erb"
  cookbook node['hammock']['config_cookbook']
  mode "0750"
  user skyline_user
  variables(
  :allowlist => node['hammock']['allowlist'] 
  )
end



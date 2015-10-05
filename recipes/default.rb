#
# Cookbook Name:: chef-hammock
# Recipe:: default
#
# Copyright 2015, ~elw
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apache2::default'
include_recipe 'apache2::mod_fastcgi'
include_recipe 'apache2::mod_php5'

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
  notifies :reload, 'service[apache2]'
end




include_recipe "git"
include_recipe 'python'
include_recipe 'python::pip'

git "#{node['hammock']['install_dir']}/#{node['hammock']['git']['branch']}" do
  repository node['hammock']['git']['url']
  reference node['hammock']['git']['branch']
  action node['hammock']['git']['type'].to_s
  user hammock_user
end

link "#{node['hammock']['install_dir']}/current" do
  to "#{node['hammock']['install_dir']}/#{node['hammock']['git']['branch']}"
end




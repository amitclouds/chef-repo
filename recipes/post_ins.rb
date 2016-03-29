#post installation
user "nginx" do
  manage_home true
end

cookbook_file node['package']['script'] do
  source "script"
  mode '0675'
 
  user node['package']['user']
  group node['package']['group']

  action :create
end

service "nginx" do

action :restart
end 

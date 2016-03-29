#
# Cookbook Name:: nginx
# Recipe:: file
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

 
cookbook_file "#{Chef::Config[:file_cache_path]}/nginx-#{node[:package_version]}.tar.gz" do
  source 'nginx.tar.gz'
  mode '0644'
  action :create
end




bash "install_program" do
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    tar xzf "#{Chef::Config[:file_cache_path]}/nginx-#{node[:package_version]}.tar.gz"
    cd "#{Chef::Config[:file_cache_path]}/nginx-#{node[:package_version]}"
    ./configure --prefix=/usr/local/nginx --sbin-path=/usr/local/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/run/nginx.pid --lock-path=/run/lock/subsys/nginx --user=nginx
    make 
    make install
 EOH
 
  action :run
#not_if { ::File.exists?("/usr/local/nginx") }
end

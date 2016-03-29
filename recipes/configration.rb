
 ruby_block "comment conf file path" do
  block do
    file = Chef::Util::FileEdit.new("/etc/sysctl.conf")
    #file.search_file_replace_line( "include /etc/nginx/sites-enabled/" ,"       #include /etc/nginx/sites-enabled/*;")
    file.insert_line_if_no_match( "#net.ipv4.conf.all.rp_filter = 1" ,"net.ipv4.conf.all.rp_filter = 1")
    file.insert_line_if_no_match( "#net.ipv4.conf.default.rp_filter = 1" ,"net.ipv4.conf.default.rp_filter = 1")
    file.insert_line_if_no_match( "#net.ipv4.icmp_echo_ignore_broadcasts = 1" ,"net.ipv4.icmp_echo_ignore_broadcasts = 1")
    file.insert_line_if_no_match( "#net.ipv4.conf.all.accept_source_route = 0" ,"net.ipv4.conf.all.accept_source_route = 0")
    file.insert_line_if_no_match( "#net.ipv6.conf.all.accept_source_route = 0" ,"net.ipv6.conf.all.accept_source_route = 0")
    file.insert_line_if_no_match( "#net.ipv4.conf.default.accept_source_route = 0" ,"net.ipv4.conf.default.accept_source_route = 0")
    file.insert_line_if_no_match( "#net.ipv6.conf.default.accept_source_route = 0" ,"net.ipv6.conf.default.accept_source_route = 0")
    file.insert_line_if_no_match( "#net.ipv4.conf.all.send_redirects = 0" ,"net.ipv4.conf.all.send_redirects = 0")
    file.insert_line_if_no_match( "#net.ipv4.conf.default.send_redirects = 0" ,"net.ipv4.conf.default.send_redirects = 0")
    file.insert_line_if_no_match( "#net.ipv4.tcp_syncookies = 1" ,"net.ipv4.tcp_syncookies = 1")
    file.insert_line_if_no_match( "#net.ipv4.tcp_max_syn_backlog = 2048" ,"net.ipv4.tcp_max_syn_backlog = 2048")
    file.insert_line_if_no_match("#net.ipv4.tcp_synack_retries = 2","net.ipv4.tcp_synack_retries = 2")
    file.insert_line_if_no_match("#net.ipv4.tcp_synack_retries = 2","net.ipv4.tcp_synack_retries = 2")
    file.insert_line_if_no_match("#net.ipv4.tcp_syn_retries = 5","net.ipv4.tcp_syn_retries = 5")
    file.insert_line_if_no_match("#net.ipv4.conf.all.log_martians = 1","net.ipv4.conf.all.log_martians = 1")
    file.insert_line_if_no_match("#net.ipv4.icmp_ignore_bogus_error_responses = 1","net.ipv4.icmp_ignore_bogus_error_responses = 1")
    file.insert_line_if_no_match("#net.ipv4.conf.all.accept_redirects = 0","net.ipv6.conf.all.accept_redirects = 0")
    file.insert_line_if_no_match("#net.ipv4.conf.default.accept_redirects = 0","net.ipv4.conf.default.accept_redirects = 0 ")
    file.insert_line_if_no_match("#net.ipv6.conf.default.accept_redirects = 0","net.ipv6.conf.default.accept_redirects = 0")
    file.insert_line_if_no_match("#net.ipv4.icmp_echo_ignore_all = 1","net.ipv4.icmp_echo_ignore_all = 1")

    file.write_file
  end
end

 #bash "append_to_config" do 
  # user "root"
   #code <<-EOF
#
 #       sed -i -e '/sites-enabled/r /tmp/nginx.code' /etc/nginx/nginx.conf
  #      EOF
   #not_if "grep -q  upstream  /etc/nginx/nginx.conf"
# end
bash "insert_line" do
  user "root"
  code <<-EOS
  echo "include /etc/nginx/sites-enabled/" >> /etc/nginx/nginx.conf
  EOS
  not_if "grep -q /etc/nginx/sites-enabled/ /etc/nginx/nginx.conf"
end

directory '/etc/nginx/sites-enabled' do
  owner 'nginx'
  group 'nginx'
  mode '0644'
  action :create
end

 cookbook_file "/etc/nginx/sites-enabled/000-default.conf" do
   source "nginx.conf"
 end

service 'apache2' do
  action :restart
end


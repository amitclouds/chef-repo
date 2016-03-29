
#necessary packages to build apache as well as extra apache modules.

default['package']['supported_packages'] = ["libapache2-mod-php5", "libapache2-mod-php5"]
#package version	
default[:package_version] = '2.4'
#package download link

#default['package']['url'] = "http://apache.org/download/apache-#{node[:package_version]}.tar.gz"


default['package']['user'] = 'www-data'
default['package']['group'] = 'www-data'

default['package']['dir'] ="/etc/apache2/"
default['package']['script'] ="#{node['package']['dir']}/"
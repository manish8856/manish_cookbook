#----
# Set up preseeding data for debian packages
#---
directory '/var/cache/local/preseeding' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

template '/var/cache/local/preseeding/mysql-server.seed' do
  source 'mysql-server.seed.erb'
  owner 'root'
  group 'root'
  mode '0600'
  notifies :run, 'execute[preseed mysql-server]', :immediately
end

execute 'preseed mysql-server' do
  command '/usr/bin/debconf-set-selections /var/cache/local/preseeding/mysql-server.seed'
  action  :nothing
end

#----
# Install software
#----
node['mysql']['server']['packages'].each do |name|
  package name do
    action :install
  end
end

node['mysql']['server']['directories'].each do |key, value|
  directory value do
    owner     'mysql'
    group     'mysql'
    mode      '0775'
    action    :create
    recursive true
  end
end


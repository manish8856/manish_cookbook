package 'mysql-server' do
  version node['mysql']['version']
  action :install
end

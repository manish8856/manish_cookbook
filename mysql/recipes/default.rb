mysql_client "default" do
  port "3306"
  version "5.5"
  initial_root_password "manish"
  action [:create, :start]
end

mysql_service "default" do
  source "mysite.cnf.erb"
  notifies :restart, "mysql_service[default]"
  action :create
end

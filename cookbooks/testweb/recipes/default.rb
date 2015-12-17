#
# Cookbook Name:: testweb
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "package update" do
  user    "root"
  command node["pkg"]["update"]
  action  :run
end

[node["pkg"]["httpd"], node["pkg"]["php"]].each do |pkg|
  package pkg do
    action :install
  end
end

service node["pkg"]["httpd"] do
  action [:enable, :restart]
end

template "#{node["web"]["docroot"]}/index.php" do
  source "index.php.erb"
  owner  "root"
  group  "root"
  mode   0644
  variables(
    :platform => node["platform"],
    :version  => node["platform_version"]
  )
end

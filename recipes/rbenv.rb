#
# Cookbook Name:: kono_workstation
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "applications::default"
include_recipe "rbenv"
include_recipe "ruby_build"
include_recipe 'kono_workstation::java'

if platform?('mac_os_x')
  package 'rbenv' do
    action [:install, :upgrade]
  end

  package 'ruby-build' do
    action [:install, :upgrade]
  end

  package 'rbenv-gem-rehash' do
    action [:install, :upgrade]
  end
elsif platform_family?('debian')
  include_recipe "rbenv::user_install"
end

rbenv_ruby "jruby-1.7.4" do
  user node['current_user']
  action :install
end
rbenv_ruby "2.0.0-p247" do
  user node['current_user']
  action :install
end
rbenv_global "2.0.0-p247"

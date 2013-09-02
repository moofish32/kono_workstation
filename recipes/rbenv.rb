#
# Cookbook Name:: kono_workstation
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "applications::default"

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
end

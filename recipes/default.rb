#
# Cookbook Name:: kono_workstation
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
file "/tmp/testing" do
  content 'I am testing this recipe before the platform check'
end

include_recipe "applications::default"

if platform?('mac_os_x')
  file "/tmp/testing_inside_platform_check" do
    content 'I am testing this recipe in the platform check'
  end

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

#
# Cookbook Name:: kono_workstation
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "applications::default"
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

  execute 'Install ruby 2.0.0-p247' do
    user node['current_user']
    command "export RBENV_ROOT=/usr/local/var/rbenv;/usr/local/bin/rbenv install 2.0.0-p247;/usr/local/bin/rbenv global 2.0.0-p247"
    not_if { File.exists? '/usr/local/var/rbenv/versions/2.0.0-p247/' }
  end

  execute 'Install jruby-1.7.4' do
    command 'export RBENV_ROOT=/usr/local/var/rbenv;/usr/local/bin/rbenv install jruby-1.7.4'
    not_if { File.exists? '/usr/local/var/rbenv/versions/jruby-1.7.4/' }
  end

  execute 'Chown the rbenv versions' do
    command "chown -R #{node['current_user']} /usr/local/var/rbenv"
  end

elsif platform_family?('debian')

node.default['rbenv']['user_installs'] = [
  { 'user'    => node.current_user,
    'rubies'  => ['1.9.3-p448', 'jruby-1.7.4',  '2.0.0-p247'],
    'global'  => '1.9.3-p448',
    'gems'    => {
      '1.9.3-p448'    => [
        { 'name'    => 'bundler'},
        { 'name'    => 'rake' }
      ],
      'jruby-1.7.4' => [
        { 'name'    => 'bundler'},
        { 'name'    => 'rake' }
      ]
    }
  }
]
  include_recipe "ruby_build"
  include_recipe "rbenv::user"

end


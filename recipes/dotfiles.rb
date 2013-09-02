include_recipe 'git'
include_recipe 'zsh' # bkonowitz dotfiles expect zsh

git "#{node['etc']['passwd'][node['current_user']]['dir']}/.dotfiles" do
  repository 'git://github.com/bkonowitz/dotfiles.git'
  user node['current_user']
  reference 'master'
  action :sync
  not_if { File.exist?("#{node['etc']['passwd'][node['current_user']]['dir']}/.dotfiles") }
end

execute 'dotfiles install' do
  command " pushd #{node['etc']['passwd'][node['current_user']]['dir']}/.dotfiles;sh install.sh;popd"
  user node['current_user']
  action :run
end

if platform?('mac_os_x')
  package 'ctags' do
    action [:install, :upgrade]
  end
elsif platform?('debian')
  package 'exuberant-ctags' do
    action [:install, :upgrade]
  end
end

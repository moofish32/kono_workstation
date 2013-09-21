include_recipe 'applications::default'
#include_recipe 'git'
include_recipe 'zsh' # bkonowitz dotfiles expect zsh

git "#{node['etc']['passwd'][node['current_user']]['dir']}/.dotfiles" do
  repository 'git://github.com/bkonowitz/dotfiles.git'
  user node['current_user']
  reference 'master'
  action :sync
  not_if { File.exist?("#{node['etc']['passwd'][node['current_user']]['dir']}/.dotfiles") }
end

git "#{node['etc']['passwd'][node['current_user']]['dir']}/.dotfiles/.oh-my-zsh" do
  repository 'https://github.com/robbyrussell/oh-my-zsh'
  user node['current_user']
  reference 'master'
  action :sync
end

execute 'dotfiles install' do
  command "cd #{node['etc']['passwd'][node['current_user']]['dir']}/.dotfiles;sh chef_install.sh"
  user node['current_user']
  action :run
end

git "#{node['etc']['passwd'][node['current_user']]['dir']}/.vim/bundle/vundle" do
  repository 'https://github.com/gmarik/vundle.git'
  user node['current_user']
  reference 'master'
  action :sync
end

#  this is currently causing a ruckous... commented for now
# execute 'Run vundle' do
#   command "vim -u ~/.vimrc.bundles +BundleInstall +qa"
#   user node['current_user']
# end

if platform?('mac_os_x')
  package 'ctags' do
    action [:install, :upgrade]
  end

  package 'tree' do
    action [:install, :upgrade]
  end
elsif platform_family?('debian')
  package 'exuberant-ctags' do
    action [:install, :upgrade]
  end
  cookbook_file "#{node['etc']['passwd'][node['current_user']]['dir']}/.dotfiles/.oh-my-zsh/themes/kono.zsh-theme" do
    source "kono.zsh-theme"
    owner node['current_user']
    backup false
    mode "0777"
  end
end

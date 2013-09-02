include_recipe 'git'

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

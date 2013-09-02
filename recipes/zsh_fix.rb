include_recipe 'zsh'

if platform?('mac_os_x')
  execute 'Fix OSX environment bug' do
    command 'mv /etc/{zshenv,zshrc}'
  end
end

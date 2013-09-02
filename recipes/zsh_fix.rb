include_recipe 'zsh'

if platform?('mac_os_x')
  execute 'Add brew ZSH to etc/shells' do
    command 'echo "/usr/local/bin/zsh" >> /etc/shells'
  end
  execute 'Set brew ZSH as default' do
    command 'chsh -s /usr/local/bin/zsh $USER'
  end
  execute 'Fix OSX environment bug' do
    command 'mv /etc/{zshenv,zshrc}'
  end
end

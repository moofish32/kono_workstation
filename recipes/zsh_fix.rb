include_recipe 'zsh'

if platform?('mac_os_x')
  execute 'Add brew ZSH to etc/shells' do
    command 'echo "/usr/local/bin/zsh" >> /etc/shells'
  end
  execute 'Set default zsh temporarily' do
    command 'chsh -s /bin/zsh'
  end
  execute 'Set default zsh for user temporarily' do
    command "chsh -s /bin/zsh #{node['current_user']}"
  end
  # execute 'Set brew ZSH as default' do
  #   command 'chsh -s /usr/local/bin/zsh $USER'
  # end
  execute 'Fix OSX environment bug' do
    command 'mv /etc/{zshenv,zshrc}'
    not_if { File.exists?('/etc/zshrc') }
  end
end

include_recipe 'applications::default'

package 'tmux' do
  action [:install, :upgrade]
end

if platform?('mac_os_x')
  package 'reattach-to-user-namespace' do
    action [:install, :upgrade]
  end
end

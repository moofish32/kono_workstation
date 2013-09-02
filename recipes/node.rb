include_recipe 'applications::default'

if platform?('mac_os_x')
  package 'node' do
    action [:install, :upgrade]
  end
end # TODO add linux support

include_recipe 'java'

if platform?('mac_os_x')
  package 'scala' do
    action [:install, :upgrade]
  end
end # TODO add linux support

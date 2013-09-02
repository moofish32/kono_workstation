include_recipe 'applications::default'
include_recipe 'applications::java'

if platform?('mac_os_x')
  package 'scala' do
    action [:install, :upgrade]
  end
  package 'sbt' do
    action [:install, :upgrade]
  end
end # TODO add linux support

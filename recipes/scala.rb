include_recipe 'applications::default'
include_recipe 'java::oracle'

if platform?('mac_os_x')
  package 'scala' do
    action [:install, :upgrade]
  end
  package 'sbt' do
    action [:install, :upgrade]
  end
end # TODO add linux support

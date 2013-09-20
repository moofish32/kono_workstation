include_recipe 'applications::default'
include_recipe 'kono_workstation::java'

if platform?('mac_os_x')
  package 'scala' do
    action [:install, :upgrade]
  end
  package 'sbt' do
    action [:install, :upgrade]
  end
end # TODO add linux support

if platform?('ubuntu')
  include_recipe 'apt'
  package 'scala' do
    action [:install, :upgrade]
  end
  package 'sbt' do
    action [:install, :upgrade]
  end
end

include_recipe 'applications::default'
include_recipe 'kono_workstation::java'

package 'maven' do
  action [:install, :upgrade]
end

include_recipe 'applications::default'
include_recipe 'git'

package 'hub' do
  action [:install, :upgrade]
end

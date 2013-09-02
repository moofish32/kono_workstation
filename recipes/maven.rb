include_recipe 'applications::default'
include_recipe 'java'

package 'maven' do
  action [:install, :upgrade]
end

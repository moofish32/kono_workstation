include_recipe 'applications::default'
include_recipe 'applications::java'

package 'maven' do
  action [:install, :upgrade]
end

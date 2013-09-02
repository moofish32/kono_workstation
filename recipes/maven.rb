include_recipe 'applications::default'
include_recipe 'java::oracle'

package 'maven' do
  action [:install, :upgrade]
end

include_recipe 'applications::default'

if platform?('mac_os_x')
  package 'sqlite' do
    action [:install, :upgrade]
  end
elsif platform?('debian')
  package 'sqlite3' do
    action [:install, :upgrade]
  end
end

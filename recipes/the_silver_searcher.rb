include_recipe 'applications::default'

if platform?('mac_os_x')
  package 'the_silver_searcher' do
    action [:install, :upgrade]
  end
elsif platform_family?('debian')
  include_recipe 'apt'

  apt_repository 'the-silver-searcher' do
    uri 'http://ppa.launchpad.net/pgolm/the-silver-searcher/'
    components ['main']
  end

  package 'the-silver-searcher' do
    action [:install, :upgrade]
  end
end

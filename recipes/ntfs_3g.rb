include_recipe 'applications::default'

if platform?('mac_os_x')
  package 'ntfs-3g' do
    action [:install, :upgrade]
  end
end

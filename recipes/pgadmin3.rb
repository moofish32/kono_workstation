if platform?('mac_os_x')
  include_recipe "applications::homebrewcask"
  applications_cask "pgadmin3"
end

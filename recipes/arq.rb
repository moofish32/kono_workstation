if platform?('mac_os_x')
  include_recipe "applications::homebrewcask"
  applications_cask "arq"
end

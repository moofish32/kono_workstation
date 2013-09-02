if platform?('mac_os_x')
  include_recipe "applications::homebrewcask"
  include_recipe "kono_workstation::konocasks"
  applications_cask "parallels-desktop"
end

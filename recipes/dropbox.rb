if platform?('mac_os_x')
  include_recipe "applications::homebrewcask"
  applications_cask "dropbox"
end

case node[:platform]
when "ubuntu","debian"
  bash "apt-get update" do
    code "apt-get update"
    action :nothing
  end
  apt_repository "dropbox" do
    uri "http://linux.dropbox.com/ubuntu"
    distribution node['lsb']['codename']
    components ["main"]
    keyserver "pgp.mit.edu"
    key "5044912E"
    notifies :run, resources(:bash => "apt-get update"), :immediately
  end

  package "nautilus-dropbox"

when "mac_os_x"
  include_recipe "applications::homebrewcask"
  applications_cask "dropbox"

when "arch"
  include_recipe "pacman"
  pacman_aur "dropbox-daemon"
  pacman_aur "dropbox-cli"
end
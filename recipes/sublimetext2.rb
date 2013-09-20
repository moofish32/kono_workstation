if platform?('mac_os_x')
  dmg_package "Sublime Text 2" do
    dmg_name "Sublime%20Text%202.0.1"
    source "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg"
    owner node['current_user']
  end
  link "/usr/local/bin/subl" do
    to "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"
  end
  package_dir =["#{node['etc']['passwd'][node['current_user']]['dir']}/Library/Application Support/Sublime Text 2", "Packages"]
  sublime_package_dir = ["#{node['etc']['passwd'][node['current_user']]['dir']}/Library/Application Support/Sublime Text 2", "Packages"]
end

if platform?('ubuntu')
  package_dir = "#{node['etc']['passwd'][node['current_user']]['dir']}/.config/sublime-text-2/Installed Packages"
  sublime_package_path =  ["#{node['etc']['passwd'][node['current_user']]['dir']}/.config/sublime-text-2", "Packages"]
  sublime_download = "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20x64.tar.bz2"
  sublime_tar_ball = "\'Sublime Text 2.0.2 x64.tar.bz2\'"
  script "sublime text 2" do
    interpreter "bash"
    user "root"
    cwd "/tmp/"
    code <<-EOH
    rm -rf '/opt/Sublime Text 2'
    cd '/opt/Sublime Text 2'
    wget #{sublime_download}
    sudo tar -xf #{sublime_tar_ball}
    sudo mv 'Sublime Text 2' /opt
    sudo rm Sublime*
    EOH
  end
end

sublime_user_path = sublime_package_path.dup << "User"

recursive_directories sublime_user_path do
  owner node['current_user']
end

node["sublime_text_packages"].each do |package|
  kono_workstation_sublime_package package["name"] do
    source package["source"]
    destination File.join(sublime_package_path)
    owner node['current_user']
  end
end
template File.expand_path("Preferences.sublime-settings", File.join(sublime_user_path)) do
  source "sublime_text-Preferences.sublime-settings.erb"
  owner node['current_user']
  action :create_if_missing
end

filename = "Package\\ Control.sublime-package"

recursive_directories(["#{package_dir}"]) do
  owner node['current_user']
end

remote_file "#{package_dir}/#{filename}" do
   source 'https://sublime.wbond.net/Package%20Control.sublime-package'
   owner node['current_user']
   :create_if_missing
end

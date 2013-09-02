if platform?('mac_os_x')
  dmg_package "JDK 7 Update 25" do
    source "https://s3-us-west-1.amazonaws.com/kono-storage/public/software/jdk-7u25-macosx-x64.dmg"
    action :install
    type "pkg"
    not_if { File.exist?("/Library/Java/JavaVirtualMachines/jdk1.7.0_25.jdk") }
  end
elsif platform_family?('debian')
  include_recipe "java::oracle"
end

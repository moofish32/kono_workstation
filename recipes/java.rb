if platform?('mac_os_x')
  dmg_package "Java 7 Update 25 JDK" do
    source "http://download.oracle.com/otn-pub/java/jdk/7u25-b15/jdk-7u25-macosx-x64.dmg"
    action :install
    type "pkg"
    package_id "com.oracle.jre"
  end
elsif platform_family?('debian')
  include_recipe "java::oracle"
end

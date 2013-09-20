if platform?('mac_os_x')
  include_recipe "applications::homebrewcask"
  applications_cask "intellij-community"


elsif platform_family?('debian')
	
	cookbook_file "/usr/share/applications/intellij.desktop" do
	  source "ubuntu.intellij.desktop"
	  owner node['root']
	  backup false
	  mode "0777"

	end

	intellij_mirror_site = "http://download.jetbrains.com/idea/ideaIC-12.1.4.tar.gz"
	intellij_file = "ideaIC-12.1.4.tar.gz"
	script "install_intellij" do
		interpreter "bash"
		user "root"
		cwd "/tmp/"
		code <<-EOH
		rm -rf /opt/intellij
		mkdir /opt/intellij
		cd /opt/intellij
		wget #{intellij_mirror_site}
		tar -zxvf #{intellij_file}
		find . -maxdepth 1 -name "idea-IC*" -type d | head -1 | xargs -i sudo ln -s {} idea-IC
		rm -rf idea-IC*.tar.gz
		EOH

		# only_if do ! File.exists?("/opt/intellij/idea-IC/bin/idea.sh") end
	end
end
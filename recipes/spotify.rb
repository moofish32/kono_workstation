if platform?('ubuntu')
	apt_repository "spotify" do
	  uri "http://www.ubuntuupdates.org/package/spotify/stable/non-free/base/spotify-client"
	  distribution node['lsb']['codename'] # or "lucid" if lsb isn't installed :)
	  components ["main"]
	  key "94558F59"
	  keyserver "keyserver.ubuntu.com"
	  action :add
	end

	package "spotify" do 
	  action [:install, :upgrade]
	end
end
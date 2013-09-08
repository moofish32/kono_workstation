if platform?('mac_os_x')
  include_recipe "applications::default"

  applications_tap "bkonowitz/homebrew-cask" do
    not_if { ::File.directory?("/usr/local/Library/Taps/bkonowitz-cask") }
  end

  package "brew-cask" do
      action [:install, :upgrade]
  end
end

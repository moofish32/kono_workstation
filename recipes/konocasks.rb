include_recipe "applications::default"
include_recipe "applications::homebrewcask"

applications_tap "bkonowitz/homebrew-cask" do
    not_if { ::File.directory?("/usr/local/Library/Taps/bkonowitz-cask") }
end

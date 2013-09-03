include_recipe 'applications::default'
include_recipe 'kono_workstation::rbenv'

if platform?('mac_os_x')
  execute 'Installing bundler, pg, rails for 2.0.0-p247' do
    user node['current_user']
    command 'export RBENV_ROOT=/usr/local/var/rbenv;export PATH=$RBENV_ROOT/shims:$RBENV_ROOT/bin:/usr/local/bin:/usr/local/sbin:$PATH;rbenv shell 2.0.0-p247;echo `ruby -v`;$RBENV_ROOT/shims/gem install bundler pg rails rspec thor unicorn guard --no-document'
  end

  execute 'Installing bundler, pg, rails, puma for jruby-1.7.4' do
    user node['current_user']
    command 'export RBENV_ROOT=/usr/local/var/rbenv;export PATH=$RBENV_ROOT/shims:$RBENV_ROOT/bin:/usr/local/bin:/usr/local/sbin:$PATH;eval "$(rbenv init -)";rbenv shell jruby-1.7.4;$RBENV_ROOT/shims/gem install bundler jdbc-postgres rails rspec thor puma guard'
  end
elsif platform_family?('debian')
  %w{ 2.0.0-p247 jruby-1.7.4 }.each do |ver|
    %w{ bundler pg rails thor guard }.each do |gem_name|
      rbenv_gem gem_name do
        user node['current_user']
        rbenv_version ver
      end
    end

    if ver.contains? 'jruby'
      rbenv_gem 'puma' do
        user node['current_user']
        rbenv_version ver
      end
    else
      rbenv_gem 'unicorn' do
        user node['current_user']
        rbenv_version ver
      end
    end
  end
end

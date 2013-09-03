include_recipe 'applications::default'

if platform?('mac_os_x')
  execute 'Installing bundler, pg, rails for 2.0.0-p247' do
    user node['current_user']
    command 'export RBENV_ROOT=/usr/local/var/rbenv;export PATH=$RBENV_ROOT/shims:$RBENV_ROOT/bin:/usr/local/bin:/usr/local/sbin:$PATH;eval "$(rbenv init -)";/usr/local/bin/rbenv shell 2.0.0-p247;/usr/local/bin/gem install bundler pg rails thor unicorn --no-document'
  end

  execute 'Installing bundler, pg, rails, puma for jruby-1.7.4' do
    user node['current_user']
    command 'export RBENV_ROOT=/usr/local/var/rbenv;export PATH=$RBENV_ROOT/shims:$RBENV_ROOT/bin:/usr/local/bin:/usr/local/sbin:$PATH;eval "$(rbenv init -)";/usr/local/bin/rbenv shell jruby-1.7.4;/usr/local/bin/gem install bundler pg rails thor unicorn --no-document'
  end
elsif platform_family?('debian')
  include_recipe 'rbenv'

  %w{ '2.0.0-p247' 'jruby-1.7.4' }.each do |ver|
    rbenv_gem 'bundler' do
      user node['current_user']
      rbenv_version ver
    end

    rbenv_gem 'pg' do
      user node['current_user']
      rbenv_version ver
    end

    rbenv_gem 'rails' do
      user node['current_user']
      rbenv_version ver
    end

    rbenv_gem 'thor' do
      user node['current_user']
      rbenv_version ver
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

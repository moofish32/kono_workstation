include_recipe 'applications::default'
include_recipe 'kono_workstation::rbenv'

if platform?('mac_os_x')
  #  taking a different approach ....
  bash 'install gems for 2.0.0-p247' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    sudo su - bkonowitz
    export RBENV_ROOT=/usr/local/var/rbenv
    export PATH=$RBENV_ROOT/shims:$RBENV_ROOT/bin:/usr/local/bin:/usr/local/sbin:$PATH
    export GEM_HOME=/usr/local/var/rbenv/versions/2.0.0-p247/lib/ruby/gems/2.0.0
    export GEM_PATH=/usr/local/var/rbenv/versions/2.0.0-p247/lib/ruby/gems/2.0.0
    eval "$(rbenv init -)"
    rbenv shell 2.0.0-p247
    ruby -v
    gem env
    gem install bundler pg rails rspec thor unicorn guard --no-rdoc --no-ri
    EOH
  end

  bash 'install gems for jruby-1.7.4' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    sudo su - bkonowitz
    export RBENV_ROOT=/usr/local/var/rbenv
    export PATH=$RBENV_ROOT/shims:$RBENV_ROOT/bin:/usr/local/bin:/usr/local/sbin:$PATH
    export GEM_HOME=/usr/local/var/rbenv/versions/jruby-1.7.4/lib/ruby/gems/shared
    export GEM_PATH=/usr/local/var/rbenv/versions/jruby-1.7.4/lib/ruby/gems/shared
    eval "$(rbenv init -)"
    rbenv shell jruby-1.7.4
    ruby -v
    gem env
    gem install bundler jdbc-postgres rails rspec thor puma guard --no-rdoc --no-ri
    EOH
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

name             'kono_workstation'
maintainer       'bkonowitz'
maintainer_email 'konowitzb@gmail.com'
license          'All rights reserved'
description      'Installs/Configures kono_workstation'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports         "mac_os_x"
supports         "debian"
supports         "ubuntu"
depends          "dmg"
depends          "composer"
depends          "apt"
depends          "git"
depends          "zsh"
depends          "pivotal-workstation"
depends          "root_ssh_agent"
depends          "osxdefaults"

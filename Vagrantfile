# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # box configuration.  Ubuntu 12.04 LTS (Precise Pangolin; 32-bit)
  config.vm.hostname = "vacation-scheduler"
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # HTTP port forwarding
  config.vm.network :forwarded_port, guest: 3000, host: 3000, auto_correct: true
  # mailcatcher port forwarding
  config.vm.network :forwarded_port, guest: 1080, host: 3001, auto_correct: true

  # configure VirtualBox specific settings
  config.vm.provider :virtualbox do |vb|
    # enable the DNS proxy in NAT mode
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.memory = 4000
  end

  config.vm.provision "shell", inline: "echo \"cd /vagrant\" >> /home/vagrant/.bashrc"

  # Enabling the Berkshelf plugin.
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "Berksfile"

  # Enable omnibus to manage Chef versioning
  config.omnibus.chef_version = '12.11.18'

  # invoke the chef provisioning scripts
  config.vm.provision :chef_solo do |chef|
    chef.json = {
      rbenv: {
        user_installs: [
          {
            user: 'vagrant',
            rubies: ['2.1.6'],
            global: '2.1.6',
            gems: {
              '2.1.6' => [
                { name: 'bundler' }
              ]
            }
          }
        ]
      },
      postgresql: {
        users: [
          {
            username: "vagrant",
            password: "password",
            superuser: true,
            createdb: true,
            login: true
          }
        ],
        databases: [
          {
            name: "development",
            owner: "vagrant",
            encoding: "unicode"
          }
        ],
        pg_hba: [
          { type: "local", db: "all", user: "all",        addr: "",             method: "ident" },
          { type: "local", db: "all", user: "postgres",        addr: "",             method: "md5" },
          { type: "local", db: "all", user: "all",        addr: "",             method: "trust" },
          { type: "host",  db: "all", user: "all",        addr: "127.0.0.1/32", method: "trust" },
          { type: "host",  db: "all", user: "all",        addr: "::1/128",      method: "trust" },
        ]
      },
      bundler: {
        user: 'vagrant',
        group: 'vagrant',
        apps_path: '/vagrant',
        app: ''
      }
    }

    chef.run_list = [
      'recipe[apt]',
      'recipe[build-essential]',
      'recipe[postgresql::server]',
      'recipe[postgresql::client]',
      'recipe[ruby_build]',
      'recipe[sqlite]',
      'recipe[nodejs]',
      'recipe[rbenv::user]'
    ]
    
    config.vm.provision "shell", inline: "sudo apt-get install -y libpq-dev"
  end
end

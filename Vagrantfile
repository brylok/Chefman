
Vagrant.configure('2') do |config|
  config.vm.box = 'bento/ubuntu-14.04'

  config.vm.network 'private_network', ip: '11.0.1.6'

  `vagrant plugin install vagrant-omnibus` unless Vagrant.has_plugin?('vagrant-omnibus')
  config.omnibus.chef_version = '12.5.1' if Vagrant.has_plugin?('vagrant-omnibus')

  config.vbguest.auto_update = false if Vagrant.has_plugin?('vagrant-vbguest')

  config.vm.provider 'virtualbox' do |v|
    v.memory = 2048
    v.cpus = 4
  end

  config.vm.network 'forwarded_port', guest: 4567, host: 4567 # app
  config.vm.network 'forwarded_port', guest: 6379, host: 6379 # redis


  config.vm.provision 'shell' do |s|
    ssh_priv_key = File.readlines("#{ENV['HOME']}/.ssh/id_rsa").first.strip
    s.inline = <<-SHELL
      echo #{ssh_priv_key} >> /home/vagrant/.ssh/id_rsa
      chmod 0600 /home/vagrant/.ssh/id_rsa
    SHELL
  end if ssh_key_exists?

  config.vm.provision 'shell' do |s|
    aws_priv_key = File.readlines("#{ENV['HOME']}/.aws/config").first.strip
    s.inline = <<-SHELL
      mkdir -p /home/vagrant/.aws/
      echo #{aws_priv_key} >> /home/vagrant/.aws/config
      chmod 0600 /home/vagrant/.aws/config
    SHELL
  end if aws_key_exists?

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = 'provisioning/cookbooks'
    chef.roles_path = 'provisioning/roles'
    chef.provisioning_path = '/tmp/vagrant-chef'
    chef.add_role('app')
    chef.json = {
      rvm: {
        default_ruby: 'ruby-2.3.1-railsexpress'
      }
    }
    config.ssh.forward_agent = true
    add_ssh_key if ssh_key_exists?
    add_aws_key if aws_key_exists?
  end
end

def ssh_key_exists?(path = "#{ENV['HOME']}/.ssh/id_rsa")
  raise "No ssh private key found at #{path}" unless File.exist?(path)
end

def add_ssh_key
  `ssh-add`
end

def aws_key_exists?(path = "#{ENV['HOME']}/.aws/config")
  raise "No aws private key found at #{path}" unless File.exist?(path)
end

def add_aws_key
  `aws-add`
end

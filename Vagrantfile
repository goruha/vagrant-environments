 Vagrant.configure("2") do |config|
   config.environments.default_environment = "local"
   config.environment.define config do |machine, options, env_settings|
     machine.vm.network :private_network, ip: options["ip"]

     machine.vm.provider :virtualbox do |vb, override|
       vb.customize ["modifyvm", :id, "--memory", "2048"]
       vb.customize ["modifyvm", :id, "--cpus", options["cpu"]]
       override.vm.box = "centos6.3_x86_64_500g"
       override.vm.box_url = "http://vbox.sciencescape.org/centos6.3_x86_64_500g.box"
     end
   end
 end

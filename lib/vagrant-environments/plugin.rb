module VagrantPlugins
  module Environments
    class Plugin < Vagrant.plugin(2)

      name 'vagrant-environments'
      description 'Vagrant plugin to config muiltiple environments (dev, test, stage, prod)'

    end # Plugin
  end # Environments
end # VagrantPlugins

module VagrantPlugins
  module Environments
    class Plugin < Vagrant.plugin(2)

      name 'vagrant-environments'
      description 'Vagrant plugin to config muiltiple environments (dev, test, stage, prod)'

      config :environments do
        require_relative 'config'
        Config
      end

      config :environment do
        require_relative 'environment'
        Environment
      end

     

    end # Plugin
  end # Environments
end # VagrantPlugins

module VagrantPlugins
  module Environments
    class Environment < Vagrant.plugin(2, :config)

      def define(config, &block)
        settings = config.environments.data
        settings["machines"].each do |name, options|
          config.vm.define [config.environments.active, name].join('__') do |machine|
            block.call(machine, options, settings["configs"])
          end
        end
      end

      def validate(_)
        errors = _detected_errors
        { 'environment' => errors }
      end

    end #Environment
  end #Envrionments
end # VagrantPlugins

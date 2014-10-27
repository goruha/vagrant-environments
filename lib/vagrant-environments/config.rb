require 'yaml'

module VagrantPlugins
  module Environments
    class Config < Vagrant.plugin(2, :config)
      attr_accessor :file, :active
      attr_reader :data

      DEFAULT_SETTINGS = {
        file: 'environments.yaml'
      }.freeze

      def initialize
        @file = UNSET_VALUE
        @active = UNSET_VALUE
      end

      def file=(path)
        @file = path unless path.empty?
      end

      def active

        if @active == UNSET_VALUE && !ENV['VAGRANT_ENVIRONMENT'].nil?
          @active = ENV['VAGRANT_ENVIRONMENT']
        end

        @active

      end

      def data
        finalize!
        environments = YAML.load_file(@file)
        environments[@active]
      end

      def validate(_)
        finalize!
        errors = _detected_errors

        if File.file?(@file)

          begin
            environments = YAML.load_file(@file)
            errors.push("There is no #{@active} environment in #{@file}") unless environments.has_key?(@active)
          rescue Exception
            errors.push("file #{@file} have wrong format")
          end

        else
          errors.push("file #{@file} does not exists") 
        end

        { 'environments' => errors }
      end

      def finalize! 
        @file = DEFAULT_SETTINGS[:file] if @file == UNSET_VALUE
        active
      end


    end #Config
  end #Envrionments
end # VagrantPlugins

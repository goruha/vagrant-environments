module Vagrant
  module Plugin
    module V2
      # This is the base class for a CLI command.
      class Command
        protected
        # Parses the options given an OptionParser instance.
        #
        # This is a convenience method that properly handles duping the
        # originally argv array so that it is not destroyed.
        #
        # This method will also automatically detect "-h" and "--help"
        # and print help. And if any invalid options are detected, the help
        # will be printed, as well.
        #
        # If this method returns `nil`, then you should assume that help
        # was printed and parsing failed.
        def parse_options(opts=nil)
          # Creating a shallow copy of the arguments so the OptionParser
          # doesn't destroy the originals.
          argv = @argv
          # Default opts to a blank optionparser if none is given
          opts ||= OptionParser.new
          # Add the help option, which must be on every command.
          opts.on_tail("-h", "--help", "Print this help") do
            safe_puts(opts.help)
            return nil
          end

          opts.on("-e ENVIRONMENT", "--environment ENVIRONMENT", "Define environment") do |environment|
            ENV['VAGRANT_ENVIRONMENT'] = environment if !ENV.has_key?('VAGRANT_ENVIRONMENT') ||  ENV['VAGRANT_ENVIRONMENT'].nil?
          end

          opts.parse!(argv)
          return argv
        rescue OptionParser::InvalidOption
          raise Errors::CLIInvalidOptions, help: opts.help.chomp
        end
      end
    end
  end
end

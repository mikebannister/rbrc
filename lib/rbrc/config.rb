require 'active_support/inflector'
require 'parseconfig'

module Rbrc
  class Config
    def initialize(name)
      @name = name
      raise ConfigFileDoesNotExistError unless File.exist?(file_path)
    end

    def file_path
      @file_path ||= File.expand_path("~/.#{@name}rc")
    end

    def values
      ParseConfig.new(file_path).params
    end

    def [](key)
      values[key.to_s]
    end

    def method_missing(sym, *args, &block)
      return self[sym]
    end

    class << self

      def register(config)
        Rbrc::Registry.register_config(config)
      end

      def method_missing(sym, *args, &block)
        return Registry[sym] if Registry[sym]

        super(sym, *args, &block)
      end

    end
  end
end

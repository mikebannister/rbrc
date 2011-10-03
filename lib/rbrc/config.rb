require 'active_support/inflector'
require 'parseconfig'

module Rbrc
  class Config
    def initialize(name)
      @name = name
      raise ConfigFileDoesNotExistError unless File.exist?(file_path)

      init_shortcut_class
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

    def init_shortcut_class
      helper_name = "#{@name.to_s.camelize}Config".to_sym
      shortcut_class = Class.new(Rbrc::ShortcutClass)
      Object.const_set(helper_name, shortcut_class)
    end
  end
end

module Rbrc
  class ShortcutClass
    class << self
      def method_missing(sym, *args, &block)
        @sym = sym
        if config_exists? and
          return config[sym]
        end
        super(sym, *args, &block)
      end

      # get :Foo from FooConfig
      def config_name
        self.name.slice(0..-7).underscore.to_sym
      end

      def config
        Registry[config_name]
      end

      def config_exists?
        !!config
      end
    end
  end
end

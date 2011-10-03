module Rbrc
  class Registry
    class << self
      def register_config(name, options={})
        @configs ||= {}
        @configs[name] = Config.new(name, options)
      end

      def [](name)
        @configs[name] if @configs
      end
    end
  end
end

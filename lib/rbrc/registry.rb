module Rbrc
  class Registry
    class << self
      def register_config(name)
        @configs ||= {}
        @configs[name] = Config.new(name)
      end

      def [](name)
        @configs[name] if @configs
      end
    end
  end
end

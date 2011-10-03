require 'spec_helper'

module Rbrc
  describe Registry do
    describe "#register_config" do
      it "should add a config object to the registry for each registered config" do
        # Note: FakeFS activated globally in spec_helper
        FileUtils.mkdir_p File.expand_path('~')
        FileUtils.touch File.expand_path('~/.foorc')
        FileUtils.touch File.expand_path('~/.barrc')

        Registry.register_config(:foo)
        Registry.register_config(:bar)
        Registry[:foo].should be_a Rbrc::Config
        Registry[:bar].should be_a Rbrc::Config
      end
    end
  end
end

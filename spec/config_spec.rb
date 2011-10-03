require 'spec_helper'

module Rbrc
  describe Config do
    before(:each) do
      # Note: FakeFS activated globally in spec_helper
      FileUtils.mkdir_p File.expand_path('~')
      FileUtils.touch File.expand_path('~/.foorc')
      FileUtils.touch File.expand_path('~/.barrc')
    end

    describe "#initialize" do
      it "should throw an error if the file doesn't exist" do
        FileUtils.rm File.expand_path('~/.foorc')

        lambda {
          Config.new(:foo)
        }.should raise_error Rbrc::ConfigFileDoesNotExistError
      end

      it "should activate a shortcut class for accessing config values globally" do
        FakeFS.deactivate!
        Config.any_instance.stubs(:file_path).returns('/Users/mike/work/rbrc/spec/files/foorc')

        Registry.register_config :foo

        FooConfig.should be_a ShortcutClass.class
      end
    end

    describe "#file_path" do
      it "should return the path to the config file" do
        config = Config.new(:foo)
        relative_path = config.file_path.split('/').last

        relative_path.should eq '.foorc'
      end
    end

    describe "#values" do
      it "should return values from the config file" do
        FakeFS.deactivate!
        Config.any_instance.stubs(:file_path).returns('/Users/mike/work/rbrc/spec/files/foorc')

        config = Config.new(:foo)
        expected_values = {
          'moof' => 'doof',
          'foof' => 'toof'
        }
        config.values.should eq expected_values
      end
    end

    describe "#[]" do
      it "should return for specified config key" do
        FakeFS.deactivate!
        Config.any_instance.stubs(:file_path).returns('/Users/mike/work/rbrc/spec/files/foorc')

        Registry.register_config :foo

        FooConfig.moof.should == 'doof'
        FooConfig.foof.should == 'toof'
      end
    end
  end
end

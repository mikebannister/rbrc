require 'spec_helper'

module Rbrc
  describe Config do
    let(:root_path) { File.expand_path('../files', __FILE__) }

    context "fake fs" do
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
      end

      describe "#file_path" do
        it "should return the path to the config file" do
          config = Config.new(:foo)
          relative_path = config.file_path.split('/').last

          relative_path.should eq '.foorc'
        end
      end
    end

    describe "#values" do
      it "should return values from the config file" do
        FakeFS.deactivate!
        Config.any_instance.stubs(:file_path).returns("#{root_path}/foorc")

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
        Config.any_instance.stubs(:file_path).returns("#{root_path}/foorc")

        Registry.register_config :foo

        Config.foo['moof'].should == 'doof'
        Config.foo['foof'].should == 'toof'
      end
    end

    describe "#method_missing" do
      it "should serve up each config as an named attribute" do
        FakeFS.deactivate!
        Config.any_instance.stubs(:file_path).returns("#{root_path}/foorc")

        Config.foo.moof.should eq 'doof'
        Config.foo.foof.should eq 'toof'
      end
    end

    describe "self#method_missing" do
      it "should serve up each config as an named attribute" do
        FakeFS.deactivate!
        Config.any_instance.stubs(:file_path).returns("#{root_path}/foorc")

        Config.foo.should be_a Config
        Config.foo.should be_a Config
      end
    end

    describe "self#register" do
      it "should expose a shortcut to Registry.register_config" do
        FakeFS.deactivate!
        Config.any_instance.stubs(:file_path).returns("#{root_path}/foorc")

        Config.register(:foo)
        Registry[:foo].should be_a Config
      end
    end
  end
end

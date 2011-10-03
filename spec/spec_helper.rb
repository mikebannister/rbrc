require 'fakefs/spec_helpers'

require File.expand_path("../../lib/rbrc", __FILE__)

RSpec.configure do |config|
  config.mock_with :mocha
  config.include FakeFS::SpecHelpers

  config.before(:each) do
    FakeFS.activate!
  end

  config.after(:each) do
    FakeFS.deactivate!
    FakeFS::FileSystem.clear
  end
end

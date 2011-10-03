require 'rbrc/registry'
require 'rbrc/config'

module Rbrc
  class ConfigFileDoesNotExistError < Exception
  end

  class ConfigFileSecurityError < Exception
  end
end

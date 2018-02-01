require "fc_to_raw/version"
require "active_support/dependencies/autoload"

module FcToRaw
  extend ActiveSupport::Autoload

  autoload :Processor
end

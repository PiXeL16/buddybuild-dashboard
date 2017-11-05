require 'rspec'
require 'webmock/rspec'
require 'uri'
require_relative '../models/build'

def require_job path
  require File.expand_path '../../jobs/' + path, __FILE__
end

class SCHEDULER
  def self.every(ignoreme)
  end
end

module Builds
  BUILD_CONFIG = {
    "buddyBuildApiBaseUrl" => 'https://api.buddybuild.com',
    "buddyBuildAppID" => '12341234'
  }
end

RSpec.configure do |config|
  config.color = true
  config.order = 'random'
end

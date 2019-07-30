$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'minitest/autorun'
require 'trailblazer/active_job'
require 'pry'

# disable log output for active_job
Trailblazer::ActiveJob::Base.logger = Logger.new(nil)

class Minitest::Test
  include ActiveJob::TestHelper
end

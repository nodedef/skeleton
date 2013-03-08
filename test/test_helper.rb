ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join(File.dirname(__FILE__), "..", "init"))

require "rack/test"
require "contest"
require "override"

class Test::Unit::TestCase
  include Rack::Test::Methods

  def setup
  end

  def app
    Main.new
  end
end

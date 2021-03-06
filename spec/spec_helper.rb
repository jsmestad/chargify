require 'rubygems'
require 'bundler'
require 'logger'

Bundler.require(:default, :runtime, :test)
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'chargify'
require 'rspec/core'
require 'autotest/rspec2'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

FakeWeb.allow_net_connect = false

RSpec.configure do |config|
  # config.include(Rack::Test::Methods)

  config.before :suite do

  end

end


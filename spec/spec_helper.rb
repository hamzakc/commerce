ENV['RACK_ENV'] = 'test'

require 'rspec'
require "rack/test"
require 'pry-byebug'

require_relative '../lib/commerce'

RSpec.configure do |config|
  include Rack::Test::Methods
  config.before(:suite) do
    Curator.data_store.remove_all_keys
  end

  config.after(:each) do
    Curator.data_store.reset!
  end
end

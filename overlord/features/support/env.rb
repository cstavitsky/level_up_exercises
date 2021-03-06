ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'overlord.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = Overlord

class OverlordWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  OverlordWorld.new
end
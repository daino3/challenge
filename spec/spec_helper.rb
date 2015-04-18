require 'capybara'
require 'capybara/dsl'
require 'database_cleaner'
require 'pry'
require 'rack/test'
require 'rspec'
require 'sinatra'

# can't reuse APP_ROOT bc environment not loaded
root = Pathname.new(File.expand_path('../../', __FILE__))

Dir["#{root}/spec/support/**/*.rb"].each {|file| require file}

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app
    CivisAnalyticsApp::App
  end
end

# set environment to test for database logic
Sinatra::Base.set :environment, :test
Sinatra::Base.set :views, File.join(root, "app", "views")

# load up the application
require_relative "../config/environment"

Capybara.app = CivisAnalyticsApp::App

RSpec.configure do |config|

  config.include RSpecMixin
  config.include Capybara::DSL
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:transaction)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end


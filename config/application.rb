module CivisAnalyticsApp
  class App < Sinatra::Base
    register Sinatra::AssetPack
    register Sinatra::Partial
    helpers  Sinatra::HtmlHelpers # http://www.rubydoc.info/gems/sinatra-support/1.2.2/Sinatra/HtmlHelpers

    set :root, APP_ROOT
    set :partial_template_engine, :slim

    configure do
      set :port, 3000
      set :public_folder, './public'
      set :views, Proc.new { File.join(root, 'app', 'views') }
      set :slim, pretty: true
    end

    Sass.load_paths << File.join(root, 'app', 'assets', 'stylesheets')

    assets {
      serve '/css', from: 'app/assets/stylesheets'
      serve '/js', from: 'app/assets/javascripts'
      serve '/images', from: 'app/assets/images'

      css :application, '/application.css', [
        '/css/application.css',
      ]

      js :application, '/application.js', [
        '/js/underscore.js',
        '/js/application.js'
      ]

    }
  end
end

# Run initializers
Dir[APP_ROOT.join('config', 'initializers', '**', '*.rb')].each { |file| require file }

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')
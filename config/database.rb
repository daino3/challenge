
# Log queries to STDOUT in development
if CivisAnalyticsApp::App.development?
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

# Automatically load every file in APP_ROOT/app/models/*.rb, e.g.,
#   autoload "Person", 'app/models/person.rb'
#
# See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
#
Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
  filename = File.basename(model_file).gsub('.rb', '')
  autoload ActiveSupport::Inflector.camelize(filename), model_file
end

# We have to do this in case we have models that inherit from each other.
# If model Student inherits from model Person and app/models/student.rb is
# required first, it will throw an error saying "Person" is undefined.
#
# With this lazy-loading technique, Ruby will try to load app/models/person.rb
# the first time it sees "Person" and will only throw an exception if
# that file doesn't define the Person class.

# Heroku controls what database we connect to by setting the DATABASE_URL environment variable
# We need to respect that if we want our Sinatra apps to run on Heroku without modification
env = CivisAnalyticsApp::App.environment.to_s
db = URI.parse(ENV['DATABASE_URL'] || "postgres://localhost/#{APP_NAME}_#{env}")

DB_NAME = db.path[1..-1]

if CivisAnalyticsApp::App.test?
  # in memory database for test environment
  require 'sqlite3'
  ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
  ActiveRecord::Migrator.up("#{APP_ROOT}/db/migrate")
else
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :port     => db.port,
    :username => db.user,
    :password => db.password,
    :database => DB_NAME,
    :encoding => 'utf8'
  )
end

begin
  ActiveRecord::Base.connection
rescue ActiveRecord::NoDatabaseError
  false
end

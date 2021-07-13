# Gemfile 
source 'http://rubygems.org'

# rack-contrib gives us access to Rack::JSONBodyParser allowing Sinatra (which is built on Rack) to parse requests whose body is in JSON format
gem 'rack-contrib', '~> 2.3', :require => 'rack/contrib'
# sinatra-cross_origin allows our Sinatra API to respond to cross-origin requests
gem 'sinatra-cross_origin'

# these should be familiar from before. Allow us to set up our sqlite3 database with activerecord and sinatra.
gem 'activerecord', '~> 5.2'
gem 'sinatra-activerecord'
gem 'rake'

gem 'require_all'
gem 'sqlite3'

# thin is a basic web server that we can run so our application can respond to requests in production
gem 'thin'
# shotgun is a development server that will respond to requests with the latest version of our code (we don't need to restart the server when we change code–though we will need to refresh the browser unlike with the react dev server)
gem 'shotgun'
# you know about pry at this point, used to allow us to stop our code while it's running for debugging purposes.
gem 'pry'
# bcrypt is a gem used to encrypt user passwords so that they are not stored in plain text within the database.
gem 'bcrypt'
# tux adds a command called `tux` that has access to all of our classes (similar to what we did with rake console manually)
gem 'tux'

# these gems are specialized for testing our application.
group :test do
  gem 'rspec'
  gem 'capybara' # for feature tests
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git' # for resetting the test database before and after the test suite runs
end
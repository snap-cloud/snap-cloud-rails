source 'https://rubygems.org'
ruby '2.2.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'haml'

gem 'paperclip', :git => "https://github.com/thoughtbot/paperclip.git"
gem 'aws-sdk', '< 2.0'

# Embed v8 into Ruby. Sever-side JS processing.
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes following links in your web application faster.
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem "devise"
# allows for user sessions in JSON APIs
gem 'simple_token_authentication', '~> 1.0'


# ASSETS:
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# gem 'bower-rails'
# allows for hellza sexiness
# FIXME -- remove
gem 'jquery-rails'

gem 'rack-cache'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :test do
  # Cucumber, testing and coverage
  gem 'cucumber-rails', :require => false
  gem 'rspec-rails', '>= 3.1'
  gem "factory_girl_rails"
  gem 'faker'
  gem "shoulda-matchers"

  # Lots of different coverage things...
  gem 'simplecov'
  gem 'coveralls', require: false
  gem "codeclimate-test-reporter", require: nil

  gem "database_cleaner"
end

# Development Only Gems. Speed up loading in Travis.
group :development do
  gem 'byebug'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Access an IRB console on exception pages or by using <%= console %> in views
  # gem 'web-console', '~> 2.0'
  # Security Analysis
  gem 'brakeman'
  # DB Query Analysis / Optimizations
  gem "bullet"

  # Custtom Error Pages in Dev Only
  gem "better_errors"
  gem "binding_of_caller"

  # Disable logging Assets in the Server log
  gem 'quiet_assets'

  # Code Linting
  gem 'rubocop', require: false

  # Better Debugging From Rails Console (See Readme)
  gem 'awesome_print'

  # Code Quality Locally
  gem 'metric_fu'
end

group :staging do
  # Heh, we need a real staging enviornment...
end

group :staging, :production do
  # Use Unicorn as the app server
  # gem 'puma'

  # Postgres DB
  gem 'pg'
  # Perf and other Heroku features
  gem 'rails_12factor'
end

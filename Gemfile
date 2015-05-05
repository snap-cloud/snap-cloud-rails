source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'

gem 'paperclip', git: "https://github.com/thoughtbot/paperclip.git"
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

# ASSETS
# Use SCSS for stylesheets
# Includes the :sass compiler for CSS minification
gem 'sass-rails', '~> 5.0'
# Use Google's Closure to compress JS files.
gem 'closure-compiler'
gem 'haml'
# Work with Paperclip for better asset generation
# gem 'rails-retina'

# Manage Keys
gem 'figaro'

# Search
gem 'ransack'

# App Monitoring
# Exclude from :test ...there must be a better way to do this...
gem 'newrelic_rpm', group: [:development, :production, :staging]

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :test do
  # Cucumber and rspec tools
  gem 'cucumber-rails', require: false
  gem 'rspec-rails', '>= 3.1'
  gem "factory_girl_rails"
  gem 'faker'
  gem "shoulda-matchers"

  # CODE COVERAGE
  gem 'simplecov'
  gem 'coveralls'
  gem "codeclimate-test-reporter"

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

  # Security Analysis
  gem 'brakeman'
  # DB Query Analysis / Optimizations
  gem "bullet"
end


group :staging do
  # Heh, we need a real staging enviornment...
end

group :production do
  # Page Caching
  gem 'rack-cache'

  # Use Puma as the app server
  gem 'puma'

  # Postgres DB
  gem 'pg'
  # Perf and other Heroku features
  gem 'rails_12factor'
end

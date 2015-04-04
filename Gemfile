source 'https://rubygems.org'
ruby '2.2.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'haml'

gem 'paperclip', :git => "git://github.com/thoughtbot/paperclip.git"
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
gem 'simple_token_authentication', '~> 1.0' # see semver.org

# allows for hellza sexiness
# FIXME -- remove
gem 'jquery-rails'

gem 'rack-cache'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Cucumber, testing and coverage
  gem 'cucumber-rails', :require => false
  gem 'rspec-rails', '~> 2.14.0'
  gem 'simplecov'
  gem "factory_girl_rails"
  gem 'faker'
  gem "shoulda-matchers"
  gem 'coveralls', require: false
  gem "database_cleaner"
end

# Development Only Gems. Speed up loading in Travis.
group :development do


  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Security Analysis
  gem 'brakeman'
  # DB Query Analysis / Optimizations
  gem "bullet"

end


group :production do
  # Postgres DB
  gem 'pg'
  # Perf and other Heroku features
  gem 'rails_12factor'
  gem 'rack-cache'
end

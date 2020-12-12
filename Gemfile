source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'cancancan'
gem 'bootstrap', '~> 4.4.1'
gem 'cowsay', '~> 0.3.0'
gem 'faker'
gem 'rack-cors'
gem 'rails_same_site_cookie'
# Step 2:👇🏻
# After bundle install run :👉🏻yarn add bootstrap@4.4.1 jquery popper.js 


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'rails-controller-testing' # library that helps us test rails controllers
  # Library heavily integrated into rails to allow us to test stuff really easily
  gem "factory_bot_rails"
  gem 'pry-rails', '~> 0.3.9'
end

# The gemfile is where all your dependencies are listed
# They're seperated into different environments
# You must `bundle` inside of terminal it actually install the added gems

# you can use the command `rails c` to enter a "rails console".
# Rails console is a REPL with all of the gems for your rails project loaded in to play around with... really good debugging/testing tool
# type `exit` to exit the console
group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener', '~> 1.7'
  gem 'delayed_job_active_record'
  gem 'delayed_job_web', '~> 1.4', '>= 1.4.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

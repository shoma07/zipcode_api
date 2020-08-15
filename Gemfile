# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use Puma as the app server
gem 'puma'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', '1.4.2'
gem 'google-protobuf', '3.13.0', platforms: %i[ruby]
gem 'kaminari'
gem 'lograge'
gem 'rubyzip', '>= 1.0.0', require: false
gem 'sqlite3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end

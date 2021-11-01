source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'
gem 'oj'
gem 'puma', '~> 4.3'
gem 'sinatra'
gem 'sinatra-contrib'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'shotgun'
  gem 'rspec'
  gem 'rspec-html-matchers'
  gem 'rack-test'
  gem 'rack-vcr'
  gem 'vcr'
  gem 'webmock'
end

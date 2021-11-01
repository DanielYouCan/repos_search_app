require 'sinatra'
require File.expand_path('.', File.join(File.dirname(__FILE__), 'config', 'environment.rb'))

%w[controllers presenters services validators views].each do |dir|
  path = File.expand_path('.', File.join(File.dirname(__FILE__), 'app', dir))
  $LOAD_PATH << path
  Dir["#{path}/**/*.rb"].each { |file| require File.join(file) }
end

class App < Sinatra::Application
  use ReposController
end

# frozen_string_literal: true

require 'sinatra/base'

class ApplicationController < Sinatra::Base
  configure do
    set :views, File.join('.', 'app', 'views')
  end

  get '/' do
    erb :index
  end
end

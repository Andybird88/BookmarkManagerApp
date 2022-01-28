# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra.reloader
  end

  get '/' do
    'Bookmark Manager'
  end

  get '/bookmarks' do
      @bookmarks = [
        "http://www.makersacademy.com ",
        "http://www.google.com ",
        "http://www.askjeeves.com"
      ]

      erb :'bookmarks/index'
  end

  run! if app_file == $PROGRAM_NAME
end

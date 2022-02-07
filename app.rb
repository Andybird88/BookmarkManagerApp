# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require './lib/bookmark'
require './lib/database_connection_setup'
require './lib/comment'
require 'uri'



class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    
  end
  register Sinatra::Flash
  enable :sessions, :method_override

  get '/' do
    'Bookmark Manager - Please Log In'
  end

  get '/bookmarks' do
      @bookmarks = Bookmark.all

      erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks' do
    flash[:notice] = "Please only submit valid URL's." unless Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  post '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect('/bookmarks')
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :'comments/new'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(bookmark_id: params[:id], text: params[:comment])
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end

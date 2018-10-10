require 'sinatra'
require 'pg'
require_relative "./../spec/dbhelper.rb"
require_relative "./models/space.rb"

class MakersBnbManager < Sinatra::Base
  get '/' do
    'Hello, World!';
  end

  get '/spaces' do
    @spaces = Space.all
    erb(:spaces)
  end

  get '/spaces/:id' do
    @space = Space.select_space(params[:id])
    erb(:booking)
  end

  get '/requests' do

    erb(:requests)
  end

  post '/requests' do
    redirect '/requests'
  end


end

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
end

require 'sinatra'
require 'pg'
require_relative "./../spec/dbhelper.rb"
require_relative "./models/space.rb"
require_relative "./models/booking_request.rb"

class MakersBnbManager < Sinatra::Base
  enable :sessions
  get '/' do
    'Hello, World!';
    erb(:index)
  end

  get '/sign-up' do
    erb(:sign_up)
  end

  get '/spaces' do
    @spaces = Space.all
    erb(:spaces)
  end

  get '/spaces/:id' do
    @space = Space.select_space(params[:id])
    session[:space] = @space
    erb(:booking)
  end

  post '/requests' do
    @space = session[:space]
    host_id = @space[:host_id]
    guest_id = 17
    #guest_id = session[:user_id]
    space_id = @space[:space_id]
    date = params[:stay]
    BookingRequest.create(space_id, host_id, guest_id, date)
    redirect '/requests'
  end

  get '/requests' do
    @booking_requests = BookingRequest.all
    erb(:requests)
  end



end

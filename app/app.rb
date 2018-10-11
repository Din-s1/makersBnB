require 'sinatra'
require 'pg'
require 'bcrypt'
require_relative "./../spec/dbhelper.rb"
require_relative "./models/space.rb"
require_relative "./models/booking_request.rb"
require_relative "./models/user.rb"

class MakersBnbManager < Sinatra::Base
  enable :sessions

  def logged_in?
    !session[:username].nil?
  end

  def username
    session[:username]
  end

  get '/' do
    'Hello, World!';
    erb(:index)
  end

  get '/sign-up' do
    erb(:sign_up)
  end

  post '/sign-up' do
    password = BCrypt::Password.create(params[:password])
    username = params[:username]
    email = params[:email]
    User.create(username, email, password)
    redirect '/sign-in'
  end

  get '/sign-in' do
    erb(:sign_in)
  end

  post '/sign-in' do
    if User.view(params[:username]).nil?
      # flash no user
      redirect '/'
    end

    db_password = BCrypt::Password.new(User.view(params[:username])[:password])
    if db_password == params[:password]
      session[:username] = params[:username]
      redirect '/spaces'
    else
      # flash error
      redirect '/'
    end
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

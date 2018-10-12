require 'sinatra'
require 'pg'
require 'bcrypt'
require_relative "./../spec/dbhelper.rb"
require_relative "./models/space.rb"
require_relative "./models/booking_request.rb"
require_relative "./models/user.rb"

class MakersBnbManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'makersbnb_secret'
  
  def logged_in?
    !session[:username].nil?
  end

  def username 
    session[:username]
  end

  get '/' do
    @logged_in = logged_in?
    @username = username
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
      redirect '/options'
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
    space_id = session[:space][:id]
    host_id = session[:space][:host_id]
    guest_id = User.view(session[:username])[:id]
    date = params[:stay]
    
    BookingRequest.create(space_id, host_id, guest_id, date)
    redirect '/requests'
  end

  get '/requests' do
    guest_id = User.view(username)[:id]
    @booking_requests = BookingRequest.guest_pending_requests(guest_id)
    erb(:requests)
  end

  get '/options' do
    @username = session[:username]
    erb(:options)
  end

  get '/space_manager' do
    user_id = User.view(session[:username])[:id]
    @spaces = Space.list_with_requests(user_id)
    erb(:space_manager)
  end

  post '/accept_booking' do
    BookingRequest.accept(params[:booking_request_id])
    redirect '/space_manager'
  end

  post '/decline_booking' do
    BookingRequest.decline(params[:booking_request_id])
    redirect '/space_manager'
  end


  post '/space_manager' do
    user_id = User.view(session[:username])[:id]
    Space.create(params[:description], params[:location], params[:price], user_id, params[:date])
    redirect '/space_manager'
  end
end

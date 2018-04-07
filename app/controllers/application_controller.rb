require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "supersecret"
  end

  get '/' do
    if logged_in?
      @cities = current_user.cities
      erb :index
    else
      erb :index
    end
  end

  get '/index' do
    @cities = current_user.cities
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

end

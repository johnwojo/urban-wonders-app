class CitiesController < ApplicationController

    get '/cities' do
      if logged_in?
        @cities = City.all
      erb :'cities/cities'
      else
        redirect to '/login'
      end
    end

    get '/cities/new' do
      if logged_in?
        erb :'cities/create_city'
      else
        redirect to '/login'
      end
    end

end

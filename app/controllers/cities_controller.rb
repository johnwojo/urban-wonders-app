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

post '/cities' do
    if logged_in?
      if params[:name] == ""
        redirect to '/cities/new'
      else
        @city = current_user.cities.build(name: params[:name])
        if @city.save
          redirect to "/cities/#{@city.id}"
        else
          redirect to '/cities/new'
        end
      end
    else
      redirect to "/login"
    end
  end


  get '/cities/:id' do
    if logged_in?
      @city = City.find_by_id(params[:id])
      erb :'/cities/show_city'
    else
      redirect to '/login'
    end
  end

end

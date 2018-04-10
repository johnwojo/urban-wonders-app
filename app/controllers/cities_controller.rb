class CitiesController < ApplicationController

  get '/cities' do
    if logged_in?
      @cities = current_user.cities
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

  get '/cities/:id' do
    if logged_in?
      @city = City.find_by_id(params[:id])
      erb :'/cities/show_city'
    else
      redirect to '/login'
    end
  end


  get '/cities/:id/edit' do
    if logged_in?
      @city = City.find_by_id(params[:id])
      if @city
        # && @city.user == current_user
        erb :'cities/edit_city'
      else
        redirect to '/cities'
      end
    else
      redirect to '/login'
    end
  end



  post '/cities' do
    if logged_in?
      if params[:name] == ""
        redirect to '/cities/new'
      else
        @city = City.create(:name => params[:name])
        @city.save
        @current_user.cities << @city
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

  patch '/cities/:id' do
    if logged_in?
      if params[:name] == ""
        redirect to "/cities/#{params[:id]}/edit"
      else
        @city = City.find_by_id(params[:id])
        @city.name = params[:name]
        @city.save
        redirect to "/cities/#{@city.id}"
      end
    else
      redirect to '/login'
    end
  end


  delete '/cities/:id/delete' do
    if logged_in?
      @city = City.find_by_id(params[:id])
      if @city
        #  && @city.user == current_user
        @city.delete
      end
      redirect to '/cities'
    else
      redirect to '/login'
    end
  end
end

class TasksController < ApplicationController
  get '/tasks' do
    if logged_in?
      @tasks = Task.all
      erb :'tasks/tasks'
    else
      redirect to '/login'
    end
  end

  get '/tasks/new' do
    if logged_in?
      erb :'tasks/create_task'
    else
      redirect to '/login'
    end
  end

  post '/tasks' do
    if logged_in?
      if params[:name] == ""
        redirect to '/tasks/new'
      else
        @task = Task.new(params[:task])
        @task.city = City.create(name: params["city"]["name"])
        @task.save
        if @task.save
          redirect to "/tasks/#{@task.id}"
        else
          redirect to '/tasks/new'
        end
      end
    else
      redirect to "/login"
    end
  end

  get '/tasks/:id' do
    if logged_in?
      @task = Task.find_by_id(params[:id])
      erb :'/tasks/show_task'
    else
      redirect to '/login'
    end
  end

  get '/tasks/:id/edit' do
    if logged_in?
      @task = Task.find_by_id(params[:id])
      if @task
        # && @city.user == current_user
        erb :'tasks/edit_task'
      else
        redirect to '/tasks'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tasks/:id' do
    if logged_in?
      if params[:name] == ""
        redirect to "/tasks/#{params[:id]}/edit"
      else
        @task = Task.find_by_id(params[:id])
        @task.name = params[:name]
        @task.description = params[:description]
        @task.save
        redirect to "/tasks/#{@task.id}"
      end
    else
      redirect to '/login'
    end
  end


  delete '/tasks/:id/delete' do
    if logged_in?
      @task = Task.find_by_id(params[:id])
      if @task
        #  && @city.user == current_user
        @task.delete
      end
      redirect to '/tasks/'
    else
      redirect to '/login'
    end
  end
end

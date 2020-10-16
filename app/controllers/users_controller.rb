class UsersController < ApplicationController
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
      end
    get "/signup" do
        
        if !logged_in?
            erb :'/users/signup'
          else
            redirect to '/items'
        end
    end
    post '/signup' do
        
        if params[:email] == "" || params[:username] == "" || params[:password] == ""
            redirect '/users/signup'
        else
            @user = User.create(username: params[:username], password: params[:password])

            session[:user_id] = @user.id
            redirect '/items'
        end
    end
    get '/login' do
        if !logged_in?
            
            erb :'users/login'
          else
            redirect to '/items'
        end
    end
    post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id

            redirect to '/items'
        else
            redirect "/users/signup"
        end
    end
    get "/logout" do

        if logged_in?
            session.destroy
            redirect to '/login'
        else
            redirect to '/'
        end
    end
end
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
end
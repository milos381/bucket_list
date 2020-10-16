class ItemsController < ApplicationController
    get '/items' do
        if logged_in?
          @items = Item.all
          erb :'items/items'
        else
          redirect to '/login'
        end
    end
    get '/items/new' do
        if logged_in?
          erb :'items/create_item'
        else
          redirect to '/login'
        end
    end
    
end
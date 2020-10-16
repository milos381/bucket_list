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
    post '/items' do
        #if logged in and content empty - go "back" to start
        #if logged in and content !empty - build (create but for multiple)
        #if logged in and item CAN be saved, redirect to the very item that was created
        #if logged in and not able to save, go "back" and start all over
        if logged_in?
          if params[:content] == ""
            redirect to "/items/new"
          else
            @item = current_user.items.build(content: params[:content])
            if @item.save
              redirect to "/items/#{@item.id}"
            else
              redirect to "/items/new"
            end
          end
        else
          redirect to '/login'
        end
    end
    get '/items/:id' do
        if logged_in?
          @item = Item.find_by_id(params[:id])
          erb :'items/show_item'
        else
          redirect to '/login'
        end
      end
end
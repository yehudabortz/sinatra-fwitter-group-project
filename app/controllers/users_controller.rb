class UsersController < ApplicationController


    get '/signup' do 

        if !logged_in?
            erb :'users/create_user'
        else
            redirect '/tweets'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == "" 
            redirect '/signup'
        else
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end
    
    get '/login' do 
        if !logged_in?
            erb :'users/login'
        else
            redirect '/tweets'
        end
    end
    
    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/'
        else
            redirect '/login'
        end
    end

    get '/show' do
        if logged_in?
            @user = current_user
            erb :'users/show'
        else
            redirect '/login'
        end

    end
    

    get '/logout' do
        if logged_in?
          session.destroy
          redirect to '/login'
        else
          redirect to '/'
        end
      end


end



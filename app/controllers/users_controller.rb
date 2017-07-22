class UsersController < ApplicationController
    #Index page
    def index
    @users = User.all
    end
    
    #New user page
    def new
        @user = User.new
    end
    
    #Create user
    def create
        #debugger
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome to the alpha blog #{@user.username}!"
            redirect_to articles_path
        else
            render 'new'
        end
    end
    
    #Edit user page
    def edit
        @user = User.find(params[:id])
    end
    
    #Update
    def update
        @user = User.find(params[:id]) 
        if @user.update(user_params)
            flash[:success] = "Successfully updated #{@user.username}'s account!"
            redirect_to articles_path
        else
            render 'edit'
        end
    end
    
    #Show user page
    def show
        #debugger
        @user = User.find(params[:id]) 
    end
    
    private
    
    #Reinforces User parameters
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end

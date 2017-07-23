class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:destroy]
    #Index page
    def index
    @users = User.paginate(page: params[:page], per_page: 5)
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
            session[:user_id] = @user.id
            flash[:success] = "Welcome to the alpha blog #{@user.username}!"
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end
    
    #Edit user page
    def edit
        #@user = User.find(params[:id])
    end
    
    #Update
    def update
        #@user = User.find(params[:id]) 
        if @user.update(user_params)
            flash[:success] = "Successfully updated #{@user.username}'s account!"
            redirect_to articles_path
        else
            render 'edit'
        end
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger] = "User and all articles have been destroyed"
        redirect_to users_path
    end
    
    #Show user page
    def show
        #debugger
        #@user = User.find(params[:id]) 
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end
    
    private
    
    #Reinforces User parameters
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
        @user = User.find(params[:id])
    end
    def require_same_user
        if current_user != @user and !current_user.admin?
            flash[:danger] = 'You can only edit your own user account'
        end
    end
    def require_admin
        if logged_in? and !current_user.admin?
            flash[:danger] = 'Only admin users may perform that action'
            redirect_to root_path
        end
    end
end

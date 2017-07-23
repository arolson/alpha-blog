class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy] # calls within the functions
    before_action :reguire_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    # Index: Display all Articles
    def index
        #@article = Article.all
        @articles = Article.paginate(page: params[:page], per_page: 5) 
    end
    
    # New: Article to create
    def new
        @article = Article.new
    end
    
    # Create: New Article
    def create
        # debugger
        @article = Article.new(article_params) #create a new article
        #@article.user = User.first #temporary
        @article.user = current_user
       if @article.save
           flash[:success] = "Article was successfully created" #Flash a message..views/layouts/application.html.erb
           redirect_to article_path(@article) #redirects to the article
       else
           render 'new' # Reload the new article page
       end
    end
    
    # Show: Created article
    def show
        
    end
    
    # Edit: Existing Article
    def edit
       
    end
    
    # Update: Existing Article
    def update
        
        if @article.update(article_params)
            @article.save
            flash[:success] = "Article was successfully updated" #Flash a message..views/layouts/application.html.erb
            redirect_to article_path(@article) #redirects to the article
        else
            render 'edit'
        end
    end
    
    # Destroy: Selected Article
    def destroy
        
        @article.destroy
        flash[:danger] = "The article was successfully destroyed"
        redirect_to articles_path
    end
   
    private
    def article_params
        params.require(:article).permit(:title, :description, :private)
    end
    
    def set_article
       @article = Article.find(params[:id]) 
    end
    
    def require_same_user
        if current_user != @article.user and !current_user.admin?
            flash[:danger] = "You can only edit or delete your own article"
            redirect_to root_path
        end
    end
    
end

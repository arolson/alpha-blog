class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy] # calls within the functions
    # New: Article to create
    def new
        @article = Article.new
    end
    
    # Create: New Article
    def create
        #render plain: params[:article].inspect
        @article = Article.new(article_params) #create a new article
       if @article.save
           flash[:notice] = "Article was successfully created" #Flash a message..views/layouts/application.html.erb
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
            flash[:notice] = "Article was successfully updated" #Flash a message..views/layouts/application.html.erb
            redirect_to article_path(@article) #redirects to the article
        else
            render 'edit'
        end
    end
    
    # Index: Display all Articles
    def index
       @articles = Article.all 
    end
    
    # Destroy: Selected Article
    def destroy
        
        @article.destroy
        flash[:notice] = "The article was successfully destroyed"
        redirect_to articles_path
    end
    
    private
    def article_params
        params.require(:article).permit(:title, :description)
    end
    
    def set_article
       @article = Article.find(params[:id]) 
    end
end

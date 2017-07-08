class ArticlesController < ApplicationController

    def new
        @article = Article.new
    end
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
    
    def show
        @article = Article.find(params[:id])
    end
    
    private
    def article_params
        params.require(:article).permit(:title, :description)
    end
end

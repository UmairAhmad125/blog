class CommentsController < ApplicationController

    http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params)
        redirect_to article_path(@article)
    end

    def edit
        @comment = Article.find(params[:article_id]).comments.find(params[:id])
    end

    def update
        byebug
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
            redirect_to @comment.article
        else
            render 'edit'
        end
    end
    
    def destroy
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        @comment.destroy
        redirect_to article_path(@article)
    end

    private
    def comment_params
        #byebug
        params.require(:comment).permit(:commenter, :body)
    end
end

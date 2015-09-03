class CommentsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    if @comment = @recipe.comments.create(comment_params)
      flash[:success] = "Your post has been added"
      redirect_to @recipe
    else
      render 'new'
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @comment = @recipe.comments.find_by(id: params[:id])

    @comment.destroy
    flash[:success] = "Your comment has been deleted"
    redirect_to :back
  end

  def comment_params
    comment_values = {
        :name => current_user.name,
        :content => params[:comment][:content],
        :user_id => current_user.id
    }
    return comment_values
  end
end

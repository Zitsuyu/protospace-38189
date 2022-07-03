class CommentsController < ApplicationController
 
  def create
    @comment = Comment.new(prototype_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototypes = @comment.prototype
      render "prototypes/show"
    end
  end

  private
  def prototype_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end

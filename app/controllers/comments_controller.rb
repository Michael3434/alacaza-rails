class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save!
      @comment.update(user: current_user)
      @message = @comment.message
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :message_id)
  end
end

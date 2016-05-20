class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save!
      @comment.update(user: current_user)
      @message = @comment.message
      notifier
    end
  end

  def notifier
    Notifier.new_comment_sent(@comment)
    User.where(building_id: @message.building_id).where.not(id: @comment.user.id).each do |user|
      UserMailer.new_comment(@comment, user).deliver_now!
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :message_id)
  end
end

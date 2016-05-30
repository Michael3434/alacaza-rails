class CommentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]
  def create
    @comment = Comment.new(comment_params)
    if @comment.save!
      @comment.update(user: current_user)
      @message = @comment.message
      notifier
    end
  end

  def notifier
    SlackNotifierWorker.perform_async(:new_comment, comment_id: @comment.id)
    # Notifier.new_comment_sent(@comment)
    User.where(building_id: @message.building_id).where.not(id: @comment.user.id).each do |user|
      # UserMailer.new_comment(@comment, user).deliver_now!
      Mailer::UserMailerWorker.perform_async(:new_comment, comment_id: @comment.id, user_id: user.id)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :message_id)
  end
end

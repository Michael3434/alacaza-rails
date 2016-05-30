class Mailer::UserMailerWorker
  include Sidekiq::Worker

  def perform(method, params)
    message = Message.where(id: params["message_id"]).first
    comment = Comment.where(id: params["comment_id"]).first
    user = User.where(id: params["user_id"]).first

    case method
    when "new_message"
      arguments = [message, user]
    when "new_comment"
      arguments = [comment, user]
    when "welcom"
      arguments = [user]
    end

    UserMailer.send(method, *arguments).deliver!
  end
end

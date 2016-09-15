class Mailer::UserMailerWorker
  include Sidekiq::Worker

  def perform(method, params)
    message = Message.where(id: params["message_id"]).first
    comment = Comment.where(id: params["comment_id"]).first
    user = User.where(id: params["user_id"]).first
    password = params["password"]

    case method
    when "new_message"
      arguments = [message, user]
    when "new_comment"
      arguments = [comment, user]
    when "welcome"
      arguments = [user]
    when "password_email"
      arguments = [user, password]
    when "welcome_with_password"
      arguments = [user, password]
    end

    UserMailer.send(method, *arguments).deliver!
  end
end

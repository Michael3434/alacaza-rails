class SlackNotifierWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(method, params)
    message = Message.where(id: params["message_id"]).first
    user = User.where(id: params["user_id"]).first
    comment = Comment.where(id: params["comment_id"]).first

    case method
    when "new_message"
      arguments = [message]
    when "new_comment"
      arguments = [comment]
    when "new_message_page_view"
      arguments = [user]
    when "new_user"
      arguments = [user]
    end

    Notifier.send(method, *arguments)
  end
end

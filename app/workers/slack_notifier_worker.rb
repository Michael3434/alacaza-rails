class SlackNotifierWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(method, params)
    message = Message.where(id: params["message_id"]).first
    channel = Channel.where(id: params["channel_id"]).first
    user = User.where(id: params["user_id"]).first
    comment = Comment.where(id: params["comment_id"]).first
    lead = Lead.where(id: params["lead_id"]).first
    post = Post.where(id: params["post_id"]).first
    item = Item.where(id: params["item_id"]).first
    invitation = Invitation.where(id: params["invitation_id"]).first

    case method
    when "new_message"
      arguments = [message]
    when "new_message_from_gardien"
      arguments = [message]
    when "new_comment"
      arguments = [comment]
    when "new_message_page_view"
      arguments = [user]
    when "new_user"
      arguments = [user]
    when "new_lead"
      arguments = [lead]
    when "new_like"
      arguments = [message, user]
    when "new_post"
      arguments = [post]
    when "new_channel"
      arguments = [channel]
    when "new_invitation"
      arguments = [invitation]
    when "item_sold"
      arguments = [item]
    when "item_created"
      arguments = [item]
    when "item_destroyed"
      arguments = [item]
    end

    Notifier.send(method, *arguments)
  end
end

class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]
  def create
    @message = current_user.messages.build(body: params["message"]["body"], building_id: current_user.building_id)
    @building_name = @message.user.building.name
    if @message.save!
      message_notifier
    end
  end

  def message_notifier
    # unless Rails.env == "development"
      User.where(building_id: @message.building_id).where.not(id: @message.user.id).each do |user|
        Mailer::UserMailerWorker.perform_async(:new_message, message_id: @message.id, user_id: user.id)
      end
      # Notifier.new_message_sent(@message)
      SlackNotifierWorker.perform_async(:new_message, message_id: @message.id)
    # end
  end
end

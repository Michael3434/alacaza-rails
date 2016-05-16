class CommentsController < ApplicationController
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
        UserMailer.new_message(@message, user).deliver_now!
      end
      Notifier.new_message_sent(@message)
    # end
  end
end

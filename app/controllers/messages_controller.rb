class MessagesController < ApplicationController
  def create
    @message = current_user.messages.build(body: params["message"]["body"], building_id: current_user.building_id)
    if @message.save!
      UserMailer.new_message(@message).deliver_now!
    end
  end
end

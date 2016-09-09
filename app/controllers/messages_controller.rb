class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create, :add_like, :vote, :remove_like]
  def create
    @message = current_user.messages.build(message_params)
    @building_name = @message.user.building.name
    @building = @message.user.building
    if @message.save
      if @message.user = User.where(email: "r.seigneur@free.fr").last
        @message.update(validated: false)
        SlackNotifierWorker.perform_async(:new_message, message_id: @message.id)
      else
        message_notifier
      end
    end
  end

  def message_notifier
    unless Rails.env.in?(["staging"])
      User.to_be_notify(@message).each do |user|
        Mailer::UserMailerWorker.perform_async(:new_message, message_id: @message.id, user_id: user.id)
      end
      SlackNotifierWorker.perform_async(:new_message, message_id: @message.id)
    end
  end

  def new_photo
  end

  def add_like
    @message = Message.find(params[:message_id])
    unless @message.users_like_id.include?(current_user.id)
      @message.users_like_id << current_user.id
      @message.save
      SlackNotifierWorker.perform_async(:new_like, message_id: @message.id, user_id: current_user.id)
    end
  end

  def vote
    @option = params[:option]
    @message = Message.find(params[:message_id])
    @message.clean_vote(current_user.id)
    @message.send("vote_for_#{@option}") << current_user.id
    @message.save
  end

  def remove_like
    @message = Message.find(params[:message_id])
    ids = @message.users_like_id
    @message.users_like_id = ids - [current_user.id]
    @message.save
  end

  private

  def message_params
    params.require(:message).permit(
    :body,
    :channel_id,
    :building_id,
    :photo,
    :as_vote_option,
    :option_1,
    :option_2,
    :option_3,
    :vote_for_option_1 => [],
    :vote_for_option_2 => [],
    :vote_for_option_3 => [],
    :users_like_id => [])
  end
end

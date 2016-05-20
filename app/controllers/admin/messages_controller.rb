class Admin::MessagesController < AdminController
  def index
    @messages = Message.all
  end
end

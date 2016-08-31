class Admin::StatsController < AdminController
  MONTHS = (Date.parse("01/12/2015")..Date.today).to_a.group_by { |d| d.strftime("%m/%Y") }.keys

  def index
    get_stats_signup
    get_stats_messages
  end

  def get_stats_signup
    @users_count = User.all.count
    @users = User.group_by_week(:created_at).count
  end

  def get_stats_messages
    messages = Message.joins(:user).where('users.email != ?', "hello@alacaza.fr")
    @messages_count = messages.all.count
    @messages = messages.group_by_week('messages.created_at').count
  end
end

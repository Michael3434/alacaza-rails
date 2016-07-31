class Admin::StatsController < AdminController
  MONTHS = (Date.parse("01/12/2015")..Date.today).to_a.group_by { |d| d.strftime("%m/%Y") }.keys

  def index
    get_stats_signup
  end

  def get_stats_signup
    @user_count = User.all.count
    @user = User.group_by_week(:created_at).count
  end
end

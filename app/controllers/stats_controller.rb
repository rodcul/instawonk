class StatsController < ApplicationController
  def index
    @user_count = User.where().not(username: nil, checked_instagram: nil).count
    @user_count_no_username = User.where(username: nil, checked_instagram: nil).count
    @users_last_24h = User.where().not(username: nil).where(checked_instagram: (Time.now - 24.hours)..Time.now).group_by_hour_of_day(:checked_instagram).count
    @users_last_90d = User.where().not(username: nil).where(checked_instagram: (Time.now - 90.days)..Time.now).group_by_day(:checked_instagram).count
  end
end

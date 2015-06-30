class StatsController < ApplicationController
  def index
    @user_count = User.where.not(username: nil).count
    @users_last_24h = User.where().not(username: nil).where(checked_instagram: (Time.now - 24.hours)..Time.now)
  end
end

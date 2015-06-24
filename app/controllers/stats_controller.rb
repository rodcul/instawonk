class StatsController < ApplicationController
  def index
    @users_last_24h = User.where().not(username: nil).where(created_at: (Time.now - 24.hours)..Time.now)
  end
end

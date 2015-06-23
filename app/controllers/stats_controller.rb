class StatsController < ApplicationController
  def index
    @users = User.where().not(username: nil).where(created_at: (Time.now - 24.hours)..Time.now)
  end
end

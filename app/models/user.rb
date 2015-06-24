class User < ActiveRecord::Base
  validates :username, uniqueness: true, allow_nil: true
  validates :instagram_id, uniqueness: true, allow_nil: false
  # paginates_per 50

  def self.search(search_term)
    where("bio ilike ?", "%#{search_term}%")
  end

end

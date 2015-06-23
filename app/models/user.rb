class User < ActiveRecord::Base
  validates :username, uniqueness: true, allow_nil: true

  def self.search(search_term)
    where("bio like ?", "%#{search_term}%")
  end

end

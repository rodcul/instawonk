class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  def self.search(search_term)
    where("bio like ?", "%#{search_term}%") 
  end

end

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:bio) {['yoga','football','photography'].sample }
    follows Random.rand(1000)
    followed_by Random.rand(1000)
    media Random.rand(1000)
    checked_instagram Time.new
    sequence(:instagram_id) { |n| n + 10000 }
  end

end

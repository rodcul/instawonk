FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:instagram_id) { |n| n + 10000 }
    follows Random.rand(1000)
    followed_by Random.rand(1000)
    media Random.rand(1000)
    checked_instagram Time.new
  end

end

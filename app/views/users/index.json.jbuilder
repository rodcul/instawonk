json.array!(@users) do |user|
  json.extract! user, :id, :username, :full_name, :profile_picture, :bio, :website, :media, :follows, :followed_by
  json.url user_url(user, format: :json)
end

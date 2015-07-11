# require 'byebug'
namespace :instagram_api do
  desc 'Import data from Instagram'
  task get_users: :environment do
      counter_successes = 0
      counter_fails = 0
      5.times do
        @first_call = HTTParty.get('https://api.instagram.com/v1/users/25025320/followed-by?access_token=2132188018.130ce4b.1febb483dd044f0982ff9b1d882e1c20')
        @data_first = @first_call.parsed_response['data']
        @data_first.each do |data|
          user = User.create(instagram_id: data['id'])
          user.errors.messages == { instagram_id: ['has already been taken'] } ? counter_fails += 1 : counter_successes += 1
        end
      end
      ActiveRecord::Base.logger.debug "instagram_api:get_users:  users_added = #{counter_successes}, users_exists = #{counter_fails}"
  end

  desc 'Import data from Instagram'
  task get_user_data: :environment do
    counter_successes = 0
    counter_fails = 0
    @users = User.where(username: nil, checked_instagram: nil).limit 400

    @users.each do |user|
      @second_call = HTTParty.get('https://api.instagram.com/v1/users/' + user.instagram_id.to_s + '?access_token=3593753.1fb234f.3d48a82cf7644fd8a6b8a6fa7d10bbd2')
      @data = @second_call.parsed_response['data']
      unless @data.nil?
        user.update(username: @data['username'],
                    full_name: @data['full_name'],
                    bio: @data['bio'],
                    website: @data['website'],
                    media: @data['counts']['media'],
                    follows: @data['counts']['follows'],
                    followed_by: @data['counts']['followed_by'],
                    profile_picture: @data['profile_picture'],
                    checked_instagram: Time.now)
        counter_successes += 1
      else
          user.update(checked_instagram: Time.now)
          counter_fails += 1
      end
    end
    ActiveRecord::Base.logger.debug "instagram_api:get_user_data: users_public_profile = #{counter_successes}, users_private_profile = #{counter_fails}"
  end
end

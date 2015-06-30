namespace :instagram_api do
  desc 'Import data from Instagram'
  task get_users: :environment do
    # get_users
    get_user_data
  end
  def get_users
    10.times do
      @first_call = HTTParty.get('https://api.instagram.com/v1/users/25025320/followed-by?access_token=2132188018.130ce4b.1febb483dd044f0982ff9b1d882e1c20')
      @data_first = @first_call.parsed_response['data']
      @data_first.each do |data|
        User.create(instagram_id: data['id'])
      end
      ActiveRecord::Base.logger.debug '250 users created'
      puts "50 users created"
    end
  end

  def get_user_data
    @users = User.where(username: nil, checked_instagram: nil).limit 250
    @users.each do |user|
      user.update(checked_instagram: Time.now)
      @second_call = HTTParty.get('https://api.instagram.com/v1/users/' + user.instagram_id.to_s + '?access_token=3593753.1fb234f.3d48a82cf7644fd8a6b8a6fa7d10bbd2')
      @data_second = @second_call.parsed_response['data']
      unless @data_second.nil?
        user.update(username: @data_second['username'],
                      full_name: @data_second['full_name'],
                      bio: @data_second['bio'],
                      website: @data_second['website'],
                      media: @data_second['counts']['media'],
                      follows: @data_second['counts']['follows'],
                      followed_by: @data_second['counts']['followed_by'],
                      profile_picture: @data_second['profile_picture'])
      user.inspect
      end
    end
  end
end

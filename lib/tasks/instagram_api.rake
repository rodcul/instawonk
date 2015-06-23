require 'byebug'

namespace :instagram_api do
  desc "TODO"
  task get_users: :environment do
     @first_call = HTTParty.get('https://api.instagram.com/v1/users/25025320/followed-by?access_token=2132188018.130ce4b.1febb483dd044f0982ff9b1d882e1c20')
    @data_first = @first_call.parsed_response["data"]

    @data_first.each do |data|

      User.create(instagram_id: data["id"])
      @user = User.find_by(instagram_id: data["id"])
      @second_call = HTTParty.get('https://api.instagram.com/v1/users/' + @user.instagram_id.to_s + '/?access_token=2132188018.130ce4b.1febb483dd044f0982ff9b1d882e1c20')
      @data_second = @second_call.parsed_response["data"]

        if @data_second != nil

          if @data_second["username"] != nil && @data_second["full_name"] != nil && @data_second["bio"] != nil && @data_second["counts"]["follows"] != nil && @data_second["counts"]["followed_by"] != nil

             @user.update(username: @data_second["username"],full_name: @data_second["full_name"], bio: @data_second["bio"],follows: @data_second["counts"]["follows"], followed_by: @data_second["counts"]["followed_by"])
          end

          if @data_second["profile_picture"] != nil
            @user.update(profile_picture: @data_second["profile_picture"])
          end

        end
      end
  end

  desc "TODO"
  task get_user_data: :environment do
  end

end

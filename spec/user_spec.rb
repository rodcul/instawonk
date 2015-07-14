require 'rails_helper'

describe User do
  it {should validate_uniqueness_of(:username)}
  it {should validate_uniqueness_of(:instagram_id)}
end

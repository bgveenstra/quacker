require 'rails_helper'

RSpec.describe User, type: :model do
  let! (:user) do
    User.create({username: "Morocco", email:"stupid@dumb.com", password:"sup"})
  end
  describe "validations" do
    it { should validate_presence_of :username }
    it { should validate_presence_of :email  }
    it { should validate_presence_of :password }
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:email) }
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_length_of(:password).is_at_most(20) }
    it { should have_many(:tweets) }
    it { should have_many(:comments) }
    it { should have_many(:following) }
    it { should have_many(:followers) }
    it { expect(user).to_not allow_value("DUMMY").for(:email) }
    it { expect(user).to_not allow_value("foo@bar").for(:email) }
    it { expect(user).to allow_value("foo@bar.com").for(:email) }
  end
end

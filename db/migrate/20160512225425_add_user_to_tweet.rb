class AddUserToTweet < ActiveRecord::Migration
  def change
    add_reference :tweets, :user, index: true, foreign_key: true
  end
end

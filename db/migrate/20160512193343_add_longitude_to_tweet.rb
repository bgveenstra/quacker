class AddLongitudeToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :longitude, :float
  end
end

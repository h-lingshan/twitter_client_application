class CreateTweetNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :tweet_notes do |t|
      t.string :tweet_author 
      t.string :tweet
      t.string :user_uid
      t.timestamps
    end
  end
end

class CreateLikeTos < ActiveRecord::Migration
  def change
    create_table :like_tos do |t|
      t.integer :user_id
      t.integer :url_id

      t.timestamps
    end
  end
end

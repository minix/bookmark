class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.string :tag
      t.string :state
      t.integer :bm_user_id
      t.boolean :bm_share

      t.timestamps
    end
  end
end

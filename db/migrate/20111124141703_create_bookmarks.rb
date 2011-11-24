class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.string :tag
      t.string :state
      t.string :bm_user_name
      t.text :description
      t.boolean :saved

      t.timestamps
    end
  end
end

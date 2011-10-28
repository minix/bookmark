class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.string :tag
      t.string :state

      t.timestamps
    end
  end
end

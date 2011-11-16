class Bookmark < ActiveRecord::Migration
  def up
    add_column :description => "text"
  end

  def down
  end
end

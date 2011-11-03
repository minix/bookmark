class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment
      t.integer :comment_user
      t.integer :comment_bm

      t.timestamps
    end
  end
end

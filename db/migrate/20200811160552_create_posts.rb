class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :description
      t.integer :category
      t.string :image

      t.timestamps
    end
  end
end

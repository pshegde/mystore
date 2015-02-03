class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :desc
      t.string :image_link

      t.timestamps null: false
    end
  end
end

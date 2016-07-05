class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :title
      t.float :price
      t.string :negotiable
      t.string :location
      t.text :description
      t.string :status
      t.string :kind
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

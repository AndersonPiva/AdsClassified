class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :comment
      t.references :receiver, index: true, foreign_key: true
      t.references :sender, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

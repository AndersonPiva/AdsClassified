class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :star
      t.text :comment
      t.references :rated, index: true, foreign_key: true
      t.references :evaluator, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

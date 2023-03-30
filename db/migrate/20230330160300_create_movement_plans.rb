class CreateMovementPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :movement_plans do |t|
      t.references :movement, null: false, foreign_key: true
      t.references :progression, null: false, foreign_key: true
      t.references :block, null: false, foreign_key: true
      t.decimal :initial_weight, precision: 8, scale: 3, null: false, default: 1 # example: 10000.000
      t.integer :initial_reps, limit: 2, null: false, default: 1
      t.integer :initial_sets, limit: 2, null: false, default: 1

      t.timestamps
    end
  end
end

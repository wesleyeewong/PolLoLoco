class CreateProgressions < ActiveRecord::Migration[7.0]
  def change
    create_table :progressions do |t|
      t.integer :min_sets, limit: 2, null: false, default: 1
      t.integer :max_sets, limit: 2, null: false, default: 1
      t.integer :min_reps, limit: 2, null: false, default: 1
      t.integer :max_reps, limit: 2, null: false, default: 1
      t.decimal :weight_increments, precision: 8, scale: 3, null: false, default: 2.5 # example: 10000.000
      t.integer :rep_increments, limit: 2, null: false, default: 1
      t.integer :set_increments, limit: 2, null: false, default: 1
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end

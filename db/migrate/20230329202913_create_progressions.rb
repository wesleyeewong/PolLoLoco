class CreateProgressions < ActiveRecord::Migration[7.0]
  def change
    create_table :progressions do |t|
      t.string :name, null: false
      t.integer :min_sets, limit: 2, null: false, default: 1
      t.integer :max_sets, limit: 2, null: false, default: 1
      t.integer :min_reps, limit: 2, null: false, default: 1
      t.integer :max_reps, limit: 2, null: false, default: 1
      t.decimal :weight_increments, precision: 8, scale: 3, null: false, default: 2.5 # example: 10000.000
      t.integer :rep_increments, limit: 2, null: false, default: 1
      t.integer :set_increments, limit: 2, null: false, default: 1
      t.references :profile, null: false, foreign_key: true
      t.references :movement, null: false, foreign_key: true
      t.decimal :initial_weight, precision: 8, scale: 3, null: false, default: 1
      t.integer :initial_reps, limit: 2, null: false, default: 1 # smallint, range: -32768 to +32767
      t.integer :initial_sets, limit: 2, null: false, default: 1

      t.timestamps
    end

    create_table :days_progressions do |t|
      t.belongs_to :day
      t.belongs_to :progression
    end
  end
end

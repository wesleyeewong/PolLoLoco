class CreateProgressionAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :progression_assignments do |t|
      t.references :progression, foreign_key: true
      t.references :day_assignment, null: false, foreign_key: true
      t.integer :reps, limit: 2, null: false
      t.integer :sets, limit: 2, null: false # smallint, range: -32768 to +32767
      t.integer :rpe, limit: 2, null: false, default: 0
      t.decimal :weight, precision: 8, scale: 3, null: false # example: 10000.000

      t.timestamps
    end
  end
end

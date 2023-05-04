class CreateCompletedSets < ActiveRecord::Migration[7.0]
  def change
    create_table :completed_sets do |t|
      t.integer :reps, limit: 2, null: false # smallint, range: -32768 to +32767
      t.decimal :weight, precision: 8, scale: 3, null:false # example: 10000.000
      t.references :progression_assignment, null: false, foreign_key: true

      t.timestamps
    end
  end
end

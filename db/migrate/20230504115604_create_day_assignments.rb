class CreateDayAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :day_assignments do |t|
      t.references :day, foreign_key: true
      t.references :plan, foreign_key: true
      t.datetime :completed_at
      t.integer :completion, limit: 2, null: false, default: 0

      t.timestamps
    end
  end
end

class CreateDayAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :day_assignments do |t|
      t.references :day, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.integer :completion, limit: 2, array: true, null: false

      t.timestamps
    end
  end
end

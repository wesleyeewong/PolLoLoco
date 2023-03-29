class CreateMovements < ActiveRecord::Migration[7.0]
  def change
    create_table :movements do |t|
      t.string :slug, index: { unique: true }, null: false

      t.timestamps
    end
  end
end

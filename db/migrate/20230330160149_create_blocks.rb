class CreateBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :blocks do |t|
      t.references :day, null: false, foreign_key: true

      t.timestamps
    end
  end
end

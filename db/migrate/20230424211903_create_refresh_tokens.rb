class CreateRefreshTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :refresh_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :jti

      t.timestamps
    end
    add_index :refresh_tokens, :jti, unique: true
  end
end

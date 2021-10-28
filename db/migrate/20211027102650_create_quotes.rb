class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.text :quotes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

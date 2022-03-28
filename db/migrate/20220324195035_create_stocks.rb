class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :name, index: { unique: true }
      t.belongs_to :bearer

      t.timestamps
    end
  end
end

class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.integer :category_id,               null: false
      t.string :name,             null: false
      t.text :detail,              null: false
      t.integer :price,             null: false
      t.integer :condition_id,             null: false
      t.integer :ship_resp_id,             null: false
      t.integer :ship_from_id,             null: false
      t.integer :ship_period_id,             null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

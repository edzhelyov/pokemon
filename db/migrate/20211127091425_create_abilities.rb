class CreateAbilities < ActiveRecord::Migration[6.1]
  def change
    create_table :abilities do |t|
      t.integer :original_id, unique: true, index: true
      t.string :name, unique: true
      t.text :flavors

      t.timestamps
    end
  end
end

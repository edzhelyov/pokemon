class CreateTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :types do |t|
      t.string :name, unique: true
      t.integer :original_id
      t.string :move_damage_class
      t.text :moves

      t.timestamps
    end
  end
end

class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.string :name, unique: true
      t.integer :height
      t.integer :weight
      t.integer :original_id, unique: true, index: true

      t.timestamps
    end

    create_table :pokemons_types, id: false do |t|
      t.belongs_to :pokemon
      t.belongs_to :type
    end
  end
end

module Pokesync
  extend self

  def sync_types
    response = Pokeapi.types
    offset = 0
    
    while !response[:results].empty?
      response[:results].each do |type|
        details = Pokeapi.type type[:name]

        t = Type.where(original_id: details[:id]).first_or_initialize
        t.assign_attributes({
          name: details[:name],
          move_damage_class: details.dig(:move_damage_class, :name),
          moves: details[:moves].map { |move| move[:name] }.sort,
        })
        t.save if t.changed?

        offset += 1
        response = Pokeapi.types offset: offset
      end
    end
  end
end

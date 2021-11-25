module Pokesync
  extend self

  def sync_all
    sync_types
    sync_pokemons
  end

  def sync_types
    response = Pokeapi.types
    offset = 0
    
    while !response[:results].empty?
      response[:results].each do |result|
        details = Pokeapi.type result[:name]

        type = Type.where(original_id: details[:id]).first_or_initialize
        type.assign_attributes({
          name: details[:name],
          move_damage_class: details.dig(:move_damage_class, :name),
          moves: details[:moves].map { |move| move[:name] }.sort,
        })
        type.save if type.changed?

        offset += 1
        response = Pokeapi.types offset: offset
      end
    end
  end

  def sync_pokemons(types_cache: Type.types_cache, limit: 2)
    response = Pokeapi.pokemons
    offset = 0
    
    while !response[:results].empty?
      response[:results].each do |result|
        details = Pokeapi.pokemon result[:name]

        pokemon = Pokemon.where(original_id: details[:id]).first_or_initialize
        pokemon.assign_attributes({
          name: details[:name],
          height: details[:height],
          weight: details[:weight],
        })

        types = details[:types].map { |type| types_cache[type.dig(:type, :name)] }
        pokemon.types = types

        pokemon.save if pokemon.changed?

        offset += 1
        break if limit && offset == limit

        response = Pokeapi.pokemons offset: offset
      end
    end
  end
end

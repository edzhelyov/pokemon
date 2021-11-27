module Pokesync
  class Pokemon < Base
    def sync(types_cache:, limit:)
      response = Pokeapi.pokemons
      offset = 0

      while !response[:results].empty?
        response[:results].each do |result|
          details = Pokeapi.pokemon result[:name]

          pokemon = ::Pokemon.where(original_id: details[:id]).first_or_initialize
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
end

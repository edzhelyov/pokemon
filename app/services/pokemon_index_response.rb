class PokemonIndexResponse
  def initialize(pokemons)
    @pokemons = pokemons
  end

  def to_json(*)
    result = {results: []}

    @pokemons.each do |pokemon|
      result[:results] << {
        id: pokemon.id,
        name: pokemon.name,
        types: pokemon.types.map(&:name),
      }
    end

    result.to_json
  end
end

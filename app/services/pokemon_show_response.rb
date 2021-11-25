class PokemonShowResponse
  def initialize(pokemon)
    @pokemon = pokemon
  end

  def to_json(*)
    {
      height: @pokemon.height,
      weight: @pokemon.weight,
    }.to_json 
  end
end

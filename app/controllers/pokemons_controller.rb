class PokemonsController < ApplicationController
  def index
    pokemons = Pokemon.list_pokemons(offset: params[:offset])

    render json: PokemonIndexResponse.new(pokemons)
  end

  def show
    pokemon = Pokemon.find params[:id]

    render json: PokemonShowResponse.new(pokemon)
  end
end

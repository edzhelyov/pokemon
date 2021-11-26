require 'rails_helper'

describe Pokesync do
  it 'saves types taken from the Pokemon API' do
    types = {results: [
      {name: 'normal'},
      {name: 'fighting'},
    ]}
    stub_pokeapi_collection :types, types
    type = {
      move_damage_class: {name: 'physical'},
      moves: [
        {name: 'comet-punch'},
        {name: 'double-slap'},
      ]
    }
    stub_pokeapi :type, type

    expect {
      Pokesync.sync_types
    }.to change(Type, :count).by 2

    expected = {
      original_id: 1,
      name: 'normal',
      move_damage_class: 'physical',
      moves: ['comet-punch', 'double-slap'],
    }

    Type.find_by(name: 'normal').should have_attributes(expected)
  end

  it 'saves pokemons taken from the Pokemon API' do
    normal = Type.create name: 'normal'
    poison = Type.create name: 'poison'

    pokemons = {results: [
      {name: 'bulbasaur'},
      {name: 'ivysaur'},
    ]}
    stub_pokeapi_collection :pokemons, pokemons
    pokemon = {
      height: 60,
      weight: 60,
      types: [
        {type: {name: 'normal'}},
        {type: {name: 'poison'}},
      ]
    }
    stub_pokeapi :pokemon, pokemon

    expect {
      Pokesync.sync_pokemons
    }.to change(Pokemon, :count).by 2

    expected = {
      original_id: 1,
      name: 'bulbasaur',
      height: 60,
      weight: 60,
    }

    pokemon = Pokemon.find_by(name: 'bulbasaur')
    pokemon.should have_attributes(expected)
    pokemon.types.should eq [normal, poison]
  end

  def stub_pokeapi_collection(method, return_value)
    Pokeapi.stub method do |offset: 0|
      if offset > 0
        {results: []}
      else
        return_value
      end
    end
  end

  def stub_pokeapi(method, return_value)
    id = 0

    Pokeapi.stub method do |name|
      id += 1

      {
        id: id,
        name: name,
      }.merge return_value
    end
  end
end

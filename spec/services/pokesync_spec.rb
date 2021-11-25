require 'rails_helper'

describe Pokesync do
  it 'saves types taken from the Pokemon API' do
    types = {results: [
      {name: 'normal'},
      {name: 'fighting'},
    ]}
    Pokeapi.stub :types do |offset: 0|
      if offset > 0
        {results: []}
      else
        types
      end
    end
    id = 0
    Pokeapi.stub :type do |name|
      id += 1
      {id: id,
       name: name,
       move_damage_class: {name: 'physical'},
       moves: [
         {name: 'comet-punch'},
         {name: 'double-slap'},
       ]}
    end

    expect {
      Pokesync.sync_types
    }.to change(Type, :count).by 2

    expected = {
      original_id: 1,
      name: 'normal',
      move_damage_class: 'physical',
      moves: ['comet-punch', 'double-slap'],
    }.stringify_keys

    Type.find_by(name: 'normal').attributes.slice('original_id', 'name', 'move_damage_class', 'moves').should eq expected
  end

  it 'saves pokemons taken from the Pokemon API' do
    Type.create name: 'normal'
    Type.create name: 'poison'

    pokemons = {results: [
      {name: 'bulbasaur'},
      {name: 'ivysaur'},
    ]}
    Pokeapi.stub :pokemons do |offset: 0|
      if offset > 0
        {results: []}
      else
        pokemons
      end
    end
    id = 0
    Pokeapi.stub :pokemon do |name|
      id += 1
      {id: id,
       name: name,
       height: 60,
       weight: 60,
       types: [
         {type: {name: 'normal'}},
         {type: {name: 'poison'}},
       ]}
    end

    expect {
      Pokesync.sync_pokemons
    }.to change(Pokemon, :count).by 2

    expected = {
      original_id: 1,
      name: 'bulbasaur',
      height: 60,
      weight: 60,
    }.stringify_keys

    Pokemon.find_by(name: 'bulbasaur').attributes.slice('original_id', 'name', 'height', 'weight').should eq expected
  end
end

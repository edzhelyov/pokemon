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
end

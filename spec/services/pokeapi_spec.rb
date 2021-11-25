require 'rails_helper'

describe Pokeapi do
  it 'gets type information' do
    body = {name: 'normal',
            id: 1,
            move_damage_class: {name: 'physical'},
            moves: [
              {name: 'double-slap'},
              {name: 'comet-punch'},
            ]}.to_json
    stub_request(:any, "#{Pokeapi::HOST}/type/normal").to_return(body: body)

    response = Pokeapi.type 'normal'

    response.should eq JSON.parse(body)
  end

  it 'gets types list' do
    body = {count: 2,
            next: nil,
            previous: nil,
            results: [
              {name: 'normal'},
              {name: 'fighting'},
            ]}.to_json
    stub_request(:any, "#{Pokeapi::HOST}/type").to_return(body: body)

    response = Pokeapi.types

    response.should eq JSON.parse(body)
  end

  it 'gets next page of types' do
    body = {count: 2,
            next: nil,
            previous: 'https://pokeapi.co/api/v2/type?limit=20&offset=0',
            results: [
              {name: 'normal'},
              {name: 'fighting'},
            ]}.to_json
    stub_request(:any, "#{Pokeapi::HOST}/type?offset=20").to_return(body: body)

    response = Pokeapi.types offset: 1

    response.should eq JSON.parse(body)
  end

  it 'gets pokemon list' do
    body = {count: 2,
            next: nil,
            previous: nil,
            results: [
              {name: 'bulbasaur'},
              {name: 'ivysaur'},
            ]}.to_json
    stub_request(:any, "#{Pokeapi::HOST}/pokemon").to_return(body: body)

    response = Pokeapi.pokemons

    response.should eq JSON.parse(body)
  end

  it 'get next page of types' do
    body = {count: 2,
            next: nil,
            previous: nil,
            results: [
              {name: 'bulbasaur'},
              {name: 'ivysaur'},
            ]}.to_json
    stub_request(:any, "#{Pokeapi::HOST}/pokemon?offset=20").to_return(body: body)

    response = Pokeapi.pokemons offset: 1

    response.should eq JSON.parse(body)
  end

  it 'gets pokemon information' do
    body = {name: 'bulbasaur',
            id: 1,
            height: 60,
            weight: 60,
            types: [
              {slot: 1, type: {name: 'normal'}},
              {slot: 2, type: {name: 'fighting'}},
            ],
           }.to_json
    stub_request(:any, "#{Pokeapi::HOST}/pokemon/bulbasaur").to_return(body: body)

    response = Pokeapi.pokemon 'bulbasaur'

    response.should eq JSON.parse(body)
  end
end

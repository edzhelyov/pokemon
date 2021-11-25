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
end

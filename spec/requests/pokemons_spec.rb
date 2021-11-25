require 'rails_helper'

describe 'Pokemons', type: :request do
  describe 'GET /index' do
    it 'returns pokemons' do
      normal = Type.create name: 'normal'
      poison = Type.create name: 'poison'
      pokemon = Pokemon.create name: 'bulbasaur', types: [normal, poison]

      get '/pokemons'

      response.should have_http_status(:success)

      expected = {
        results: [
          {id: pokemon.id,
           name: pokemon.name,
           types: %w(normal poison)
          }
        ]
      }.to_json
      response.body.should eq expected
    end

    it 'supports offset' do
      stub_const 'Pokemon::LIMIT', 1
      Pokemon.create name: 'bulbasaur'
      ivysaur = Pokemon.create name: 'ivysaur'

      get '/pokemons?offset=1'

      expected = {
        results: [
          {id: ivysaur.id,
           name: ivysaur.name,
           types: [],
          }
        ]
      }.to_json
      response.body.should eq expected
    end
  end

  describe 'GET /show' do
    it 'returns pokemon data' do
      pokemon = Pokemon.create name: 'bulbasaur', height: 60, weight: 60

      get "/pokemons/#{pokemon.id}"

      response.should have_http_status(:success)

      response.body.should eq({height: 60, weight: 60}.to_json)
    end
  end
end

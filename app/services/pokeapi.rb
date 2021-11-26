module Pokeapi
  extend self

  HOST = 'https://pokeapi.co/api/v2'
  LIMIT = 20

  def types(offset: 0)
    url = "#{HOST}/type"
    url += "?offset=#{LIMIT * offset}" if offset > 0

    get url
  end

  def type(name)
    url = "#{HOST}/type/#{name}"

    get url
  end

  def pokemons(offset: 0)
    url = "#{HOST}/pokemon"
    url += "?offset=#{LIMIT * offset}" if offset > 0

    get url
  end

  def pokemon(name)
    url = "#{HOST}/pokemon/#{name}"

    get url
  end

  private

  def get(url)
    response = RestClient.get url, accept: :json

    JSON.parse(response).with_indifferent_access
  end
end

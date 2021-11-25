module Pokeapi
  extend self

  HOST = 'https://pokeapi.co/api/v2'
  LIMIT = 20

  def types(offset: 0)
    url = "#{HOST}/type"
    url += "?offset=#{LIMIT * offset}" if offset > 0

    response = RestClient.get url, accept: :json

    JSON.parse response
  end

  def type(name)
    url = "#{HOST}/type/#{name}"

    response = RestClient.get url, accept: :json

    JSON.parse response
  end
end

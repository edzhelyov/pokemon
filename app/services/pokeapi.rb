module Pokeapi
  extend self

  HOST = 'https://pokeapi.co/api/v2'
  LIMIT = 20

  class << self
    def api(resource)
      define_singleton_method resource.to_s.pluralize do |offset: 0|
        url = "#{HOST}/#{resource.to_s.singularize}"
        url += "?offset=#{LIMIT * offset}" if offset > 0

        get url
      end

      define_singleton_method resource.to_s.singularize do |name|
        url = "#{HOST}/#{resource.to_s.singularize}/#{name}"

        get url
      end
    end
  end

  api :type
  api :ability
  api :pokemon

  private

  def get(url)
    response = RestClient.get url, accept: :json

    JSON.parse(response).with_indifferent_access
  end
end

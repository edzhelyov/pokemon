module Pokesync
  class Ability < Base
    def initialize
      @all_method = :abilities
      @find_method = :ability
      @model = ::Ability
    end

    def assign(details)
      {
        name: details[:name],
        flavors: details[:flavor_text_entries].select { |flavor|
          flavor[:language][:name] == 'en'
        }.map { |flavor| flavor[:flavor_text] }.uniq,
      }
    end
  end
end

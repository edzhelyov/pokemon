class Pokemon < ApplicationRecord
  has_and_belongs_to_many :types, dependent: :destroy

  LIMIT = 20

  class << self
    def list_pokemons(offset: nil)
      scope = order(:id).
                limit(LIMIT).
                includes(:types)

      scope = scope.offset(offset) if offset

      scope.all
    end
  end
end

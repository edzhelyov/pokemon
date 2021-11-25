class Type < ApplicationRecord
  serialize :moves, JSON

  after_initialize :set_empty_moves

  has_and_belongs_to_many :pokemons

  class << self
    def types_cache
      Type.all.map { |type| [type[:name], type] }.to_h
    end
  end

  private

  def set_empty_moves
    self.moves ||= []
  end
end

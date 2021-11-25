class Type < ApplicationRecord
  serialize :moves, JSON

  after_initialize :set_empty_moves

  private

  def set_empty_moves
    self.moves ||= []
  end
end

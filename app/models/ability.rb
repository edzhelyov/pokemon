class Ability < ApplicationRecord
  serialize :flavors, JSON

  after_initialize :set_empty_flavors

  private

  def set_empty_flavors
    self.flavors ||= []
  end
end

module Pokesync
  class Type < Base
    def initialize
      @all_method = :types
      @find_method = :type
      @model = ::Type
    end

    def assign(details)
      {
        name: details[:name],
        move_damage_class: details.dig(:move_damage_class, :name),
        moves: details[:moves].map { |move| move[:name] }.sort,
      }
    end
  end
end

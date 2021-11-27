module Pokesync
  class Base
    def sync
      response = Pokeapi.public_send @all_method
      offset = 0

      while !response[:results].empty?
        response[:results].each do |result|
          details = Pokeapi.public_send @find_method, result[:name]

          object = @model.where(original_id: details[:id]).first_or_initialize
          object.assign_attributes(assign(details))

          object.save if object.changed?

          offset += 1

          response = Pokeapi.public_send @all_method, offset: offset
        end
      end
    end

    def assign
      raise 'Must be implemented in the child class'
    end
  end
end

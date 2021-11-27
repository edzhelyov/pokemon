module Pokesync
  extend self

  def sync_all
    sync_abilities
    sync_types
    sync_pokemons
  end

  def sync_types
    Type.new.sync
  end

  def sync_pokemons(types_cache: ::Type.types_cache, limit: 2)
    Pokemon.new.sync types_cache: types_cache, limit: limit
  end

  def sync_abilities
    Ability.new.sync
  end
end

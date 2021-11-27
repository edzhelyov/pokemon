This project download Pokemon data from the [Pokemon API](https://pokeapi.co/docs/v2) site.

## Requirements

You need to have a working ruby version. The project is developed against 2.7.2, but any recent Ruby should work.
The database is a local sqlite3 file, and you would need the sqlite3 header files in order to compile the ruby adapter.

1. Run `bundle install` to install ruby dependecies.
2. Run `rails db:setup` to setup the database.

## Populating database

The `Pokesync` service downloads data from the Pokemon API. You can sync everyting by calling `Pokesync.sync_all` which will download the types first and the pokemons.
There is no rate limiting on the Pokemon API server, and we don't slowdown the request so don't run the synchronization frequently. It will only update changed records.

## Starting the server

After we have the database populated we can run the rails server and consume
the exposed data from our service.

Run `rails s` to start the server.

## Consume the API

We expose two endpoints:
* `/pokemons` which returns a list of pokemons. The limit of the response is 20 records. If you want to obtain the next batch of records you have to provide the `offset` parameter. `/pokemons?offset=20` will return the next batch of 20 records and so on.
    For example:
    ```
    curl localhost:3000/pokemons
    curl localhost:3000/pokemons?offset=20
    ```
* `/pokemons/:id` this returns more details for a given pokemon by its id.
  For example:
  ```
  curl localhost:3000/pokemons/1
  ```

## Running specs

Run `bundle exec rspec` to run all specs.

## Design considerations

I use the models as primary domain representation and sync them with the results taken from the API. The Pokeapi returns simple responses in the form of a parsed JSON without a specific structure, while we can put a validation of the received JSON I've decided to go with a more simple route and just transform the resulting Hash in the Pokesync child classes.

require('rspec')
require('pry')
require('pg')
require('book')
require('catalog')
require('user')
require('checkouts')

DB = PG.connect({:dbname => 'local_library_test'})

RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM checkouts *;")
      DB.exec("DELETE FROM books *;")
      DB.exec("DELETE FROM users *")
    end
  end

require('sinatra')
require('sinatra/reloader')
require('pry')
require('rspec')
also_reload('./lib/**/*.rb')
require('./lib/author')
require('./lib/book')
require('./lib/checkouts')
require('./lib/user')

require('pg')

get ('/')do
  erb :default
end

get ('/checkouts')do
  erb :checkouts
end

post('/checkouts')do
  user_name = params[:user_name]
  user_id = User.search_by_name(user_name)
  book_id = params[:book_id].to_i
  # sooo.... this chains a bunch of methods to conver the current time to a date, change the date to the next month, and then convert it to a string in the following format: "2019-08-31"
  due_date = Time.new.to_date.next_month.to_s
  Checkout.save(user_id, book_id, due_date)
  redirect to ('/checkouts')
end

get ('/users')do
  erb :users
end

post ('/users')do
  user_name = params[:user_name]
  User.save(user_name)
  redirect to ('/users')
end

get ('/users/:user_id')do
  user_name = params[:user_name]
  user_id = User.search_by_name(user_name)

end

get ('/catalog')do
  erb :catalog
end

get ('/catalog/books')do
  erb :catalog
end

get ('/catalog/authors')do
  erb :catalog
end

require('./lib/book')
class User
  @@DB = PG.connect({:dbname => "local_library"})
  @@display_user = []
  @@checked_out = []

  def self.save(user_name)
  @@DB.exec("INSERT INTO users (name) VALUES ('#{user_name}');")
  end

  def self.search_by_name(user_name)
      result = @@DB.exec("SELECT * FROM users WHERE name='#{user_name}';").first
      result["id"].to_i
  end

  def self.checked_out(user_id)
    checkout_results = @@DB.exec("SELECT * FROM checkouts WHERE id_users = '#{user_id}';")
    checkout_results.each do |checkout_result|
      book_result = @@DB.exec("SELECT * FROM books where id='#{checkout_result["id_books"]}' ;").first
      book_title = book_result["title"]
      book = Book.new({:title => book_title})
      @@checked_out.push(book)
    end
    binding.pry
    @@checked_out
  end

end

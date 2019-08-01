require('./lib/book')
class User
  @@display_user = []
  @@checked_out = []

  def self.save(user_name)
  DB.exec("INSERT INTO users (name) VALUES ('#{user_name}');")
  end

  def self.search_by_name(user_name)
      result = DB.exec("SELECT * FROM users WHERE name='#{user_name}';").first
      result["id"].to_i
  end

  def self.checked_out(user_id)
    @@checked_out = []
    checkout_results = DB.exec("SELECT * FROM checkouts WHERE id_users='#{user_id.to_i}';")
    checkout_results.each do |checkout_result|
      id_books = checkout_result["id_books"].to_i
      book_result = DB.exec("SELECT * FROM books where id='#{id_books}' ;").first
      book_title = book_result["title"]
      checkout_date_result = DB.exec("SELECT * FROM checkouts WHERE id_books='#{id_books}';").first
      checkout_date_str = checkout_date_result["checkout_date"]
      due_date_str = checkout_date_result["due_date"]
      book = Book.new({:title => book_title, :checkout_date => Time.parse(checkout_date_str), :due_date => Time.parse(due_date_str)})
      @@checked_out.push(book)
    end
    @@checked_out
  end

end

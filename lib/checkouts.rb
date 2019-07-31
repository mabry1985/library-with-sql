require('pg')

class Checkout
  @@DB = PG.connect({:dbname => "local_library"})

  def self.save(user_id, book_id, checkout_date, due_date)
    @@DB.exec("INSERT INTO checkouts (id_users, id_books, checkout_date, due_date) VALUES (#{user_id}, #{book_id},'#{checkout_date}', '#{due_date}');")
    @@DB.exec("UPDATE books SET checked_out='true' WHERE id='#{book_id}';")
  end

  def self.return(book_title)
    book_title = book_title.gsub("'", "''")
    books_result = @@DB.exec("SELECT * FROM books WHERE title='#{book_title}';").first
    book_id = books_result["id"].to_i
    @@DB.exec("UPDATE books SET checked_out='false' WHERE id='#{book_id}';")
    @@DB.exec("DELETE FROM checkouts WHERE id_books='#{book_id}';")
  end

  def self.hard_reset
    ## BREAK GLASS IN CASE OF EMERGENCY
    @@DB.exec("DELETE FROM checkouts;")
    @@DB.exec("UPDATE books SET checked_out='false';")
  end

end

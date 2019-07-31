require('pg')

class Checkout
  @@DB = PG.connect({:dbname => "local_library"})

  def self.save(user_id, book_id, due_date)
    @@DB.exec("INSERT INTO checkouts (id_users, id_books, due_date) VALUES (#{user_id}, #{book_id}, '#{due_date}');")
    @@DB.exec("UPDATE books SET checked_out='true' WHERE id='#{book_id}';")
  end

  def self.hard_reset
    ## BREAK GLASS IN CASE OF EMERGENCY
    @@DB.exec("DELETE FROM checkouts;")
    @@DB.exec("UPDATE books SET checked_out='false';")
  end

end

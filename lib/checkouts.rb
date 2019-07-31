require('pg')

class Checkout
  @@DB = PG.connect({:dbname => "local_library"})

  def self.save(user_id, book_id, due_date)
    @@DB.exec("INSERT INTO checkouts (id_users, id_books, due_date) VALUES (#{user_id}, #{book_id}, '#{due_date}');")
  end

end

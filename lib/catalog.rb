require('./lib/book')
require('time')

class Catalog
  @@DB = PG.connect({:dbname => "local_library"})
  @@catalog_contents = []
  def self.save(book_title)
       book_title = book_title.gsub("'", "''")
    @@DB.exec("INSERT INTO books (title, checked_out) VALUES ('#{book_title}', 'false');")
  end

  def self.clear
    @@catalog_contents = []
  end

  def self.populate
    result = @@DB.exec("SELECT * FROM books WHERE checked_out='false';")
    result.each do |result_book|
      book_id = result_book["id"].to_i
      checkout_result = @@DB.exec("SELECT * FROM checkouts WHERE id_books='#{book_id}';").first
      checkout_date_str = checkout_result["checkout_date"]
      due_date_str = checkout_result["due_date"]
      @@catalog_contents.push(Book.new({:title => result_book["title"], :checkout_date => Time.parse(checkout_date_str), :due_date => Time.parse(due_date_str)}))
    end
    @@catalog_contents
  end

end

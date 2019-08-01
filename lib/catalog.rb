require('./lib/book')
require('time')


class Catalog
  # DB = PG.connect({:dbname => "local_library"})
  @@catalog_contents = []
  def self.save(book_title, book_desc)
       book_title = book_title.gsub("'", "''")
       book_desc = book_desc.gsub("'", "''")
    DB.exec("INSERT INTO books (title, checked_out, description) VALUES ('#{book_title}', 'false', '#{book_desc}');")
  end

  def self.clear
    @@catalog_contents = []
  end

  def self.populate
    result = DB.exec("SELECT * FROM books WHERE checked_out='false';")
    result.each do |result_book|

      # book_id = result_book["id"].to_i
      # checkout_result = DB.exec("SELECT * FROM checkouts WHERE id_books='#{book_id}';").first
      # binding.pry
      # checkout_date_str = checkout_result["checkout_date"]
      # due_date_str = checkout_result["due_date"]
      @@catalog_contents.push(Book.new({:title => result_book["title"], :checkout_date => nil, :due_date => nil, :desc => result_book["description"]}))
    end
    @@catalog_contents
  end

  def self.search_by_title(book_title)
    # need this gsub here so that sql doesn't crash from out of place apostrophe
    book_title = book_title.gsub("'", "''")
    result = DB.exec("SELECT * FROM books WHERE title='#{book_title}';").first
    book = Book.new({:title => book_title, :checkout_date => nil, :due_date => nil, :desc => result["description"]})

  end

end

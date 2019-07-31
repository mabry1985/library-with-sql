require('./lib/book')

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
    result.each{|result_book| @@catalog_contents.push(Book.new({:title => result_book["title"]}))}
    @@catalog_contents
  end

end

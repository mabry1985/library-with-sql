
class Book
  attr_accessor :title

  def initialize(attr)
    @title = attr.fetch(:title)
  end
end

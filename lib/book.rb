
class Book
  attr_accessor :title, :due_date, :checkout_date

  def initialize(attr)
    @title = attr.fetch(:title)
    @checkout_date = attr.fetch(:checkout_date)
    @due_date = attr.fetch(:due_date)
  end
end

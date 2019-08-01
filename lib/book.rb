
class Book
  attr_accessor :title, :due_date, :checkout_date, :desc

  def initialize(attr)
    # @title = attr.fetch(:title)
    # @checkout_date = attr.fetch(:checkout_date)
    # @due_date = attr.fetch(:due_date)

    # This is a better solution for getting attributes from the hash, if they don't exist then they'll be set to a default value
    (attr.key? :title) ? @title = attr.fetch(:title) : @title = "Untitled"
    (attr.key? :checkout_date) ? @checkout_date = attr.fetch(:checkout_date) : @checkout_date= nil
    (attr.key? :due_date) ? @due_date = attr.fetch(:due_date) : @due_date = nil
    (attr.key? :desc) ?  @desc = attr.fetch(:desc) : @desc = "No Description Found"
  end
end

class BookSetsManager
  
  def initialize books
    @books = books
    @book_sets = []
  end
  
  def discover_book_sets
    discover_set_in_books(@books)
    @book_sets
  end
  
  private
  def discover_set_in_books books
    book_set = books.uniq
    remaining_books = Array.new(books)
    for book in book_set
      remaining_books.delete_at(remaining_books.index(book));
    end
    @book_sets << book_set
    if remaining_books.length > 0
      discover_set_in_books(remaining_books)
    end
  end
  
end
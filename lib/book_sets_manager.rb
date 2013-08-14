class BookSetsManager
  
  def initialize books
    @books = books
    @book_sets = []
  end
  
  def discover_book_sets
    discover_set_in_books(@books)
    balance_book_sets
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
  
  def balance_book_sets
    average_size = get_book_sets_average_size
    for book_set in @book_sets
      for book_set_2 in @book_sets
        if can_balance_book_sets?(book_set,book_set_2,average_size)
          books_difference = book_set - book_set_2
          if (books_difference.length > 0)
            book = books_difference.pop
            book_set_2.push(book)
            book_set.delete(book)
          end
        end
      end
    end
  end
  
  def get_book_sets_average_size
    average_size = 0
    for book_set in @book_sets
      average_size += book_set.length
    end
    (average_size / @book_sets.length).round(0)
  end
  
  def can_balance_book_sets?(book_set, book_set_2, average_size)
    book_set_2.length < average_size && book_set != book_set_2 && book_set.length > book_set_2.length
  end
end
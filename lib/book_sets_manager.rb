class BookSetsManager

  def initialize books
    @books = books
    @book_sets = []
  end

  def unbalanced_sets
    discover_set_in_books(@books)
    @book_sets
  end

  def balanced_sets
    balance_book_sets
  end

  private
  def discover_set_in_books books
    book_set = books.uniq
    remaining_books = Array.new(books)
    book_set.each do |book|
      remaining_books.delete_at(remaining_books.index(book));
    end
    @book_sets << book_set
    if remaining_books.length > 0
      discover_set_in_books(remaining_books)
    end
  end
  
  def balance_book_sets
    average_size = get_book_sets_average_size
    book_sets = @book_sets  
    book_sets.each do |book_set|
      book_sets.each do |book_set_2|
        books_difference = book_set - book_set_2
        if could_balance_book_sets?(book_set,book_set_2,books_difference,average_size)
          if !books_difference.empty?
            book = books_difference.pop
            book_set_2 << book
            book_set.delete(book)
          end
        end
      end
    end
    book_sets
  end
  
  def get_book_sets_average_size
    average_size = 0
    @book_sets.each do |book_set|
      average_size += book_set.length
    end
    (average_size / @book_sets.length).round(0)
  end
  
  def could_balance_book_sets?(book_set, book_set_2, books_difference, average_size)
    book_set != book_set_2 &&
    book_set_2.length < average_size &&
    book_set.length > book_set_2.length
  end
end

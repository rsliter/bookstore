require "book_sets_manager"

class PriceManager

    COST_OF_BOOK = 8
    DISCOUNT_PER_BOOK = 0.05
    AMOUNT_OF_BOOKS_FOR_FIRST_DISCOUNT = 3

    def initialize books
        @sets_manager = BookSetsManager.new(books)
    end

    def price
        unbalanced_price = calculate(@sets_manager.unbalanced_sets)
        balanced_price = calculate(@sets_manager.balanced_sets)
        unbalanced_price < balanced_price ? unbalanced_price : balanced_price
    end

    private
    def calculate book_sets
        total_price = 0
        for book_set in book_sets
          set_price = 0
          full_price = COST_OF_BOOK * book_set.length
          if can_discount_set?(book_set)
              set_price = full_price * calculate_discount_factor(book_set)
          else
              set_price = full_price
          end  
          total_price += set_price 
        end
        total_price
    end
    
    def calculate_discount_factor(book_set)
        if less_than_four_books_in_set?(book_set)
            1 - DISCOUNT_PER_BOOK * (book_set.length - 1)
        else
            1 - DISCOUNT_PER_BOOK * (book_set.length)
        end
    end
    
    def can_discount_set?(book_set)
        unique_books = book_set.uniq
        unique_books.length == book_set.length
    end

    def less_than_four_books_in_set?(book_set)
        book_set.length <= AMOUNT_OF_BOOKS_FOR_FIRST_DISCOUNT
    end

end

class PriceManager

    COST_OF_BOOK = 8
    DISCOUNT_PER_BOOK = 0.05
    AMOUNT_OF_BOOKS_FOR_FIRST_DISCOUNT = 3

    def initialize books
        @books = books
        @books_length = books.length
    end

    def calculate
        full_price = COST_OF_BOOK * @books_length
        if is_eligible_for_discount
            full_price * calculate_discount_factor
        else
            full_price
        end
    end

    private
    def calculate_discount_factor
        if is_eligible_for_first_type_of_discount
            1 - DISCOUNT_PER_BOOK * (@books_length - 1)
        else
            1 - DISCOUNT_PER_BOOK * (@books_length)
        end    
    end

    def is_eligible_for_discount
        unique_books = @books.uniq
        unique_books.length == @books_length
    end

    def is_eligible_for_first_type_of_discount
        @books_length <= AMOUNT_OF_BOOKS_FOR_FIRST_DISCOUNT
    end

end
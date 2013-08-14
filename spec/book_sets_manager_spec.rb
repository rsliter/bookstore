require "book_sets_manager"

describe BookSetsManager do

  describe ".discover_book_sets" do
    
    it "should return one set if unique books are given" do
      book_sets_manager = BookSetsManager.new([1, 2, 3])
      result = [[1, 2, 3]]
      book_sets_manager.discover_book_sets.should == result
    end
    
    describe "with books that are not unique" do
      
      it "should return two sets with one book each if the same book is given two times" do
        book_sets_manager = BookSetsManager.new([1, 1])
        result = [[1],[1]]
        book_sets_manager.discover_book_sets.should == result
      end
      it "should return three sets with one book each if the same book is given three times" do
        book_sets_manager = BookSetsManager.new([2, 2, 2])
        result = [[2],[2],[2]]
        book_sets_manager.discover_book_sets.should == result
      end
      it "should return two sets if 1 or more books are repeated 1 time" do
        book_sets_manager = BookSetsManager.new([1, 2, 3, 2, 3])
        result = [[1, 2, 3],[2, 3]]
        book_sets_manager.discover_book_sets.should == result
      end
      
    end
    
  end
  
end

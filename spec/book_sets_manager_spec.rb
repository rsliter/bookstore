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
      it "should return two sets if 1 or more of the given books are repeated 1 time" do
        book_sets_manager = BookSetsManager.new([1, 2, 3, 2, 3])
        result = [[1, 2, 3],[2, 3]]
        book_sets_manager.discover_book_sets.should == result
      end
      it "should return more than 2 sets if 1 or more books are repeated more than 1 time" do
        book_sets_manager = BookSetsManager.new([1, 2, 3, 2, 3, 1, 2, 3])
        result = [[1, 2, 3],[2, 3, 1],[2, 3]]
        book_sets_manager.discover_book_sets.should == result
      end
      it "should return a balanced set of books if possible" do
        book_sets_manager = BookSetsManager.new([1,1,2,2,3,3,4,5])
        result = [[1, 2, 3, 4],[1, 2, 3, 5]]
        book_sets_manager.discover_book_sets.should == result
        book_sets_manager = BookSetsManager.new([0,0,0,0,0,1,1,1,1,1,2,2,2,2,3,3,3,3,3,4,4,4,4])
        result = [[0,1,2,3],[0,1,2,3,4],[0,1,2,3,4],[0,1,2,3,4],[0,1,3,4]]
        book_sets_manager.discover_book_sets.should == result
      end
      
    end
    
  end
  
end

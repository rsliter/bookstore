require "price_manager"

describe PriceManager do
  
    describe ".calculate" do
      
        it "should be 0 when no books" do
            price_manager = PriceManager.new([])
            price_manager.calculate.should == 0
        end
        it "should be 8 when 1 book" do # there is a default book set
            price_manager = PriceManager.new([[1]])
            price_manager.calculate.should == 8
        end

        describe "with multiple books belonging to a unique book set" do
          
            it "should apply a 5% discount when 2 different books" do # both books are part of a default set
                price_manager = PriceManager.new([[1,2]])
                price_manager.calculate.should == 15.20
            end
            it "should apply a 10% discount when 3 different books" do
                price_manager = PriceManager.new([[1,2,3]])
                price_manager.calculate.should == 21.6
            end
            it "should apply a 20% discount when 4 different books" do
                price_manager = PriceManager.new([[1,2,3,4]])
                price_manager.calculate.should == 25.60
            end
            it "should apply a 25% discount when 5 different books" do
                price_manager = PriceManager.new([[1,2,3,4,5]])
                price_manager.calculate.should == 30
            end
            
        end

        describe "with multiple books belonging to different book sets" do
          
            it "should not apply any discount when 2 of the same books" do
                price_manager = PriceManager.new([[1],[1]])
                price_manager.calculate.should == 16
            end
            it "should not apply any discount when 3 of the same books" do
                price_manager = PriceManager.new([[2],[2],[2]])
                price_manager.calculate.should == 24
            end
            
            it "should apply discount to the books of a series and not to the different/repeated book" do
                price_manager = PriceManager.new([[1,2,3],[3]]) # Books: [1,2,3,3]
                price_manager.calculate.should == 21.6 + 8 
            end
            it "should apply discount independently to each book series found" do
                price_manager = PriceManager.new([[1,2,3,4],[2,3]]) # Books: [1,2,3,2,3,4]
                price_manager.calculate.should == 25.6 + 15.2 
            end
            it "should apply discount independently to a balanced book set" do
                price_manager = PriceManager.new([[1,2,3,4],[1,2,3,5]]) # Books: [1,1,2,2,3,3,4,5]
                price_manager.calculate.should == 25.6 + 25.6
                price_manager = PriceManager.new([[0,1,2,3],[0,1,2,3,4],[0,1,2,3,4],[0,1,2,3,4],[0,1,3,4]]) # Books: [0*5,1*5,2*4,3*5,4*4]
                price_manager.calculate.should == 141.2 # 3*8*5*0.75 + 2*8*4*0.80
            end
            
        end
        
    end
    
end

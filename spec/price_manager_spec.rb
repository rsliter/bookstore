require "price_manager"

describe PriceManager do

    describe ".calculate" do
        it "should be 0 when no books" do
            price_manager = PriceManager.new([])
            price_manager.calculate.should == 0
        end
        it "should be 8 when 1 book" do
            price_manager = PriceManager.new([1])
            price_manager.calculate.should == 8
        end

        describe "with multiple books" do
            it "should apply a 5% discount when 2 different books" do
                price_manager = PriceManager.new([1,2])
                price_manager.calculate.should == 15.20
            end
            it "should apply a 10% discount when 3 different books" do
                price_manager = PriceManager.new([1,2,3])
                price_manager.calculate.should == 21.6
            end
            it "should apply a 20% discount when 4 different books" do
                price_manager = PriceManager.new([1,2,3,4])
                price_manager.calculate.should == 25.60
            end
            it "should apply a 25% discount when 5 different books" do
                price_manager = PriceManager.new([1,2,3,4,5])
                price_manager.calculate.should == 30
            end

            it "should not apply any discount when 2 of the same books" do
                price_manager = PriceManager.new([1,1])
                price_manager.calculate.should == 16
            end
        end
    end
    
end

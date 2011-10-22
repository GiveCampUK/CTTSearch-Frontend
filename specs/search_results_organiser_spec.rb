$: << File.dirname(__FILE__)
require 'frontend'

describe SearchResultsOrganiser do
  describe "#sort" do
    describe "column layout" do
      it "should put every other item into the second column" do
        items = [
          { :title => "first col" },
          { :title => "second col" },
          { :title => "first col (again)" }
        ]
    
        org = SearchResultsOrganiser.new;
        result = org.sort items
        result[:column1].should include(items[0])
        result[:column1].should include(items[2])
        result[:column2].should include(items[1])
      end
    end
  end
end
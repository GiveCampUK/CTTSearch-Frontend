$: << File.dirname(__FILE__)
require 'frontend'

describe SearchResultsOrganiser do
  let (:org) do
    SearchResultsOrganiser.new
  end
  
  describe "#sort" do
    describe "no items" do
      it "should return empty" do
        result = org.sort [ ]
        result.count.should eql 0
      end
    end
    
    describe "column layout" do
      it "should put every other item into the second column" do
        items = [
          { :title => "first col" },
          { :title => "second col" },
          { :title => "first col (again)" }
        ]
        
        result = org.sort items
        result[0][:column].should eql :column1
        result[1][:column].should eql :column2
        result[2][:column].should eql :column1
      end
      
      it "should promote 'promoted' items to the top of the list" do
        items = [
          { :title => "test1" },
          { :title => "test2", :tags => ['promoted'] },
          { :title => "test3" },
          { :title => "test4" },
          { :title => "test5", :tags => ['promoted'] }
        ]
        
        result = org.sort items
        p result
        # LIFO - So Test5 First!
        result[0][:item][:title].should eql "test5"
        result[1][:item][:title].should eql "test2"
      end
    end
  end
  
  describe "#classify" do
    describe "non-video types" do
      it "should add the 'type_text' for internal links" do
        items = [{ :resourceType => "internalLink" }]
        result = org.classify items
        result[0][:classes].should include('type_text')
      end
      
      it "should add the 'type_text' for external links" do
        items = [{ :resourceType => "externalLink" }]
        result = org.classify items
        result[0][:classes].should include('type_text')
      end
      
      it "should add the 'type_text' for unkown content" do
        items = [{ :resourceType => "someArbitraryThing" }]
        result = org.classify items
        result[0][:classes].should include('type_text')
      end
    end
    
    describe "video types" do
      it "should add the 'type_video' for video links" do
        items = [{ :resourceType => "YouTubeVideo" }]
        result = org.classify items
        result[0][:classes].should include('type_video')
      end
    end
    
    describe "prototyed types" do
      it "should add 'promoted' to 'promoted' items" do
        items = [{ :resourceType => "internalLink", :tags => ['promoted'] }]
        result = org.classify items
        result[0][:classes].should include('promoted')
      end
    end
  end
end
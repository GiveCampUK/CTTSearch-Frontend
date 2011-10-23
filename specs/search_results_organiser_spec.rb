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
        result.empty?.should be_true
      end
    end
    
    describe "column layout" do
      it "should put every other item into the second column" do
        a = { :title => "first col" }
        b = { :title => "second col" }
        c = { :title => "first col (again)" }

        result = org.sort [a,b,c]
        
        result.column1.should include(a)
        result.column1.should include(c)
        result.column2.should include(b)
      end
      
      it "should promote 'promoted' items to the top of the list" do
        a = { :title => "test2", :tags => ['promoted'] }
        b = { :title => "test5", :tags => ['promoted'] }
        items = [
          { :title => "test1" },
          a,
          { :title => "test3" },
          { :title => "test4" },
          b
        ]
        
        result = org.sort items
        # LIFO - So Test5 First!
        result.column1[0].should be b
        result.column2[0].should be a
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
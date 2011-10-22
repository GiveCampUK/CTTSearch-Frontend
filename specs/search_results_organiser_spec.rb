$: << File.dirname(__FILE__)
require 'frontend'

describe SearchResultsOrganiser do
  let (:org) do
    SearchResultsOrganiser.new
  end
  
  describe "#sort" do
    describe "column layout" do
      it "should put every other item into the second column" do
        items = [
          { :title => "first col" },
          { :title => "second col" },
          { :title => "first col (again)" }
        ]
        
        result = org.sort items
        result[:column1].should include(items[0])
        result[:column1].should include(items[2])
        result[:column2].should include(items[1])
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
      it "should add 'promoted' to 'important' items" do
        items = [{ :resourceType => "internalLink", :tags => ['promoted'] }]
        result = org.classify items
        result[0][:classes].should include('promoted')
      end
    end
  end
end
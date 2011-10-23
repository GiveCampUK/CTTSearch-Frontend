class SearchResultsOrganiser
  def sort(items)
    sorted_promoted = (classify items).sort do |a,b|
      item1Promoted = a[:classes].include?('promoted')
      item2Promoted = b[:classes].include?('promoted')
      
      compare = 0
      compare -=1 if item1Promoted
      compare +=1 if item2Promoted
      compare
    end
    
    column1Items = [ ]
    column2Items = [ ]
    odd = false
    sorted_promoted.map do |classified_item|
      odd = !odd
      
      if odd
        column1Items << classified_item[:item]
      else
        column2Items << classified_item[:item]
      end
    end
    
    SearchResults.new(column1Items, column2Items)
  end
  
  def classify(items)
    result = items.map do |item|
      item_classes = [ ]
      item_classes << ((item[:resourceType] =~ /YouTubeVideo/) == 0 ? 'type_video' : 'type_text')
      item_tags = item[:tags ] || [ ]
      (item_classes << "promoted") if item_tags.include?('promoted')
      
      {
        :item => item,
        :classes => item_classes
      }
    end
  end
end

class SearchResults
  attr_reader :column1, :column2
  
  def initialize(column1Items, column2Items)
    @column1 = column1Items || [ ]
    @column2 = column2Items || [ ]
  end
  
  def empty?
    @column1.empty? && @column2.empty?
  end
end
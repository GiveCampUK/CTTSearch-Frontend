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
    
    odd = false
    sorted_promoted.map do |classified_item|
      odd = !odd
      {
       :item => classified_item[:item],
       :column => (odd  ? :column1 : :column2)
      }
    end
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
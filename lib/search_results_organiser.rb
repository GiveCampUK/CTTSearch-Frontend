class SearchResultsOrganiser
  def sort(items)
    first_col = [ ]
    second_col = [ ]
    
    odd = true
    items.each do |item|
      if odd
        first_col << item
      else
        second_col << item
      end
      odd = !odd
    end
    
    {
      :column1 => first_col,
      :column2 => second_col
    }
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
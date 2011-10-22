class SearchResultsOrganiser
  def sort(items)
    odd = false
    items.map do |item|
      odd = !odd
      {
       :item => item,
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
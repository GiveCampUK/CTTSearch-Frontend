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
end
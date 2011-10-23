class SearchUriBuilder
  
  def initialize(query, *tags)
    @query = query
    @tags = tags.flatten
  end
  
  def uri
    "/search#{query_string}"
  end
  
  def query_string
    SearchUriBuilder.query_string @query, @tags
  end
  
  def self.query_string(q = "", *tags)
    "?q=#{q.escaped}" << "&tags=#{tags.join(",")}" unless tags.empty?
  end
  
  private
  
  def self.search_terms(q = "", tags = [ ])
    tags << q unless q.strip.empty?
  end
end
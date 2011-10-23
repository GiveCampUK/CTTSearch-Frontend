require 'json'
require 'uri'
require 'open-uri'

class Search
  def self.party(query = "", tags = [])
    return if query.empty? && tags.empty?
    path = "/search?q=#{query.escaped}"
    path << "&tags=#{tags.join(",").escaped}" unless tags.empty?
    (query_api path)['results'].flatten
  end
  
  def self.cats
    (query_api "/Category").flatten # Capital C is SUPER-Important!
  end
  def self.cat(id)
    (query_api "/Category?id=#{id}") # Capital C is SUPER-Important!
  end
  
  private
  
  def self.base_uri
    "http://searchparty-1.apphb.com"
  end
  
  def self.query_api(path)

    # For when shit goes bad!     
    # stub = JSON.parse(File.open('stub-search-results.json').read)
    # return stub['results'][0]
    
    begin
      uri = "#{base_uri}#{path}"
      p "Querying API Via: '#{uri}'"
      JSON.parse(URI.parse(uri).read)
    rescue => ex
      p ex.inspect
    end
  end
end
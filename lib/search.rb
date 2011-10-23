require 'json'
require 'uri'
require 'open-uri'

class Search
  def self.party(query = "", tags = [])
    return if query.empty? && tags.empty?
    path = "/search?q=#{escaped query}"
    path << "&tags=#{escaped tags.join(",")}" unless tags.empty?
    query_api path
  end
  
  private
  
  def self.escaped(val)
    URI.escape(val, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  end
  
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
      JSON.parse(URI.parse(uri).read)['results'].flatten
    rescue => ex
      p ex.inspect
    end
  end
end
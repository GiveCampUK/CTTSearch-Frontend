require 'json'
require 'uri'
require 'open-uri'

class Search
  def self.party(query = "", tags = [])
    return if query.empty? && tags.empty?
    
    tags = tags.map {|t| "^#{t}"}
    path = "/search?q=#{escaped query}"
    path << "#{escaped tags.join(" ")}" unless tags.empty?
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
    begin
      uri = "#{base_uri}#{path}"
      JSON.parse(URI.parse(uri).read)
    rescue => ex
      p ex.inspect
    end
  end
end